/obj/machinery/shower/automated
	name = "motion activated shower"
	icon = 'icons/obj/watercloset.dmi'

/obj/machinery/shower/automated/Crossed(atom/A)
	// motion sensor shower for autoresleever
	if(!on)
		on = TRUE
		START_MACHINE_PROCESSING(src)
		process()
		soundloop.start()
	addtimer(CALLBACK(src, PROC_REF(auto_stop)), 10 SECONDS, TIMER_DELETE_ME)

/obj/machinery/shower/automated/proc/auto_stop()
	if(!on)
		return
	on = FALSE
	soundloop.stop()
