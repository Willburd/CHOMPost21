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
	var/base_icon = "sec_apc" // for destruction

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
	var/obj/item/key/key
	var/key_type = /obj/item/key/cargo_train // override me
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
/obj/vehicle/has_interior/controller/Initialize(mapload)
	. = ..()

	cell = new /obj/item/cell/high(src)
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

	// find interior entrypos
	for(var/area/A)
		if(!istype(A, interior_area))
			continue
		intarea = A // become reference...
		for(var/turf/T in intarea.get_contents())
			if(!istype(T))
				continue
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

/obj/vehicle/has_interior/controller/ex_act(severity)
	// noise!
	playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)

	// make a smaller explosion inside
	explosion(entrance_hatch, 0, 0, 6, 8)

	// disable ex_act destruction, would lead to gamebreaking behaviors
	switch(severity)
		if(3)
			take_damage(10)
		if(2)
			take_damage(30)
		if(1)
			take_damage(50)

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

/obj/vehicle/has_interior/controller/update_icon()
	. = ..()
	update_weapons_location(loc)
	// Handle destruction
	var/dest_state = "";
	if(health <= 0)
		dest_state = "_dest"
	icon_state = "[base_icon][dest_state]"
	for(var/obj/item/vehicle_interior_weapon/W in internal_weapons_list)
		W.update_icon()

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
	if(istype(target, /obj/structure/blob))
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
			EF.adjust_strength(rand(-8, -10))
			EF.visible_message("<span class='danger'>\The [src] crashes through \the [EF]!</span>")

			// shakey time
			shake_cab()
			return 1

	// kaboom!
	else if(istype(target,/obj/effect/mine))
		var/obj/effect/mine/M = target
		M.Bumped(src)

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

	else if(istype(target,/mob/living/simple_mob/animal/statue))
		// cab sounds
		playsound(entrance_hatch, get_sfx("vehicle_crush"), 50, 1)
		shake_cab()

		// Because they'll be at this forever
		if(has_breaking_speed && prob(5))
			var/mob/living/simple_mob/animal/statue/S = target
			S.ash()
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
	src.visible_message(span_red("<B>[src] blows apart!</B>"), 1)
	playsound(src, 'sound/effects/explosions/vehicleexplosion.ogg', 100, 8, 3) //CHOMPedit: New sound effects.
	// unbucker riders and camera viewers
	if(istype(interior_helm,/obj/machinery/computer/vehicle_interior_console))
		interior_helm.clean_all_viewers()
	for(var/obj/item/vehicle_interior_weapon/W in internal_weapons_list)
		if(istype(W))
			var/obj/machinery/computer/vehicle_interior_console/CC = W.control_console
			if(istype(CC,/obj/machinery/computer/vehicle_interior_console))
				CC.clean_all_viewers()
	update_icon()

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
