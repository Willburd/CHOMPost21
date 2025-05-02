/datum/reagent/drink/coffee/withdrawl(var/mob/living/carbon/M, var/alien)
	// A copy of the base with withdrawl, but with much less effects, no vomiting and sometimes halloss
	var/current_addiction = M.addiction_counters[id]
	// slow degrade
	if(prob(8))
		current_addiction  -= 1
	// withdrawl mechanics
	if(current_addiction > 0)
		// send a message to notify players
		if(prob(2))
			if(current_addiction < 90 && prob(10))
				to_chat(M, "<span class='warning'>[pick("You feel miserable.","You feel sluggish.","You get a small headache.")]</span>")
				M.adjustHalLoss(-2)
			else if(current_addiction <= 50)
				to_chat(M, "<span class='warning'>You're really craving some [name].</span>")
			else if(current_addiction <= 100)
				to_chat(M, "<span class='notice'>You're feeling the need for some [name].</span>")
			// effects
			if(current_addiction < 60 && prob(20))
				M.emote(pick("pale","shiver","twitch"))
	// end addiction with a clear message!
	if(current_addiction == 0)
		to_chat(M, "<span class='notice'>You feel your symptoms end, you no longer feel the craving for [name].</span>")
	return current_addiction

// Omega nukie
/datum/reagent/drink/coffee/nukie/mega/final_nukie
	name = REAGENT_NUKIEFINAL
	id = REAGENT_ID_NUKIEFINAL
	color = "#14ed39"
	taste_description = "you're not welcome in this swamp."

/datum/reagent/drink/coffee/nukie/mega/final_nukie/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.jitteriness < 500)
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
