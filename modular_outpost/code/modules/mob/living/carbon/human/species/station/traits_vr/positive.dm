/datum/trait/positive/enzyme_immune
	name = "Enzyme Immune"
	desc = "Allows contact exposure to terraforming enzymes."
	cost = 3
	var_changes = list("enzyme_contact_mod" = 0)

	// Traitgenes edit begin - Made into a gene trait
	is_genetrait = TRUE
	hidden = FALSE

	activation_message="Your skin feels different..."
	// Traitgenes edit end

/datum/trait/positive/phoron_resist
	name = "Phoron Resistant"
	desc = "Allows contact exposure to phoron without ill effects. Your results may vary."
	cost = 2
	var_changes = list("phoron_contact_mod" = 0)

	// Traitgenes edit begin - Made into a gene trait
	is_genetrait = TRUE
	hidden = FALSE

	activation_message="Your skin feels waxy..."
	// Traitgenes edit end

/datum/trait/positive/breathes/vox_air
	name = "Dust Huffer"
	desc = "You breathe air instead of phoron. Used for custom vox-like creatures. Abusing this trait may result in a species ban."
	var_changes = list("breath_type" = GAS_O2, "poison_type" = GAS_PHORON, "ideal_air_type" = /datum/gas_mixture/belly_air)
	cost = 5
	allowed_species = list(SPECIES_VOX)

/datum/trait/positive/vibration_sense
	name = "Vibration Sense"
	desc = "Allows you to sense subtle vibrations nearby, even if the source cannot be seen."
	cost = 2
	var_changes = list("has_vibration_sense" = TRUE)

	// Traitgenes edit begin - Made into a gene trait
	is_genetrait = TRUE
	hidden = FALSE

	activation_message="Your ears ring, and hear everything..."
	// Traitgenes edit end

/datum/trait/positive/vibration_sense/apply(datum/species/S, mob/living/carbon/human/H, trait_prefs)
	. = ..()
	H.motiontracker_subscribe()

/datum/trait/positive/vibration_sense/unapply(datum/species/S, mob/living/carbon/human/H, trait_prefs)
	. = ..()
	H.motiontracker_unsubscribe()
