/turf/simulated/floor/water/blood/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent(reagent_type, round(volume, 0.1))

/turf/simulated/floor/water/digestive_enzymes/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent(reagent_type, round(volume, 0.1))

/turf/simulated/floor/water/glamour/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent(reagent_type, round(volume, 0.1))
