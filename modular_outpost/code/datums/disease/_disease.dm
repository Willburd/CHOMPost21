/datum/disease
	var/has_timer = FALSE

/datum/disease/proc/start_cure_timer()
	if(has_timer) // Do not set a timer if we already made one
		return
	has_timer = TRUE
	addtimer(CALLBACK(src, PROC_REF(check_natural_immunity)), (1 HOUR) + rand( -20 MINUTES, 60 MINUTES), TIMER_DELETE_ME) // Once this period is over, allow random cure chances

/datum/disease/proc/check_natural_immunity()
	// Infected mobs eventually make antibodies to viruses if they are
	// mild enough to survive for hours with it in them.
	// Check every 10 minutes or so if we pass the dice roll for naturalized curing.
	if(prob( rand(10,20) ))
		has_timer = FALSE
		cure()
		return
	// check again in a bit
	addtimer(CALLBACK(src, PROC_REF(check_natural_immunity)), rand(5 MINUTES, 10 MINUTES), TIMER_DELETE_ME)
