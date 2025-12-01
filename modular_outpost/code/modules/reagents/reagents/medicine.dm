/datum/reagent/hemocyanin
	name = REAGENT_HEMOCYANIN
	id = REAGENT_ID_HEMOCYANIN
	description = REAGENT_HEMOCYANIN + " is a copper based artifical blood, modified to repair cellular respiration damage. Usually for creatures harmed by oxygen exposure."
	taste_description = "metallic"
	reagent_state = LIQUID
	color = "#309bb3"
	overdose = 7
	overdose_mod = 1.25
	scannable = 1
	supply_conversion_value = REFINERYEXPORT_VALUE_RARE
	industrial_use = REFINERYEXPORT_REASON_MEDSCI

/datum/reagent/hemocyanin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.species.poison_type != GAS_O2)
		M.adjustToxLoss(removed * 9)
	else if(alien != IS_DIONA)
		M.adjustOxyLoss(-15 * removed * M.species.chem_strength_heal)

	// cleans a bunch of other meds, acts as replacement specialized blood
	holder.remove_reagent(REAGENT_ID_LEXORIN, 3 * removed)
	holder.remove_reagent(REAGENT_ID_DEXALIN, 3 * removed)
	holder.remove_reagent(REAGENT_ID_DEXALINP, 3 * removed)

/datum/reagent/hemocyanin/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	// why did you eat this?
	M.adjustToxLoss(2 * removed)
