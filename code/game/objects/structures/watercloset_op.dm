/obj/machinery/shower/automated
	name = "motion activated shower"
	icon = 'icons/obj/watercloset.dmi'
	var/starttime = 0

/obj/machinery/shower/automated/Crossed(atom/A)
	// motion sensor shower for autoresleever
	starttime = world.time
	if(!on)
		on = TRUE
		update_icon()
		soundloop.start()
		if(istype(A,/mob/))
			var/mob/M = A
			if (M.loc == loc)
				wash(M)
				process_heat(M)
		for (var/atom/movable/G in src.loc)
			G.clean_blood()
