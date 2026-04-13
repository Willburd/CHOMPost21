/datum/event/hiccups
	announceWhen = -1

/datum/event/hiccups/setup()
	endWhen = 1

/datum/event/hiccups/start()
	var/mob/living/target = pick(GLOB.player_list)

	// Check if we breath at all
	if(issilicon(target))
		return

	// Special human stuff
	if(ishuman(target))
		var/mob/living/carbon/human/man = target
		if(man.isSynthetic())
			return
		if(man.does_not_breathe)
			return
		var/datum/species/speci = man.species
		if(!speci.breath_type)
			return

	// Curse be upon ye
	target.AddElement(/datum/element/hiccups)
