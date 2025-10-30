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

/datum/admins/proc/lock_planet_light()
	set category = "Debug.Events"
	set name = "Lock Planet Lightlevel"
	set desc = "Locks a planet to a specific light level and color."

	if(!check_rights(R_EVENT))
		return

	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to toggle the weather lock on?", "Toggle Lock Weather", SSplanets.planets)
	if(istype(planet))
		if(!isnull(planet.locked_light_color))
			planet.locked_light_intensity = 0
			planet.locked_light_color = null
			planet.update_sun()
			to_chat(usr, span_vdanger("The light on [planet] is now unlocked."))
			return
		var/new_color = tgui_color_picker(usr, "New light color.", "Light Color")
		var/new_intensity = tgui_input_number(usr, "The new light intensity.", "Light Intensity", 1, 1, 0)
		if(!new_color)
			return
		planet.locked_light_color = new_color
		planet.locked_light_intensity = new_intensity
		planet.update_sun()

/datum/admins/proc/change_weather_temp()
	set category = "Debug.Events"
	set name = "Change Weather Temperature"
	set desc = "Sets the temperature of the current weather."

	if(!check_rights(R_EVENT))
		return

	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to change the temperature on?", "Change Weather Temperature", SSplanets.planets)
	var/set_temp = tgui_input_number(usr,"The new temperature in kelvin.", "New Temperature", 215, 999999, 1)
	if(set_temp && istype(planet))
		planet.weather_holder.temperature = max(1,set_temp)
		SSplanets.updateTemp(planet)
