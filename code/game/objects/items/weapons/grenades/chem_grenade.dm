/obj/item/grenade/chem_grenade
	name = "grenade casing"
	icon_state = "chemg"
	item_state = "grenade"
	desc = "A hand made chemical grenade."
	w_class = ITEMSIZE_SMALL
	force = 2.0
	det_time = null
	unacidable = TRUE

	var/stage = 0
	var/state = 0
	var/path = 0
	/// If TRUE, grenade is permanently sealed when fully assembled, useful for things like off-the-shelf grenades.
	var/sealed = FALSE
	var/obj/item/assembly_holder/detonator = null
	var/list/beakers = new/list()
	var/list/allowed_containers = list(/obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/glass/bottle)
	var/affected_area = 3

/obj/item/grenade/chem_grenade/Initialize(mapload)
	. = ..()
	create_reagents(1000)

/obj/item/grenade/chem_grenade/Destroy()
	QDEL_NULL(detonator)
	QDEL_LIST_NULL(beakers)
	return ..()

/obj/item/grenade/chem_grenade/attack_self(mob/user as mob)
	if(!stage || stage==1)
		if(detonator)
//				detonator.loc=src.loc
			detonator.detached()
			user.put_in_hands(detonator)
			detonator=null
			det_time = null
			stage=0
			icon_state = initial(icon_state)
		else if(beakers.len)
			for(var/obj/B in beakers)
				if(istype(B))
					beakers -= B
					user.put_in_hands(B)
		name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
	if(stage > 1 && !active && clown_check(user))
		to_chat(user, span_warning("You prime \the [name]!"))

		msg_admin_attack("[key_name_admin(user)] primed \a [src]")

		activate()
		add_fingerprint(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_on()

/obj/item/grenade/chem_grenade/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/assembly_holder) && (!stage || stage==1) && !detonator && path != 2)
		var/obj/item/assembly_holder/det = W
		if(istype(det.a_left,det.a_right.type) || (!isigniter(det.a_left) && !isigniter(det.a_right)))
			to_chat(user, span_warning("Assembly must contain one igniter."))
			return
		if(!det.secured)
			to_chat(user, span_warning("Assembly must be secured with screwdriver."))
			return
		path = 1
		to_chat(user, span_notice("You add [W] to the metal casing."))
		playsound(src, 'sound/items/Screwdriver2.ogg', 25, -3)
		user.remove_from_mob(det)
		det.loc = src
		detonator = det
		if(istimer(detonator.a_left))
			var/obj/item/assembly/timer/T = detonator.a_left
			det_time = 10*T.time
		if(istimer(detonator.a_right))
			var/obj/item/assembly/timer/T = detonator.a_right
			det_time = 10*T.time
		icon_state = initial(icon_state) +"_ass"
		name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
		stage = 1
	else if(W.has_tool_quality(TOOL_SCREWDRIVER) && path != 2)
		if(stage == 1)
			path = 1
			if(beakers.len)
				to_chat(user, span_notice("You lock the assembly."))
				name = "grenade"
			else
//					to_chat(user, span_warning("You need to add at least one beaker before locking the assembly."))
				to_chat(user, span_notice("You lock the empty assembly."))
				name = "fake grenade"
			playsound(src, W.usesound, 50, 1)
			icon_state = initial(icon_state) +"_locked"
			stage = 2
		else if(stage == 2)
			if(active && prob(95))
				to_chat(user, span_warning("You trigger the assembly!"))
				detonate()
			else if(sealed)
				to_chat(user, span_warning("This grenade lacks a way to disassemble it."))
			else
				to_chat(user, span_notice("You unlock the assembly."))
				playsound(src, W.usesound, 50, -3)
				name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
				icon_state = initial(icon_state) + (detonator?"_ass":"")
				stage = 1
				active = 0
	else if(is_type_in_list(W, allowed_containers) && (!stage || stage==1) && path != 2)
		path = 1
		if(beakers.len == 2)
			to_chat(user, span_warning("The grenade can not hold more containers."))
			return
		else
			if(W.reagents.total_volume)
				to_chat(user, span_notice("You add \the [W] to the assembly."))
				user.drop_item()
				W.loc = src
				beakers += W
				stage = 1
				name = "unsecured grenade with [beakers.len] containers[detonator?" and detonator":""]"
			else
				to_chat(user, span_warning("\The [W] is empty."))

/obj/item/grenade/chem_grenade/examine(mob/user)
	. = ..()
	if(detonator)
		. += "It has [detonator.name] attached to it."

/obj/item/grenade/chem_grenade/activate(mob/user as mob)
	if(active) return

	if(detonator)
		if(!isigniter(detonator.a_left))
			detonator.a_left.activate()
			active = 1
		if(!isigniter(detonator.a_right))
			detonator.a_right.activate()
			active = 1
	if(active)
		icon_state = initial(icon_state) + "_active"

		if(user)
			msg_admin_attack("[key_name_admin(user)] primed \a [src.name]")

	return

/obj/item/grenade/chem_grenade/proc/primed(var/primed = 1)
	if(active)
		icon_state = initial(icon_state) + (primed?"_primed":"_active")

/obj/item/grenade/chem_grenade/detonate(var/sound = TRUE) // Outpost 21 edit - added sound parameter
	if(!stage || stage<2) return

	var/has_reagents = 0
	for(var/obj/item/reagent_containers/glass/G in beakers)
		if(G.reagents.total_volume) has_reagents = 1

	active = 0
	if(!has_reagents)
		icon_state = initial(icon_state) +"_locked"
		if(sound) // Outpost 21 edit - added sound parameter
			playsound(src, 'sound/items/Screwdriver2.ogg', 50, 1)
		spawn(0) //Otherwise det_time is erroneously set to 0 after this
			if(istimer(detonator.a_left)) //Make sure description reflects that the timer has been reset
				var/obj/item/assembly/timer/T = detonator.a_left
				det_time = 10*T.time
			if(istimer(detonator.a_right))
				var/obj/item/assembly/timer/T = detonator.a_right
				det_time = 10*T.time
		return

	if(sound) // Outpost 21 edit - added sound parameter
		playsound(src, 'sound/effects/bamf.ogg', 50, 1)

	for(var/obj/item/reagent_containers/glass/G in beakers)
		G.reagents.trans_to_obj(src, G.reagents.total_volume)

	if(src.reagents.total_volume) //The possible reactions didnt use up all reagents.
		var/datum/effect/effect/system/steam_spread/steam = new /datum/effect/effect/system/steam_spread()
		steam.set_up(10, 0, get_turf(src))
		steam.attach(src)
		steam.start()

		for(var/atom/A in view(affected_area, src.loc))
			if( A == src ) continue
			src.reagents.touch(A)

	if(istype(loc, /mob/living/carbon))		//drop dat grenade if it goes off in your hand
		var/mob/living/carbon/C = loc
		C.drop_from_inventory(src)
		C.throw_mode_off()

	invisibility = INVISIBILITY_MAXIMUM //Why am i doing this?
	spawn(50)		   //To make sure all reagents can work
		qdel(src)	   //correctly before deleting the grenade.


/obj/item/grenade/chem_grenade/large
	name = "large chem grenade"
	desc = "An oversized grenade that affects a larger area."
	icon_state = "large_grenade"
	allowed_containers = list(/obj/item/reagent_containers/glass)
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3)
	affected_area = 4

/obj/item/grenade/chem_grenade/metalfoam
	name = "metal-foam grenade"
	desc = "Used for emergency sealing of air breaches."
	icon_state = "foam"
	path = 1
	stage = 2
	sealed = TRUE

/obj/item/grenade/chem_grenade/metalfoam/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(REAGENT_ID_ALUMINIUM, 30)
	B2.reagents.add_reagent(REAGENT_ID_FOAMINGAGENT, 10)
	B2.reagents.add_reagent(REAGENT_ID_PACID, 10)

	detonator = new/obj/item/assembly_holder/timer_igniter(src)

	beakers += B1
	beakers += B2

/obj/item/grenade/chem_grenade/incendiary
	name = "incendiary grenade"
	desc = "Used for clearing rooms of living things."
	icon_state = "incendiary"
	path = 1
	stage = 2
	sealed = TRUE

/obj/item/grenade/chem_grenade/incendiary/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(REAGENT_ID_ALUMINIUM, 15)
	B1.reagents.add_reagent(REAGENT_ID_FUEL,20)
	B2.reagents.add_reagent(REAGENT_ID_PHORON, 15)
	B2.reagents.add_reagent(REAGENT_ID_SACID, 15)
	B1.reagents.add_reagent(REAGENT_ID_FUEL,20)

	detonator = new/obj/item/assembly_holder/timer_igniter(src)

	beakers += B1
	beakers += B2

/obj/item/grenade/chem_grenade/antiweed
	name = "weedkiller grenade"
	desc = "Used for purging large areas of invasive plant species. Contents under pressure. Do not directly inhale contents."
	path = 1
	stage = 2
	sealed = TRUE

/obj/item/grenade/chem_grenade/antiweed/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(REAGENT_ID_PLANTBGONE, 25)
	B1.reagents.add_reagent(REAGENT_ID_POTASSIUM, 25)
	B2.reagents.add_reagent(REAGENT_ID_PHOSPHORUS, 25)
	B2.reagents.add_reagent(REAGENT_ID_SUGAR, 25)

	detonator = new/obj/item/assembly_holder/timer_igniter(src)

	beakers += B1
	beakers += B2
	icon_state = "grenade"

/obj/item/grenade/chem_grenade/cleaner
	name = "cleaner grenade"
	desc = "BLAM!-brand foaming space cleaner. In a special applicator for rapid cleaning of wide areas."
	icon_state = "cleaner"
	stage = 2
	path = 1
	sealed = TRUE

/obj/item/grenade/chem_grenade/cleaner/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(REAGENT_ID_FLUOROSURFACTANT, 40)
	B2.reagents.add_reagent(REAGENT_ID_WATER, 40)
	B2.reagents.add_reagent(REAGENT_ID_CLEANER, 10)

	detonator = new/obj/item/assembly_holder/timer_igniter(src)

	beakers += B1
	beakers += B2

/obj/item/grenade/chem_grenade/teargas
	name = "tear gas grenade"
	desc = "Concentrated Capsaicin. Contents under pressure. Use with caution."
	icon_state = "teargas"
	stage = 2
	path = 1
	sealed = TRUE

/obj/item/grenade/chem_grenade/teargas/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/large/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/large/B2 = new(src)

	B1.reagents.add_reagent(REAGENT_ID_PHOSPHORUS, 40)
	B1.reagents.add_reagent(REAGENT_ID_POTASSIUM, 40)
	B1.reagents.add_reagent(REAGENT_ID_CONDENSEDCAPSAICIN, 40)
	B2.reagents.add_reagent(REAGENT_ID_SUGAR, 40)
	B2.reagents.add_reagent(REAGENT_ID_CONDENSEDCAPSAICIN, 80)

	detonator = new/obj/item/assembly_holder/timer_igniter(src)

	beakers += B1
	beakers += B2
