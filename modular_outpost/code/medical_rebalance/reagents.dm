/**
 * Ensures all chemicals BY DEFAULT will only affect the living, even if on a stablizer or during cpr. See change in reagents.dm for details.
 */
/datum/reagent
	affects_dead = FALSE
	var/allow_stabilizer = FALSE // If cpr/stablizer is allowed to process chems


/******************************************************************
 * 							REBALANCES
 ******************************************************************/

/**
 * Bicardaze: Reworked to affect the dead while a stablizer is used.
 */
/datum/reagent/bicaridine/topical
	affects_dead = TRUE
	description = REAGENT_BICARIDAZE + " is a post-humous variant of the chemical " + REAGENT_BICARDINE + " that affects necrotic tissues. Has toxic byproducts when metabolized by living tissues."

/datum/reagent/bicaridine/topical/affect_blood(mob/living/carbon/M, alien, removed)
	var/chem_effective = 1 * M.species.chem_strength_heal
	if(alien == IS_SLIME)
		chem_effective = 0.75
	if(M.stat == DEAD)
		M.adjustToxLoss(chem_effective * removed)
		return
	if(alien != IS_DIONA)
		M.heal_organ_damage(4 * removed * chem_effective, 0)

/datum/reagent/bicaridine/topical/affect_touch(mob/living/carbon/M, alien, removed)
	return // Disable this


/**
 * Dermalaze: Reworked to affect the dead while a stablizer is used.
 */
/datum/reagent/dermaline/topical
	affects_dead = TRUE
	description = REAGENT_DERMALAZE + " is a post-humous variant of the chemical " + REAGENT_DERMALINE + " that affects dead tissues. Has toxic byproducts when metabolized by living tissues."

/datum/reagent/dermaline/topical/affect_blood(mob/living/carbon/M, alien, removed)
	var/chem_effective = 1 * M.species.chem_strength_heal
	if(alien == IS_SLIME)
		chem_effective = 0.75
	if(M.stat == DEAD)
		M.adjustToxLoss(2 * chem_effective)
		return
	if(alien != IS_DIONA)
		M.heal_organ_damage(0, 12 * removed * chem_effective)

/datum/reagent/dermaline/topical/affect_touch(mob/living/carbon/M, alien, removed)
	return // Disable this


/**
 * Dylovene: Works on the dead, but at a much slower rate
 */

/datum/reagent/dylovene
	description = REAGENT_ANTITOXIN + " is a broad-spectrum antitoxin. Works even in necrotic tissues, but much more slowly."

/datum/reagent/dylovene/affect_blood(mob/living/carbon/M, alien, removed)
	if(M.stat == DEAD)
		return ..(M, alien, removed * 0.1) // work at 10% the rate while dead
	. = ..()
