/datum/trait/positive/enzyme_immune
	name = "Enzyme Immune"
	desc = "Allows contact exposure to terraforming enzymes."
	cost = 6
	var_changes = list("enzyme_contact_mod" = 0)

	// Traitgenes edit begin - Made into a gene trait
	is_genetrait = TRUE
	hidden = FALSE

	activation_message="Your skin feels different..."
	// Traitgenes edit end

/datum/trait/positive/phoron_resist
	name = "Phoron Resistant"
	desc = "Allows contact exposure to phoron without ill effects. Your results may vary."
	cost = 3
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
	cost = 4
	allowed_species = list(SPECIES_VOX)

/datum/trait/positive/superpower_superfart
	name = "Super Fart"
	desc = "Sin beyond mortal comprehension, this could only be the geneticist's fault."
	cost = 6
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARD_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	activation_message="You feel incredible pressure inside of you."
	deactivation_message="The pressure inside of you vanishes."
	primitive_expression_messages=list("toots.")

/datum/trait/positive/superpower_superfart/apply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	add_verb(H, /mob/living/proc/super_fart)

/datum/trait/positive/superpower_superfart/unapply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	if(!(/mob/living/proc/super_fart in S.inherent_verbs))
		remove_verb(H, /mob/living/proc/super_fart)
