/obj/machinery/door/flesh
    name = "Valve"
    desc = "Organic structure that opens on its own."
    icon = 'icons/turf/stomach_op.dmi'
    icon_state = "door1"

/obj/machinery/door/flesh/Initialize(mapload)
    // randomize openclose
    close_door_at = world.time + next_close_wait()
    . = ..()

/obj/machinery/door/flesh/inoperable(var/additional_flags = 0)
    // always works
    return FALSE

/obj/machinery/door/flesh/Bumped(atom/AM)
    // do nothing

/obj/machinery/door/flesh/bullet_act(var/obj/item/projectile/Proj)
    // no damage

/obj/machinery/door/flesh/hitby(AM as mob|obj, var/speed=5)
    // no damage
    visible_message("<span class='danger'>[src.name] was hit by [AM], with no visible effect.</span>")

/obj/machinery/door/flesh/attackby(obj/item/I as obj, mob/user as mob)
    // no interaction

/obj/machinery/door/flesh/emag_act(var/remaining_charges)
    // no behavior

/obj/machinery/door/flesh/emp_act(severity)
    // immune to

/obj/machinery/door/flesh/ex_act(severity)
    // immune to

/obj/machinery/door/flesh/blob_act()
    // even you bob

/obj/machinery/door/flesh/requiresID()
    return FALSE

/obj/machinery/door/flesh/examine(mob/user)
    src.health = src.maxhealth // force heal, never show status
    . = ..()

/obj/machinery/door/flesh/next_close_wait()
	return rand(200,5000)

/obj/machinery/door/flesh/process()
	#if !UNIT_TEST
	if(close_door_at >= 0 && world.time >= close_door_at)
		close_door_at = -1 // wait till ready
		if(!src.density)
			spawn(0)
				close()
				close_door_at = world.time + next_close_wait()
		else
			spawn(0)
				open()
				close_door_at = world.time + next_close_wait()
	#endif

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
