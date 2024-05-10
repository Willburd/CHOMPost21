/datum/data/pda/app/weather
	name = "Weather"
	icon = "cloud"
	template = "pda_weather"

/datum/data/pda/app/weather/update_ui(mob/user as mob, list/data)
	var/list/weather = list()
	//Weather reports.
	for(var/datum/planet/planet in SSplanets.planets)
		if(planet.weather_holder && planet.weather_holder.current_weather)
			var/list/W = list(
				"Planet" = planet.name,
				"Time" = planet.current_time.show_time("hh:mm"),
				"Weather" = planet.weather_holder.current_weather.name,
				"Temperature" = planet.weather_holder.temperature - T0C,
				"High" = planet.weather_holder.current_weather.temp_high - T0C,
				"Low" = planet.weather_holder.current_weather.temp_low - T0C,
				"WindDir" = planet.weather_holder.wind_dir ? dir2text(planet.weather_holder.wind_dir) : "None",
				"WindSpeed" = planet.weather_holder.wind_speed ? "[planet.weather_holder.wind_speed > 2 ? "Severe" : "Normal"]" : "None",
				"Forecast" = english_list(planet.weather_holder.forecast, and_text = "&#8594;", comma_text = "&#8594;", final_comma_text = "&#8594;") // Unicode RIGHTWARDS ARROW.
				)
			weather.Add(list(W))
	data["weather"] = weather

/datum/data/pda/app/sop
	name = "S.O.P"
	icon = "balance-scale"
	template = "pda_sop"
	var/pagenum = 1
	var/list/soptitles = list()
	var/list/sopbodies = list()
	var/list/sopauthor = list()

/datum/data/pda/app/sop/start()
	. = ..()
	// add each sop datum to the reported entries!
	var/list/paths = subtypesof(/datum/sop_entry)
	for(var/subtype in paths)
		var/datum/sop_entry/entry = new subtype()
		soptitles.Add(entry.title)
		sopbodies.Add(entry.body)
		sopauthor.Add(entry.author)

/datum/data/pda/app/sop/update_ui(mob/user as mob, list/data)
	data["sop_title"] = soptitles[pagenum]
	data["sop_body"] = sopbodies[pagenum]
	data["sop_author"] = sopauthor[pagenum]
	data["first"] = (pagenum == 1)
	data["last"] = (pagenum == soptitles.len)

/datum/data/pda/app/sop/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("next")
			pagenum++
			if(pagenum > soptitles.len)
				pagenum = soptitles.len

		if("prev")
			pagenum--
			if(pagenum < 1)
				pagenum = 1
