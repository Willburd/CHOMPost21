/obj/effect/haunting_hallucination
	name = ""
	desc = ""
	density = FALSE
	anchored = TRUE
	opacity = 0
	VAR_PRIVATE/list/clients = list()
	VAR_PRIVATE/list/image/dir_images = list()

/obj/effect/haunting_hallucination/proc/create_images_from(var/atom/clone)
	dir_images["[NORTH]"] = image(clone,dir = NORTH)
	dir_images["[SOUTH]"] = image(clone,dir = SOUTH)
	dir_images["[EAST]"] = image(clone,dir = EAST)
	dir_images["[WEST]"] = image(clone,dir = WEST)
	for(var/img in dir_images)
		var/image/G = dir_images[img]
		G.layer = clone.layer
		G.plane = clone.plane
		G.appearance_flags = clone.appearance_flags
		G.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		G.loc = loc

/obj/effect/haunting_hallucination/process()
	. = ..()
	// Passive cleanup
	for(var/datum/weakref/C in clients)
		var/client/CW = C?.resolve()
		if(isnull(CW))
			clients.Remove(C)
	if(!clients.len)
		qdel(src)

/obj/effect/haunting_hallucination/proc/append_client(var/datum/weakref/C)
	var/client/CW = C?.resolve()
	if(!CW)
		return
	clients.Add(C)
	assign_image_to_client(CW)

/obj/effect/haunting_hallucination/set_dir(newdir)
	var/updatesprite = (dir != newdir)
	. = ..()
	if(updatesprite)
		for(var/datum/weakref/C in clients)
			var/client/CW = C?.resolve()
			clear_images_from_client(CW)
			assign_image_to_client(CW)

/obj/effect/haunting_hallucination/Moved(atom/old_loc, direction, forced, movetime)
	. = ..()
	for(var/img in dir_images)
		var/image/G = dir_images[img]
		G.loc = loc

/obj/effect/haunting_hallucination/Destroy(force)
	. = ..()
	clear_every_clients_images()
	qdel_all_images()

/obj/effect/haunting_hallucination/proc/assign_image_to_client(var/client/CW)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!CW)
		return
	if(!dir_images.len)
		return
	CW.images += dir_images["[dir]"]

/obj/effect/haunting_hallucination/proc/clear_every_clients_images()
	for(var/datum/weakref/C in clients)
		clear_images_from_client(C?.resolve())

/obj/effect/haunting_hallucination/proc/clear_images_from_client(var/client/CW)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!CW)
		return
	if(!dir_images.len)
		return
	for(var/img in dir_images)
		CW.images -= dir_images[img]

/obj/effect/haunting_hallucination/proc/qdel_all_images()
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	for(var/img in dir_images)
		qdel_null(dir_images[img])
	dir_images.Cut()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Hallucination attackers with AI behaviors
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/mob/proc/create_hallucination_attacker(var/turf/T = null,var/mob/living/carbon/human/clone = null, var/forced_type = null)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!client)
		return

	if(!clone)
		// Get a randomized clone from the living mob's list, must be standing
		var/list/possible_clones = new/list()
		for(var/mob/living/carbon/human/H in living_mob_list)
			if(H.stat || H.lying || istype(H,/mob/living/carbon/human/monkey/auto_doc))
				continue
			possible_clones += H
		if(!possible_clones.len)
			return
		clone = pick(possible_clones)
	if(!clone)
		return

	if(!T)
		// Get the target's turf, then make some random steps to get away from them, respecting walls
		T = get_turf(clone)
		var/turf/CT = T
		for(var/i = 0 to 8)
			var/Cdir = pick(GLOB.cardinal)
			if(prob(30))
				Cdir = clone.dir // Results in hallucinations somewhat being in front of you
			var/turf/NT = get_step(CT,Cdir)
			if(!NT.density)
				CT = NT
		T = CT

	if(!forced_type)
		// Picking from all available options
		var/list/get_types = subtypesof(/obj/effect/haunting_hallucination/human)
		forced_type = pick(get_types)
	// Finally! After a thousand years I'm finally free to conquer EARTH!
	new forced_type(T,src,clone)

/obj/effect/haunting_hallucination/human
	VAR_PROTECTED/datum/weakref/target = null
	var/requires_hallucinating = TRUE // Mob will qdel if the target is not hallucinating if this is true

/obj/effect/haunting_hallucination/human/Initialize(mapload,var/mob/targeting_mob,var/atom/clone_appearance_from)
	. = ..()
	START_PROCESSING(SSobj, src)
	set_target(targeting_mob)
	create_images_from(clone_appearance_from)
	append_client(WEAKREF(targeting_mob.client))
	name = clone_appearance_from.name
	// Usually we want to face our target for maximum spooky effect
	set_dir(get_dir(src,targeting_mob))

/obj/effect/haunting_hallucination/human/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/effect/haunting_hallucination/human/process()
	// check if valid
	var/mob/living/M = target?.resolve()
	if(!M)
		qdel(src)
		return null
	if(requires_hallucinating)
		if(!ishuman(M))
			qdel(src)
			return null
		var/mob/living/carbon/human/H = M
		if(!H.hallucination)
			qdel(src)
			return null

	return M

/obj/effect/haunting_hallucination/human/proc/set_target(var/mob/M)
	target = WEAKREF(M)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Attacker: Performs hostile shoves and attacks
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/effect/haunting_hallucination/human/attacker/process()
	var/mob/living/M = ..()

	if(get_dist(src,M) > 1)
		set_dir(get_dir(src,M))
		Move(get_step(get_turf(src),dir))

	else if(prob(15))
		M << sound(pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg'))
		M.show_message(span_bolddanger("\The [src] has punched \the [M]!"), 1)
		M.halloss += 4

	if(prob(15))
		var/D = get_dir(src,M)
		Move(get_step(get_turf(src), GLOB.reverse_dir[D]))


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fleeing: Runs away when you get close
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/effect/haunting_hallucination/human/fleeing
	VAR_PRIVATE/flee = FALSE

/obj/effect/haunting_hallucination/human/fleeing/process()
	var/mob/living/M = ..()
	set_dir(get_dir(src,M))

	if(get_dist(src,M) < 5 || flee)
		flee = TRUE
		var/D = get_dir(src,M)
		Move(get_step(get_turf(src), GLOB.reverse_dir[D]))

	if(get_dist(src,M) > 10 || (flee && prob(20)))
		target = null
		qdel(src)
