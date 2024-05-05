/datum/objective/consume
	var/digested = 0
	target_amount = 1
	explanation_text = "Not yet init. Use child versions for proper explaination texts!"

/datum/objective/consume/check_completion()
	var/total_amount = digested // start with digested count

	if(!isnull(owner) && !isnull(owner.current) && owner.current.stat < DEAD && !isnull(owner.current.vore_organs))
		for(var/B in owner.current.vore_organs)
			for(var/mob/living/L in B)
				if(ishuman(L))
					// counts for crew eaten!
					total_amount += 1

	return total_amount >= target_amount




/datum/objective/consume/hunter/New(var/mincount,var/maxcount)
	target_amount = rand(mincount,maxcount)
	. = ..("At least [target_amount] crew members must be digested, absorbed, or contained inside you. A good hunter encourages their prey to keep their numbers plentiful.")


/datum/objective/consume/deephunger/New(var/mincount,var/maxcount)
	target_amount = rand(mincount,maxcount)
	. = ..("At least [target_amount] crew members who are not possessed must be digested, absorbed, or contained inside you. If you run out of prey, find out how to make more.")



/datum/objective/chuinfestation
	explanation_text = "Not yet init."

/datum/objective/chuinfestation/New()
	. = ..("Infest the crew, and spread your happiness by making them chus like you! Have no less than [chus.infestationglobalgoal] chus alive by the end of the round.")

/datum/objective/chuinfestation/check_completion()
	if(isnull(chus))
		return FALSE // wat

	var/infestedchus = 0
	for(var/mob/living/simple_mob/vore/alienanimals/chu/C in living_mob_list)
		if(C.stat != DEAD)
			infestedchus++

	return infestedchus > chus.infestationglobalgoal





/datum/objective/zombieinfestation
	explanation_text = "Not yet init."

/datum/objective/zombieinfestation/New()
	. = ..("BRAAAIINNSSS! Infect the crew, shamble, and moan! At least [zombies.infestationminimum + zombies.infestationglobalgoal] zombies must be still shambling around by the end of the round!")

/datum/objective/zombieinfestation/check_completion()
	if(isnull(chus))
		return FALSE // wat

	var/zombiecount = 0
	for(var/mob/living/simple_mob/vore/alienanimals/chu/C in living_mob_list)
		if(C.stat != DEAD)
			zombiecount++

	return zombiecount > (zombies.infestationminimum + chus.infestationglobalgoal)
