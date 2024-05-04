var/global/list/allisclean_list = list()
/obj/singularity/allisclean //Moving narsie to its own file for the sake of being clearer
	name = "All-Is-Clean"
	desc = "Mr.Clean gets rid of dirt and grime, and grease in just a minute."
	icon = 'icons/effects/128x128.dmi'
	icon_state = "allisclean"
	pixel_x = -48
	pixel_y = -48

	current_size = 9 //It moves/eats like a max-size singulo, aside from range. --NEO.
	contained = 0 // Are we going to move around?
	dissipate = 0 // Do we lose energy over time?
	grav_pull = 12 //How many tiles out do we pull?
	consume_range = 3 //How many tiles out do we eat
	var/list/vents = list()

/obj/singularity/allisclean/New()
	..()
	START_PROCESSING(SSobj, src)
	allisclean_list.Add(src)

	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in SSmachines.all_machines)
		if(temp_vent.loc.z in using_map.event_levels)
			var/area/A = get_area(temp_vent)
			if(!(A.forbid_events))
				vents += temp_vent

/obj/singularity/allisclean/Destroy()
	allisclean_list.Remove(src)
	..()

/obj/singularity/allisclean/process()
	eat()
	move()
	// clean
	if(vents.len > 0 && prob(20))
		var/i = 0
		while(i < 5)
			i += 1
			var/obj/machinery/atmospherics/unary/vent_pump/vent = pick(vents)
			if(!vent.welded)
				var/obj/item/weapon/grenade/chem_grenade/cleaner/C = new /obj/item/weapon/grenade/chem_grenade/cleaner(vent.loc)
				C.stage = 2
				C.detonate( FALSE )

/obj/singularity/allisclean/move(var/force_move = 0)
	if(!move_self)
		return 0

	var/movement_dir = pick(alldirs - last_failed_movement)

	if(force_move)
		movement_dir = force_move

	spawn(0)
		step(src, movement_dir)
	spawn(1)
		step(src, movement_dir)
	spawn(2)
		step(src, movement_dir)
	return 1

/obj/singularity/allisclean/eat()
	for(var/atom/X as anything in orange(grav_pull, src))
		if(!X.simulated)
			continue
		var/dist = get_dist(X, src)
		if(dist > consume_range)
			X.singularity_pull(src, current_size)
		else
			consume(X)
	return

/obj/singularity/allisclean/consume(const/atom/A) //This one is for the small ones.
	if(!(A.singuloCanEat()))
		return 0

	if (istype(A, /mob/living/))
		var/mob/living/C2 = A

		if(C2.status_flags & GODMODE)
			return 0

		C2.gib()

	else if (istype(A, /obj/))
		qdel(A)

		if (A)
			qdel(A)

	/* Mr.clean will only clean!
	else if (isturf(A))
		var/dist = get_dist(A, src)

		for (var/atom/movable/AM2 in A.contents)
			if (AM2 == src) // This is the snowflake.
				continue

			if (dist <= consume_range)
				consume(AM2)
				continue

			if (dist > consume_range)
				if(!(AM2.singuloCanEat()))
					continue

				if (101 == AM2.invisibility)
					continue

				spawn (0)
					AM2.singularity_pull(src, src.current_size)

		if (dist <= consume_range && !istype(A, get_base_turf_by_area(A)))
			var/turf/T2 = A
			T2.ChangeTurf(get_base_turf_by_area(A))
	*/

/obj/singularity/allisclean/ex_act(severity) //No throwing bombs at it either. --NEO
	return
