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

/datum/reagent/hemocyanin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.species.poison_type != GAS_O2) // outpost 21 edit, changed form alien != IS_VOX to be consistant with poison oxygen behavior
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

/datum/reagent/acid/artificial_sustenance
	name = REAGENT_ASUSTENANCE
	id = REAGENT_ID_ASUSTENANCE
	description = "A drug used to stablize vat grown bodies. Often used to control the lifespan of biological experiments." // Who else remembers Cybersix?
	taste_description = "burning metal"
	reagent_state = LIQUID
	color = "#31d422"
	overdose = 15
	overdose_mod = 1.2
	scannable = 1

/datum/reagent/acid/artificial_sustenance/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	// You need me...
	if(M.addiction_counters && M.addiction_counters[REAGENT_ID_ASUSTENANCE])
		return
	// Continue to acid damage, no changes on injection or splashing, as this is meant to be edible only to those pre-addicted to it! Not a snowflake acid that doesn't hurt you!
	. = ..()

/datum/reagent/acid/artificial_sustenance/withdrawl(var/mob/living/carbon/M, var/alien)
	// A copy of the base with withdrawl, but with death, and different messages
	var/current_addiction = M.addiction_counters[id]
	// slow degrade
	if(prob(2))
		current_addiction  -= 1
	// withdrawl mechanics
	if(current_addiction > 0)
		// send a message to notify players
		if(prob(2))
			if(current_addiction <= 40)
				to_chat(M, "<span class='danger'>You're dying for some [name]!</span>")
			else if(current_addiction <= 60)
				to_chat(M, "<span class='warning'>You're really craving some [name].</span>")
			else if(current_addiction <= 100)
				to_chat(M, "<span class='notice'>You're feeling the need for some [name].</span>")
			// effects
			if(current_addiction < 60 && prob(20))
				M.emote(pick("pale","shiver","twitch"))
		// Agony and death!
		if(current_addiction <= 20)
			if(prob(12))
				M.adjustToxLoss( rand(1,4) )
				M.adjustBruteLoss( rand(1,4) )
				M.adjustOxyLoss( rand(1,4) )
		// proc side effect
		if(current_addiction <= 30)
			if(prob(3))
				M.Weaken(2)
				M.emote("vomit")
				M.add_chemical_effect(CE_WITHDRAWL, rand(9,14) * REM)
		else if(current_addiction <= 40)
			if(prob(3))
				M.emote("vomit")
				M.add_chemical_effect(CE_WITHDRAWL, rand(5,9) * REM)
		else if(current_addiction <= 50)
			if(prob(2))
				M.emote("vomit")
	// end addiction with a clear message!
	if(current_addiction == 0)
		current_addiction = 40 // Sustinance requirements cannot be escaped!
	return current_addiction
