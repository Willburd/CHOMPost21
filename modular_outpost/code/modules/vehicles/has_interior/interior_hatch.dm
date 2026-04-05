////////////////////////////////////////////////////////////////////////////////
// interior entrance hatch objects
/obj/effect/landmark/vehicle_interior/entrypos 	// where mobs are placed on entering the tank
	name = "interior entrypos"


/obj/structure/vehicle_interior_hatch			// click door to exit vehicle
	name = "vehicle exit"
	desc = "Hatch that leaves the vehicle."
	icon = 'icons/obj/doors/Doorele.dmi'
	density = TRUE
	icon_state = "door_closed"
	light_range = 1 // so visible in dark interiors
	var/obj/vehicle/has_interior/interior_controller = null
	var/denied_sound = 'sound/machines/deniedbeep.ogg'
	var/bolt_up_sound = 'sound/machines/door/boltsup.ogg'
	var/bolt_down_sound = 'sound/machines/door/boltsdown.ogg'
	var/locked = FALSE

/obj/structure/vehicle_interior_hatch/hitby(AM as mob|obj, var/speed=5)
	visible_message( span_danger("[src.name] was hit by [AM], with no visible effect."))
	. = ..()

/obj/structure/vehicle_interior_hatch/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	attack_hand( user)

/obj/structure/vehicle_interior_hatch/attackby(obj/item/I, mob/user)
	attack_hand( user)

/obj/structure/vehicle_interior_hatch/attack_hand(mob/user)
	if(locked)
		flick("door_deny", src)
		playsound(src, denied_sound, 50, 0, 3)
		return
	if(!Adjacent(user))
		return

	// successful, begin exit!
	user.visible_message( span_notice("[user] starts leaving the [interior_controller]."), span_notice("You start leaving the [interior_controller]."))
	if(do_after(user, 2 SECONDS, target = src))
		if(Adjacent(user))
			interior_controller.exit_interior(user)

/obj/structure/vehicle_interior_hatch/attack_robot(mob/living/user)
	attack_hand( user)

/obj/structure/vehicle_interior_hatch/attack_generic(mob/user as mob)
	// aliens/borers
	attack_hand( user)

/obj/structure/vehicle_interior_hatch/attack_ai(mob/user)
	return
	// no behavior

/obj/structure/vehicle_interior_hatch/emp_act(severity, recursive)
	return
	// immune to

/obj/structure/vehicle_interior_hatch/ex_act(severity)
	return
	// immune to

/obj/structure/vehicle_interior_hatch/blob_act()
	return
	// even you bob

/obj/structure/vehicle_interior_hatch/attack_ghost(mob/user)
	user.forceMove(interior_controller.exitpos) // Ghosts warp out

/obj/structure/vehicle_interior_hatch/update_icon()
	if(locked)
		icon_state = "door_locked"
		return
	icon_state = "door_closed"

/obj/structure/vehicle_interior_hatch/proc/lock()
	if(locked)
		return 0

	src.locked = 1
	playsound(src, bolt_down_sound, 30, 0, 3, volume_channel = VOLUME_CHANNEL_DOORS)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return 1

/obj/structure/vehicle_interior_hatch/proc/unlock()
	if(!src.locked)
		return

	src.locked = 0
	playsound(src, bolt_up_sound, 30, 0, 3, volume_channel = VOLUME_CHANNEL_DOORS)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return 1
