/datum/bsa_shell_controller

/datum/bsa_shell_controller/proc/ask(var/mob/user)
	var/rounds = 0
	var/max_rounds = 0
	rounds = tgui_input_text( user, "How many rounds will be fired:", "Number of shells")
	rounds = text2num(rounds)
	if(!rounds)
		qdel(src)
		return
	// For every round fired!
	var/has_fired = FALSE
	max_rounds = rounds
	var/cur_delay = rand(3 SECONDS, 8 SECONDS)
	while(rounds > 0)
		var/x = tgui_input_text( user, "coord X:", "X Coord for shot [max_rounds - rounds]")
		x = text2num(x)
		var/y = tgui_input_text( user, "coord Y:", "Y Coord for shot [max_rounds - rounds]")
		y = text2num(y)
		var/z = tgui_input_text( user, "coord Z:", "Z Coord for shot [max_rounds - rounds]")
		z = text2num(z)
		if(x && y && z)
			has_fired = TRUE
			addtimer(CALLBACK(src, PROC_REF(announce), x, y, z, (max_rounds == rounds)), cur_delay, TIMER_DELETE_ME)
		cur_delay += rand(12 SECONDS, 16 SECONDS)
		rounds--
	if(!has_fired)
		qdel(src)
		return
	// End!
	cur_delay += rand(7 SECONDS, 9 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(finish_message)), cur_delay, TIMER_DELETE_ME)

/datum/bsa_shell_controller/proc/random_setup(xpos,ypos,zpos)
	var/rounds = pick(1,1,1,1,1,2,3)
	var/max_rounds = rounds
	var/cur_delay = rand(1 SECONDS, 3 SECONDS)
	while(rounds > 0)
		addtimer(CALLBACK(src, PROC_REF(announce), xpos, ypos, zpos, (max_rounds == rounds)), cur_delay, TIMER_DELETE_ME)
		cur_delay += rand(12 SECONDS, 15 SECONDS)
		rounds--
	// End!
	cur_delay += rand(7 SECONDS, 9 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(finish_message)), cur_delay, TIMER_DELETE_ME)

/datum/bsa_shell_controller/proc/announce(var/x,var/y,var/z, var/first_shot = TRUE)
	if(first_shot)
		var/message = "Requesting a precision artillery strike on coordinates: [x], [y], [z]."
		GLOB.global_announcer.autosay(message, "Central Command Fire Control", "Command")
		GLOB.global_announcer.autosay(message, "Central Command Fire Control", "Security")
		message = "All crew INCOMING: Bluespace Artillery Fire confirmed, precision strike. Stand by."
		GLOB.global_announcer.autosay(message, "Central Command Fire Control", "Common")
	else
		var/message = "Reloading, preparing additional artillery strike on coordinates: [x], [y], [z]."
		GLOB.global_announcer.autosay(message, "Central Command Fire Control", "Command")
		message = "Reloading, preparing additional artillery strike."
		GLOB.global_announcer.autosay(message, "Central Command Fire Control", "Common")
	addtimer(CALLBACK(src, PROC_REF(shelling), x, y, z), rand(4 SECONDS, 6 SECONDS), TIMER_DELETE_ME)

/datum/bsa_shell_controller/proc/shelling(var/x,var/y,var/z)
	var/turf/T = locate(x,y,z)
	if(!T)
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	s.set_up(2, 1, T)
	s.start()
	var/obj/structure/ship_munition/disperser_charge/C = new /obj/structure/ship_munition/disperser_charge/explosive(T)
	addtimer(CALLBACK(src, PROC_REF(detonate), WEAKREF(C)), rand(1,15), TIMER_DELETE_ME)

/datum/bsa_shell_controller/proc/detonate(var/datum/weakref/WF)
	var/obj/structure/ship_munition/disperser_charge/C = WF?.resolve()
	if(!C)
		return
	var/turf/T = get_turf(C)
	qdel(C)
	if(!T)
		return
	explosion( T, 3, 5, 7, 5)

/datum/bsa_shell_controller/proc/finish_message()
	GLOB.global_announcer.autosay("Cease Fire. All clear, all clear. Assess affect for reengagement.", "Central Command Fire Control", "Common")
	qdel(src)
