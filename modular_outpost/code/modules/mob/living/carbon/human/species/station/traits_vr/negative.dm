/datum/trait/negative/breathes/methane
	name = "Methane Breather"
	desc = "You breathe methane instead of oxygen (which is poisonous to you)."
	var_changes = list("breath_type" = GAS_CH4, "poison_type" = GAS_O2, "ideal_air_type" = /datum/gas_mixture/belly_air/methane_breather)

	// Traitgenes edit begin - Made into a gene trait
	is_genetrait = TRUE
	hidden = FALSE

	activation_message="Your chest hurts..."
	// Traitgenes edit end

/datum/trait/negative/phoron_vulnerable
	name = "Phoron Vulnerability"
	desc = "Removes Vox phoron immunity and other reagent mechanics. You interact with phoron like most other species, poorly."
	var_changes = list("reagent_tag" = null)
	cost = -2
	allowed_species = list(SPECIES_VOX)
