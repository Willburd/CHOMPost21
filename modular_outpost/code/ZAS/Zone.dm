// Outdoor atmospheres on planets reset to default state over time.
/zone/tick()
	. = ..()

	// Planet airmix cannot be saturated by station antics, slowly bleed this to base air if an outside turf is in our contents. - Willbird
	// It's advisable to not mix multiple different kinds of outside flagged turfs, if they have different initial atmos, thankfully this probably never happens.
	// Most planets only have one atmosphere, and all other areas are indoor contained areas, or simply exposed to it. If your zlevel is that funky, just don't use MAP_LEVEL_AIRMIX_CLEANS
	if(Master.current_runlevel < RUNLEVEL_GAME) // Active edges begone
		return
	var/turf/T = pick(contents)
	if(istype(T) && T.outdoors > -1 && (T.z in using_map.forced_airmix_levels))
		// slowly drain gasses back to atmospheric levels, rates are pulled out of my ass.
		var/rate = rand(1,8) / 500
		air.gas[GAS_O2] 			= LERP(air.gas[GAS_O2]				,T.oxygen			,rate)
		air.gas[GAS_CO2] 			= LERP(air.gas[GAS_CO2]				,T.carbon_dioxide	,rate)
		air.gas[GAS_N2] 			= LERP(air.gas[GAS_N2]				,T.nitrogen			,rate)
		air.gas[GAS_PHORON] 		= LERP(air.gas[GAS_PHORON]			,T.phoron			,rate)
		air.gas[GAS_CH4] 			= LERP(air.gas[GAS_CH4]				,T.methane			,rate)
		air.gas[GAS_N2O] 			= LERP(air.gas[GAS_N2O]				,T.nitrous_oxide	,rate)
		air.update_values()
