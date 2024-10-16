/mob/living/carbon/human/proc/perform_cpr(var/mob/living/carbon/human/reviver)
	// Check for sanity
	if(!istype(reviver,/mob/living/carbon/human))
		return

	// Allows medical to circulate chems on mostly dead bodies without dialysis Extreme hackjob medical ahead!
	var/tempstat = stat
	stat = CONSCIOUS
	var/i = rand(7,14)
	while(i-- > 0)
		handle_chemicals_in_body() // extremely hacky way of chem circulation, most chems require you to be alive to do stuff to the body... Done multiple times to increase speed.
	stat = tempstat

	// brute damage
	if(prob(3))
		apply_damage( 1, BRUTE, BP_TORSO)
		if(prob(8))
			var/obj/item/organ/external/chest = get_organ(BP_TORSO)
			if(chest)
				chest.fracture()

	// standard CPR ahead, adjust oxy and refresh health
	if(health > CONFIG_GET(number/health_threshold_crit) && prob(10))
		if(istype(species, /datum/species/xenochimera))
			visible_message(span_danger("\The [src]'s body twitches and gurgles a bit. You can't seem to resuscitate them like this!"))
			return // Handle xenochim, can't cpr them back to life
		if(HUSK in mutations)
			visible_message(span_danger("\The [src]'s body crunches and snaps. It's too desiccated to resuscitate!"))
			return // Handle husked, cure it before you can revive

		// allow revive chance
		var/mob/observer/dead/ghost = get_ghost()
		if(ghost)
			ghost.notify_revive("Someone is trying to resuscitate you. Re-enter your body if you want to be revived!", 'sound/effects/genetics.ogg', source = src)
		visible_message(span_warning("\The [src]'s body convulses a bit."))

		// REVIVE TIME, masically stolen from defib.dm
		dead_mob_list.Remove(src)
		if((src in living_mob_list) || (src in dead_mob_list))
			WARNING("Mob [src] was cpr revived by [reviver], but already in the living or dead list still!")
		living_mob_list += src

		timeofdeath = 0
		set_stat(UNCONSCIOUS) //Life() can bring them back to consciousness if it needs to.
		failed_last_breath = 0 //So mobs that died of oxyloss don't revive and have perpetual out of breath.
		reload_fullscreen()

		emote("gasp")
		Weaken(rand(10,25))
		updatehealth()

		// This is measures in `Life()` ticks. E.g. 10 minute defib timer = 300 `Life()` ticks.				// Original math was VERY off. Life() tick occurs every ~2 seconds, not every 2 world.time ticks.
		var/brain_damage_timer = ((CONFIG_GET(number/defib_timer) MINUTES) / 20) - ((CONFIG_GET(number/defib_braindamage_timer) MINUTES) / 20)
		var/obj/item/organ/internal/brain/brain = internal_organs_by_name[O_BRAIN]
		if(should_have_organ(O_BRAIN) && brain && brain.defib_timer <= brain_damage_timer)
			// As the brain decays, this will be between 0 and 1, with 1 being the most fresh.
			var/brain_death_scale = brain.defib_timer / brain_damage_timer
			// This is backwards from what you might expect, since 1 = fresh and 0 = rip.
			var/damage_calc = LERP(brain.max_damage, getBrainLoss(), brain_death_scale)
			// A bit of sanity.
			var/brain_damage = between(getBrainLoss(), damage_calc, brain.max_damage)
			setBrainLoss(brain_damage)
	else if(health > CONFIG_GET(number/health_threshold_dead))
		adjustOxyLoss(-(min(getOxyLoss(), 5)))
		updatehealth()
		to_chat(src, span_notice("You feel a breath of fresh air enter your lungs. It feels good."))
