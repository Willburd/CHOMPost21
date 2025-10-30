var/datum/planet/muriki/planet_muriki = null
//Dev note: This entire file handles weather and planetary effects. File name subject to change pending planet name finalization.
/datum/time/muriki
	seconds_in_day = 18 HOURS

/datum/planet/muriki
	name = "muriki"
	desc = "muriki is a TODO MAKE LORE HERE" // Ripped straight from the wiki.
	current_time = new /datum/time/muriki() // 42 hour
	// Outpost21 - See the Defines for this, so that it can be edited there if needed.
	// expected_z_levels = list()
	planetary_wall_type = /turf/unsimulated/wall/planetary/muriki

	sun_name = "SL-340"
	moon_name = ""

/datum/planet/muriki/New()
	..()
	planet_muriki = src
	weather_holder = new /datum/weather_holder/muriki(src)

// This code is horrible.
/datum/planet/muriki/update_sun()
	..()
	// Debug locked lighting
	if(!isnull(locked_light_color))
		spawn(1)
			update_sun_deferred(locked_light_intensity, locked_light_color)
		return
	// Normal sunlight
	var/datum/time/time = current_time
	var/length_of_day = time.seconds_in_day / 10 / 60 / 60
	var/noon = length_of_day / 2
	var/distance_from_noon = abs(text2num(time.show_time("hh")) - noon)
	sun_position = distance_from_noon / noon
	sun_position = abs(sun_position - 1)

	var/low_brightness = null
	var/high_brightness = null

	var/low_color = null
	var/high_color = null
	var/min = 0

	switch(sun_position)
		if(0 to 0.40) // Night
			low_brightness = 0.2
			low_color = "#660000"

			high_brightness = 0.25
			high_color = "#4D0000"
			min = 0

		if(0.40 to 0.50) // Twilight
			low_brightness = 0.5
			low_color = "#66004D"

			high_brightness = 0.6
			high_color = "#CC3300"
			min = 0.40

		if(0.50 to 0.70) // Sunrise/set
			low_brightness = 0.8
			low_color = "#DDDDDD"

			high_brightness = 0.9
			high_color = "#FFFFFF"
			min = 0.50

		if(0.70 to 1.00) // Noon
			low_brightness = 0.85
			low_color = "#CC3300"

			high_brightness = 0.9
			high_color = "#FF9933"
			min = 0.70

	var/interpolate_weight = (abs(min - sun_position)) * 4
	var/weather_light_modifier = 1
	if(weather_holder && weather_holder.current_weather)
		weather_light_modifier = weather_holder.current_weather.light_modifier

	var/new_brightness = (LERP(low_brightness, high_brightness, interpolate_weight) ) * weather_light_modifier

	var/new_color = null
	if(weather_holder && weather_holder.current_weather && weather_holder.current_weather.light_color)
		new_color = weather_holder.current_weather.light_color
	else
		var/list/low_color_list = hex2rgb(low_color)
		var/low_r = low_color_list[1]
		var/low_g = low_color_list[2]
		var/low_b = low_color_list[3]

		var/list/high_color_list = hex2rgb(high_color)
		var/high_r = high_color_list[1]
		var/high_g = high_color_list[2]
		var/high_b = high_color_list[3]

		var/new_r = LERP(low_r, high_r, interpolate_weight)
		var/new_g = LERP(low_g, high_g, interpolate_weight)
		var/new_b = LERP(low_b, high_b, interpolate_weight)

		new_color = rgb(new_r, new_g, new_b)

	// Seasonal adjust
	switch(GLOB.world_time_season)
		if("spring")
			new_brightness *= 0.9
		if("summer")
			new_brightness *= 1
		if("autumn")
			new_brightness *= 0.9
		if("winter")
			new_brightness *= 0.8

	spawn(1)
		update_sun_deferred(new_brightness, new_color)

// Returns the time datum of muriki.
/proc/get_muriki_time()
	if(planet_muriki)
		return planet_muriki.current_time

/datum/weather/muriki
	var/next_lightning_strike = 0 // world.time when lightning will strike.
	var/min_lightning_cooldown = 0
	var/max_lightning_cooldown = 0

/datum/weather/muriki/proc/fill_vats(var/global_chance,var/single_chance,var/amount)
	if(!prob(global_chance))
		return
	for(var/obj/machinery/reagent_refinery/vat/V in GLOB.vats_to_rain_into)
		if(V.z in holder.our_planet.expected_z_levels)
			var/turf/T = get_turf(V)
			if(!T.is_outdoors())
				continue
			if(prob(single_chance))
				V.reagents.add_reagent(REAGENT_ID_WATER,amount)

/datum/weather/muriki/proc/wet_plating(var/chance)
	if(holder.our_planet.planet_floors.len)
		var/i = rand(6,18)
		while(i-- > 0)
			if(!prob(chance))
				continue
			var/turf/T = pick(holder.our_planet.planet_floors)
			if((istype(T,/turf/simulated/floor/plating) || istype(T,/turf/simulated/floor/outpost_roof)) && T.is_outdoors())
				var/turf/simulated/floor/F = T
				F.wet_floor(1)

// This gets called to do lightning periodically.
// There is a seperate function to do the actual lightning strike, so that badmins can play with it.
/datum/weather/muriki/proc/handle_lightning()
	if(world.time < next_lightning_strike)
		return // It's too soon to strike again.
	next_lightning_strike = world.time + rand(min_lightning_cooldown, max_lightning_cooldown)
	var/turf/T = pick(holder.our_planet.planet_floors) // This has the chance to 'strike' the sky, but that might be a good thing, to scare reckless pilots.
	lightning_strike(T)

//Weather definitions
/datum/weather_holder/muriki
	temperature = 293.15 // 20c
	allowed_weather_types = list(
		WEATHER_CLEAR		= new /datum/weather/muriki/clear(),
		WEATHER_LIGHT_SNOW	= new /datum/weather/muriki/light_snow(),
		WEATHER_SNOW		= new /datum/weather/muriki/snow(),
		WEATHER_BLIZZARD	= new /datum/weather/muriki/blizzard(),
		WEATHER_OVERCAST	= new /datum/weather/muriki/acid_overcast(),
		WEATHER_FOG			= new /datum/weather/muriki/acid_overcast(),
		WEATHER_RAIN        = new /datum/weather/muriki/acid_rain(),
		WEATHER_STORM		= new /datum/weather/muriki/acid_storm(),
		WEATHER_HAIL		= new /datum/weather/muriki/acid_hail(),
		WEATHER_DOWNPOURWARNING = new /datum/weather/muriki/downpourwarning(),
		WEATHER_DOWNPOUR 		= new /datum/weather/muriki/downpour(),
		WEATHER_DOWNPOURFATAL 	= new /datum/weather/muriki/downpourfatal(),
		WEATHER_FALLOUT_TEMP	= new /datum/weather/muriki/fallout/temp(),
		WEATHER_CONFETTI		= new /datum/weather/muriki/confetti(),
		WEATHER_COLDDARKNESS	= new /datum/weather/muriki/clear/hidden_evildarkness(),
		WEATHER_LONGBLIZZARD	= new /datum/weather/muriki/blizzard/hidden_dangerous()
		)
	roundstart_weather_chances = list() // See New() for seasonal starting weathers

/datum/weather_holder/muriki/New(source)
	switch(GLOB.world_time_season)
		if("spring")
			roundstart_weather_chances = list(
				WEATHER_CLEAR = 0,
				WEATHER_LIGHT_SNOW = 25,
				WEATHER_OVERCAST = 5,
				WEATHER_RAIN = 40,
				WEATHER_STORM = 20,
				WEATHER_HAIL = 15
				)
		if("summer")
			roundstart_weather_chances = list(
				WEATHER_CLEAR = 0,
				WEATHER_LIGHT_SNOW = 0,
				WEATHER_OVERCAST = 10,
				WEATHER_RAIN = 40,
				WEATHER_STORM = 50,
				WEATHER_HAIL = 5
				)
		if("autumn")
			roundstart_weather_chances = list(
				WEATHER_CLEAR = 0,
				WEATHER_LIGHT_SNOW = 10,
				WEATHER_OVERCAST = 0,
				WEATHER_RAIN = 40,
				WEATHER_STORM = 40,
				WEATHER_HAIL = 15
				)
		if("winter")
			roundstart_weather_chances = list(
				WEATHER_CLEAR = 0,
				WEATHER_LIGHT_SNOW = 50,
				WEATHER_OVERCAST = 0,
				WEATHER_RAIN = 20,
				WEATHER_STORM = 10,
				WEATHER_HAIL = 24,
				WEATHER_LONGBLIZZARD = 1
				)
	. = ..()

/datum/weather/muriki
	name = "muriki base"
	temp_high = 293.15 // 20c
	temp_low = 288.15	// 15c


/////////////////////////////////////////////////////////////////////////////////////////
// CLEAR SKIES
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/clear
	name = "clear"
	temp_high = 283.15 // 10c
	temp_low = T0C
	wind_high = 2
	wind_low = 1
	transition_chances = list() // See New() for seasonal transitions
	observed_message = "The sky is clear."
	transition_messages = list(
		"The sky clears up.",
		"The sky is visible.",
		"The weather is calm."
		)
	sky_visible = TRUE
	color_grading = COLORTINT_COZY

/datum/weather/muriki/clear/New()
	switch(GLOB.world_time_season)
		if("spring")
			transition_chances = list(
				WEATHER_CLEAR = 15,
				WEATHER_RAIN = 65,
				WEATHER_HAIL = 5,
				WEATHER_LIGHT_SNOW = 15
				)
		if("summer")
			transition_chances = list(
				WEATHER_CLEAR = 15,
				WEATHER_RAIN = 65,
				WEATHER_HAIL = 5,
				WEATHER_OVERCAST = 15
				)
		if("autumn")
			transition_chances = list(
				WEATHER_CLEAR = 15,
				WEATHER_RAIN = 75,
				WEATHER_HAIL = 5,
				WEATHER_LIGHT_SNOW = 5
				)
		if("winter")
			transition_chances = list(
				WEATHER_CLEAR = 15,
				WEATHER_RAIN = 45,
				WEATHER_HAIL = 15,
				WEATHER_LIGHT_SNOW = 25
				)
	. = ..()


/////////////////////////////////////////////////////////////////////////////////////////
// DEATH FOG
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/acid_overcast
	name = "fog"
	icon_state = "acidfog"
	wind_high = 1
	wind_low = 0
	light_modifier = 0.7
	effect_message = span_notice("Acidic mist surrounds you.")
	transition_chances = list() // See New() for seasonal transitions
	observed_message = "It is misting, all you can see are corrosive clouds."
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING

	transition_messages = list(
		"All you can see is fog.",
		"Fog cuts off your view.",
		"It's very foggy."
		)

	outdoor_sounds_type = /datum/looping_sound/weather/wind/gentle
	indoor_sounds_type = /datum/looping_sound/weather/wind/gentle/indoors
	color_grading = COLORTINT_WARM

/datum/weather/muriki/acid_overcast/New()
	switch(GLOB.world_time_season)
		if("spring")
			transition_chances = list(
				WEATHER_OVERCAST = 15,
				WEATHER_RAIN = 60,
				WEATHER_HAIL = 10,
				WEATHER_LIGHT_SNOW = 10,
				WEATHER_CLEAR = 5,
				)
		if("summer")
			transition_chances = list(
				WEATHER_OVERCAST = 35,
				WEATHER_RAIN = 60,
				WEATHER_CLEAR = 5
				)
		if("autumn")
			transition_chances = list(
				WEATHER_OVERCAST = 15,
				WEATHER_RAIN = 80,
				WEATHER_HAIL = 4,
				WEATHER_CLEAR = 1
				)
		if("winter")
			transition_chances = list(
				WEATHER_OVERCAST = 15,
				WEATHER_RAIN = 40,
				WEATHER_LIGHT_SNOW = 20,
				WEATHER_HAIL = 25
				)
	. = ..()

/datum/weather/muriki/acid_overcast/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return

		L.water_act(1)
		muriki_enzyme_affect_mob(L,2,TRUE,FALSE)


/////////////////////////////////////////////////////////////////////////////////////////
// DEATH RAIN
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/acid_rain
	name = "rain"
	icon_state = "rain"
	temp_high = 293.15 // 20c
	temp_low = T0C
	wind_high = 2
	wind_low = 1
	light_modifier = 0.5
	effect_message = span_notice("Acidic rain falls on you.")
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING

	transition_chances = list() // See New() for seasonal transitions
	observed_message = "It is raining."
	transition_messages = list(
		"The sky is dark, and acidic rain falls down upon you."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/rain
	indoor_sounds_type = /datum/looping_sound/weather/rain/indoors
	color_grading = COLORTINT_DIM

/datum/weather/muriki/acid_rain/New()
	switch(GLOB.world_time_season)
		if("spring")
			transition_chances = list(
				WEATHER_OVERCAST = 5,
				WEATHER_RAIN = 60,
				WEATHER_STORM = 45,
				WEATHER_HAIL = 10,
				WEATHER_LIGHT_SNOW = 5
			)
		if("summer")
			transition_chances = list(
				WEATHER_OVERCAST = 55,
				WEATHER_RAIN = 25,
				WEATHER_STORM = 10,
				WEATHER_HAIL = 5,
				WEATHER_CLEAR = 5
			)
		if("autumn")
			transition_chances = list(
				WEATHER_OVERCAST = 15,
				WEATHER_RAIN = 30,
				WEATHER_STORM = 45,
				WEATHER_HAIL = 5,
				WEATHER_LIGHT_SNOW = 5,
			)
		if("winter")
			transition_chances = list(
				WEATHER_OVERCAST = 5,
				WEATHER_RAIN = 15,
				WEATHER_STORM = 50,
				WEATHER_LIGHT_SNOW = 10,
				WEATHER_HAIL = 15
			)
	. = ..()

/datum/weather/muriki/acid_rain/process_effects()
	..()
	wet_plating(30)
	fill_vats(10,40,8)

/datum/weather/muriki/acid_rain/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return // They're indoors, so no need to rain on them.

		// If they have an open umbrella, it'll guard from rain
		if(istype(L.get_active_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = L.get_active_hand()
			if(U.open)
				if(show_message)
					to_chat(L, span_notice("Rain showers loudly onto your umbrella!"))
				return
		else if(istype(L.get_inactive_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = L.get_inactive_hand()
			if(U.open)
				if(show_message)
					to_chat(L, span_notice("Rain showers loudly onto your umbrella!"))
				return

		if(show_message)
			to_chat(L, effect_message)

		L.water_act(2)
		muriki_enzyme_affect_mob(L,2,FALSE,FALSE)


/////////////////////////////////////////////////////////////////////////////////////////
// REALLY DEATH RAIN
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/acid_storm
	name = "storm"
	icon_state = "storm"
	temp_high = T0C
	temp_low =  268.15 // -5c
	wind_high = 4
	wind_low = 2
	light_modifier = 0.3
	flight_failure_modifier = 10
	effect_message = span_notice("Acidic rain falls on you.")
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING

	min_lightning_cooldown = 5 SECONDS
	max_lightning_cooldown = 1 MINUTE
	observed_message = "An intense storm pours down over the region."
	transition_messages = list(
		"You feel intense winds hit you as the weather takes a turn for the worst.",
		"Loud thunder is heard in the distance.",
		"A bright flash heralds the approach of a storm."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/rain
	indoor_sounds_type = /datum/looping_sound/weather/rain/indoors

	transition_chances = list() // See New() for seasonal transitions
	color_grading = COLORTINT_DARK

/datum/weather/muriki/acid_storm/New()
	switch(GLOB.world_time_season)
		if("spring")
			transition_chances = list(
				WEATHER_RAIN = 45,
				WEATHER_STORM = 30,
				WEATHER_DOWNPOURWARNING = 6, // Fun times ahead
				WEATHER_HAIL = 15,
				WEATHER_OVERCAST = 4
				)
		if("summer")
			transition_chances = list(
				WEATHER_RAIN = 70,
				WEATHER_STORM = 26,
				WEATHER_DOWNPOURWARNING = 4 // Fun times ahead
				)
		if("autumn")
			transition_chances = list(
				WEATHER_RAIN = 45,
				WEATHER_STORM = 30,
				WEATHER_DOWNPOURWARNING = 4, // Fun times ahead
				WEATHER_HAIL = 15,
				WEATHER_OVERCAST = 6
				)
		if("winter")
			transition_chances = list(
				WEATHER_RAIN = 55,
				WEATHER_STORM = 10,
				WEATHER_DOWNPOURWARNING = 3, // Fun times ahead
				WEATHER_HAIL = 25,
				WEATHER_OVERCAST = 7
				)
	. = ..()

/datum/weather/muriki/acid_storm/process_effects()
	..()
	handle_lightning()
	wet_plating(60)
	fill_vats(20,40,16)

/datum/weather/muriki/acid_storm/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return // They're indoors so no need to rain on them.

		// Lazy wind code
		if(prob(4))
			if(istype(L.get_active_hand(), /obj/item/melee/umbrella))
				var/obj/item/melee/umbrella/U = L.get_active_hand()
				if(U.open)
					to_chat(L, span_danger("You struggle to keep hold of your umbrella!"))
					L.Stun(10)
					playsound(L, 'sound/effects/rustle1.ogg', 100, 1)	// Closest sound I've got to "Umbrella in the wind"
			else if(istype(L.get_inactive_hand(), /obj/item/melee/umbrella))
				var/obj/item/melee/umbrella/U = L.get_inactive_hand()
				if(U.open)
					to_chat(L, span_danger("A gust of wind yanks the umbrella from your hand!"))
					playsound(L, 'sound/effects/rustle1.ogg', 100, 1)
					L.drop_from_inventory(U)
					U.toggle_umbrella()
					U.throw_at(get_edge_target_turf(U, pick(GLOB.alldirs)), 8, 1, L)

		// If they have an open umbrella, it'll guard from rain
		if(istype(L.get_active_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = L.get_active_hand()
			if(U.open)
				if(show_message)
					to_chat(L, span_notice("Rain showers loudly onto your umbrella!"))
				return
		else if(istype(L.get_inactive_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = L.get_inactive_hand()
			if(U.open)
				if(show_message)
					to_chat(L, span_notice("Rain showers loudly onto your umbrella!"))
				return

		if(show_message)
			to_chat(L, effect_message)

		L.water_act(3)
		muriki_enzyme_affect_mob(L,4,FALSE,FALSE)


/////////////////////////////////////////////////////////////////////////////////////////
// DOWNPOUR WARNING
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/downpourwarning
	name = "early extreme monsoon"
	light_modifier = 0.4
	timer_low_bound = 1
	timer_high_bound = 2

	transition_chances = list(
		WEATHER_DOWNPOUR = 100
	)
	observed_message = "It looks like a very bad storm is about to approach."
	transition_messages = list(
		span_danger("Inky black clouds cover the sky in a eerie rumble, get to cover!")
	)
	outdoor_sounds_type = /datum/looping_sound/weather/rainrumble
	indoor_sounds_type = /datum/looping_sound/weather/rainrumble/indoors
	color_grading = COLORTINT_DARK


/////////////////////////////////////////////////////////////////////////////////////////
// ACTUAL DOWNPOUR
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/downpour
	name = "extreme monsoon"
	icon_state = "downpour"
	light_modifier = 0.3
	timer_low_bound = 1
	timer_high_bound = 1
	wind_high = 4
	wind_low = 2
	flight_failure_modifier = 100
	effect_message = span_warning("Extreme rain is knocking you down!")
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING

	min_lightning_cooldown = 5 SECONDS
	max_lightning_cooldown = 15 SECONDS

	transition_chances = list(
		WEATHER_DOWNPOURFATAL = 95,
		WEATHER_STORM = 5
	)
	observed_message = "Extreme rain is crushing you, get to cover!"
	transition_messages = list(
		span_danger("An immense downpour of falls on top of of the planet crushing anything in its path!")
	)
	outdoor_sounds_type = /datum/looping_sound/weather/rainheavy
	indoor_sounds_type = /datum/looping_sound/weather/rainindoors
	color_grading = COLORTINT_DARK

/datum/weather/muriki/downpour/process_effects()
	..()
	handle_lightning()
	wet_plating(70)
	fill_vats(25,50,25)

/datum/weather/muriki/downpour/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return // They're indoors, so no need to rain on them.

		// If they have an open umbrella, knock it off
		var/obj/item/melee/umbrella/U = L.get_active_hand()
		if(!istype(U) || !U.open)
			U = L.get_inactive_hand()
		if(istype(U) && U.open)
			if(show_message)
				to_chat(L, span_notice("The storm pushes the umbrella out of your hands!"))
				L.drop_both_hands()

		L.water_act(2)
		L.Weaken(3)

		if(show_message)
			to_chat(L, effect_message)

		L.water_act(5)
		muriki_enzyme_affect_mob(L,4,FALSE,FALSE)


/////////////////////////////////////////////////////////////////////////////////////////
// MEGADEATH DOWNPOUR
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/downpourfatal
	name = "fatal monsoon"
	icon_state = "downpourfatal"
	light_modifier = 0.15
	timer_low_bound = 1
	timer_high_bound = 3
	wind_high = 6
	wind_low = 4
	flight_failure_modifier = 100
	effect_message = span_warning("Extreme rain is crushing you!")
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING

	min_lightning_cooldown = 1 SECONDS
	max_lightning_cooldown = 3 SECONDS

	transition_chances = list(
		WEATHER_DOWNPOURFATAL = 65,
		WEATHER_RAIN = 25,
		WEATHER_CLEAR = 10
	)
	observed_message = "Extreme rain is crushing you, get to cover!"
	//No transition message, supposed to be the 'actual' rain
	outdoor_sounds_type = /datum/looping_sound/weather/rainextreme
	indoor_sounds_type = /datum/looping_sound/weather/rainindoors
	color_grading = COLORTINT_DARK

/datum/weather/muriki/downpourfatal/process_effects()
	..()
	handle_lightning()
	wet_plating(60)
	fill_vats(45,60,35)

/datum/weather/muriki/downpourfatal/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return // They're indoors, so no need to rain on them.

		// If they have an open umbrella, knock it off
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			var/obj/item/melee/umbrella/U = L.get_active_hand()
			if(!istype(U) || !U.open)
				U = L.get_inactive_hand()

			if(istype(U) && U.open)
				if(show_message)
					to_chat(L, span_notice("The rain pushes the umbrella off your hands!"))
					H.drop_both_hands()

		var/target_zone = pick(BP_ALL)
		var/amount_blocked = L.run_armor_check(target_zone, "melee")
		var/amount_soaked = L.get_armor_soak(target_zone, "melee")

		var/damage = rand(10,30) //Ow

		if(amount_blocked >= 30)
			return

		if(amount_soaked >= damage)
			return // No need to apply damage.

		L.apply_damage(damage, BRUTE, target_zone, amount_blocked, amount_soaked, used_weapon = "rain bludgoning")
		L.Weaken(3)

		if(show_message)
			to_chat(L, effect_message)

		// digest living things
		L.water_act(6)
		muriki_enzyme_affect_mob(L,9,FALSE,FALSE)


/////////////////////////////////////////////////////////////////////////////////////////
// HAIL
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/acid_hail
	name = "hail"
	icon_state = "hail"
	temp_high = 263.15  // -10c
	temp_low = 258.15 // -15c
	light_modifier = 0.3
	flight_failure_modifier = 15
	timer_low_bound = 2
	timer_high_bound = 5
	effect_message = span_warning("The hail smacks into you!")
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING
	outdoor_sounds_type = /datum/looping_sound/weather/outside_snow
	indoor_sounds_type = /datum/looping_sound/weather/inside_snow

	transition_chances = list(
		WEATHER_RAIN = 20,
		WEATHER_STORM = 5,
		WEATHER_HAIL = 4,
		WEATHER_OVERCAST = 70,
		WEATHER_CLEAR = 1
		)
	observed_message = "Frozen acid is falling from the sky."
	transition_messages = list(
		"Frozen acid begins to fall from the sky.",
		"It begins to hail.",
		"An intense chill is felt, and chunks of frozen acid start to fall from the sky, towards you."
	)
	color_grading = COLORTINT_CHILL

/datum/weather/muriki/acid_hail/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return // They're indoors or dead, so no need to pelt them with ice.

		// If they have an open umbrella, it'll guard from hail
		var/obj/item/melee/umbrella/U = L.get_active_hand()
		if(!istype(U) || !U.open)
			U = L.get_inactive_hand()

		if(istype(U) && U.open)
			if(show_message)
				to_chat(L, span_notice("Hail patters onto your umbrella."))
			return

		var/target_zone = pick(BP_ALL)
		var/amount_blocked = L.run_armor_check(target_zone, "melee")
		var/amount_soaked = L.get_armor_soak(target_zone, "melee")

		var/damage = rand(1,3)

		if(amount_blocked >= 30)
			return // No need to apply damage. Hardhats are 30. They should probably protect you from hail on your head.
			//Voidsuits are likewise 40, and riot, 80. Clothes are all less than 30.

		if(amount_soaked >= damage)
			return // No need to apply damage.
		L.apply_damage(damage, BRUTE, target_zone, amount_blocked, amount_soaked, used_weapon = "hail")

		// show transition messages
		if(show_message)
			to_chat(L, effect_message)


/////////////////////////////////////////////////////////////////////////////////////////
// SNOW
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/light_snow
	name = "light snow"
	icon_state = "snowfall_light"
	temp_high = T0C
	temp_low = 263.15 // -10c
	wind_high = 1
	wind_low = 0
	light_modifier = 0.8
	transition_chances = list() // See New() for seasonal transitions
	observed_message = "It is snowing lightly."
	transition_messages = list(
		"Small snowflakes begin to fall from above.",
		"It begins to snow lightly.",
		)
	color_grading = COLORTINT_CHILL

/datum/weather/muriki/light_snow/New()
	switch(GLOB.world_time_season)
		if("spring")
			transition_chances = list(
				WEATHER_LIGHT_SNOW = 50,
				WEATHER_CLEAR = 50
				)
		if("summer")
			transition_chances = list(
				WEATHER_LIGHT_SNOW = 10,
				WEATHER_CLEAR = 90
				)
		if("autumn")
			transition_chances = list(
				WEATHER_LIGHT_SNOW = 50,
				WEATHER_CLEAR = 50
				)
		if("winter")
			transition_chances = list(
				WEATHER_LIGHT_SNOW = 40,
				WEATHER_SNOW = 40,
				WEATHER_CLEAR = 20
				)
	. = ..()

/datum/weather/muriki/snow
	name = "moderate snow"
	icon_state = "snowfall_med"
	temp_high = 258.15 // -15c
	temp_low = 253.15 // -20c
	wind_high = 2
	wind_low = 0
	light_modifier = 0.5
	flight_failure_modifier = 5
	transition_chances = list(
		WEATHER_LIGHT_SNOW = 10,
		WEATHER_SNOW = 50,
		WEATHER_BLIZZARD = 30,
		WEATHER_HAIL = 5,
		WEATHER_CLEAR = 5
		)
	observed_message = "It is snowing."
	transition_messages = list(
		"It's starting to snow.",
		"The air feels much colder as snowflakes fall from above."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/outside_snow
	indoor_sounds_type = /datum/looping_sound/weather/inside_snow
	color_grading = COLORTINT_COLD


/////////////////////////////////////////////////////////////////////////////////////////
// BLIZZARD
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/blizzard
	name = "blizzard"
	icon_state = "snowfall_heavy"
	temp_high = 243.15 // -30c
	temp_low = 213.15 // -60c
	wind_high = 4
	wind_low = 2
	light_modifier = 0.3
	flight_failure_modifier = 10
	effect_message = span_warning("The ice shards cut into you!")
	effect_flags = HAS_PLANET_EFFECT|EFFECT_ONLY_LIVING
	transition_chances = list(
		WEATHER_SNOW = 45,
		WEATHER_BLIZZARD = 40,
		WEATHER_HAIL = 10,
		WEATHER_CLEAR = 5
		)
	observed_message = "A blizzard blows snow everywhere."
	transition_messages = list(
		"Strong winds howl around you as a blizzard appears.",
		"It starts snowing heavily, and it feels extremly cold now."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/outside_blizzard
	indoor_sounds_type = /datum/looping_sound/weather/inside_blizzard
	color_grading = COLORTINT_COLD

/datum/weather/muriki/blizzard/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.is_outdoors())
			return // They're indoors or dead, so no need to pelt them with ice.

		if(prob(10))
			// If they have an open umbrella, it'll guard from hail
			var/obj/item/melee/umbrella/U = L.get_active_hand()
			if(!istype(U) || !U.open)
				U = L.get_inactive_hand()
			if(istype(U) && U.open)
				if(prob(10))
					if(show_message)
						to_chat(L, span_notice("The storm pushes the umbrella out of your hands!"))
						L.drop_both_hands()
				else
					if(show_message)
						to_chat(L, span_notice("ice shards patter onto your umbrella."))
				return

			var/target_zone = pick(BP_ALL)
			var/amount_blocked = L.run_armor_check(target_zone, "melee")
			var/amount_soaked = L.get_armor_soak(target_zone, "melee")

			var/damage = rand(1,3)

			if(amount_blocked >= 30)
				return // No need to apply damage. Hardhats are 30. They should probably protect you from hail on your head.
				//Voidsuits are likewise 40, and riot, 80. Clothes are all less than 30.

			if(amount_soaked >= damage)
				return // No need to apply damage.
			L.apply_damage(damage, BRUTE, target_zone, amount_blocked, amount_soaked, used_weapon = "sharp ice")

			// show transition messages
			if(show_message)
				to_chat(L, effect_message)

/////////////////////////////////////////////////////////////////////////////////////////
// FIREWORKS
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/fallout/temp //fixs firework stars
	name = "short-term fallout"
	timer_low_bound = 1
	timer_high_bound = 3
	transition_chances = list(
		WEATHER_FALLOUT = 10,
		WEATHER_RAIN = 50,
		WEATHER_STORM = 20
		)
	color_grading = COLORTINT_MEAT

/datum/weather/muriki/confetti //fixs firework stars
	name = "confetti"
	icon_state = "confetti"

	transition_chances = list(
		WEATHER_RAIN = 50,
		WEATHER_OVERCAST = 20,
		WEATHER_CONFETTI = 5
		)
	observed_message = "Confetti is raining from the sky."
	transition_messages = list(
		"Suddenly, colorful confetti starts raining from the sky."
	)
	imminent_transition_message = "A rain is starting... A rain of confetti...?"
	color_grading = COLORTINT_OMEN





/////////////////////////////////////////////////////////////////////////////////////////
// EVENT WEATHERS

/////////////////////////////////////////////////////////////////////////////////////////
// EXTREME BLIZZARD
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/blizzard/hidden_dangerous
	name = "extreme blizzard"
	temp_high = 213.15 // -60c
	temp_low = 183.15 // -90c
	light_modifier = 0.1
	flight_failure_modifier = 10
	transition_chances = list(
		WEATHER_LONGBLIZZARD = 95,
		WEATHER_BLIZZARD = 5,
		)
	color_grading = COLORTINT_EXTREMECOLD
	observed_message = "The blizzard grows more intense."
	transition_messages = list(
		"The blizzard's wind chills you to your bones."
	)

/////////////////////////////////////////////////////////////////////////////////////////
// EVIL DARKNESS
/////////////////////////////////////////////////////////////////////////////////////////
/datum/weather/muriki/clear/hidden_evildarkness
	name = "frigid darkness"
	temp_high = 120
	temp_low = 100
	wind_high = 0
	wind_low = 0
	light_modifier = 0.01
	transition_chances = list(
		WEATHER_COLDDARKNESS = 95,
		WEATHER_CLEAR = 5,
		)
	color_grading = COLORTINT_UNDERDARK
	observed_message = "The world feels still."
	transition_messages = list(
		"Everything around you seems to stop, it's quiet enough to hear the air creaking under the weight of something you cannot see."
	)


/////////////////////////////////////////////////////////////////////////////////////////
// Muriki enzymatic rain effects
/////////////////////////////////////////////////////////////////////////////////////////
/mob/living/
	var/enzyme_affect = TRUE

/proc/muriki_enzyme_affect_mob( var/mob/living/L, var/multiplier, var/mist, var/submerged)
	// drop out early if no damage anyway
	if(multiplier <= 0)
		return

	// no phased out or observer
	if(isnull(L) || L.is_incorporeal() || istype(L,/mob/observer))
		return

	// no synth damage
	if(issilicon(L))
		return
	// check for excluded wildlife
	if(!L.enzyme_affect)
		return

	// We find this to be pleasant weather~
	var/probmod = 1
	var/mob/living/carbon/human/H = L
	if(istype(H))
		if(is_changeling(H))
			return
		if(H.species)
			probmod = H.species.enzyme_contact_mod
		if(probmod == 0)
			return
		if(!prob(100 * probmod))
			return

	// acid burn time!
	var/min_permeability = 0.15;

	//Burn eyes, lungs and skin if misting...
	var/burn_eyes = mist
	var/burn_lungs = mist

	//Check for protective maskwear
	if(istype(H))
		//Check for protective helmets, if blocks airtight and smoke should be full head helmet anyway like a biohood!
		if(burn_eyes && H.head && ((H.head.item_flags & BLOCK_GAS_SMOKE_EFFECT) || (H.head.item_flags & AIRTIGHT) || (H.head.flags & PHORONGUARD)))
			burn_eyes = FALSE
		//Check for protective glasses
		if(burn_eyes && H.glasses && (H.glasses.body_parts_covered & EYES) && ((H.glasses.item_flags & BLOCK_GAS_SMOKE_EFFECT) || (H.glasses.item_flags & AIRTIGHT) || (H.glasses.flags & PHORONGUARD)))
			burn_eyes = FALSE
		// no breathers
		if(!H.species || !H.species.breath_type)
			burn_lungs = FALSE
	if(L.wear_mask)
		// check for masks
		if(burn_eyes && (L.wear_mask.body_parts_covered & EYES) && ((L.wear_mask.item_flags & BLOCK_GAS_SMOKE_EFFECT) || (L.wear_mask.item_flags & AIRTIGHT) || (L.wear_mask.flags & PHORONGUARD)))
			burn_eyes = FALSE
		if(burn_lungs && (L.wear_mask.item_flags & BLOCK_GAS_SMOKE_EFFECT))
			burn_lungs = FALSE

	// check if running on internals to protect lungs
	if(burn_lungs && L.internal)
		burn_lungs = FALSE

	//burn their eyes!
	if(burn_eyes)
		var/obj/item/organ/internal/eyes/O = L.internal_organs_by_name[O_EYES]
		if(O && prob(20 * probmod) && O.robotic <= ORGAN_ASSISTED)
			O.damage += 8
			to_chat(L,  "<span class='danger'>Your eyes burn!</span>")
	//burn their lungs!
	if(burn_lungs)
		var/obj/item/organ/internal/lungs/O = L.internal_organs_by_name[O_LUNGS]
		if(O && prob(20 * probmod) && O.robotic <= ORGAN_ASSISTED)
			O.damage += 12
			to_chat(L,  "<span class='danger'>Your lungs burn!</span>")

	// Skip complex checks if simple mob that's not immune
	if(isanimal(L))
		if(!submerged)
			to_chat(L, "<span class='danger'>The acidic environment burns your body!</span>")
			L.adjustFireLoss( 0.8 * multiplier, FALSE)
		else
			to_chat(L, "<span class='danger'>The acidic pool is digesting your body!</span>")
			L.adjustFireLoss( 0.8 * multiplier,  FALSE) // note, water passes the acid depth as the multiplier, 5 or 10 depending on depth!
		return


	// find damaging zones to burn mobs skin!
	var/obj/item/protection = null


	var/applied_damage = FALSE
	var/pick_zone = ran_zone()
	var/obj/item/organ/external/org = L.get_organ(pick_zone)
	if(org && org.robotic < ORGAN_ROBOT)
		if(pick_zone == BP_HEAD)
			if(istype(H))
				protection = H.head
		else if(pick_zone == BP_GROIN || pick_zone == BP_TORSO)
			if(istype(H))
				protection = H.wear_suit
				if(protection == null)
					protection = H.w_uniform
		else if(pick_zone == BP_L_ARM || pick_zone == BP_R_ARM)
			if(istype(H))
				protection = H.wear_suit // suit will protect arms in most cases, otherwise try gloves?
				if(protection == null)
					protection = H.gloves
		else if(pick_zone == BP_L_HAND || pick_zone == BP_R_HAND)
			if(istype(H))
				protection = H.wear_suit // avoid checking gloves directly, highly permeable in most cases
				if(protection == null)
					protection = H.gloves
		else if(pick_zone == BP_L_LEG || pick_zone == BP_R_LEG)
			if(istype(H))
				protection = H.wear_suit // most nonpermeable boots are large ones like gooloshes, suit usually protects legs first though
				if(protection == null)
					protection = H.shoes
		else if(pick_zone == BP_L_FOOT || pick_zone == BP_R_FOOT)
			if(istype(H))
				protection = H.wear_suit // suit will protect feet in most cases, otherwise try shoes?
				if(protection == null)
					protection = H.shoes

		if(!submerged)
			if(protection == null)
				// full damage, what are you doing!?
				to_chat(L, "<span class='danger'>The acidic environment burns your [L.get_bodypart_name(pick_zone)]!</span>")
				L.apply_damage( 3 * multiplier, BURN, pick_zone, used_weapon = "enzymatic burns")
				org.wounds +=  new /datum/wound/cut/small(mist ? 5 : 3)
				applied_damage = TRUE

			else if(protection.permeability_coefficient > min_permeability)
				// only show the message if the permeability selection actually did any damage at all
				to_chat(H, "<span class='danger'>The acidic environment leaks through \The [protection], and is burning your [L.get_bodypart_name(pick_zone)]!</span>")
				L.apply_damage( 2 * (protection.permeability_coefficient * multiplier), BURN, pick_zone, used_weapon = "enzymatic burns")
				org.wounds +=  new /datum/wound/cut/small(mist ? 5 : 3)
				applied_damage = TRUE

		else if(prob(65 * probmod))
			if(!istype(H) || !protection) // no protection!
				to_chat(L, "<span class='danger'>The acidic pool is digesting your [L.get_bodypart_name(pick_zone)]!</span>")
				L.apply_damage( 1.8 * multiplier,  BURN, pick_zone, used_weapon = "enzymatic burns") // note, water passes the acid depth as the multiplier, 5 or 10 depending on depth!
				org.wounds +=  new /datum/wound/cut/small(4)
				applied_damage = TRUE
			else
				var/obj/item/rig/R = H.back
				if(!(istype(H.back,/obj/item/rig) && R.suit_is_deployed())) // rig snowflake check
					if(protection.permeability_coefficient > min_permeability) // leaky protection
						to_chat(L, "<span class='danger'>The acidic pool leaks through \The [protection], and is digesting your [L.get_bodypart_name(pick_zone)]!</span>")
						L.apply_damage( 1.1 * (protection.permeability_coefficient * multiplier),  BURN, pick_zone, used_weapon = "enzymatic burns") // note, water passes the acid depth as the multiplier, 5 or 10 depending on depth!
						org.wounds +=  new /datum/wound/cut/small(4)
						applied_damage = TRUE
					else
						var/liquidbreach = H.get_pressure_weakness( 0) // spacesuit are watertight
						if(liquidbreach > 0) // unprotected!
							to_chat(L, "<span class='danger'>The acidic pool splashes into \The [protection], and is digesting your [L.get_bodypart_name(pick_zone)]!</span>")
							L.apply_damage( 1 * (protection.permeability_coefficient * multiplier),  BURN, pick_zone, used_weapon = "enzymatic burns") // note, water passes the acid depth as the multiplier, 5 or 10 depending on depth!
							org.wounds +=  new /datum/wound/cut/small(4)
							applied_damage = TRUE

	if(applied_damage && ((org.damage >= 10 && prob(5)) || (org.damage >= 30 && prob(15)) || org.damage >= 80))
		if(!(pick_zone == BP_GROIN || pick_zone == BP_TORSO))
			org.droplimb(TRUE, DROPLIMB_ACID)
