/datum/reagent/hemocyanin
	name = REAGENT_HEMOCYANIN
	id = REAGENT_ID_HEMOCYANIN
	description = REAGENT_HEMOCYANIN + " is a copper based artifical blood, modified to repair cellular respiration damage. Usually for creatures harmed by oxygen exposure."
	taste_description = "metallic"
	reagent_state = LIQUID
	color = "#309bb3"
	overdose = 7
	overdose_mod = 1.25
	supply_conversion_value = REFINERYEXPORT_VALUE_RARE
	industrial_use = REFINERYEXPORT_REASON_MEDSCI
	scannable = SCANNABLE_BENEFICIAL
	ppe_flags = REAGENT_PPE_SPLASH

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

/datum/reagent/toxin/fenthol
	name = REAGENT_FENTHOL
	id = REAGENT_ID_FENTHOL
	description = REAGENT_FENTHOL + " is an extremely powerful painkiller with lethal side effects if administered incorrectly."
	taste_description = "bitter"
	reagent_state = LIQUID
	color = "#64916E"
	overdose = 1

	supply_conversion_value = REFINERYEXPORT_VALUE_RARE
	industrial_use = REFINERYEXPORT_REASON_SPECIALDRUG
	scannable = SCANNABLE_BENEFICIAL

	ppe_flags = REAGENT_PPE_SPLASH

/datum/reagent/toxin/fenthol/proc/fenthol_effect(var/mob/living/carbon/M, chem_effective)
	M.add_chemical_effect(CE_PAINKILLER, 400 * chem_effective)
	M.add_chemical_effect(CE_NARCOTICS, 1)
	M.AdjustConfused(-10 * chem_effective)
	M.adjustHalLoss(-15 * chem_effective)
	M.make_dizzy(-15 * chem_effective)
	M.fear = max((M.fear - (20 * chem_effective)),0)
	M.make_jittery(-12 * chem_effective)
	M.stuttering = max((M.stuttering - (12 * chem_effective)),0)

/datum/reagent/toxin/fenthol/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA || alien == IS_VOX)
		return
	fenthol_effect(M, 1 * M.species.chem_strength_pain)

/datum/reagent/toxin/fenthol/affect_touch(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA || alien == IS_VOX)
		return
	fenthol_effect(M, 1 * M.species.chem_strength_pain * 0.2)

/datum/reagent/toxin/fenthol/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA || alien == IS_VOX)
		return
	fenthol_effect(M, 1 * M.species.chem_strength_pain * 0.6)

/datum/reagent/toxin/fenthol/overdose(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA || alien == IS_VOX)
		return
	M.add_chemical_effect(CE_PAINKILLER, 100)
	M.add_chemical_effect(CE_NARCOTICS, 1)
	// suffocation and poisoning
	if(M.toxloss > 20 || M.oxyloss > 20)
		M.AdjustParalysis(40 * removed)
	M.adjustOxyLoss(80 * removed)
	M.adjustToxLoss(45 * removed)
	M.adjustHalLoss(30 * removed)
	// Night night, critical OD
	if(M.paralysis > 100)
		M.AdjustSleeping(35 * removed)
		M.adjustToxLoss(35 * removed)
		M.adjustOxyLoss(20 * removed)
		M.hallucination = max(M.hallucination, 100)

/datum/reagent/narcoloxon
	name = REAGENT_NARCOLOXON
	id = REAGENT_ID_NARCOLOXON
	description = REAGENT_NARCOLOXON + " is a drug used to treat opioid overdoses by blocking opioid receptors while rapidly reacting with opioids in the patient's bloodstream."
	taste_description = "sour"
	reagent_state = LIQUID
	color = "#89e6c7"
	metabolism = 4 * REM

	supply_conversion_value = REFINERYEXPORT_VALUE_RARE
	industrial_use = REFINERYEXPORT_REASON_SPECIALDRUG
	scannable = SCANNABLE_BENEFICIAL

	ppe_flags = REAGENT_PPE_SPLASH

/datum/reagent/narcoloxon/affect_blood(mob/living/carbon/M, alien, removed)
	var/remove_amnt = 3 * removed
	M.bloodstr.remove_reagent(REAGENT_ID_BLISS, remove_amnt)
	M.bloodstr.remove_reagent(REAGENT_ID_STIMM, remove_amnt)
	M.bloodstr.remove_reagent(REAGENT_ID_HYPERZINE, remove_amnt)
	M.bloodstr.remove_reagent(REAGENT_ID_OXYCODONE, remove_amnt)
	M.bloodstr.remove_reagent(REAGENT_ID_OXYPHOROMIN, remove_amnt)
	M.bloodstr.remove_reagent(REAGENT_ID_METHYLPHENIDATE, remove_amnt)
	M.bloodstr.remove_reagent(REAGENT_ID_FENTHOL, remove_amnt)
	M.druggy = max(0, M.druggy - remove_amnt)
