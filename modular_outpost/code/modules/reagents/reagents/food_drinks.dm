// Omega nukie
/datum/reagent/drink/coffee/nukie/mega/final_nukie
	name = REAGENT_NUKIEFINAL
	id = REAGENT_ID_NUKIEFINAL
	color = "#14ed39"
	taste_description = "you're not welcome in this swamp."

/datum/reagent/drink/coffee/nukie/mega/final_nukie/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.get_jittery() < 500)
		to_chat(M, span_critical("You have a seizure!"))
		M.Paralyse(10)
		M.Weaken(10)
		M.make_jittery(1000)
		if(!M.lying)
			M.emote("collapse")
	..()
	if(prob(20))
		M.gib()

// The Dew
/datum/reagent/ickypak/the_dew
	name = REAGENT_THEDEW
	id = REAGENT_ID_THEDEW
	description = "Mountain Wind Crystal Classic, was the hit soft drink fad in 2231. Last seen on sale in 2285..."
	color = "#80ba80"

/datum/reagent/ickypak/the_dew/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.druggy = max(M.druggy, 12)
	M.make_dizzy(1)
	M.adjustHalLoss(2)
	if(prob(3))
		M.vomit(5)
		if(M.nutrition <= 10 && prob(5))
			M.death()

	for(var/obj/belly/B as anything in M.vore_organs)
		for(var/atom/movable/A in B)
			if(isliving(A))
				var/mob/living/P = A
				if(P.absorbed)
					continue
			if(prob(5))
				playsound(M, 'sound/effects/splat.ogg', 50, 1)
				B.release_specific_contents(A)
