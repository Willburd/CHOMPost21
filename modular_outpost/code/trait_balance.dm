// Only modify upstream traits here, do our own directly!!!
// They are in modular_outpost\code\modules\mob\living\carbon\human\species\station\traits_vr\X.dm

// Please mark your reasoning for later consideration if point cost is modified in the future.

/////////////////////////////////////////////////////////////////////////////////////////////////
/// POSITIVE
/////////////////////////////////////////////////////////////////////////////////////////////////
/datum/trait/positive/virus_immune // Cannot get viruses or malignant organs
	cost = 5 // upstream is: 1

/datum/trait/positive/stable_genetics // Cannot mutate
	cost = 5 // upstream is: 2

/datum/trait/positive/rad_immune // Cannot be irradiated
	cost = 5 // upstream is: 3

/datum/trait/positive/rad_resistance_extreme // like above but lesser
	cost = 4 // upstream is: 2

/datum/trait/positive/rad_resistance // like above but lesser
	cost = 3 // upstream is: 1

/datum/trait/positive/darksight // See in dark like xenochi
	cost = 2 // upstream is: 1




/////////////////////////////////////////////////////////////////////////////////////////////////
/// NEUTRAL
/////////////////////////////////////////////////////////////////////////////////////////////////
/datum/trait/neutral/allergy_reaction/gibbing // Sploot gives some bonus points
	cost = -2 // upstream is: 0




/////////////////////////////////////////////////////////////////////////////////////////////////
/// NEGATIVE
/////////////////////////////////////////////////////////////////////////////////////////////////
/datum/trait/negative/disability_censored // Free points begone
	cost = 0 // upstream is: -1

/datum/trait/negative/disability_nervousness // Free points begone
	cost = 0 // upstream is: -1
