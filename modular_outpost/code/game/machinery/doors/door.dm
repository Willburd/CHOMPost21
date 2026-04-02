/obj/machinery/door/flesh
	name = "Valve"
	desc = "Organic structure that opens on its own."
	icon = 'modular_outpost/icons/turf/stomach.dmi'
	icon_state = "door1"
	var/stented = FALSE

/obj/machinery/door/flesh/Initialize(mapload)
	// randomize openclose
	. = ..()
	#ifndef UNIT_TESTS
	addtimer(CALLBACK(src,PROC_REF(handle_living)),next_close_wait())
	#endif

/obj/machinery/door/flesh/inoperable(var/additional_flags = 0)
	// always works
	return FALSE

/obj/machinery/door/flesh/Bumped(atom/AM)
	// do nothing

/obj/machinery/door/flesh/bullet_act(var/obj/item/projectile/Proj)
	// no damage
	health = maxhealth

/obj/machinery/door/flesh/hitby(AM as mob|obj, var/speed=5)
	// no damage
	visible_message(span_danger("[name] was hit by [AM], with no visible effect."))

/obj/machinery/door/flesh/attackby(obj/item/I as obj, mob/user)
	if(istype(I, /obj/item/stent_kit))
		user.visible_message("\the [user] begins stenting \the [src] open!")
		if(do_after(user, 8 SECONDS, target = src))
			user.drop_from_inventory(I)
			qdel(I)
			apply_stent()
		return

/obj/machinery/door/flesh/attack_hand(mob/user)
	if(!stented)
		return
	user.visible_message("\the [user] pulls out the stent!")
	user.put_in_active_hand(new /obj/item/stent_kit(get_turf(src)))
	stented = FALSE
	update_icon()
	close() // Reflexive

/obj/machinery/door/flesh/attack_generic(mob/user, damage)
	attack_hand(user)

/obj/machinery/door/flesh/attack_alien(mob/user)
	attack_hand(user)

/obj/machinery/door/flesh/emag_act(var/remaining_charges)
	// no behavior

/obj/machinery/door/flesh/emp_act(severity, recursive)
	// immune to
	health = maxhealth

/obj/machinery/door/flesh/ex_act(severity)
	// immune to
	health = maxhealth

/obj/machinery/door/flesh/blob_act()
	// even you bob
	health = maxhealth

/obj/machinery/door/flesh/requiresID()
	return FALSE

/obj/machinery/door/flesh/next_close_wait()
	return rand(5,40) SECONDS

/obj/machinery/door/flesh/proc/handle_living()
	if(!stented)
		if(!density)
			addtimer(CALLBACK(src, PROC_REF(close)), 1)
		else
			addtimer(CALLBACK(src, PROC_REF(open)), 1)
	else
		playsound(src, 'sound/machines/door/airlock_creaking.ogg', 100, 1)
		if(prob(20)) // KABLAM!
			addtimer(CALLBACK(src, PROC_REF(break_stent)), rand(2,4) SECONDS)
			return
	addtimer(CALLBACK(src, PROC_REF(handle_living)), next_close_wait())

/obj/machinery/door/flesh/proc/apply_stent()
	stented = TRUE
	update_icon()
	if(density)
		open()

/obj/machinery/door/flesh/proc/break_stent()
	if(stented) // just incase
		stented = FALSE
		update_icon()
		playsound(src, 'sound/machines/door/airlockforced.ogg', 70, 1)
		// Throw some rods around
		var/obj/item/stack/rods/throw_rod = (new /obj/item/stack/rods(get_turf(src)))
		throw_rod.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), 3, 1)
		throw_rod = new /obj/item/stack/rods(get_turf(src))
		throw_rod.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), 3, 1)
		if(prob(10))
			throw_rod = new /obj/item/stack/rods(get_turf(src))
			throw_rod.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), 3, 1)
	// Scrunch
	close()
	addtimer(CALLBACK(src, PROC_REF(handle_living)), next_close_wait())

/obj/machinery/door/flesh/process()
	return PROCESS_KILL // not needed, we handle fleshdoors with timers

/obj/machinery/door/flesh/update_icon(var/update_neighbors)
	cut_overlays()
	. = ..()

	for(var/direction in GLOB.cardinal)
		var/turf/T = get_step(src,direction)
		if(istype(T) && !T.density)
			var/place_dir = turn(direction, 180)
			var/offset = 32
			if(!GLOB.flesh_overlay_cache["flesh_side_[place_dir]"])
				GLOB.flesh_overlay_cache["flesh_side_[place_dir]"] = image('icons/turf/stomach_vr.dmi', "flesh_side", dir = place_dir)
				var/image/cache = null
				switch(direction)
					if(NORTH)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_y = offset
					if(SOUTH)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_y = -offset
					if(EAST)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_x = offset
					if(WEST)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_x = -offset
			add_overlay(GLOB.flesh_overlay_cache["flesh_side_[place_dir]"])

	if(stented)
		add_overlay(image('modular_outpost/icons/turf/stomach.dmi', "stent"))

/obj/machinery/door/flesh/open()
	playsound(src, 'sound/effects/blobattack.ogg', 100, 1)
	. = ..()

/obj/machinery/door/flesh/close()
	if(stented)
		return
	playsound(src, 'sound/effects/squelch1.ogg', 100, 1)
	for(var/turf/turf in locs)
		for(var/atom/movable/AM in turf)
			AM.airlock_crush(DOOR_CRUSH_DAMAGE * 3) // these don't care, you're crushed by the muscles of a mountain sized organism. It's your fault for being in here.
	. = ..()
