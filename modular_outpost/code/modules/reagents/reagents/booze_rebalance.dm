// Makes booze last longer and affect harder
/datum/reagent/ethanol/New()
	. = ..()
	ingest_met = ingest_met * 0.85
	strength = strength * 0.55
