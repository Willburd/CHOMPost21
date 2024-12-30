/datum/disease
	var/cure_time = 0

/datum/disease/proc/start_cure_timer()
	if(cure_time) // Do not reset timer
		return
	cure_time = world.time + 1 HOUR + rand( -20 MINUTES, 60 MINUTES) // Once this period is over, allow random cure chances

/datum/disease/proc/check_natural_immunity() // Infected mobs eventually develoup antibodies to viruses if they are mild enough to survive for hours with it in them
	// Check every 10 minutes or so if we pass the dice roll for naturalized curing.
	if(world.time < cure_time)
		return FALSE
	if(prob(5))
		return TRUE
	cure_time = world.time + rand(5 MINUTES, 10 MINUTES) // check again in a bit
	return FALSE
