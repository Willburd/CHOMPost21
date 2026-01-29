/obj/machinery/shower/automated
	name = "motion activated shower"
	icon = 'icons/obj/watercloset.dmi'
	var/starttime = 0
	current_temperature = "freezing"

/obj/machinery/shower/automated/Crossed(atom/A)
	// motion sensor shower for autoresleever
	starttime = world.time
	if(!on)
		on = TRUE
		START_MACHINE_PROCESSING(src)
		process()
		soundloop.start()
