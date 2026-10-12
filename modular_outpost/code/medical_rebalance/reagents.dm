/**
 * Ensures all chemicals BY DEFAULT will only affect the living, even if on a stablizer or during cpr. See change in reagents.dm for details.
 */
/datum/reagent
	affects_dead = FALSE
	var/allow_stabilizer = FALSE // If cpr/stablizer is allowed to process chems


/******************************************************************
 * 							REBALANCES
 ******************************************************************/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// raw reagent changes
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Carbon: can heal tox, but still eats other reagents
 */
/datum/reagent/carbon/affect_ingest(mob/living/carbon/M, alien, removed)
	if(alien != IS_DIONA)
		var/chem_effective = 1 * M.species.chem_strength_heal
		M.adjustToxLoss(-1 * removed * chem_effective)
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Basic med-chem changes
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Bicaridine: altered overdose
 */
/datum/reagent/bicaridine
	overdose = REAGENTS_OVERDOSE

/datum/reagent/bicaridine/overdose(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	var/chem_effective = 1 * M.species.chem_strength_tox
	M.adjustBruteLoss(2 * removed * chem_effective) // Does brute damage


/**
 * Kelotane: given OD threshold
 */
/datum/reagent/kelotane
	overdose = REAGENTS_OVERDOSE

/datum/reagent/kelotane/overdose(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	var/chem_effective = 1 * M.species.chem_strength_tox
	M.adjustFireLoss(2 * removed * chem_effective) // Does burn damage


/**
 * Dermaline: given OD threshold
 */
/datum/reagent/dermaline
	overdose = REAGENTS_OVERDOSE

/datum/reagent/dermaline/overdose(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	var/chem_effective = 1 * M.species.chem_strength_tox
	M.adjustFireLoss(2 * removed * chem_effective) // Does burn damage
	. = ..()


/**
 * Dylovene: Works on the dead, but at a much slower rate, given OD threshold
 */
/datum/reagent/dylovene
	description = REAGENT_ANTITOXIN + " is a broad-spectrum antitoxin. Works even in necrotic tissues, but much more slowly."
	affects_dead = TRUE
	overdose = REAGENTS_OVERDOSE * 2

/datum/reagent/dylovene/affect_blood(mob/living/carbon/M, alien, removed)
	if(M.stat == DEAD)
		return ..(M, alien, removed * 0.1) // work at 10% the rate while dead
	. = ..()

/datum/reagent/dylovene/overdose(mob/living/carbon/M, alien, removed)
	if(M.stat == DEAD)
		return
	if(alien == IS_DIONA)
		return
	if(alien == IS_SLIME) // slimes trip out
		M.druggy = max(M.druggy, 5)
		return
	// Slowly causes hallucinations before druggy
	M.drowsyness += 1 * removed
	M.hallucination += 2 * removed
	if(M.hallucination > 100)
		if(M.druggy == 0 && prob(4))
			to_chat(M, span_danger("You see a tall dark man with a hat coming closer."))
		M.druggy = max(M.druggy, 5)


/**
 * Tricordrazine: Made OD more damaging
 */
/datum/reagent/tricordrazine
	overdose = REAGENTS_OVERDOSE * 2

/datum/reagent/tricordrazine/overdose(mob/living/carbon/M, alien, removed)
	var/chem_effective = 1 * M.species.chem_strength_tox
	M.adjustBruteLoss(1 * removed * chem_effective) // Does brute damage
	M.adjustFireLoss(1 * removed * chem_effective) // Does burn damage
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Topical chems -> Post humous chems
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Bicardaze: Reworked to affect the dead.
 */
/datum/reagent/bicaridine/topical
	affects_dead = TRUE
	description = REAGENT_BICARIDAZE + " is a post-humous variant of the chemical " + REAGENT_BICARIDINE + " that affects necrotic tissues. Has toxic byproducts when metabolized by living tissues."

/datum/reagent/bicaridine/topical/affect_blood(mob/living/carbon/M, alien, removed)
	var/chem_effective = 1 * M.species.chem_strength_heal
	if(alien == IS_SLIME)
		chem_effective = 0.75
	if(M.stat != DEAD)
		M.adjustToxLoss(chem_effective * removed)
		return
	if(alien != IS_DIONA)
		M.heal_organ_damage(4 * removed * chem_effective, 0)

/datum/reagent/bicaridine/topical/affect_touch(mob/living/carbon/M, alien, removed)
	return // Disable this


/**
 * Dermalaze: Reworked to affect the dead.
 */
/datum/reagent/dermaline/topical
	affects_dead = TRUE
	description = REAGENT_DERMALAZE + " is a post-humous variant of the chemical " + REAGENT_DERMALINE + " that affects dead tissues. Has toxic byproducts when metabolized by living tissues."

/datum/reagent/dermaline/topical/affect_blood(mob/living/carbon/M, alien, removed)
	var/chem_effective = 1 * M.species.chem_strength_heal
	if(alien == IS_SLIME)
		chem_effective = 0.75
	if(M.stat != DEAD)
		M.adjustToxLoss(2 * chem_effective)
		return
	if(alien != IS_DIONA)
		M.heal_organ_damage(0, 12 * removed * chem_effective)

/datum/reagent/dermaline/topical/affect_touch(mob/living/carbon/M, alien, removed)
	return // Disable this


/**
 * Tricorlidaze: Reworked to affect the dead.
 */
/datum/reagent/tricorlidaze
	affects_dead = TRUE
	description = REAGENT_TRICORLIDAZE + " is a post-humous variant of the chemical " + REAGENT_TRICORDRAZINE + " that affects dead tissues. Has toxic byproducts when metabolized by living tissues."

/datum/reagent/tricorlidaze/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	var/chem_effective = 1 * M.species.chem_strength_heal
	if(alien == IS_SLIME)
		chem_effective = 0.5
	if(M.stat != DEAD)
		M.adjustToxLoss(4 * chem_effective)
		return
	M.adjustOxyLoss(-3 * removed * chem_effective)
	M.heal_organ_damage(1.5 * removed, 1.5 * removed * chem_effective)
	M.adjustToxLoss(-1.5 * removed * chem_effective)

/datum/reagent/tricorlidaze/affect_touch(mob/living/carbon/M, alien, removed)
	return // Disable this


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Combat-chem changes
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
