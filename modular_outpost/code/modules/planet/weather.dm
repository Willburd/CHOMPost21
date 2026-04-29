/datum/weather
	var/hazardous_weather

/datum/weather_holder/advance_forecast()
	. = ..()
	if(current_weather.hazardous_weather)
		return
	if(!forecast.len)
		return
	var/next_weather = forecast[1]
	var/datum/weather/new_data = allowed_weather_types[next_weather]
	if(!new_data || !new_data.hazardous_weather)
		return
	addtimer(CALLBACK(src, PROC_REF(weather_alarm)), rand(10,25) SECONDS, TIMER_DELETE_ME)

/datum/weather_holder/proc/weather_alarm()
	SHOULD_NOT_OVERRIDE(TRUE)
	GLOB.priority_announcement.Announce("Crew are advised to delay EVA activities or prepare and shelter accordingly for approaching weather.", "Attention! Severe weather warning is in effect!", new_sound = ANNOUNCER_MSG_WEATHER_ALERT, zlevel = our_planet.expected_z_levels[1])

ADMIN_VERB(weather_warning_siren, R_EVENT, "Severe Weather Siren", "Sets off the severe weather alarm.", ADMIN_CATEGORY_EVENTS)
	var/datum/planet/planet = SSplanets.planets[1]
	if(istype(planet))
		planet.weather_holder.weather_alarm()
