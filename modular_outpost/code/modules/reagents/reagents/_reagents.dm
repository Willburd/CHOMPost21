/datum/reagent
	var/has_overdosed = FALSE

/datum/reagent/proc/is_overdosing(mob/living/carbon/M)
	return (overdose && volume > (overdose * M?.species.chemOD_threshold)) || has_overdosed
