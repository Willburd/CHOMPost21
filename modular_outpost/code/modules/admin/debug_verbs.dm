/datum/admins/proc/lock_weather()
	set category = "Debug.Events"
	set name = "Lock Weather"
	set desc = "Locks or unlocks the current weather from proceeding to the next forcast."

	if(!check_rights(R_EVENT))
		return

	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to toggle the weather lock on?", "Toggle Lock Weather", SSplanets.planets)
	if(istype(planet))
		planet.weather_holder.locked = !planet.weather_holder.locked
		to_chat(usr, span_vdanger("The weather on [planet] is now [planet.weather_holder.locked ? "LOCKED" : "unlocked"], the weather is currently [planet.weather_holder.current_weather]."))

/datum/admins/proc/change_weather_temp()
	set category = "Debug.Events"
	set name = "Change Weather Temperature"
	set desc = "Sets the temperature of the current weather."

	if(!check_rights(R_EVENT))
		return

	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to change the temperature on?", "Change Weather Temperature", SSplanets.planets)
	var/set_temp = tgui_input_number(usr,"The new temperature in kelvin.")
	if(set_temp && istype(planet))
		planet.weather_holder.temperature = max(1,set_temp)
		SSplanets.updateTemp(planet)
