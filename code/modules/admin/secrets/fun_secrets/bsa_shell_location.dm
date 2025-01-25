/datum/admin_secret_item/fun_secret/shell_location
	name = "Bluespace Shell Coords"
	var/rounds = 0
	var/max_rounds = 0

/datum/admin_secret_item/fun_secret/shell_location/execute(var/mob/user)
	. = ..()
	if(.)
		rounds = tgui_input_text( user, "How many rounds will be fired:", "Number of shells")
		rounds = text2num(rounds)
		if(!rounds)
			return
		// For every round fired!
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
				addtimer(CALLBACK(src, PROC_REF(announce), x, y, z, max_rounds == rounds), cur_delay, TIMER_DELETE_ME)
			cur_delay += rand(12 SECONDS, 16 SECONDS)
			rounds--
		// End!
		addtimer(CALLBACK(src, PROC_REF(finish_message)), cur_delay, TIMER_DELETE_ME)

/datum/admin_secret_item/fun_secret/shell_location/proc/announce(var/x,var/y,var/z, var/first_shot = TRUE)
	if(first_shot)
		var/message = "Requesting a precision artillery strike on coordinates: [x], [y], [z]."
		global_announcer.autosay(message, "Central Command Fire Control", "Command")
		global_announcer.autosay(message, "Central Command Fire Control", "Security")
		message = "All crew INCOMING: Bluespace Artillery Fire confirmed, precision strike. Stand by."
		global_announcer.autosay(message, "Central Command Fire Control", "Common")
	else
		var/message = "Reloading, preparing additional artillery strike on coordinates: [x], [y], [z]."
		global_announcer.autosay(message, "Central Command Fire Control", "Command")
		message = "Reloading, preparing additional artillery strike."
		global_announcer.autosay(message, "Central Command Fire Control", "Common")
	addtimer(CALLBACK(src, PROC_REF(shelling), x, y, z), rand(4 SECONDS, 6 SECONDS), TIMER_DELETE_ME)

/datum/admin_secret_item/fun_secret/shell_location/proc/shelling(var/x,var/y,var/z)
	var/turf/T = locate(x,y,z)
	if(!T)
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	s.set_up(2, 1, T)
	s.start()
	var/obj/structure/ship_munition/disperser_charge/C = new /obj/structure/ship_munition/disperser_charge/explosive(T)
	addtimer(CALLBACK(src, PROC_REF(detonate), WEAKREF(C)), rand(1,5), TIMER_DELETE_ME)

/datum/admin_secret_item/fun_secret/shell_location/proc/detonate(var/datum/weakref/WF)
	var/obj/structure/ship_munition/disperser_charge/C = WF?.resolve()
	if(!C)
		return
	var/turf/T = get_turf(C)
	qdel(C)
	if(!T)
		return
	explosion( T, 3, 5, 7, 5)

/datum/admin_secret_item/fun_secret/shell_location/proc/finish_message()
	global_announcer.autosay("Cease Fire. All clear, all clear. Assess affect for reengagement.", "Central Command Fire Control", "Common")
