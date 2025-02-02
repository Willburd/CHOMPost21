GLOBAL_VAR(cursed_dna_counter)
GLOBAL_VAR(cursed_species_counter)

/datum/dna/New()
	. = ..()
	GLOB.cursed_dna_counter += 1

/datum/dna/Destroy()
	. = ..()
	GLOB.cursed_dna_counter -= 1

/datum/species/New()
	. = ..()
	GLOB.cursed_species_counter += 1

/datum/species/Destroy()
	. = ..()
	GLOB.cursed_species_counter -= 1
