// Only change spawn_flags here, use our modular species.dm for species edits
// If friendship mode, use upstream's
#ifndef OUTPOST_FRIENDSHIP_MODE

/////////////////////////////////////////////////////////////////////////////////
// Whitelist section
/////////////////////////////////////////////////////////////////////////////////
/datum/species/shadekin
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE // Almost an antag, whitelist please

/datum/species/vox
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE // Almost an antag, whitelist please

/datum/species/crew_shadekin
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE // Allowed here but still whitelist for lore

/datum/species/xenomorph_hybrid
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_WHITELIST_SELECTABLE // Was going to be restricted, but made whitelist instead

/////////////////////////////////////////////////////////////////////////////////
// Disabled section
/////////////////////////////////////////////////////////////////////////////////
/datum/species/shapeshifter/hanner
	spawn_flags = SPECIES_IS_RESTRICTED // Space elves

/datum/species/lleill
	spawn_flags = SPECIES_IS_RESTRICTED // half-elves

/datum/species/grey
	spawn_flags = SPECIES_IS_RESTRICTED // We only plan to use these for abductors

/datum/species/protean
	spawn_flags = SPECIES_IS_RESTRICTED // Nifs

/datum/species/shapeshifter/replicant
	spawn_flags = SPECIES_IS_RESTRICTED // What even are these?

/datum/species/werebeast
	spawn_flags = SPECIES_IS_RESTRICTED // Event admemes

/datum/species/sparkledog
	spawn_flags = SPECIES_IS_RESTRICTED // Aprilfools admemes

/datum/species/spider
	spawn_flags = SPECIES_IS_RESTRICTED // Just use custom species

/datum/species/shapeshifter/replicant/crew
	spawn_flags = SPECIES_IS_RESTRICTED // Absolutely not.

#endif
