/datum/event/spontaneous_malignant_organ/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		var/area/A = get_area(H)
		if(!A)
			continue
		if(!(A.z in using_map.event_levels))
			continue
		if(H.job == JOB_STOWAWAY && prob(90)) // stowaways only have a 10% chance to proc
			continue
		if(H.client && H.random_malignant_organ(TRUE,TRUE,prob(20)))
			break

/datum/event/spontaneous_malignant_organ/only_tumor/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		if(H.client && H.random_malignant_organ(TRUE,FALSE,FALSE))
			break

/datum/event/spontaneous_malignant_organ/only_para/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		if(H.client && H.random_malignant_organ(FALSE,TRUE,FALSE))
			break

/datum/event/spontaneous_malignant_organ/only_engineered/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		if(H.client && H.random_malignant_organ(FALSE,FALSE,TRUE))
			break
