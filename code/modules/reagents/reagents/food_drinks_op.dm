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
