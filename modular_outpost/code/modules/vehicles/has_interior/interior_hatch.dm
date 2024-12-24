////////////////////////////////////////////////////////////////////////////////
// interior entrance hatch objects
/obj/effect/landmark/vehicle_interior/entrypos 	// where mobs are placed on entering the tank
	name = "interior entrypos"


/obj/machinery/door/vehicle_interior_hatch			// click door to exit vehicle
	name = "vehicle exit"
	desc = "Hatch that leaves the vehicle."
	icon = 'icons/obj/doors/Doorele.dmi'
	icon_state = "door_closed"
	light_range = 1 // so visible in dark interiors
	var/obj/vehicle/has_interior/controller/interior_controller = null
	var/denied_sound = 'sound/machines/deniedbeep.ogg'
	var/bolt_up_sound = 'sound/machines/door/boltsup.ogg'
	var/bolt_down_sound = 'sound/machines/door/boltsdown.ogg'
	var/locked = FALSE

/obj/machinery/door/vehicle_interior_hatch/inoperable(var/additional_flags = 0)
    // always works
    return FALSE

/obj/machinery/door/vehicle_interior_hatch/Bumped(atom/AM)
    // do nothing

/obj/machinery/door/vehicle_interior_hatch/bullet_act(var/obj/item/projectile/Proj)
    // no damage

/obj/machinery/door/vehicle_interior_hatch/hitby(AM as mob|obj, var/speed=5)
    // no damage
    visible_message( span_danger("[src.name] was hit by [AM], with no visible effect."))

/obj/machinery/door/vehicle_interior_hatch/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/attackby(obj/item/I as obj, mob/user as mob)
	if(locked)
		do_animate("deny")
		return
	if(!Adjacent(user))
		return

	// successful, begin exit!
	user.visible_message( span_notice("[user] starts leaving the [interior_controller]."), span_notice("You start leaving the [interior_controller]."))
	if(do_after(user, 20))
		if(Adjacent(user))
			interior_controller.exit_interior(user)

/obj/machinery/door/vehicle_interior_hatch/attack_robot(mob/living/user)
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/attack_ai(mob/user)
	return
	// no behavior

/obj/machinery/door/vehicle_interior_hatch/attack_generic(mob/user as mob)
	// aliens/borers
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/emag_act(var/remaining_charges)
	return
    // no behavior

/obj/machinery/door/vehicle_interior_hatch/emp_act(severity)
	return
    // immune to

/obj/machinery/door/vehicle_interior_hatch/take_damage(damage)
	return
    // immune to

/obj/machinery/door/vehicle_interior_hatch/ex_act(severity)
	return
    // immune to

/obj/machinery/door/vehicle_interior_hatch/blob_act()
	return
    // even you bob

/obj/machinery/door/vehicle_interior_hatch/requiresID()
    return FALSE

/obj/machinery/door/vehicle_interior_hatch/examine(mob/user)
    src.health = src.maxhealth // force heal, never show status
    . = ..()

/obj/machinery/door/vehicle_interior_hatch/process()
	return PROCESS_KILL

/obj/machinery/door/vehicle_interior_hatch/update_icon()
	if(density)
		if(locked)
			icon_state = "door_locked"
		else
			icon_state = "door_closed"
	else
		icon_state = "door_open"
	return

/obj/machinery/door/vehicle_interior_hatch/do_animate(animation)
	switch(animation)
		if("deny")
			if(density)
				flick("door_deny", src)
				playsound(src, denied_sound, 50, 0, 3)
	return

/obj/machinery/door/vehicle_interior_hatch/proc/lock()
	if(locked)
		return 0

	src.locked = 1
	playsound(src, bolt_down_sound, 30, 0, 3, volume_channel = VOLUME_CHANNEL_DOORS)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return 1

/obj/machinery/door/vehicle_interior_hatch/proc/unlock()
	if(!src.locked)
		return

	src.locked = 0
	playsound(src, bolt_up_sound, 30, 0, 3, volume_channel = VOLUME_CHANNEL_DOORS)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return 1
