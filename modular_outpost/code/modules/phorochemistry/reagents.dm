/datum/reagent/sapoformator
	id = REAGENT_ID_SAPOFORMATOR
	name = REAGENT_SAPOFORMATOR
	description = "Enough units splashed on the ground would appear to have great cleaning effects"
	color = "#EEE139"
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_MATSCI

/datum/reagent/sapoformator/touch_turf(var/turf/T, var/volume)
	if(holder && holder.my_atom)
		if(volume >= 25)
			holder.my_atom.visible_message("The solution begins to fizzle.")
			playsound(T, 'sound/effects/bamf.ogg', 50, 1)
			var/datum/reagents/cleaner = new()
			cleaner.my_atom = T
			cleaner.add_reagent(REAGENT_ID_CLEANER, 10)
			var/datum/effect/effect/system/foam_spread/soapfoam = new()
			soapfoam.set_up(12, T, cleaner, 0)
			soapfoam.start()
			addtimer(CALLBACK(src, PROC_REF(slipinate), T), 50, TIMER_DELETE_ME)
		else
			holder.my_atom.visible_message("The solution sputters.")

/datum/reagent/sapoformator/proc/slipinate(var/turf/T)
	var/list/soaps = typesof(/obj/item/soap)// - /obj/item/soap/fluff/azare_siraj_1
	var/soap_type = pick(soaps)
	var/obj/item/soap/S = new soap_type(T)
	if(volume >= 50)
		volume -= 50
		var/list/tiles = list()
		if(istype(locate(T.x + 1, T.y, T.z), /turf/simulated/floor))
			tiles.Add(locate(T.x + 1, T.y, T.z))
		if(istype(locate(T.x - 1, T.y, T.z), /turf/simulated/floor))
			tiles.Add(locate(T.x - 1, T.y, T.z))
		if(istype(locate(T.x, T.y + 1, T.z), /turf/simulated/floor))
			tiles.Add(locate(T.x, T.y + 1, T.z))
		if(istype(locate(T.x, T.y - 1, T.z), /turf/simulated/floor))
			tiles.Add(locate(T.x, T.y - 1, T.z))

		while(tiles.len > 0 && volume >= 0)
			soap_type = pick(soaps)
			S = new soap_type()
			var/turf/location = pick(tiles)
			tiles.Remove(location)
			S.forceMove(location)
			volume -= 20


/datum/reagent/obscuritol
	id = REAGENT_ID_OBSCURITOL
	name = REAGENT_OBSCURITOL
	description = "Exhibits strange electromagnetic properties"
	color = "#5D505E"
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_MATSCI

/datum/reagent/obscuritol/touch_turf(var/turf/T, var/volume) //-round(-x) = Ceiling(x)
	for(var/obj/machinery/light/light in orange(-round(-1 * (volume / 10)), T))
		light.broken()
	for(var/obj/machinery/light/light in orange(-round(-1 * (volume / 6)), T))
		light.flicker()


/datum/reagent/oxyphoromin
	id = REAGENT_ID_OXYPHOROMIN
	name = REAGENT_OXYPHOROMIN
	description = "Extreme painkiller derived of Oxycodone, dangerous in high doses"
	color = "#540E5C"
	metabolism = 5 * REM
	overdose = 7
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_MATSCI

/datum/reagent/oxyphoromin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.add_chemical_effect(CE_PAINKILLER, 600)
	M.eye_blurry = min(M.eye_blurry + 10, 250)
	M.Confuse(5)

/datum/reagent/oxyphoromin/overdose(var/mob/living/carbon/M, var/alien)
	..()
	M.druggy = max(M.druggy, 60)
	M.hallucination = max(M.hallucination, 3)


/datum/reagent/extreme_mutagen //this one should work fine, but genetics may still be a little messed up
	id = REAGENT_ID_MUTAGENX
	name = REAGENT_MUTAGENX
	description = "Seems as if it would induce instant, random mutations in a living humanoid"
	color = "#20E7F5"
	overdose = 10
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_MATSCI

/datum/reagent/extreme_mutagen/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/i = rand(9,13)
		while(i-- > 0)
			if(prob(20))
				randmutg(H)
			else
				randmutb(H)
		domutcheck(M,null,MUTCHK_FORCED)
		M.update_mutations()
	var/damage = rand(5 * (volume / 30 + 1), 10 * (volume / 30 + 1))
	M.adjustToxLoss(damage)
	M.reagents.add_reagent(REAGENT_ID_TOXIN, volume / 4) //add toxin damage over time
	holder.remove_reagent(id, volume) //instant use

/datum/reagent/extreme_mutagen/overdose(var/mob/living/carbon/M, var/alien)
	..()
	if(alien == IS_DIONA)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		// Traitgenes Locate the gene from trait
		var/datum/gene/trait/G
		if(prob(50))
			G = get_gene_from_trait(/datum/trait/negative/disability_gibbing)
		else
			G = get_gene_from_trait(/datum/trait/negative/disability_deteriorating)
		H.dna.SetSEState(G.block, TRUE)
		domutcheck(H, null, GENE_ALWAYS_ACTIVATE)
		H.UpdateAppearance()
	holder.remove_reagent(id, volume) //instant use


/datum/reagent/genedrazine
	id = REAGENT_ID_GENEDRAZINE
	name = REAGENT_GENEDRAZINE
	description = "Seems as if it would heal very quickly, but at the cost of genetic damage"
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_MATSCI

/datum/reagent/genedrazine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	var/healedDamage = 0
	if(M.getOxyLoss())
		healedDamage = 1
		M.adjustOxyLoss(-4*REM)
	if(M.getBruteLoss())
		healedDamage = 1
		M.heal_organ_damage(4*REM,0)
	if(M.getFireLoss())
		healedDamage = 1
		M.heal_organ_damage(0,4*REM)
	if(M.getToxLoss())
		healedDamage = 1
		M.adjustToxLoss(-4*REM)

	if(healedDamage && prob(50))
		M.adjustCloneLoss(1)
	return ..()


/datum/reagent/expulsicol
	id = REAGENT_ID_EXPULSICOL
	name = REAGENT_EXPULSICOL
	description = "Structure indicates it could purge living cells of non-essential reagents"
	color = "#8C4C3E"
	var/message_given = FALSE
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_MATSCI

/datum/reagent/expulsicol/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(!message_given)
		to_chat(M, "You don't feel very good...")
		message_given = TRUE
		addtimer(CALLBACK(src, PROC_REF(expulse),M), 20, TIMER_DELETE_ME)

/datum/reagent/expulsicol/proc/expulse(var/mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.visible_message(span_warning("[H] throws up!"),span_warning("You throw up!"))
		playsound(H.loc, 'sound/effects/splat.ogg', 50, 1)

		var/turf/location = H.loc
		if(istype(location, /turf/simulated))
			location.add_vomit_floor(src, 1)
		H.adjust_nutrition(-120)
		H.AdjustWeakened(30)
		H.AdjustStunned(15)

		for(var/datum/reagent/R in H.ingested.reagent_list)
			if(R.id == id)
				continue
			H.ingested.remove_reagent(R.id, R.volume)

		for(var/datum/reagent/R in H.bloodstr.reagent_list)
			if(R.id == id)
				continue
			H.bloodstr.remove_reagent(R.id, R.volume)

	M.reagents.remove_reagent(id, volume)


/datum/reagent/nocturnol
	id = REAGENT_ID_NOCTURNOL
	name = REAGENT_NOCTURNOL
	description = "Reagent bears strong resemblance to enzymes found in feline eyes"
	color = "#61E34F"
	supply_conversion_value = REFINERYEXPORT_VALUE_COMMON
	industrial_use = REFINERYEXPORT_REASON_WEAPONS
