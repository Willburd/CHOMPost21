/obj/effect/map_effect/interval/atmogland
	name = "atmogland space"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 15 SECONDS
	interval_upper_bound = 35 SECONDS

/obj/effect/map_effect/interval/atmogland/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi(GAS_O2, 0, GAS_CO2, 0, GAS_N2, 0, GAS_PHORON, 0, GAS_CH4, 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume
	#endif

/obj/effect/map_effect/interval/atmogland/airmix
	name = "atmogland airmix"

/obj/effect/map_effect/interval/atmogland/airmix/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		// reset air
		T.make_air()
	#endif

/obj/effect/map_effect/interval/atmogland/nitrogen
	name = "atmogland nitrogen"

/obj/effect/map_effect/interval/atmogland/nitrogen/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi(GAS_O2, 0, GAS_CO2, 0, GAS_N2, ONE_ATMOSPHERE, GAS_PHORON, 0, GAS_CH4, 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume
	#endif

/obj/effect/map_effect/interval/atmogland/carbo
	name = "atmogland carbondioxide"

/obj/effect/map_effect/interval/atmogland/carbo/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi(GAS_O2, 0, GAS_CO2, ONE_ATMOSPHERE, GAS_N2, 0, GAS_PHORON, 0, GAS_CH4, 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume
	#endif

/obj/effect/map_effect/interval/atmogland/phoron
	name = "atmogland phoron"

/obj/effect/map_effect/interval/atmogland/phoron/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi(GAS_O2, 0, GAS_CO2, 0, GAS_N2, 0, GAS_PHORON, ONE_ATMOSPHERE, GAS_CH4, 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume
	#endif

/obj/effect/map_effect/interval/atmogland/methane
	name = "atmogland methane"

/obj/effect/map_effect/interval/atmogland/phoron/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi(GAS_O2, 0, GAS_CO2, 0, GAS_N2, 0, GAS_PHORON, 0, GAS_CH4, ONE_ATMOSPHERE)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume
	#endif

/obj/effect/map_effect/interval/atmogland/bodyheat
	name = "atmogland bodyheat"

/obj/effect/map_effect/interval/atmogland/bodyheat/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		// recover till at body temp
		if(air_contents.temperature < TERRAFORMER_BODY_TEMP)
			air_contents.temperature += 1
		if(air_contents.temperature > TERRAFORMER_BODY_TEMP + 5)
			air_contents.temperature -= 2
		T.air = air_contents;
	#endif
