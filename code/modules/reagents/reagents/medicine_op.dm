/datum/reagent/hemocyanin
	name = "Hemocyanin"
	id = "hemocyanin"
	description = "Hemocyanin is a copper based artifical blood, modified to repair cellular respiration damage. Usually for creatures harmed by oxygen exposure."
	taste_description = "metallic"
	reagent_state = LIQUID
	color = "#309bb3"
	overdose = 7
	overdose_mod = 1.25
	scannable = 1

/datum/reagent/hemocyanin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.species.poison_type != "oxygen") // outpost 21 edit, changed form alien != IS_VOX to be consistant with poison oxygen behavior
		M.adjustToxLoss(removed * 9)
	else if(alien != IS_DIONA)
		M.adjustOxyLoss(-15 * removed * M.species.chem_strength_heal)

	// cleans a bunch of other meds, acts as replacement specialized blood
	holder.remove_reagent("lexorin", 3 * removed)
	holder.remove_reagent("dexalin", 3 * removed)
	holder.remove_reagent("dexalinp", 3 * removed)

/datum/reagent/hemocyanin/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	// why did you eat this?
	M.adjustToxLoss(2 * removed)
