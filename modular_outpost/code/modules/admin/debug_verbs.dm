/datum/admins/proc/lock_weather()
	set category = "Debug.Events"
	set name = "Lock Weather"
	set desc = "Locks or unlocks the current weather from proceeding to the next forcast."

	if(!check_rights(R_DEBUG))
		return

	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to toggle the weather lock on?", "Toggle Lock Weather", SSplanets.planets)
	if(istype(planet))
		planet.weather_holder.locked = !planet.weather_holder.locked
		to_chat(usr, span_vdanger("The weather on [planet] is now [planet.weather_holder.locked ? "LOCKED" : "unlocked"], the weather is currently [planet.weather_holder.current_weather]."))
