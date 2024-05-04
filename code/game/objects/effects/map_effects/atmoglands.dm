#define TERRAFORMER_BODY_TEMP 333

/obj/effect/map_effect/interval/atmogland
	name = "atmogland space"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 15 SECONDS
	interval_upper_bound = 35 SECONDS

/obj/effect/map_effect/interval/atmogland/trigger()
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi("oxygen", 0, "carbon_dioxide", 0, "nitrogen", 0, "phoron", 0, "methane", 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume

/obj/effect/map_effect/interval/atmogland/airmix
	name = "atmogland airmix"

/obj/effect/map_effect/interval/atmogland/airmix/trigger()
	var/turf/simulated/T = loc
	if(T)
		// reset air
		T.make_air()

/obj/effect/map_effect/interval/atmogland/nitrogen
	name = "atmogland nitrogen"

/obj/effect/map_effect/interval/atmogland/nitrogen/trigger()
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi("oxygen", 0, "carbon_dioxide", 0, "nitrogen", ONE_ATMOSPHERE, "phoron", 0, "methane", 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume

/obj/effect/map_effect/interval/atmogland/carbo
	name = "atmogland carbondioxide"

/obj/effect/map_effect/interval/atmogland/carbo/trigger()
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi("oxygen", 0, "carbon_dioxide", ONE_ATMOSPHERE, "nitrogen", 0, "phoron", 0, "methane", 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume

/obj/effect/map_effect/interval/atmogland/phoron
	name = "atmogland phoron"

/obj/effect/map_effect/interval/atmogland/phoron/trigger()
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi("oxygen", 0, "carbon_dioxide", 0, "nitrogen", 0, "phoron", ONE_ATMOSPHERE, "methane", 0)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume

/obj/effect/map_effect/interval/atmogland/methane
	name = "atmogland methane"

/obj/effect/map_effect/interval/atmogland/phoron/trigger()
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		T.air = new/datum/gas_mixture
		T.air.temperature = air_contents.temperature
		T.air.adjust_multi("oxygen", 0, "carbon_dioxide", 0, "nitrogen", 0, "phoron", 0, "methane", ONE_ATMOSPHERE)
		T.air.group_multiplier = air_contents.group_multiplier
		T.air.volume = air_contents.volume

/obj/effect/map_effect/interval/atmogland/bodyheat
	name = "atmogland bodyheat"

/obj/effect/map_effect/interval/atmogland/bodyheat/trigger()
	var/turf/simulated/T = loc
	if(T)
		var/datum/gas_mixture/air_contents = T.return_air()
		// recover till at body temp
		if(air_contents.temperature < TERRAFORMER_BODY_TEMP)
			air_contents.temperature += 1
		if(air_contents.temperature > TERRAFORMER_BODY_TEMP + 5)
			air_contents.temperature -= 2
		T.air = air_contents;
