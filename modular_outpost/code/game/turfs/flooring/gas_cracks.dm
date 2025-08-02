/turf/simulated/floor/gas_crack/methane
	methane = 2500
	gas_type = list(GAS_CH4)

/turf/simulated/floor/gas_crack/methane/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent(REAGENT_ID_SULFUR, round(volume / 2, 0.1))
	R.add_reagent(REAGENT_ID_PHOSPHORUS, round(volume / 2, 0.1))

/turf/simulated/floor/gas_crack/methane/examine(mob/user)
	. = ..()
	. += "A terrible smell wafts from beneath it."
