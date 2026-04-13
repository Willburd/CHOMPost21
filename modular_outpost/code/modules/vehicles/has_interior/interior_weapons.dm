////////////////////////////////////////////////////////////////////////////////
// Vehicle weaponry

/obj/structure/vehicle_interior_weapon
	name = "vehicle weapon"
	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER+0.1
	w_class = ITEMSIZE_COST_NO_CONTAINER

	var/base_icon = "" // For destruction

	var/weapon_index = -1 // set by the init!
	var/projectile //Type of projectile fired.
	var/projectiles = 1 //Amount of projectiles loaded.
	var/projectiles_per_shot = 1 //Amount of projectiles fired per single shot.
	var/deviation = 0 //Inaccuracy of shots.
	var/fire_cooldown = 0 //Duration of sleep between firing projectiles in single shot.
	var/fire_sound //Sound played while firing.
	var/fire_volume = 50 //How loud it is played.
	var/freeaim = TRUE //If false, the weapon only aims in 8 directions
	var/obj/machinery/computer/vehicle_interior_console/control_console = null

/obj/structure/vehicle_interior_weapon/GotoAirflowDest(n) // weapon is rooted to tank...
	return

/obj/structure/vehicle_interior_weapon/RepelAirflowDest(n) // airflow does not push it around!
	return

/obj/structure/vehicle_interior_weapon/proc/action_checks(atom/target)
	if(projectiles <= 0)
		return FALSE
	return TRUE

/obj/structure/vehicle_interior_weapon/proc/solve_aim_angle(endx, endy)
	var/ev = control_console.interior_controller.extra_view

	// is just /proc/Get_Angle(atom/movable/start,atom/movable/end) but with X/Y on the screen from its center...
	var/startx = (15 + (ev * 2)) / 2
	var/starty = ((15 + (ev * 2)) / 2)
	var/dy = endy - starty
	var/dx = endx - startx
	var/returnangle = 0
	if(!dy)
		return (dx>=0)?90:270
	returnangle = arctan(dx/dy)
	if(dy<0)
		returnangle += 180
	else if(dx<0)
		returnangle += 360

	return returnangle

/obj/structure/vehicle_interior_weapon/proc/action(atom/target, params, mob/user_calling)
	if(!action_checks(target))
		return

	// get clicked location on screen, this is just copied from /proc/screen_loc2turf(scr_loc, turf/origin) but I only want the XY on screen and not a turf
	var/list/pr = params2list(params)
	var/tX = splittext(pr["screen-loc"], ",")
	var/tY = splittext(tX[2], ":")
	tY = tY[1]
	tX = splittext(tX[1], ":")
	tX = tX[1]

	// actually use it!
	var/turf/curloc = control_console.interior_controller.loc
	var/angledir = angle2dir( solve_aim_angle(text2num(tX),text2num(tY)))
	var/turf/targloc = get_turf(target)
	if(!curloc || !targloc)
		return FALSE
	// stop thinking darkness is bottom left of the map, just don't allow firing...
	if(targloc.x == 0 && targloc.y == 0)
		return FALSE

	// turn toward!
	if(dir != angledir)
		update_weapon_turn( angledir)
		return FALSE

	// intent check
	if(user_calling.a_intent == I_HELP && user_calling.client?.prefs?.read_preference(/datum/preference/toggle/safefiring))
		to_chat(user_calling, "<span class='warning'>You refrain from firing the mounted \the [src] as your intent is set to help.</span>")
		return FALSE

	// check if it uses a loader, and is loaded
	var/obj/machinery/ammo_loader/loader
	if(weapon_index <= control_console.interior_controller.internal_loaders_list.len)
		loader = control_console.interior_controller.internal_loaders_list[weapon_index]
	if(loader)
		if(!loader.loaded)
			to_chat(user_calling, "<span class='warning'>You are unable to fire \the [src] as there is no shell loaded.</span>")
			return FALSE
		loader.fire()

	// ACTUALLY fire
	control_console.interior_controller.visible_message("<span class='warning'>[user_calling] fires [src]!</span>")
	to_chat(user_calling,"<span class='warning'>You fire [src]!</span>")
	add_attack_logs(user_calling, target, "Fired vehicle [control_console.interior_controller] weapon [src] (MANUAL)")

	for(var/i = 1 to min(projectiles, projectiles_per_shot))
		var/turf/aimloc = targloc
		if(deviation)
			aimloc = locate(targloc.x+GaussRandRound(deviation,1),targloc.y+GaussRandRound(deviation,1),targloc.z)
		if(!aimloc || aimloc == curloc)
			break

		playsound(control_console.interior_controller, fire_sound, fire_volume, 0.85) // interior
		playsound(control_console, fire_sound, fire_volume, 1) // exterior
		projectiles--

		var/obj/item/projectile/P = new projectile( get_turf(curloc))

		// Free aim allows any angle, but still turns weapon
		var/dirangle = dir2angle(dir)
		if(freeaim)
			dirangle = solve_aim_angle(text2num(tX),text2num(tY));
		Fire(P, target, params, user_calling, dirangle)
		if(fire_cooldown)
			sleep(fire_cooldown)

	// reload
	projectiles = projectiles_per_shot
	return TRUE

/obj/structure/vehicle_interior_weapon/proc/get_pilot_zone_sel(mob/user)
	if(!user.zone_sel || user.stat)
		return BP_TORSO

	return user.zone_sel.selecting

/obj/structure/vehicle_interior_weapon/proc/Fire(atom/A, atom/target, params, mob/user, angle_override)
	if(istype(A, /obj/item/projectile))	// Sanity.
		var/obj/item/projectile/P = A
		P.plane = MOB_PLANE
		P.layer = ABOVE_MOB_LAYER+0.05
		P.dispersion = deviation
		process_accuracy(P, user, target)
		P.launch_projectile_from_turf(target, get_pilot_zone_sel(user), user, params, angle_override)
		return

	if(istype(A, /atom/movable))
		var/atom/movable/AM = A
		AM.throw_at(target, 7, 1, control_console.interior_controller)

/obj/structure/vehicle_interior_weapon/proc/process_accuracy(obj/projectile, mob/living/user, atom/target)
	var/obj/item/projectile/P = projectile
	if(!istype(P))
		return

	P.accuracy -= user.get_accuracy_penalty()

	// Some modifiers make it harder or easier to hit things.
	for(var/datum/modifier/M in user.modifiers)
		if(!isnull(M.accuracy))
			P.accuracy += M.accuracy
		if(!isnull(M.accuracy_dispersion))
			P.dispersion = max(P.dispersion + M.accuracy_dispersion, 0)

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.species)
			P.accuracy += H.species.gun_accuracy_mod
			P.dispersion = max(P.dispersion + H.species.gun_accuracy_dispersion_mod, 0)

/obj/structure/vehicle_interior_weapon/attack_hand(mob/user)
	// ignore

/obj/structure/vehicle_interior_weapon/proc/update_weapon_turn(goaldir)
	// find current direction's angle, find rotation direction, add 45+1 to it, then return the new dir we want to be!
	var/startdir = dir2angle(dir)
	dir = angle2dir(360 + startdir + (SIGN(closer_angle_difference(startdir,dir2angle(goaldir))) * 46))

/obj/structure/vehicle_interior_weapon/ex_act(severity)
	return // No damage

/obj/structure/vehicle_interior_weapon/update_icon()
	. = ..()
	var/dest_state = "";
	if(control_console.interior_controller.health <= 0)
		dest_state = "_dest"
	icon_state = "[base_icon][dest_state]"

//-------------------------------------------
// Internal machines, mostly weapon linked machinery
//-------------------------------------------

/obj/machinery/ammo_storage
	name = "ammunition storage"
	desc = "It's a secure, armored storage unit embedded into the floor. Shells must be dragged out manually."
	icon = 'icons/obj/machines/vehicle_weapons.dmi'
	icon_state = "storage"
	anchored = TRUE
	density = FALSE
	var/ammo_path = /obj/item/tank_shell
	var/ammo_count = 50

/obj/machinery/ammo_storage/MouseDrop(atom/over)
	if(!CanMouseDrop(over, usr))
		return
	if(over != usr)
		return
	if(ammo_count <= 0)
		to_chat( usr, "No shells remain!")
		return

	add_fingerprint(usr)
	usr.visible_message("[usr] begins to extract a shell.", "You begin to extract a shell.")
	playsound(src, 'sound/items/electronic_assembly_empty.ogg', 100, 1)
	if(do_after(usr, 6 SECONDS, target = src) && ammo_count > 0)
		ammo_count--
		var/obj/item/thing = new ammo_path(usr.loc)
		usr.visible_message("[usr] picks up \the [thing].", "You pick up \the [thing].")
		usr.put_in_hands(thing)


/obj/machinery/ammo_storage/ex_act(severity)
	return // no explosive act

/obj/machinery/ammo_storage/attack_hand(mob/user)
	if(ammo_count <= 0)
		to_chat( usr, "No shells remain!")
		return
	if(ammo_count == 1)
		to_chat( usr, "A single shell remains!")
		return
	to_chat( usr, "[ammo_count] shells remain!")

/obj/machinery/ammo_storage/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I,ammo_path))
		if(ammo_count >= initial(ammo_count))
			to_chat( user, "\The [src] is full!")
		else if(do_after(user, 2 SECONDS, target = src))
			if(ammo_count < initial(ammo_count))
				ammo_count++
				user.visible_message("[user] loads a shell into \the [src].", "You load a shell into \the [src].")
				qdel(I)
		return
	attack_hand(user)


/obj/machinery/ammo_loader
	name = "ammunition loader"
	desc = "Loading mechanism for vehicle mounted weapon."
	icon = 'icons/obj/machines/vehicle_weapons.dmi'
	icon_state = "loader"
	anchored = TRUE
	density = TRUE
	var/weapon_index = -1 // set by the init!
	var/ammo_path = /obj/item/tank_shell
	var/loaded = 0
	var/loaded_max = 1

/obj/machinery/ammo_loader/Initialize(mapload)
	. = ..()
	update_icon()

/obj/machinery/ammo_loader/ex_act(severity)
	return 0 // no explosive act

/obj/machinery/ammo_loader/attackby(obj/item/I, mob/user)
	if(!istype(I,ammo_path))
		return
	if(loaded >= loaded_max)
		if(loaded_max == 1)
			to_chat( user, "A shell is already loaded.")
		else
			to_chat( user, "The autoloader is full.")
		return
	if(do_after(user, 2 SECONDS, target = src) && !loaded)
		loaded += 1
		user.visible_message("[user] loads a shell into \the [src].", "You load a shell into \the [src].")
		qdel(I)
		playsound(src, 'sound/machines/turrets/turret_deploy.ogg', 100, 1)
		update_icon()

/obj/machinery/ammo_loader/MouseDrop(atom/over)
	if(!loaded)
		to_chat(usr, "There is nothing loaded.")
		return
	if(!CanMouseDrop(over, usr))
		return
	if(over == usr)
		usr.visible_message("[usr] unloads \the [src].", "You unload \the [src].")
		loaded -= 1
		var/obj/item/thing = new ammo_path(usr.loc)
		usr.put_in_hands(thing)
		playsound(src, 'sound/items/electronic_assembly_empty.ogg', 100, 1)
		update_icon()

/obj/machinery/ammo_loader/proc/fire()
	loaded -= 1
	update_icon()
	flick("loader_fire",src)
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(5, 0, src)
	sparks.attach(loc)
	sparks.start()
	playsound(src, 'sound/machines/hiss.ogg', 50, 1)
	playsound(src, 'sound/machines/machine_die_short.ogg', 100, 1)

/obj/machinery/ammo_loader/update_icon()
	cut_overlays()
	if(!loaded)
		icon_state = "loader"
	else
		icon_state = "loader_loaded"
	add_overlay("loader_top")


// weapon shells
/obj/item/tank_shell
	name = "railgun shell"
	desc = "Heavy ammunition, meant to be fired from a mounted gun."
	icon = 'icons/obj/machines/vehicle_weapons.dmi'
	icon_state = "weapon_shell"
	item_state = "weapon_shell"
	force = 10.0
	w_class = ITEMSIZE_HUGE
	throwforce = 15.0
	throw_speed = 2
	throw_range = 4
