// Most species edits go here, except changing spawn_flags. Do that in species_restrictions.dm
/datum/species/crew_shadekin
	// No inf pressure shadekin here
	hazard_high_pressure = HAZARD_HIGH_PRESSURE
	// Has eye color here, so they can do faded eyes
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_SKIN_COLOR | HAS_UNDERWEAR | HAS_EYE_COLOR

/datum/species/shadekin
	// No inf pressure shadekin here
	hazard_high_pressure = HAZARD_HIGH_PRESSURE

/datum/species/skrell
	// Deepsea creatures get deep sea resistances!
	hazard_high_pressure = 1250		// Dangerously high pressure.
	warning_high_pressure = 910		// High pressure warning.
	warning_low_pressure = 80		// Low pressure warning.
	hazard_low_pressure = 50		// Dangerously low pressure.

/datum/species/vox
	// Our vox use the RIGHT gas
	breath_type = GAS_PHORON
	// Allow sleeving
	flags = NO_DNA | NO_DEFIB


/// ENGAGE ASSSSSSSSSS
// EVERYONE NEEDS AN ASSSSSSSSSSSSSSSS
// THEY ARE DESTINED FOR ASSSSSSSSSSSSSSSSS
// EXCEPT VOX AND DIONA
// THEY DON'T PAY THE ASSSSSSSSSSSSSSS TAXXXXXXXXXXXXXXXXX

/datum/species/akula/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/altevian/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/crew_shadekin/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/custom/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/human/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/nevrean/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/harpy/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/sergal/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/shadekin/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/skrell/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/tajaran/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/teshari/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/unathi/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/vulpkanin/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/xenos/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/xenomorph_hybrid/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/zaddat/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/hi_zorren/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/shapeshifter/hanner/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/lleill/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/event1/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/grey/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/shapeshifter/replicant/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/xenochimera/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/werebeast/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/sparkledog/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()

/datum/species/spider/New()
	has_organ[O_BUTT] = /obj/item/organ/internal/butt
	. = ..()
