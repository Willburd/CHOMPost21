/datum/trait/negative/phoron_vulnerable
	name = "Phoron Vulnerability"
	desc = "Removes Vox phoron immunity and other reagent mechanics. You interact with phoron like most other species, poorly."
	var_changes = list("reagent_tag" = null)
	cost = -2
	allowed_species = list(SPECIES_VOX)
