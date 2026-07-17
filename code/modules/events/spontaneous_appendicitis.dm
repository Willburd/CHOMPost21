/datum/event/spontaneous_appendicitis/start()
	// CHOMPAdd Start
	if(prob(50))
		kill()
		return
		
	// CHOMPAdd End
	for(var/mob/living/carbon/human/H in shuffle(GLOB.living_mob_list))
		// Outpost 21 edit begin - restricted event to event levels, and lowered chance for stowaways
		var/area/A = get_area(H)
		if(!A)
			continue
		if(!(A.z in using_map.event_levels))
			continue
		//if(A.flag_check(RAD_SHIELDED))
		//	continue
		if(isbelly(H.loc))
			continue
		if(H.job == JOB_STOWAWAY && prob(90)) // stowaways only have a 10% chance to proc
			continue
		if(is_changeling(H)) // Changelings immune to organ based events
			continue
		// Outpost 21 edit end
		if(H.client && H.appendicitis())
			break
