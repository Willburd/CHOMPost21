/datum/trait/negative/breathes/carbon
	name = "Carbon Dioxide Breather"
	desc = "You breathe carbon dioxide instead of oxygen (which is poisonous to you). Incidentally, phoron isn't poisonous to breathe to you."
	var_changes = list("breath_type" = "carbon_dioxide", "exhale_type" = "oxygen", "poison_type" = "oxygen", "ideal_air_type" = /datum/gas_mixture/belly_air/carbon_dioxide_breather)

/datum/trait/negative/breathes/methane
	name = "Methane Breather"
	desc = "You breathe methane instead of oxygen (which is poisonous to you)."
	var_changes = list("breath_type" = "methane", "poison_type" = "oxygen", "ideal_air_type" = /datum/gas_mixture/belly_air/methane_breather)
