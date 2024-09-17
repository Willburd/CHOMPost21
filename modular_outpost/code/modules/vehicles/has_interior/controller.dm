/obj/vehicle/has_interior/controller
	/*=================================================================
	Explaination:
		This is the core of the vehicle's code. It handles multi-tile movement,
		running things over, etc. Players that click the vehicle can enter it
		from whatever tile is specific as the entrance tile. They will be teleported
		to the 'interior_area' specified, at the 'vehicle_interior/entrypos' landmark
		in that area.

		This 'interior_area' also scans for certain seats and consoles defined
		in this file. Each child object of this controller can have different
		seat and console requirements, such as driver, gunner, maingun, loader, etc.
		For example, an APC wouldn't have a maingun, but instead multiple gunners.
		Placing a main gun inside it would not work, as the child object itself does
		not have a main gun defined on the exterior of the vehicle. The vehicle itself
		also requires every seat and console for each gunner present.
	=================================================================*/

	name = "interior capable vehicle controller"

	desc = "If you can read this, something is wrong."
	description_info = "..."

	icon = 'icons/obj/vehicles_160x160.dmi'
	icon_state = "sec_apc"

	// lorge boi
	bound_width = 96
	bound_height = 96
	bound_x = -32
	bound_y = -32

	// graphics offset of lorge boi
	old_x = -64
	old_y = -64
	pixel_x = -64
	pixel_y = -64

	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER

	locked = 0
	load_item_visible = FALSE
	var/obj/item/weapon/key/key
	var/key_type = /obj/item/weapon/key/cargo_train // override me
	var/breakwalls = FALSE
	var/has_breaking_speed = TRUE // if becomes stopped by a wall, this becomes false, until we are able to free move again (including reversing)
	var/headlight_maxrange = 10
	var/headlights_enabled = FALSE
	var/extra_view = 4 // how much the view is increased by when the mob is in tank view

	// area needed for each unique vehicle interior!
	// Cannot share map locations either.
	// DO NOT SET IN CHILD OBJECTS, this is for MAPPERS to set!
	var/interior_area = null
	var/list/weapons_equiped = null // /obj/item/vehicle_interior_weapon type list that populates internal_weapons_list
	var/list/weapons_draw_offset = null // format is weaponarray[ DIR[x,y] ]

	var/exit_door_direction = SOUTH // if vehicle is facing north, what direction do things leaving it go in? They appear outside the collision box, and only if they can stand there.

	// set AUTOMAGICALLY by init! DO NOT SET
	var/area/intarea = null
	var/turf/entrypos = null // where to place atoms that enter the interior
	var/turf/exitpos = null // where to place atoms that enter the interior
	var/obj/machinery/door/vehicle_interior_hatch/entrance_hatch = null
	var/obj/machinery/computer/vehicle_interior_console/interior_helm = null // driving console
	var/list/internal_weapons_list = list()
	var/list/internal_loaders_list = list() // ammo is put into this and used up by mainguns
	var/cached_dir // used for weapon position being retained in moved()

	var/haskey = TRUE

	var/has_camera = TRUE
	var/obj/machinery/camera/camera = null

	var/datum/looping_sound/move_loop

//-------------------------------------------
// Standard procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/New()
	. = ..()
	cell = new /obj/item/weapon/cell/high(src)
	if(haskey)
		key = new key_type(src)
	for(var/weapon_type in weapons_equiped)
		internal_weapons_list.Add(new weapon_type(loc))
		internal_loaders_list.Add(null)
	if(has_camera && !camera)
		camera = new /obj/machinery/camera(src)
		camera.c_tag = "[name] ([rand(1000,9999)])" // camera bullshit needs unique name
		camera.replace_networks(list(NETWORK_DEFAULT,NETWORK_ROBOTS))
	interior_vehicle_list += src

/obj/vehicle/has_interior/controller/Initialize()
	// find interior entrypos
	for(var/area/A)
		if(istype( A, interior_area))
			intarea = A // become reference...
			for(var/turf/T in intarea.get_contents())
				if(istype(T))
					// TODO - make all one typechecking loop instead of 10 lol

					// scan for interior drop location
					if(istype( locate(/obj/effect/landmark/vehicle_interior/entrypos) in T.contents, /obj/effect/landmark/vehicle_interior/entrypos))
						entrypos = T
					// scan for exit door
					for(var/obj/machinery/door/vehicle_interior_hatch/R in T.contents)
						R.interior_controller = src // set controller so we can leave this vehicle!
						entrance_hatch = R
					// scan for consoles
					for(var/obj/machinery/computer/vehicle_interior_console/C in T.contents)
						C.desc = "Used to pilot the [name]. Use ctrl-click to quickly toggle the engine if you're adjacent. Alt-click will grab the keys, if present."
						C.interior_controller = src
						if(istype(C,/obj/machinery/computer/vehicle_interior_console/helm))
							remote_turn_off()		//so engine verbs are correctly set
							interior_helm = C 		// update vehicle, we found the pilot seat, so we know which console is the drivers!

						for(var/obj/structure/bed/chair/vehicle_interior_seat/S in get_step(C.loc,C.dir))
							S.paired_console = C
							C.paired_seat = S
							C.paired_seat.name = C.name + " Seat"
							break

						if(C.controls_weapon_index > 0)
							var/obj/item/vehicle_interior_weapon/W = internal_weapons_list[C.controls_weapon_index]
							W.weapon_index = C.controls_weapon_index
							W.control_console = C // link weapon to console
							// rotate weapon to facing angle of vehicle
							W.dir = dir
					// scan for loaders
					for(var/obj/machinery/ammo_loader/L in T.contents)
						internal_loaders_list[L.weapon_index] = L

	// set exit pos
	update_exit_pos()
	cached_dir = dir

	if(!istype(intarea))
		log_debug("Interior vehicle [name] was missing a defined area! Could not init...")
	else
		// load all interior parts as components of vehicle!
		log_debug("Interior vehicle [name] setting up...")

	. = ..()

/obj/vehicle/has_interior/controller/ex_act(severity)
	// sparking!
	for(var/turf/T in intarea.get_contents())
		if(prob(30) && istype(T))
			var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
			sparks.set_up(3, 0, T)
			sparks.attach(T)
			sparks.start()

	// noise!
	playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

	// make a smaller explosion inside
	explosion(entrance_hatch, 0, 0, 4-severity, 8)

    // disable ex_act destruction, would lead to gamebreaking behaviors
	if(severity == 3)
		take_damage(1)
	if(severity == 2)
		take_damage(3)
	if(severity == 1)
		take_damage(5)

/obj/vehicle/has_interior/controller/relaymove(mob/user, direction)
	if(stat)
		// Destroyed
		return FALSE

	if(on)
		// attempt destination
		cached_dir = dir // update cached dir
		var/could_move = FALSE
		var/turf/newloc = get_step(src, direction)

		if(user.stat || !user.canmove)
			// knocked out controller
			return FALSE

		// stairs check
		for(var/obj/structure/stairs/S in newloc)
			could_move = Move(newloc, direction) // move to pos,
			if(!could_move && S.dir == direction) // bumped back step...
				S.use_stairs(src, newloc) // ... so use stairs!
				start_move_sound()
				return TRUE
			return could_move // stop movement here, do not break walls

		// standard move
		var/turf/checkm = get_step(newloc, direction)
		var/turf/checka = get_step(checkm, NORTH)
		var/turf/checkb = get_step(checkm, SOUTH)
		if(direction == NORTH || direction == SOUTH)
			checka = get_step(checkm, EAST)
			checkb = get_step(checkm, WEST)

		// tank only likes to turn if able to move, cannot 180!
		could_move = Move(newloc, direction)
		if(!could_move)
			// normally called from Moved()!
			if(dir == reverse_direction(cached_dir))
				dir = cached_dir // hold direction...

		// break things we run over, IS A WIDE BOY
		smash_at_loc(checkm) // at destination
		if(!could_move) crush_mobs_at_loc(checkm)
		smash_at_loc(checka) // and at --
		if(!could_move) crush_mobs_at_loc(checka)
		smash_at_loc(checkb) // -- each side
		if(!could_move) crush_mobs_at_loc(checkb)

		// UNRELENTING VIOLENCE
		for(var/turf/T in locs)
			crush_mobs_at_loc(T)

		start_move_sound()
		return could_move
	return FALSE

/obj/vehicle/has_interior/controller/Moved(atom/old_loc, direction, forced = FALSE, movetime)
	. = ..()
	// Always update weapon location after move
	update_weapons_location(loc)
	// restore breaking speed
	has_breaking_speed = TRUE
	if(dir == reverse_direction(cached_dir))
		dir = cached_dir // hold direction...

/obj/vehicle/has_interior/controller/proc/shake_cab()
	for(var/mob/living/M in intarea)
		if(!M.buckled)
			shake_camera(M, 0.5, 0.1)

/obj/vehicle/has_interior/controller/Bump(atom/Obstacle)
	if(!istype(Obstacle, /atom/movable))
		return

	var/atom/movable/A = Obstacle
	var/turf/T = get_step(A, dir)
	if(isturf(T))
		if(istype(A, /obj))//Then we check for regular obstacles.
			/* I'm not sure if this works with portals at all due to chaining shenanigans, I'm only fixing stairs here, TODO?
			if(istype(A, /obj/effect/portal))	//derpfix
				src.anchored = 0				// Portals can only move unanchored objects.
				A.Crossed(src)
				spawn(0)//countering portal teleport spawn(0), hurr
					src.anchored = 1
			*/
			if(A.anchored)
				A.Bumped(src) //bonk
			else
				A.Move(T)	  //bump things away when hit

//trains are commonly open topped, so there is a chance the projectile will hit the mob riding the train instead
/obj/vehicle/has_interior/controller/bullet_act(var/obj/item/projectile/Proj)
	. = ..()

/obj/vehicle/has_interior/controller/update_icon()
	. = ..()
	update_weapons_location(loc)

/obj/vehicle/has_interior/controller/proc/update_weapons_location(var/newloc)
	for(var/obj/item/vehicle_interior_weapon/W in internal_weapons_list)
		if(istype(W,/obj/item/vehicle_interior_weapon) && W.weapon_index != -1)
			W.loc = newloc
			var/list/dirlist = weapons_draw_offset[W.weapon_index] // get sublist, sorted by directions
			var/list/offsetxylist = dirlist["[dir]"] // get subsublist with x and y inside
			W.pixel_x = offsetxylist[1]
			W.pixel_y = offsetxylist[2]

/obj/vehicle/has_interior/controller/Destroy()
	update_weapons_location(loc)
	if(on)
		remote_turn_off()
	if(move_loop)
		stop_move_sound()
		qdel(move_loop)
		move_loop = null
	. = ..()
	interior_vehicle_list -= src;

/obj/vehicle/has_interior/controller/proc/start_move_sound()
	if(move_loop)
		move_loop.start(src,TRUE)

/obj/vehicle/has_interior/controller/proc/stop_move_sound()
	if(move_loop)
		move_loop.stop(src,TRUE)

//-------------------------------------------
// Violence!
//-------------------------------------------
/obj/vehicle/has_interior/controller/proc/smash_at_loc(var/newloc)
	if(istype(newloc,/turf/))
		var/turf/T = newloc
		for(var/atom/A in T.contents)
			smash_things(A) // what is in the turf
		smash_things(T) // turf itself

/obj/vehicle/has_interior/controller/proc/smash_things(var/target)
	var/severity = pick(2,2,3,3,3)
	if(has_breaking_speed)
		severity = 2 // first smash always best

	// special handling due to vis breaking if it doesn't get a ex_act(1)
	if(istype(target,/obj/machinery/door/blast))
		var/obj/machinery/door/blast/BD = target

		if(!BD.density || BD.operating)
			return 1

		if((prob(10) && has_breaking_speed) || BD.health <= 0)
			BD.visible_message("<span class='danger'>\The [src] crashes through \the [BD]!</span>")
			spawn()
				BD.open(1)
		else
			BD.ex_act(3)
			if(has_breaking_speed)
				if(BD.opacity)
					BD.visible_message("<span class='danger'>Something is forcing itself through \the [BD]!</span>")
				else
					BD.visible_message("<span class='danger'>\The [src] is forcing itself through \the [BD]!</span>")

		// shakey time
		playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)
		shake_cab()
		return 1

	// blob grinding
	if(istype(target, /obj/structure/blob/))
		var/obj/structure/blob/B = target
		if(has_breaking_speed)
			B.ex_act(1)
		else
			B.ex_act(2)

		// cab sounds
		if(prob(40))
			playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

			// shakey time
			shake_cab()
		return 1

	// vine grinding
	if(istype(target, /obj/effect/plant))
		var/obj/effect/plant/P = target
		if(has_breaking_speed)
			P.ex_act(1)
		else
			P.ex_act(2)

		// cab sounds
		if(prob(40))
			playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

			// shakey time
			shake_cab()
		return 1

	// shielded
	else if(istype(target, /obj/effect/energy_field))
		if(has_breaking_speed)
			var/obj/effect/energy_field/EF = target
			if(EF.opacity)
				EF.visible_message("<span class='danger'>Something begins forcing itself through \the [EF]!</span>")
			else
				EF.visible_message("<span class='danger'>\The [src] begins forcing itself through \the [EF]!</span>")

			if(do_after(src, EF.strength * 5))
				EF.adjust_strength(rand(-8, -10))
				EF.visible_message("<span class='danger'>\The [src] crashes through \the [EF]!</span>")
			else
				EF.visible_message("<span class='danger'>\The [EF] reverberates as it returns to normal.</span>")

			// shakey time
			shake_cab()
			return 1

	// BREAK
	else if(istype(target,/turf/simulated/wall))
		if(has_breaking_speed && breakwalls)
			var/turf/simulated/wall/W = target
			if(W.density)
				// stopped speed!
				has_breaking_speed = FALSE
				W.visible_message("<span class='danger'>Something crashes against \the [W]!</span>")
				W.ex_act(severity)

				// breaking stuff
				var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				sparks.set_up(5, 0, W.loc)
				sparks.attach(W)
				sparks.start()

				// cab sounds
				playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

				// shakey time
				shake_cab()
				return 1

	else if(istype(target,/atom/movable))
		if(istype(target, /obj/structure))
			var/obj/structure/S = target
			if(!S.unacidable)
				if(S.density || prob(1))
					S.visible_message("<span class='danger'>Something crashes against \the [S]!</span>")
					S.ex_act(severity)

					// breaking stuff
					var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
					sparks.set_up(5, 0, S.loc)
					sparks.attach(S)
					sparks.start()

					// cab sounds
					playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

					// shakey time
					shake_cab()
					return 1

		if(istype(target, /obj/machinery/))
			var/obj/machinery/M = target
			if(M.density || prob(3))
				M.visible_message("<span class='danger'>Something crashes against \the [M]!</span>")
				M.ex_act(severity)

				// breaking stuff
				var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				sparks.set_up(5, 0, M.loc)
				sparks.attach(M)
				sparks.start()

				// cab sounds
				playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

				// shakey time
				shake_cab()
				return 1
	return 0

/obj/vehicle/has_interior/controller/proc/crush_mobs_at_loc(var/newloc)
	if(istype(newloc,/turf/))
		var/turf/T = newloc
		for(var/mob/M in T.contents)
			crush_mobs(M)

/obj/vehicle/has_interior/controller/proc/crush_mobs(var/target)
	var/move_damage = 33 / move_delay
	if(isliving(target))
		var/mob/living/M = target
		if(!M.is_incorporeal())
			visible_message("<font color='red'>[src] runs over [M]!</font>")
			M.apply_effects(5, 5)				//knock people down if you hit them
			M.apply_damages(move_damage)	// and do damage according to how fast the train is going

			// cab sounds
			playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)
			return 1

//-------------------------------------------
// Vehicle procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/explode()
	. = ..()
	// unbucker riders and camera viewers
	if(istype(interior_helm,/obj/machinery/computer/vehicle_interior_console))
		interior_helm.clean_all_viewers()
	for(var/obj/item/vehicle_interior_weapon/W in internal_weapons_list)
		if(istype(W))
			var/obj/machinery/computer/vehicle_interior_console/CC = W.control_console
			if(istype(CC,/obj/machinery/computer/vehicle_interior_console))
				CC.clean_all_viewers()


	// throw all things that are NOT internal hardware out!
	for(var/turf/T in intarea.get_contents())
		if(prob(30) && istype(T))
			for(var/atom/A in T.contents)
				//if(istype(A,/obj))
					// TODO - throw objects out!
					//A.forceMove(exitpos)
				if(istype(A,/mob))
					// throw riders out!
					var/mob/M = A
					M.forceMove(exitpos)

/obj/vehicle/has_interior/controller/explode()
	src.visible_message(span_red("<B>[src] blows apart!</B>"), 1)
	playsound(src, 'modular_chomp/sound/effects/explosions/vehicleexplosion.ogg', 100, 8, 3) //CHOMPedit: New sound effects.


//-------------------------------------------
// Interaction procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(user.buckled || user.stat || user.restrained() || !Adjacent(user) || !user.Adjacent(C) || !istype(C) || (user == C && !user.canmove))
		return 0
	if(!Adjacent(user))
		return 0
	if(entrance_hatch == null || !entrance_hatch.locked)
		user.visible_message("<span class='notice'>[user] begins to climb into \the [src].</span>", "<span class='notice'>You begin to climb into \the [src].</span>")
		if(do_after(user, 20))
			if(Adjacent(user))
				enter_interior(user)
	else
		entrance_hatch.do_animate("deny")
		playsound(src, entrance_hatch.denied_sound, 50, 0, 3)

/obj/vehicle/has_interior/controller/attack_hand(mob/user as mob)
	// nothing YET, used for attacks

/obj/vehicle/has_interior/controller/attack_generic(mob/user as mob)
	// aliens/borers
	attack_hand(user)

/obj/vehicle/has_interior/controller/proc/enter_interior(var/atom/movable/C)
	// moves atom to interior access point of tank
	if(istype(entrypos,/turf/))
		var/turf/T = entrypos
		if(!T.CanPass( C, entrypos))
			to_chat(C, "<span class='notice'>Entrance is blocked by \the [T]!</span>")
			return
		for(var/atom/A in T.contents)
			if(!A.CanPass( C, entrypos) && !istype( C, /mob/living))
				to_chat(C, "<span class='notice'>Entrance is blocked by \the [A]!</span>")
				return
		transfer_to( C, entrypos)
	else
		C.visible_message("<span class='notice'>Interior inaccessible...</span>")

/obj/vehicle/has_interior/controller/proc/update_exit_pos()
	var/ang = dir2angle(dir)
	ang += dir2angle(exit_door_direction)
	var/direx = angle2dir(ang)
	exitpos = get_step(get_step(loc,direx),direx)

/obj/vehicle/has_interior/controller/proc/exit_interior(var/atom/movable/C)
	// moves atom to interior access point of tank
	if(istype(exitpos,/turf/))
		var/turf/T = exitpos
		if(!T.CanPass( C, exitpos))
			to_chat(C, "<span class='notice'>Exit is blocked by \the [T]!</span>")
			return
		for(var/atom/A in T.contents)
			if(!A.CanPass( C, exitpos) && !istype( C, /mob/living))
				to_chat(C, "<span class='notice'>Exit is blocked by \the [A]!</span>")
				return
		transfer_to( C, exitpos)
	else
		C.visible_message("<span class='notice'>Exterior inaccessible...</span>")

/obj/vehicle/has_interior/controller/proc/transfer_to(var/atom/movable/C,var/turf/dest)
	// handles pulling code too
	if(istype(C,/mob))
		var/atom/movable/pulledobj = null
		var/mob/M = C
		if(M.pulling)
			pulledobj = M.pulling;
			M.pulling.forceMove(dest)
			M.stop_pulling() // sanity...

		M.forceMove(dest)

		if(pulledobj != null)
			M.stop_pulling() // sanity...
			M.start_pulling(pulledobj)
	else
		C.forceMove(dest)

/obj/vehicle/has_interior/controller/load(var/atom/movable/C, var/mob/user)
	return 0

/obj/vehicle/has_interior/controller/proc/light_set()
	playsound(src, 'sound/machines/button.ogg', 100, 1, 0) // VOREStation Edit
	intarea.lightswitch = on
	intarea.update_icon()
	if(!on)
		light_range = 0
	if(!headlights_enabled)
		light_range = headlight_maxrange
	else
		light_range = 6
	intarea.power_change()
	GLOB.lights_switched_on_roundstat++

/obj/vehicle/has_interior/controller/doMove(atom/destination, direction, movetime)
	. = ..(destination,direction,movetime)
	update_weapons_location(loc)
	update_exit_pos()

/obj/vehicle/has_interior/controller/proc/remote_turn_on()
	if(stat)
		return
	if(!key)
		return
	if(!cell)
		return
	else
		turn_on()
		update_stats()

		if(interior_helm)
			interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/stop_engine
			interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/start_engine
			interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
			interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off

			if(on)
				interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/stop_engine
			else
				interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/start_engine

			if(headlights_enabled)
				interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off
			else
				interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
	light_set()
	update_icon()

/obj/vehicle/has_interior/controller/proc/remote_turn_off()
	turn_off()
	if(interior_helm)
		interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/stop_engine
		interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/start_engine
		interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
		interior_helm.verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off

		if(!on)
			interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/start_engine
		else
			interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/stop_engine

		if(!headlights_enabled)
			interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
		else
			interior_helm.verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off
	light_set()
	update_icon()

////////////////////////////////////////////////////////////////////////////////
// interior area objects
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
    visible_message("<span class='danger'>[src.name] was hit by [AM], with no visible effect.</span>")

/obj/machinery/door/vehicle_interior_hatch/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/attackby(obj/item/I as obj, mob/user as mob)
	if(locked)
		do_animate("deny")
		return
	if(!Adjacent(user))
		return

	// successful, begin exit!
	user.visible_message("<span class='notice'>[user] starts leaving the [interior_controller].</span>", "<span class='notice'>You start leaving the [interior_controller].</span>")
	if(do_after(user, 20))
		if(Adjacent(user))
			interior_controller.exit_interior(user)

/obj/machinery/door/vehicle_interior_hatch/attack_robot(mob/living/user)
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/attack_ai(mob/user)
	// no behavior

/obj/machinery/door/vehicle_interior_hatch/attack_generic(mob/user as mob)
	// aliens/borers
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/emag_act(var/remaining_charges)
    // no behavior

/obj/machinery/door/vehicle_interior_hatch/emp_act(severity)
    // immune to

/obj/machinery/door/vehicle_interior_hatch/ex_act(severity)
    // immune to

/obj/machinery/door/vehicle_interior_hatch/blob_act()
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

/obj/machinery/door/vehicle_interior_hatch/ex_act(severity)
	return // nothing, because it would cause some gamebreaking behaviors

////////////////////////////////////////////////////////////////////////////////
// View consoles

/obj/machinery/computer/vehicle_interior_console
	name = "Vehicle Console"
	desc = "Exterior camera console."

	icon_keyboard = "security_key"
	icon_screen = "cameras"
	light_color = "#a91515"
	circuit = /obj/item/weapon/circuitboard/security

	var/list/viewers // Weakrefs to mobs in direct-view mode.
	var/obj/vehicle/has_interior/controller/interior_controller = null
	var/obj/structure/bed/chair/vehicle_interior_seat/paired_seat = null
	var/controls_weapon_index = 0 // if above 0, controls weapons in interior_controller.internal_weapon_list

/obj/machinery/computer/vehicle_interior_console/Initialize()
	. = ..()

/obj/machinery/computer/vehicle_interior_console/Destroy()
	clean_all_viewers()
	return ..()

/obj/machinery/computer/vehicle_interior_console/tgui_interact(mob/user, datum/tgui/ui = null)
	// nothing

/obj/machinery/computer/vehicle_interior_console/attack_ai(mob/user)
	to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")

/obj/machinery/computer/vehicle_interior_console/attack_robot(mob/living/user)
	attack_hand( null, user)

/obj/machinery/computer/vehicle_interior_console/attack_generic(mob/user as mob)
	attack_hand( null, user)

/obj/machinery/computer/vehicle_interior_console/attack_hand(mob/user)
	add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return
	if(issilicon(user) || isrobot(user))
		to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return
	if(user.blinded)
		to_chat(user, "<span class='notice'>You cannot see!</span>")
		return
	// remove all others...
	clean_all_viewers()
	playsound(src, "keyboard", 40) // into console
	look(user)

/obj/machinery/computer/vehicle_interior_console/check_eye(var/mob/user)
	if(!get_dist(user, src) > 1)
		unlook(user)
		return -1
	else
		return 0

/obj/machinery/computer/vehicle_interior_console/proc/look(var/mob/user)
	if(interior_controller)
		if(user.machine != src)
			user.set_machine(src)
		if(isliving(user))
			var/mob/living/L = user
			L.looking_elsewhere = 1
			L.handle_vision()
		user.reset_view(interior_controller)
		user.set_viewsize(world.view + interior_controller.extra_view)
		RegisterSignal(user, COMSIG_OBSERVER_MOVED, PROC_REF(unlook))
		LAZYDISTINCTADD(viewers, WEAKREF(user))
	else
		clean_all_viewers()

/obj/machinery/computer/vehicle_interior_console/proc/unlook(var/mob/user)
	interior_controller.stop_move_sound()
	user.unset_machine()
	if(isliving(user))
		var/mob/living/L = user
		L.looking_elsewhere = 0
		L.handle_vision()
	user.set_viewsize() // reset to default
	user.reset_view()
	UnregisterSignal(user, COMSIG_OBSERVER_MOVED, PROC_REF(unlook))
	LAZYREMOVE(viewers, WEAKREF(user))

/obj/machinery/computer/vehicle_interior_console/proc/clean_all_viewers()
	if(LAZYLEN(viewers))
		for(var/datum/weakref/W in viewers)
			var/M = W.resolve()
			if(M)
				unlook(M)

/obj/machinery/computer/vehicle_interior_console/ex_act(severity)
	return // nothing

/obj/machinery/computer/vehicle_interior_console/computer/update_icon()
	if(!interior_controller.on)
		// power off in vehicle
		cut_overlays()
		if(icon_keyboard)
			return add_overlay("[icon_keyboard]_off")
	else
		. = ..()

////////////////////////////////////////////////////////////////////////////////
// Pilot console

/obj/machinery/computer/vehicle_interior_console/helm
	name = "Vehicle Helm"
	desc = "Use ctrl-click to quickly toggle the engine if you're adjacent (only when vehicle is stationary). Alt-click will grab the keys, if present."

/obj/machinery/computer/vehicle_interior_console/helm/examine(mob/user)
	. = ..()
	if(ishuman(user) && Adjacent(user))
		. += "The power light is [interior_controller.on ? "on" : "off"].\nThere are[interior_controller.key ? "" : " no"] keys in the ignition."
		. += "The charge meter reads [interior_controller.cell? round(interior_controller.cell.percent(), 0.01) : 0]%"

/obj/machinery/computer/vehicle_interior_console/helm/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, interior_controller.key_type))
		if(!interior_controller.key)
			user.drop_item()
			W.forceMove(src)
			interior_controller.key = W
			verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/remove_key
		return
	..()

/obj/machinery/computer/vehicle_interior_console/helm/CtrlClick(var/mob/user)
	// helm expects pilot seat
	if(Adjacent(user))
		if(interior_controller.on)
			stop_engine()
		else
			start_engine()
	else
		return ..()

/obj/machinery/computer/vehicle_interior_console/helm/AltClick(var/mob/user)
	// helm expects pilot seat
	if(Adjacent(user))
		remove_key()
	else
		return ..()

/obj/machinery/computer/vehicle_interior_console/attack_hand(mob/user)
	// same as normal, but EXPECTS you to be in the pilot seat!
	if(!interior_controller || !paired_seat || !paired_seat.has_buckled_mobs() || paired_seat.buckled_mobs[1] != user)
		to_chat(user, "<span class='notice'>You need to buckle into the seat to use this console!</span>")
		return
	. = ..()

/obj/machinery/computer/vehicle_interior_console/helm/verb/start_engine()
	set name = "Start engine"
	set category = "Object.Vehicle"
	set src in oview(1)

	if(interior_controller.on)
		to_chat(usr, "The engine is already running.")
		return

	interior_controller.remote_turn_on()
	if (interior_controller.on)
		to_chat(usr, "You start [interior_controller]'s engine.")
	else
		if(!interior_controller.cell)
			to_chat(usr, "[interior_controller] doesn't appear to have a power cell!")
		else if(interior_controller.cell.charge < interior_controller.charge_use)
			to_chat(usr, "[interior_controller] is out of power.")
		else
			to_chat(usr, "[interior_controller]'s engine won't start.")

/obj/machinery/computer/vehicle_interior_console/helm/verb/stop_engine()
	set name = "Stop engine"
	set category = "Object.Vehicle"
	set src in oview(1)

	if(!interior_controller.on)
		to_chat(usr, "The engine is already stopped.")
		return

	interior_controller.remote_turn_off()
	if (!interior_controller.on)
		to_chat(usr, "You stop [interior_controller]'s engine.")

/obj/machinery/computer/vehicle_interior_console/helm/verb/remove_key()
	set name = "Remove key"
	set category = "Object.Vehicle"
	set src in oview(1)

	if(!interior_controller.key)
		return

	if(interior_controller.on)
		interior_controller.remote_turn_off()

	interior_controller.key.loc = usr.loc
	if(!usr.get_active_hand())
		usr.put_in_hands(interior_controller.key)
	interior_controller.key = null

	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/remove_key

/obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on()
	set name = "Headlights on"
	set category = "Object.Vehicle"
	set src in oview(1)

	interior_controller.headlights_enabled = TRUE
	playsound(src, "switch", 40)

	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
	verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off

/obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off()
	set name = "Headlights off"
	set category = "Object.Vehicle"
	set src in oview(1)

	interior_controller.headlights_enabled = FALSE
	playsound(src, "switch", 40)

	verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off

////////////////////////////////////////////////////////////////////////////////
// Gunner console

/obj/machinery/computer/vehicle_interior_console/gunner
	name = "Gunner Periscope"
	desc = "Targeting cameras for onboard weaponry."

/obj/machinery/computer/vehicle_interior_console/gunner/examine(mob/user)
	. = ..()
	//if(ishuman(user) && Adjacent(user))
	//	. += "The power light is [interior_controller.on ? "on" : "off"].\nThere are[interior_controller.key ? "" : " no"] keys in the ignition."
	//	. += "The charge meter reads [interior_controller.cell? round(interior_controller.cell.percent(), 0.01) : 0]%"

////////////////////////////////////////////////////////////////////////////////
// Internal seats

/obj/structure/bed/chair/vehicle_interior_seat
	name = "shuttle seat"
	desc = "A comfortable, secure seat. It has a sturdy-looking buckling system for smoother flights."
	base_icon = "shuttle_chair"
	icon_state = "shuttle_chair_preview"
	buckle_movable = TRUE // we do some silly stuff though
	var/buckling_sound = 'sound/effects/metal_close.ogg'
	var/padding = "blue"
	var/obj/machinery/computer/vehicle_interior_console/paired_console = null

/obj/structure/bed/chair/vehicle_interior_seat/New(var/newloc, var/new_material, var/new_padding_material)
	. = ..(newloc, MAT_STEEL, padding)

/obj/structure/bed/chair/vehicle_interior_seat/post_buckle_mob()
	playsound(src,buckling_sound,75,1)
	if(has_buckled_mobs())
		base_icon = "shuttle_chair-b"
	else
		base_icon = "shuttle_chair"
	..()

/obj/structure/bed/chair/vehicle_interior_seat/update_icon()
	..()
	var/image/I = image(icon, "[base_icon]_over")
	I.layer = ABOVE_MOB_LAYER
	I.plane = MOB_PLANE
	I.color = material.icon_colour
	add_overlay(I)
	if(!has_buckled_mobs())
		I = image(icon, "[base_icon]_special")
		I.plane = MOB_PLANE
		I.layer = ABOVE_MOB_LAYER
		if(applies_material_colour)
			I.color = material.icon_colour
		add_overlay(I)

/obj/structure/bed/chair/vehicle_interior_seat/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	if(LAZYLEN(paired_console.viewers))
		playsound(src, "keyboard", 40) // out of console
		paired_console.clean_all_viewers()
		buckled_mob.setClickCooldown(3) // lower cooldown than normal, but still have one
	else
		. = ..()

/obj/structure/bed/chair/vehicle_interior_seat/Destroy()
	if(LAZYLEN(paired_console.viewers))
		paired_console.clean_all_viewers()
	return ..()

/obj/structure/bed/chair/vehicle_interior_seat/ex_act(severity)
	// knock out of camera view
	if(LAZYLEN(paired_console.viewers))
		paired_console.clean_all_viewers()

////////////////////////////////////////////////////////////////////////////////
// Pilot seat
/obj/structure/bed/chair/vehicle_interior_seat/pilot/relaymove(mob/user, direction)
	if(LAZYLEN(paired_console.viewers) > 0) // only if driver is looking!
		return paired_console.interior_controller.relaymove(user, direction) // forward to vehicle!
	else
		return FALSE

//-------------------------------------------
// Click through procs, for when you click in vehicle view!
//-------------------------------------------

/obj/structure/bed/chair/vehicle_interior_seat/proc/click_action(atom/target,mob/user, params)
	if(paired_console.controls_weapon_index > 0)
		var/obj/item/vehicle_interior_weapon/W = paired_console.interior_controller.internal_weapons_list[paired_console.controls_weapon_index]
		if(!W)
			to_chat(user, "<span class='warning'>Weapon is inoperable!</span>")
		else
			W.action(target, params, user)

////////////////////////////////////////////////////////////////////////////////
// Vehicle weaponry

/obj/item/vehicle_interior_weapon
	name = "vehicle weapon"
	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER+0.1
	w_class = ITEMSIZE_COST_NO_CONTAINER

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

/obj/item/vehicle_interior_weapon/GotoAirflowDest(n) // weapon is rooted to tank...
	return

/obj/item/vehicle_interior_weapon/RepelAirflowDest(n) // airflow does not push it around!
	return

/obj/item/vehicle_interior_weapon/proc/action_checks(var/atom/target)
	if(projectiles <= 0)
		return FALSE
	return TRUE

/obj/item/vehicle_interior_weapon/proc/solve_aim_angle(var/endx, var/endy)
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

/obj/item/vehicle_interior_weapon/proc/action(var/atom/target, var/params, var/mob/user_calling)
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
		return
	if(targloc.x == 0 && targloc.y == 0)
		// stop thinking darkness is bottom left of the map, just don't allow firing...
		return
	if(dir != angledir)
		// turn toward!
		update_weapon_turn( angledir)
		return

	// intent check
	if(user_calling.a_intent == I_HELP && user_calling.client?.prefs?.read_preference(/datum/preference/toggle/safefiring))
		to_chat(user_calling, "<span class='warning'>You refrain from firing the mounted \the [src] as your intent is set to help.</span>")
		return

	// check if loaded
	var/obj/machinery/ammo_loader/L
	if(weapon_index <= control_console.interior_controller.internal_loaders_list.len)
		L = control_console.interior_controller.internal_loaders_list[weapon_index]
	if(L)
		if(!L.loaded)
			to_chat(user_calling, "<span class='warning'>You are unable to fire \the [src] as there is no shell loaded.</span>")
			return
		else
			L.fire()

	// ACTUALLY fire
	control_console.interior_controller.visible_message("<span class='warning'>[user_calling] fires [src]!</span>")
	to_chat(user_calling,"<span class='warning'>You fire [src]!</span>")
	var/target_for_log = "unknown"
	if(ismob(target))
		target_for_log = target
	else if(target)
		target_for_log = "[target.name]"
	add_attack_logs(user_calling,target_for_log,"Fired vehicle [control_console.interior_controller.name] weapon [src.name] (MANUAL)")

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
	return

/obj/item/vehicle_interior_weapon/proc/get_pilot_zone_sel(var/mob/user)
	if(!control_console.paired_seat.has_buckled_mobs() || !user.zone_sel || user.stat)
		return BP_TORSO

	return user.zone_sel.selecting

/obj/item/vehicle_interior_weapon/proc/Fire(var/atom/A, var/atom/target, var/params, var/mob/user, var/angle_override)
	if(istype(A, /obj/item/projectile))	// Sanity.
		var/obj/item/projectile/P = A
		P.plane = MOB_PLANE
		P.layer = ABOVE_MOB_LAYER+0.05
		P.dispersion = deviation
		process_accuracy(P, user, target)
		P.launch_projectile_from_turf(target, get_pilot_zone_sel(user), user, params, angle_override)
	else if(istype(A, /atom/movable))
		var/atom/movable/AM = A
		AM.throw_at(target, 7, 1, control_console.interior_controller)

/obj/item/vehicle_interior_weapon/proc/process_accuracy(var/obj/projectile, var/mob/living/user, var/atom/target)
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

/obj/item/vehicle_interior_weapon/attack_hand(mob/user)
	// ignore

/obj/item/vehicle_interior_weapon/proc/update_weapon_turn(var/goaldir)
	// find current direction's angle, find rotation direction, add 45+1 to it, then return the new dir we want to be!
	var/startdir = dir2angle(dir)
	dir = angle2dir(360 + startdir + (SIGN(closer_angle_difference(startdir,dir2angle(goaldir))) * 46))

/obj/item/vehicle_interior_weapon/ex_act(severity)
	return // No damage

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
	if(over == usr)
		if(ammo_count > 0)
			usr.visible_message("[usr] begins to extract a shell.", "You begin to extract a shell.")
			playsound(src, 'sound/items/electronic_assembly_empty.ogg', 100, 1)
			if(do_after(usr, 60, src) && ammo_count > 0)
				ammo_count--
				var/obj/item/thing = new ammo_path(usr.loc)
				usr.visible_message("[usr] picks up \the [thing].", "You pick up \the [thing].")
				usr.put_in_hands(thing)
		else
			to_chat( usr, "No shells remain!")
		add_fingerprint(usr)

/obj/machinery/ammo_storage/ex_act(severity)
	return // no explosive act

/obj/machinery/ammo_storage/attack_hand(mob/user)
	if(ammo_count > 0)
		if(ammo_count == 1)
			to_chat( usr, "A single shell remains!")
		else
			to_chat( usr, "[ammo_count] shells remain!")
	else
		to_chat( usr, "No shells remain!")

/obj/machinery/ammo_storage/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I,ammo_path))
		if(ammo_count >= initial(ammo_count))
			to_chat( usr, "\The [src] is full!")
		else if(do_after(usr, 20, src))
			if(ammo_count < initial(ammo_count))
				ammo_count++
				user.visible_message("[user] loads a shell into \the [src].", "You load a shell into \the [src].")
				I.Destroy()
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
	var/loaded = FALSE

/obj/machinery/ammo_loader/Initialize()
	. = ..()
	update_icon()

/obj/machinery/ammo_loader/ex_act(severity)
	return 0 // no explosive act

/obj/machinery/ammo_loader/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I,ammo_path))
		if(loaded)
			to_chat( user, "A shell is already loaded.")
			return
		else if(do_after(usr, 20, src) && !loaded)
			loaded = TRUE
			user.visible_message("[user] loads a shell into \the [src].", "You load a shell into \the [src].")
			I.Destroy()
			playsound(src, 'sound/machines/turrets/turret_deploy.ogg', 100, 1)
			update_icon()

/obj/machinery/ammo_loader/MouseDrop(atom/over)
	if(!CanMouseDrop(over, usr))
		return
	if(over == usr)
		usr.visible_message("[usr] unloads \the [src].", "You unload \the [src].")
		loaded = FALSE
		var/obj/item/thing = new ammo_path(usr.loc)
		usr.put_in_hands(thing)
		playsound(src, 'sound/items/electronic_assembly_empty.ogg', 100, 1)
		update_icon()

/obj/machinery/ammo_loader/proc/fire()
	loaded = FALSE
	update_icon()
	flick("loader_fire",src)
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(5, 0, src)
	sparks.attach(loc)
	sparks.start()
	playsound(src, 'sound/machines/hiss.ogg', 50, 1)
	playsound(src, 'sound/machines/machine_die_short.ogg', 100, 1)

/obj/machinery/ammo_loader/update_icon()
	. = ..()
	if(!loaded)
		icon_state = "loader"
	else
		icon_state = "loader_loaded"
	overlays.Cut()
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
	origin_tech = list(TECH_MATERIAL = 3, TECH_ENGINEERING = 4)
