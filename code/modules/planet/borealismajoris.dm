var/datum/planet/borealis2/planet_borealis2 = null
//Dev note: This entire file handles weather and planetary effects. File name subject to change pending planet name finalization.
/datum/time/borealis2
	seconds_in_day = 3 HOURS

/datum/planet/borealis2
	name = "Borealis 2"
	desc = "A Icey-frozen tundra, this planet has an atmosphere mainly comprised of frigid oxygen, with trace \
	amounts of both carbon dioxide and nitrogen. Originally being a lumber colony, recent findings show copious amounts of Phoron deep under the surface, \
	the Phoron is very desirable by many corporations, including NanoTrasen."
	current_time = new /datum/time/borealis2()
// YW - See the Defines for this, so that it can be edited there if needed.
/*	expected_z_levels = list(
						Z_LEVEL_CRYOGAIA_LOWER,
						Z_LEVEL_CRYOGAIA_MAIN,
						Z_LEVEL_CRYOGAIA_MINE,
						)*/
	planetary_wall_type = /turf/unsimulated/wall/planetary/borealis2

/datum/planet/borealis2/New()
	..()
	planet_borealis2 = src
	weather_holder = new /datum/weather_holder/borealis2(src)

/datum/planet/borealis2/update_sun()
	..()
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
			low_color = "#000066"

			high_brightness = 0.5
			high_color = "#66004D"
			min = 0

		if(0.40 to 0.50) // Twilight
			low_brightness = 0.6
			low_color = "#66004D"

			high_brightness = 0.8
			high_color = "#CC3300"
			min = 0.40

		if(0.50 to 0.70) // Sunrise/set
			low_brightness = 0.8
			low_color = "#CC3300"

			high_brightness = 0.9
			high_color = "#FF9933"
			min = 0.50

		if(0.70 to 1.00) // Noon
			low_brightness = 0.9
			low_color = "#DDDDDD"

			high_brightness = 1.0
			high_color = "#FFFFFF"
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

	spawn(1)
		update_sun_deferred(2, new_brightness, new_color)


/datum/weather_holder/borealis2
	temperature = T0C
	allowed_weather_types = list(
		WEATHER_CLEAR		= new /datum/weather/borealis2/clear(),
		WEATHER_OVERCAST	= new /datum/weather/borealis2/overcast(),
		WEATHER_LIGHT_SNOW	= new /datum/weather/borealis2/light_snow(),
		WEATHER_SNOW		= new /datum/weather/borealis2/snow(),
		WEATHER_BLIZZARD	= new /datum/weather/borealis2/blizzard(),
		WEATHER_RAIN		= new /datum/weather/borealis2/rain(),
		WEATHER_STORM		= new /datum/weather/borealis2/storm(),
		WEATHER_HAIL		= new /datum/weather/borealis2/hail(),
		WEATHER_BLOOD_MOON	= new /datum/weather/borealis2/blood_moon(),
		WEATHER_EMBERFALL	= new /datum/weather/borealis2/emberfall(),
		WEATHER_ASH_STORM	= new /datum/weather/borealis2/ash_storm(),
		WEATHER_FALLOUT		= new /datum/weather/borealis2/fallout()
		)
	roundstart_weather_chances = list(
		WEATHER_CLEAR		= 30,
		WEATHER_OVERCAST	= 30,
		WEATHER_LIGHT_SNOW	= 20,
		WEATHER_SNOW		= 5,
		WEATHER_BLIZZARD	= 5,
		WEATHER_RAIN		= 5,
		WEATHER_STORM		= 2.5,
		WEATHER_HAIL		= 2.5
		)

/datum/weather/borealis2
	name = "borealis2 base"
	temp_high = 233.15 // -40c
	temp_low =  228.15 // -70c

/datum/weather/borealis2/clear
	name = "clear"
	transition_chances = list(
		WEATHER_CLEAR = 50,
		WEATHER_OVERCAST = 50
		)
	transition_messages = list(
		"The sky clears up.",
		"The sky is visible.",
		"The weather is calm."
		)
	sky_visible = TRUE
	observed_message = "The sky is clear."

/datum/weather/borealis2/overcast
	name = "overcast"
	light_modifier = 0.8
	transition_chances = list(
		WEATHER_CLEAR = 20,
		WEATHER_OVERCAST = 40,
		WEATHER_LIGHT_SNOW = 20,
		WEATHER_SNOW = 10,
		WEATHER_RAIN = 5,
		WEATHER_HAIL = 5
		)
	observed_message = "It is overcast, all you can see are clouds."
	transition_messages = list(
		"All you can see above are clouds.",
		"Clouds cut off your view of the sky.",
		"It's very cloudy."
		)

/datum/weather/borealis2/light_snow
	name = "light snow"
	icon_state = "snowfall_light"
	temp_high = 230
	temp_low = 	220
	light_modifier = 0.7
	transition_chances = list(
		WEATHER_OVERCAST = 20,
		WEATHER_LIGHT_SNOW = 40,
		WEATHER_SNOW = 35,
		WEATHER_HAIL = 5
		)
	observed_message = "It is snowing lightly."
	transition_messages = list(
		"Small snowflakes begin to fall from above.",
		"It begins to snow lightly.",
		)

/datum/weather/borealis2/snow
	name = "moderate snow"
	icon_state = "snowfall_med"
	temp_high = 220
	temp_low = 210
	wind_high = 2
	wind_low = 0
	light_modifier = 0.5
	flight_failure_modifier = 5
	transition_chances = list(
		WEATHER_LIGHT_SNOW = 10,
		WEATHER_SNOW = 50,
		WEATHER_BLIZZARD = 30,
		WEATHER_HAIL = 5,
		WEATHER_OVERCAST = 5
		)
	observed_message = "It is snowing."
	transition_messages = list(
		"It's starting to snow.",
		"The air feels much colder as snowflakes fall from above."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/outside_snow
	indoor_sounds_type = /datum/looping_sound/weather/inside_snow

/datum/weather/borealis2/snow/process_effects()
	..()
	for(var/turf/simulated/floor/outdoors/snow/S in SSplanets.new_outdoor_turfs) //This didn't make any sense before SSplanets, either
		if(S.z in holder.our_planet.expected_z_levels)
			for(var/dir_checked in cardinal)
				var/turf/simulated/floor/T = get_step(S, dir_checked)
				if(istype(T))
					if(istype(T, /turf/simulated/floor/outdoors) && prob(33))
						T.chill()

/datum/weather/borealis2/blizzard
	name = "blizzard"
	icon_state = "snowfall_heavy"
	temp_high = 200
	temp_low = 190
	wind_high = 4
	wind_low = 2
	light_modifier = 0.3
	flight_failure_modifier = 10
	transition_chances = list(
		WEATHER_SNOW = 45,
		WEATHER_BLIZZARD = 40,
		WEATHER_HAIL = 10,
		WEATHER_OVERCAST = 5
		)
	observed_message = "A blizzard blows snow everywhere."
	transition_messages = list(
		"Strong winds howl around you as a blizzard appears.",
		"It starts snowing heavily, and it feels extremly cold now."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/outside_blizzard
	indoor_sounds_type = /datum/looping_sound/weather/inside_blizzard
	effect_flags = HAS_PLANET_EFFECT | EFFECT_ONLY_LIVING

/datum/weather/borealis2/blizzard/process_effects()
	..()
	for(var/turf/simulated/floor/outdoors/snow/S in SSplanets.new_outdoor_turfs) //This didn't make any sense before SSplanets, either
		if(S.z in holder.our_planet.expected_z_levels)
			for(var/dir_checked in cardinal)
				var/turf/simulated/floor/T = get_step(S, dir_checked)
				if(istype(T))
					if(istype(T, /turf/simulated/floor/outdoors) && prob(50))
						T.chill()

/datum/weather/borealis2/blizzard/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.outdoors || istype(L, /mob/living/simple_mob))
			continue // They're indoors, so no need to burn them with ash. And let's not pelter the simple_mobs either.

		L.inflict_heat_damage(rand(1, 1))

/datum/weather/borealis2/rain
	name = "rain"
	icon_state = "rain"
	wind_high = 2
	wind_low = 1
	light_modifier = 0.5
	effect_message = span_warning("Rain falls on you.")

	transition_chances = list(
		WEATHER_OVERCAST = 25,
		WEATHER_LIGHT_SNOW = 10,
		WEATHER_RAIN = 50,
		WEATHER_STORM = 10,
		WEATHER_HAIL = 5
		)
	observed_message = "It is raining."
	transition_messages = list(
		"The sky is dark, and rain falls down upon you."
	)
	effect_flags = HAS_PLANET_EFFECT | EFFECT_ONLY_LIVING

/datum/weather/borealis2/rain/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.outdoors)
			continue // They're indoors, so no need to rain on them.

		// If they have an open umbrella, it'll guard from rain
		if(istype(L.get_active_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = L.get_active_hand()
			if(U.open)
				if(show_message)
					to_chat(L, span_notice("Rain patters softly onto your umbrella"))
				continue
		else if(istype(L.get_inactive_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = L.get_inactive_hand()
			if(U.open)
				if(show_message)
					to_chat(L, span_notice("Rain patters softly onto your umbrella"))
				continue

		L.water_act(1)
		if(show_message)
			to_chat(L, effect_message)

/datum/weather/borealis2/storm
	name = "storm"
	icon_state = "storm"
	wind_high = 4
	wind_low = 2
	light_modifier = 0.3
	flight_failure_modifier = 10
	effect_message = span_warning("Rain falls on you, drenching you in water.")

	var/next_lightning_strike = 0 // world.time when lightning will strike.
	var/min_lightning_cooldown = 5 SECONDS
	var/max_lightning_cooldown = 1 MINUTE
	observed_message = "An intense storm pours down over the region."
	transition_messages = list(
		"You feel intense winds hit you as the weather takes a turn for the worst.",
		"Loud thunder is heard in the distance.",
		"A bright flash heralds the approach of a storm."
	)

	transition_chances = list(
		WEATHER_RAIN = 45,
		WEATHER_STORM = 40,
		WEATHER_HAIL = 10,
		WEATHER_OVERCAST = 5
		)
	effect_flags = HAS_PLANET_EFFECT | EFFECT_ONLY_LIVING

/datum/weather/borealis2/storm/planet_effect(mob/living/L)
		if(L.z in holder.our_planet.expected_z_levels)
			var/turf/T = get_turf(L)
			if(!T.outdoors)
				continue // They're indoors, so no need to rain on them.

			// Lazy wind code
			if(prob(10))
				if(istype(L.get_active_hand(), /obj/item/melee/umbrella))
					var/obj/item/melee/umbrella/U = L.get_active_hand()
					if(U.open)
						to_chat(L, span_danger("You struggle to keep hold of your umbrella!"))
						L.Stun(20)	// This is not nearly as long as it seems
						playsound(L, 'sound/effects/rustle1.ogg', 100, 1)	// Closest sound I've got to "Umbrella in the wind"
				else if(istype(L.get_inactive_hand(), /obj/item/melee/umbrella))
					var/obj/item/melee/umbrella/U = L.get_inactive_hand()
					if(U.open)
						to_chat(L, span_danger("A gust of wind yanks the umbrella from your hand!"))
						playsound(L, 'sound/effects/rustle1.ogg', 100, 1)
						L.drop_from_inventory(U)
						U.toggle_umbrella()
						U.throw_at(get_edge_target_turf(U, pick(alldirs)), 8, 1, L)

			// If they have an open umbrella, it'll guard from rain
			if(istype(L.get_active_hand(), /obj/item/melee/umbrella))
				var/obj/item/melee/umbrella/U = L.get_active_hand()
				if(U.open)
					if(show_message)
						to_chat(L, span_notice("Rain showers loudly onto your umbrella!"))
					continue
			else if(istype(L.get_inactive_hand(), /obj/item/melee/umbrella))
				var/obj/item/melee/umbrella/U = L.get_inactive_hand()
				if(U.open)
					if(show_message)
						to_chat(L, span_notice("Rain showers loudly onto your umbrella!"))
					continue


			L.water_act(2)
			if(show_message)
				to_chat(L, effect_message)

/datum/weather/borealis2/storm/process_effects()
	..()
	handle_lightning()

// This gets called to do lightning periodically.
// There is a seperate function to do the actual lightning strike, so that badmins can play with it.
/datum/weather/borealis2/storm/proc/handle_lightning()
	if(world.time < next_lightning_strike)
		return // It's too soon to strike again.
	next_lightning_strike = world.time + rand(min_lightning_cooldown, max_lightning_cooldown)
	var/turf/T = pick(holder.our_planet.planet_floors) // This has the chance to 'strike' the sky, but that might be a good thing, to scare reckless pilots.
	lightning_strike(T)

/datum/weather/borealis2/hail
	name = "hail"
	icon_state = "hail"
	light_modifier = 0.3
	flight_failure_modifier = 15
	timer_low_bound = 2
	timer_high_bound = 5
	effect_message = span_warning("The hail smacks into you!")

	transition_chances = list(
		WEATHER_RAIN = 45,
		WEATHER_STORM = 40,
		WEATHER_HAIL = 10,
		WEATHER_OVERCAST = 5
		)
	observed_message = "Ice is falling from the sky."
	transition_messages = list(
		"Ice begins to fall from the sky.",
		"It begins to hail.",
		"An intense chill is felt, and chunks of ice start to fall from the sky, towards you."
	)
	effect_flags = HAS_PLANET_EFFECT | EFFECT_ONLY_HUMANS

/datum/weather/borealis2/hail/planet_effect(mob/living/carbon/H)
	if(H.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(H)
		if(!T.outdoors)
			continue // They're indoors, so no need to pelt them with ice.

		// If they have an open umbrella, it'll guard from rain
		// Message plays every time the umbrella gets stolen, just so they're especially aware of what's happening
		if(istype(H.get_active_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = H.get_active_hand()
			if(U.open)
				if(show_message)
					to_chat(H, span_notice("Hail patters gently onto your umbrella."))
				continue
		else if(istype(H.get_inactive_hand(), /obj/item/melee/umbrella))
			var/obj/item/melee/umbrella/U = H.get_inactive_hand()
			if(U.open)
				if(show_message)
					to_chat(H, span_notice("Hail patters gently onto your umbrella."))
				continue

		var/target_zone = pick(BP_ALL)
		var/amount_blocked = H.run_armor_check(target_zone, "melee")
		var/amount_soaked = H.get_armor_soak(target_zone, "melee")

		if(amount_blocked >= 100)
			continue // No need to apply damage.

		if(amount_soaked >= 10)
			continue // No need to apply damage.

		H.apply_damage(rand(1, 3), BRUTE, target_zone, amount_blocked, amount_soaked, used_weapon = "hail")
		if(show_message)
			to_chat(H, effect_message)

/datum/weather/borealis2/blood_moon
	name = "blood moon"
	light_modifier = 0.5
	light_color = "#FF0000"
	flight_failure_modifier = 25
	transition_chances = list(
		WEATHER_BLOODMOON = 100
		)
	observed_message = "Everything is red. Something really ominous is going on."
	transition_messages = list(
		"The sky turns blood red!"
	)
	outdoor_sounds_type = /datum/looping_sound/weather/wind
	indoor_sounds_type = /datum/looping_sound/weather/wind/indoors


// Ash and embers fall forever, such as from a volcano or something.
/datum/weather/borealis2/emberfall
	name = "emberfall"
	icon_state = "ashfall_light"
	light_modifier = 0.7
	light_color = "#880000"
	temp_high = 293.15	// 20c
	temp_low = 283.15	// 10c
	flight_failure_modifier = 20
	transition_chances = list(
		WEATHER_EMBERFALL = 100
		)
	observed_message = "Soot, ash, and embers float down from above."
	transition_messages = list(
		"Gentle embers waft down around you like grotesque snow."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/wind
	indoor_sounds_type = /datum/looping_sound/weather/wind/indoors

// Like the above but a lot more harmful.
/datum/weather/borealis2/ash_storm
	name = "ash storm"
	icon_state = "ashfall_heavy"
	light_modifier = 0.1
	light_color = "#FF0000"
	temp_high = 323.15	// 50c
	temp_low = 313.15	// 40c
	wind_high = 6
	wind_low = 3
	flight_failure_modifier = 50
	transition_chances = list(
		WEATHER_ASH_STORM = 100
		)
	observed_message = "All that can be seen is black smoldering ash."
	transition_messages = list(
		"Smoldering clouds of scorching ash billow down around you!"
	)
	// Lets recycle.
	outdoor_sounds_type = /datum/looping_sound/weather/outside_blizzard
	indoor_sounds_type = /datum/looping_sound/weather/inside_blizzard
	effect_flags = HAS_PLANET_EFFECT | EFFECT_ONLY_LIVING

/datum/weather/borealis2/ash_storm/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		var/turf/T = get_turf(L)
		if(!T.outdoors)
			continue // They're indoors, so no need to burn them with ash.

		L.inflict_heat_damage(rand(1, 3))


// Totally radical.
/datum/weather/borealis2/fallout
	name = "fallout"
	icon_state = "fallout"
	light_modifier = 0.7
	light_color = "#CCFFCC"
	flight_failure_modifier = 30
	transition_chances = list(
		WEATHER_FALLOUT = 100
		)
	observed_message = "Radioactive soot and ash rains down from the heavens."
	transition_messages = list(
		"Radioactive soot and ash start to float down around you, contaminating whatever they touch."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/wind
	indoor_sounds_type = /datum/looping_sound/weather/wind/indoors

	// How much radiation a mob gets while on an outside tile.
	var/direct_rad_low = RAD_LEVEL_LOW
	var/direct_rad_high = RAD_LEVEL_MODERATE

	// How much radiation is bursted onto a random tile near a mob.
	var/fallout_rad_low = RAD_LEVEL_HIGH
	var/fallout_rad_high = RAD_LEVEL_VERY_HIGH
	effect_flags = HAS_PLANET_EFFECT | EFFECT_ONLY_LIVING

/datum/weather/borealis2/fallout/planet_effect(mob/living/L)
	if(L.z in holder.our_planet.expected_z_levels)
		irradiate_nearby_turf(L)
		var/turf/T = get_turf(L)
		if(!T.outdoors)
			continue // They're indoors, so no need to irradiate them with fallout.

		L.rad_act(rand(direct_rad_low, direct_rad_high))

// This makes random tiles near people radioactive for awhile.
// Tiles far away from people are left alone, for performance.
/datum/weather/borealis2/fallout/proc/irradiate_nearby_turf(mob/living/L)
	if(!istype(L))
		return
	var/list/turfs = RANGE_TURFS(world.view, L)
	var/turf/T = pick(turfs) // We get one try per tick.
	if(!istype(T))
		return
	if(T.outdoors)
		SSradiation.radiate(T, rand(fallout_rad_low, fallout_rad_high))
