
/obj/machinery/gibber
	name = "gibber"
	desc = "The name isn't descriptive enough?"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "grinder"
	density = TRUE
	anchored = TRUE
	unacidable = TRUE
	req_access = list(access_kitchen,access_morgue)

	var/operating = 0 //Is it on?
	var/dirty = 0 // Does it need cleaning?
	var/mob/living/occupant // Mob who has been put inside
	var/gib_time = 40        // Time from starting until meat appears
	var/gib_throw_dir = WEST // Direction to spit meat and gibs in.

	var/obj/machinery/transhuman/autoresleever/sleevelink // updated before each sleeving check, attempts to see if we have a autosleever ready for biomass injection!

	use_power = USE_POWER_IDLE
	idle_power_usage = 2
	active_power_usage = 500

/obj/machinery/gibber/AllowDrop()
	return TRUE // store organs for gibbing

//auto-gibs anything that bumps into it
/obj/machinery/gibber/autogibber
	var/turf/input_plate

/obj/machinery/gibber/autogibber/Initialize()
	. = ..()
	add_overlay("grjam") // Outpost 21 edit - overlay runtime fix
	// outpost 21 edit - add gibber from above detection
	var/obj/machinery/mineral/input/input_obj = locate( /obj/machinery/mineral/input, get_zstep(src, UP))
	if(!input_obj)
		for(var/i in cardinal)
			input_obj = locate( /obj/machinery/mineral/input, get_step(src.loc, i) )
			if(input_obj)
				if(isturf(input_obj.loc))
					input_plate = input_obj.loc
					gib_throw_dir = i
					qdel(input_obj)
					break
	else
		if(isturf(input_obj.loc))
			input_plate = input_obj.loc
			// keep gib throw dir default
			qdel(input_obj)

	if(!input_plate)
		log_misc("a [src] didn't find an input plate.")

/obj/machinery/gibber/Destroy()
	occupant = null
	return ..()

/obj/machinery/gibber/autogibber/Destroy()
	input_plate = null
	return ..()

/obj/machinery/gibber/autogibber/Bumped(var/atom/A)
	if(!input_plate)
		return
	if(stat & (NOPOWER|BROKEN))
		return
	if(operating)
		return
	if(istype(A,/obj/item))
		// items move into gibber for processing and ejection
		var/obj/item/thing = A
		thing.loc = src
		updatesleever()
		scanforid(thing)
		return
	if(!ismob(A))
		return
	if(src.occupant)
		return
	if(istype(A, /mob/living/carbon) || istype(A, /mob/living/simple_mob))
		// bootleg move_into_gibber
		var/mob/victim = A
		victim.loc = src
		src.occupant = victim
		src.startgibbing( victim)
		return

/obj/machinery/gibber/autogibber/process()
	// auto detect above!
	if(input_plate && input_plate.z != loc.z)
		Bumped( locate( /mob, input_plate))
	// backup item ejection
	if(!operating && isnull(occupant) && contents.len > 0 && prob(50))
		updatesleever()
		processcontents()

/obj/machinery/gibber/update_icon()
	cut_overlays()
	if (dirty)
		add_overlay("grbloody")
	if(stat & (NOPOWER|BROKEN))
		return
	if (!occupant)
		add_overlay("grjam")
	else if (operating)
		add_overlay("gruse")
	else
		add_overlay("gridle")

/obj/machinery/gibber/relaymove(mob/user as mob)
	src.go_out()
	return

/obj/machinery/gibber/attack_hand(mob/user as mob)
	if(stat & (NOPOWER|BROKEN))
		return
	if(operating)
		to_chat(user, "<span class='danger'>The gibber is locked and running, wait for it to finish.</span>")
		return
	else
		src.startgibbing(user)

/obj/machinery/gibber/examine()
	. = ..()
	. += "The safety guard is [emagged ? "<span class='danger'>disabled</span>" : "enabled"]."

/obj/machinery/gibber/emag_act(var/remaining_charges, var/mob/user)
	emagged = !emagged
	to_chat(user, "<span class='danger'>You [emagged ? "disable" : "enable"] the gibber safety guard.</span>")
	return 1

/obj/machinery/gibber/attackby(var/obj/item/W, var/mob/user)
	var/obj/item/grab/G = W

	if(default_unfasten_wrench(user, W, 40))
		return

	if(!istype(G))
		return ..()

	if(G.state < 2)
		to_chat(user, "<span class='danger'>You need a better grip to do that!</span>")
		return

	move_into_gibber(user,G.affecting)
	// Grab() process should clean up the grab item, no need to del it.

/obj/machinery/gibber/MouseDrop_T(mob/target, mob/user)
	if(user.stat || user.restrained())
		return
	move_into_gibber(user,target)

/obj/machinery/gibber/proc/move_into_gibber(var/mob/user,var/mob/living/victim)

	if(src.occupant)
		to_chat(user, "<span class='danger'>The gibber is full, empty it first!</span>")
		return

	if(operating)
		to_chat(user, "<span class='danger'>The gibber is locked and running, wait for it to finish.</span>")
		return

	if(!(istype(victim, /mob/living/carbon)) && !(istype(victim, /mob/living/simple_mob)) )
		to_chat(user, "<span class='danger'>This is not suitable for the gibber!</span>")
		return

	if(ishuman(victim) && !emagged)
		to_chat(user, "<span class='danger'>The gibber safety guard is engaged!</span>")
		return


	if(victim.abiotic(1))
		to_chat(user, "<span class='danger'>Subject may not have abiotic items on.</span>")
		return

	user.visible_message("<span class='danger'>[user] starts to put [victim] into the gibber!</span>")
	src.add_fingerprint(user)
	if(do_after(user, 30) && victim.Adjacent(src) && user.Adjacent(src) && victim.Adjacent(user) && !occupant)
		user.visible_message("<span class='danger'>[user] stuffs [victim] into the gibber!</span>")
		if(victim.client)
			victim.client.perspective = EYE_PERSPECTIVE
			victim.client.eye = src
		victim.loc = src
		src.occupant = victim
		update_icon()

/obj/machinery/gibber/verb/eject()
	set category = "Object"
	set name = "Empty Gibber"
	set src in oview(1)

	if (usr.stat != 0)
		return
	src.go_out()
	add_fingerprint(usr)
	return

/obj/machinery/gibber/proc/go_out()
	if(operating || !src.occupant)
		return
	for(var/obj/O in src)
		O.loc = src.loc
	if (src.occupant.client)
		src.occupant.client.eye = src.occupant.client.mob
		src.occupant.client.perspective = MOB_PERSPECTIVE
	src.occupant.loc = src.loc
	src.occupant = null
	update_icon()
	return


/obj/machinery/gibber/proc/startgibbing(mob/user as mob)
	if(src.operating)
		return
	if(!src.occupant)
		visible_message("<span class='danger'>You hear a loud metallic grinding sound.</span>")
		return

	use_power(1000)
	visible_message("<span class='danger'>You hear a loud [occupant.isSynthetic() ? "metallic" : "squelchy"] grinding sound.</span>")
	src.operating = 1
	update_icon()

	// alright, so. Vorecode makes this hellish, as mobs can be nested in mobs endlessly. Because fuck you.
	// We'll loop through our mob contents, and when the list's length stays the same, we know we've got EVERYTHING out and items dropped.
	var/list/byproducts = list()
	var/contentssize = -1
	var/escape = 300
	while(escape > 0)
		contentssize = contents.len
		for(var/mob/grindable in contents)
			preprocessmob(grindable)
		if(contentssize == contents.len)
			break
		escape--

	for(var/mob/living/grindable in contents)
		if(isnull(grindable))
			continue
		if(istype(grindable,/mob/living/simple_mob/animal/borer))
			continue // borers cannot be gibbered, butcher them manually
		if(grindable.client)
			GLOB.gibber_fellin_roundstat++

		var/slab_name = grindable.name
		var/slab_count = grindable.meat_amount
		var/slab_type = grindable.meat_type ? grindable.meat_type : /obj/item/reagent_containers/food/snacks/meat
		var/slab_nutrition = grindable.nutrition / 15

		// extra loot from butchery!
		byproducts += grindable?.butchery_loot?.Copy()

		if(ishuman(grindable))
			var/mob/living/carbon/human/H = grindable
			slab_name = grindable.real_name
			slab_type = H.isSynthetic() ? /obj/item/stack/material/steel : H.species.meat_type

		// Small mobs don't give as much nutrition.
		if(issmall(grindable))
			slab_nutrition *= 0.5
		if(slab_count <= 0)
			slab_count = 1 // no div by 0
		slab_nutrition /= slab_count

		while(slab_count)
			slab_count--
			var/obj/item/reagent_containers/food/snacks/meat/new_meat = new slab_type(src, rand(3,8))
			if(istype(new_meat))
				new_meat.name = "[slab_name] [new_meat.name]"
				new_meat.reagents.add_reagent(REAGENT_ID_NUTRIMENT,slab_nutrition)
				if(grindable.reagents)
					grindable.reagents.trans_to_obj(new_meat, round(grindable.reagents.total_volume/(2 + grindable.meat_amount),1))

		add_attack_logs(user,grindable,"Used [src] to gib")

		// release corticle borers
		var/mob/living/simple_mob/animal/borer/B = grindable.has_brain_worms()
		if(B)
			B.detatch() // if in control
			B.leave_host()
		// process grindables into meaty treaties
		if(!isnull(grindable.mind))
			grindable.ghostize()
		grindable.gib()

	spawn(gib_time)
		playsound(src, 'sound/effects/splat.ogg', 50, 1)
		operating = 0
		if(LAZYLEN(byproducts))
			for(var/path in byproducts)
				while(byproducts[path])
					if(prob(min(90,30 * byproducts[path])))
						new path(src)

					byproducts[path] -= 1

		// undate sleever here so we can skip organ destruction
		updatesleever()
		if(!isnull(sleevelink))
			for (var/obj/thing in contents)
				// There's a chance that the gibber will fail to destroy or butcher some evidence.
				if(istype(thing,/obj/item/organ) && prob(80))
					var/obj/item/organ/OR = thing
					if(OR.can_butcher(src))
						OR.butcher(src, null, src)	// Butcher it, and add it to our list of things to launch.
					else
						qdel(thing)
					continue

		// DIE MONSTER!
		scanforid(src)
		processcontents()
		update_icon()

/obj/machinery/gibber/proc/preprocessmob(var/mob/M)
	// transfer items
	for(var/obj/item/I in M)
		M.drop_from_inventory(I,src)

	// release prey
	if(isliving(M))
		var/mob/living/L = M
		L.release_vore_contents(silent = TRUE)


/obj/machinery/gibber/proc/scanforid(var/obj/thing)
	// Scan for ID
	if(!isnull(sleevelink))
		var/list/checks = list()
		checks |= thing
		checks |= recursive_content_check(thing,checks, recursion_limit = 5, client_check = FALSE, sight_check = FALSE, include_mobs = FALSE, include_objects = TRUE, ignore_show_messages = TRUE)
		for (var/obj/O in checks)
			if(istype(O, /obj/item/card/id))
				sleevelink.get_id_trigger(O)


/obj/machinery/gibber/proc/processcontents()
	// don't call this if currently processing something else, be careful!
	for (var/obj/thing in contents)
		var/processtobiomass = FALSE
		if(!isnull(sleevelink))
			// PROCESS ORGANICS INTO SLURRY
			if(istype(thing, /obj/item/stack/animalhide) || istype(thing, /obj/item/reagent_containers/food/snacks/meat))
				processtobiomass = TRUE
			else if(istype(thing, /obj/item/organ))
				var/obj/item/organ/O = thing
				if(!O.robotic < ORGAN_ROBOT)
					processtobiomass = TRUE
			else if(istype(thing, /obj/effect/decal/cleanable/blood/gibs))
				if(prob(70))
					processtobiomass = TRUE
		if(processtobiomass)
			// process and destroy
			thing.Destroy()
		else
			thing.forceMove( src.loc) // Drop it onto the turf for throwing.
			thing.throw_at( get_edge_target_turf(thing.loc, gib_throw_dir),rand(1,3),emagged ? 100 : 50) // Being pelted with bits of meat and bone would hurt.

	// if anything survived, toss it out, it was ungibbable
	spawn(12)
		for (var/mob/M in contents)
			M.forceMove( src.loc) // Drop it onto the turf for throwing.
			M.reset_view(null)
			visible_message("<span class='notice'>\The [M] crawls out of the [src] unharmed!</span>")

/obj/machinery/gibber/proc/updatesleever()
	var/obj/machinery/transhuman/autoresleever/S
	for(var/i in cardinal)
		S = locate( /obj/machinery/transhuman/autoresleever, get_step(src.loc, i) )
		if(!isnull(S) && S.anchored)
			S.link_gibber(src)
			break
