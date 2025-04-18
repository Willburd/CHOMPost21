// addictions
#define ADDICTION_PROC -2000 // point where addiction triggers, starts counting down from 0 to here!
#define SLOWADDICT_PROC -6000 // point where certain chems with barely addictive traits will kick in
#define FASTADDICT_PROC -500 // point where certain chems with super addictive traits will kick in
#define ADDICTION_PEAK 200 // point where addicted mobs reset to upon getting their addiction satiated... Decays over time,triggering messages and sideeffects if under 80

/mob/living/carbon/
	var/list/addictions = list() // contains currently addicted chems
	var/list/addiction_counters = list() // contains ID sorted counters

/mob/living/carbon/proc/sync_addictions()
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!species)
		return
	if(!species.traits)
		return
	for(var/TR in species.traits)
		var/datum/trait/T = GLOB.all_traits[TR]
		if(!T)
			continue
		if(!T.addiction)
			continue
		addict_to_reagent(T.addiction)

/mob/living/proc/handle_addictions()
	// Empty so it can be overridden

/mob/living/carbon/handle_addictions()
	// Don't process this if we're part of someone else
	if(absorbed)
		return
	// All addictions start at 0.
	var/list/addict = list()
	for(var/datum/reagent/R in bloodstr.reagent_list)
		var/reagentid = R.id
		if(istype( SSchemistry.chemical_reagents[reagentid], /datum/reagent/ethanol))
			reagentid = "ethanol"
		if(reagentid in addictives)
			addict.Add(reagentid)
	// Only needed for alcohols, will interfere with pills if you detect other things!
	for(var/datum/reagent/R in ingested.reagent_list)
		var/reagentid = R.id
		if(istype( SSchemistry.chemical_reagents[reagentid], /datum/reagent/ethanol))
			reagentid = "ethanol"
		if(reagentid in addictives)
			addict.Add(reagentid)

	for(var/A in addict)
		if(!(A in addictions))
			addictions.Add(A)
			addiction_counters[A] = 0
		if(addiction_counters[A] <= 0)
			// Build addiction until it procs
			addiction_counters[A] -= rand(1,3)
			if(A in slow_addictives)
				// Slowest addictions for some medications
				if(addiction_counters[A] <= SLOWADDICT_PROC)
					addict_to_reagent(A)
			if(A in fast_addictives)
				// quickly addict to these drugs, bliss, oxyco etc
				if(addiction_counters[A] <= FASTADDICT_PROC)
					addict_to_reagent(A)
			else
				// slower addiction over a longer period, cigs and painkillers mostly
				if(addiction_counters[A] <= ADDICTION_PROC)
					addict_to_reagent(A)
		else
			// satiating addiction we already have
			if(addiction_counters[A] < ADDICTION_PEAK)
				if(addiction_counters[A] < 100)
					addiction_counters[A] = 100
					var/datum/reagent/RR = SSchemistry.chemical_reagents[A]
					to_chat(src, span_notice("You feel rejuvenated as the [RR.name] rushes through you."))
				addiction_counters[A] += rand(8,13)

	// For all counters above 100, count down
	// For all under 0, count up to 0 randomly, reducing initial addiction buildup if you didn't proc it
	if(addictions.len)
		var/C = pick(addictions)
		// return to normal... we didn't haven't been addicted yet, but we shouldn't become addicted instantly next time if it's been a few hours!
		if(addiction_counters[C] < 0)
			if(prob(15))
				addiction_counters[C] += 1
		// proc reagent's withdrawl
		if(addiction_counters[C] > 0)
			var/datum/reagent/RE = SSchemistry.chemical_reagents[C]
			addiction_counters[C] = RE.withdrawl(src,species.reagent_tag)
		// remove if finished
		if(addiction_counters[C] == 0)
			addictions.Remove(C)


/mob/living/carbon/proc/addict_to_reagent(var/reagentid)
	if(!(reagentid in addictions))
		addictions.Add(reagentid)
	addiction_counters[reagentid] = ADDICTION_PEAK


#undef ADDICTION_PROC
#undef SLOWADDICT_PROC
#undef FASTADDICT_PROC
#undef ADDICTION_PEAK
