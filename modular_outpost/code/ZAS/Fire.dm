/turf/proc/lingering_fire(fl)
	return

/turf/simulated/lingering_fire(fl)
	if(!zone)
		return 1

	if(fire)
		fire.firelevel = max(fl, fire.firelevel)
		return 1

	fire = new /obj/fire/lingering(src, fl)
	SSair.active_fire_zones |= zone
	zone.fire_tiles |= src
	return 0

/turf/proc/feed_lingering_fire(var/amnt)
	return

/turf/simulated/feed_lingering_fire(var/amnt)
	if(fire && istype(fire,/obj/fire/lingering))
		var/obj/fire/lingering/F = fire
		F.firelevel += amnt
		if(F.firelevel > 1)
			F.firelevel = 1
		F.ultimate_burnout = 0 // reset
		zone.fire_tiles |= src
		// Add co2
		var/datum/gas_mixture/air_contents = return_air()
		air_contents.adjust_gas(GAS_CO2, rand(0.1,0.5))
		air_contents.update_values()

/obj/fire/lingering
	//Icon for fire on turfs.

	anchored = TRUE
	mouse_opacity = 0

	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	light_color = "#ED9200"
	layer = GASFIRE_LAYER		// CHOMPEdit
	var/ultimate_burnout = 0 // if it reaches 1, begin dying down

/obj/fire/lingering/Initialize(mapload, fl)
	if(fl > 1) // Lingering fires use 0 to 1
		fl = 1
	if(fl <= 0)
		fl = 0.01
	. = ..(mapload, fl)
	// uses parent fire init, so lets clear these
	color = initial(color)
	set_light(3, 1, l_color = light_color)

/obj/fire/lingering/process()
	. = 1

	var/turf/simulated/my_tile = loc
	if(!istype(my_tile) || !my_tile.zone)
		if(my_tile && my_tile.fire == src)
			my_tile.fire = null
		qdel(src)
		return 1

	// Don't burn forever, eventually we have no more fuel
	ultimate_burnout += 0.001

	//spread while burning out oxygen
	var/datum/gas_mixture/air_contents = my_tile.return_air()
	var/gas_exchange = rand(0.005,0.02)
	air_contents.remove_by_flag(XGM_GAS_OXIDIZER, gas_exchange)
	air_contents.adjust_gas(GAS_CO2, gas_exchange)

	var/starting_energy = air_contents.temperature * air_contents.heat_capacity()
	air_contents.temperature = (starting_energy + vsc.fire_fuel_energy_release * gas_exchange) / air_contents.heat_capacity()
	air_contents.update_values()

	// Affect contents
	for(var/mob/living/L in loc)
		L.FireBurn(firelevel, air_contents.temperature, air_contents.return_pressure())  //Burn the mobs!

	loc.fire_act(air_contents, air_contents.temperature, air_contents.volume)
	for(var/atom/A in loc)
		A.fire_act(air_contents, air_contents.temperature, air_contents.volume)

	// spreading behavior
	for(var/direction in shuffle(cardinal))
		var/turf/simulated/enemy_tile = get_step(my_tile, direction)
		if(istype(enemy_tile))
			if(my_tile.open_directions & direction) //Grab all valid bordering tiles
				if(!enemy_tile.zone)
					continue

				//If extinguisher mist passed over the turf it's trying to spread to, don't spread and end the fire
				if(enemy_tile.fire_protection > world.time-60)
					firelevel = 0
					qdel(src)
					my_tile.fire = null
					continue

				if(enemy_tile.fire)
					if(firelevel > 0.5)
						// share with other fires if we have the energy
						enemy_tile.fire.firelevel += firelevel / 3
						firelevel /= 2
					continue

				//Spread the fire.
				if(firelevel >= 0.1 && prob(60) && my_tile.CanPass(src, enemy_tile) && enemy_tile.CanPass(src, my_tile))
					var/splitrate = 0.85
					enemy_tile.lingering_fire(firelevel * splitrate)
					firelevel -= (1 - splitrate)

			else if(prob(4))
				enemy_tile.adjacent_fire_act(loc, air_contents, air_contents.temperature, air_contents.volume)

	//*** Get the fuel and oxidizer amounts
	var/total_oxidizers = 0
	for(var/g in air_contents.gas)
		if(gas_data.flags[g] & XGM_GAS_OXIDIZER)
			total_oxidizers += air_contents.gas[g]

	// Remove dying fires
	var/invalid_fire = total_oxidizers < 1 || air_contents.temperature <= (T0C + 15) || ultimate_burnout >= 1 || my_tile.is_outdoors()
	if(prob(30) || invalid_fire)
		if(total_oxidizers < 10 && prob(10))
			firelevel *= 0.95
		else if(invalid_fire)
			firelevel *= 0.5

	if(firelevel <= 0.01)
		qdel(src)
		my_tile.fire = null

/obj/fire/lingering/ex_act(strength)
	. = ..()
	var/turf/T = get_turf(src)
	if(T)
		T.fire = null
		qdel(src)
