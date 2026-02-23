/datum/trait/negative/phoron_vulnerable
	name = "Phoron Vulnerability"
	desc = "Removes Vox phoron immunity and other reagent mechanics. You interact with phoron like most other species, poorly."
	var_changes = list("reagent_tag" = null)
	cost = -4
	allowed_species = list(SPECIES_VOX)

/datum/trait/negative/no_galcom
	name = "Uncommon Linguistics"
	desc = "Removes galactic common language from your character."
	cost = -5
	excludes = list(/datum/trait/negative/monolingual)

/datum/trait/negative/no_galcom/apply(datum/species/S, mob/living/carbon/human/H, trait_prefs)
	. = ..()
	// Lets clear it out and have a fallback...
	H.remove_language(LANGUAGE_GALCOM)
	if(!H.languages.len)
		H.add_language(LANGUAGE_GIBBERISH, 1)
	// Set firstlang as default for now
	var/datum/language/L = H.languages[1]
	H.apply_default_language(L)

/datum/trait/negative/mutation_gibbing
	name = "Mutation Cascade"
	desc = "Your genes are highly reactive to any change. Even the smallest mutation causes your body to quickly and violently unravel on the spot in a burst of gore."
	cost = -5

/datum/trait/negative/mutation_gibbing/apply(datum/species/S, mob/living/carbon/human/H, trait_prefs)
	. = ..()
	ADD_TRAIT(H, TRAIT_MUTATIONCASCADE, ROUNDSTART_TRAIT)
