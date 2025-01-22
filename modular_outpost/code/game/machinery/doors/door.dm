/obj/machinery/door/flesh
    name = "Valve"
    desc = "Organic structure that opens on its own."
    icon = 'modular_outpost/icons/turf/stomach.dmi'
    icon_state = "door1"

/obj/machinery/door/flesh/Initialize(mapload)
	// randomize openclose
	. = ..()
	#ifndef UNIT_TEST
	addtimer(CALLBACK(src,PROC_REF(handle_living)),next_close_wait())
	#endif

/obj/machinery/door/flesh/inoperable(var/additional_flags = 0)
    // always works
    return FALSE

/obj/machinery/door/flesh/Bumped(atom/AM)
    // do nothing

/obj/machinery/door/flesh/bullet_act(var/obj/item/projectile/Proj)
    // no damage
    src.health = src.maxhealth

/obj/machinery/door/flesh/hitby(AM as mob|obj, var/speed=5)
    // no damage
    visible_message(span_danger("[src.name] was hit by [AM], with no visible effect."))

/obj/machinery/door/flesh/attackby(obj/item/I as obj, mob/user as mob)
    // no interaction

/obj/machinery/door/flesh/emag_act(var/remaining_charges)
    // no behavior

/obj/machinery/door/flesh/emp_act(severity)
    // immune to
    src.health = src.maxhealth

/obj/machinery/door/flesh/ex_act(severity)
    // immune to
    src.health = src.maxhealth

/obj/machinery/door/flesh/blob_act()
    // even you bob
    src.health = src.maxhealth

/obj/machinery/door/flesh/requiresID()
    return FALSE

/obj/machinery/door/flesh/next_close_wait()
	return rand(5,60) SECONDS

/obj/machinery/door/flesh/proc/handle_living()
	if(!src.density)
		INVOKE_ASYNC(src, PROC_REF(close))
	else
		INVOKE_ASYNC(src, PROC_REF(open))
	addtimer(CALLBACK(src, PROC_REF(handle_living)), next_close_wait())

/obj/machinery/door/flesh/process()
	return PROCESS_KILL // not needed, we handle fleshdoors with timers

/obj/machinery/door/flesh/update_icon(var/update_neighbors)
	cut_overlays()
	. = ..()

	for(var/direction in cardinal)
		var/turf/T = get_step(src,direction)
		if(istype(T) && !T.density)
			var/place_dir = turn(direction, 180)
			var/offset = 32
			if(!flesh_overlay_cache["flesh_side_[place_dir]"])
				flesh_overlay_cache["flesh_side_[place_dir]"] = image('icons/turf/stomach_vr.dmi', "flesh_side", dir = place_dir)
				var/image/cache = null
				switch(direction)
					if(NORTH)
						cache = flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_y = offset
					if(SOUTH)
						cache = flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_y = -offset
					if(EAST)
						cache = flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_x = offset
					if(WEST)
						cache = flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_x = -offset
			add_overlay(flesh_overlay_cache["flesh_side_[place_dir]"])

/obj/machinery/door/flesh/open()
	playsound(src, 'sound/effects/blobattack.ogg', 100, 1)
	. = ..()

/obj/machinery/door/flesh/close()
	playsound(src, 'sound/effects/squelch1.ogg', 100, 1)
	for(var/turf/turf in locs)
		for(var/atom/movable/AM in turf)
			AM.airlock_crush(DOOR_CRUSH_DAMAGE * 3) // these don't care, you're crushed by the muscles of a mountain sized organism. It's your fault for being in here.
	. = ..()
