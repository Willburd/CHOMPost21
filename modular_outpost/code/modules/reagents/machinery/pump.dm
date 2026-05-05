/turf/simulated/floor/water/blood/pump_reagents(datum/reagents/R, volume)
	. = ..()
	R.add_reagent(reagent_type, round(volume, 0.1))

/turf/simulated/floor/water/digestive_enzymes/pump_reagents(datum/reagents/R, volume)
	. = ..()
	R.add_reagent(reagent_type, round(volume, 0.1))

/turf/simulated/floor/water/glamour/pump_reagents(datum/reagents/R, volume)
	. = ..()
	R.add_reagent(reagent_type, round(volume, 0.1))
