/mob/living/simple_mob/ysbryd
	maxHealth = 900
	health = 900
	hovering = TRUE
	enzyme_affect = FALSE
	emote_threats = list(
								"I have come to collect a meal, now that your people have broken the seal.",
								"The sight of me should make you fly, but know that regardless you will die.",
								"My face may now be made of bone, but I should not experience it alone.",
								"I can hear the racing of your heart, it is approaching my favourite part.",
								"You will not be left to suffer, is it not that life is so much tougher.",
								"Your boxes of cold metal, a place where I will not settle.",
								"I can see in your eyes you wish to be free, so step forward and become one with me."
	)
	faction = FACTION_UNDERDARK
	var/obj/effect/rune/linked_rune = null

/mob/living/simple_mob/ysbryd/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/radio_jammer)
	linked_rune = locate() in get_turf(src)
	if(!linked_rune)
		linked_rune = new(get_turf(src))
	RegisterSignal(linked_rune, COMSIG_QDELETING, PROC_REF(handle_rune_qdel))

/mob/living/simple_mob/ysbryd/Destroy()
	. = ..()
	if(linked_rune)
		UnregisterSignal(linked_rune, COMSIG_QDELETING)
		linked_rune = null

/mob/living/simple_mob/ysbryd/proc/handle_rune_qdel(datum/source, force)
	death()

/mob/living/simple_mob/ysbryd/GetAccess()
	return SSaccess.get_all_station_access().Copy() // Spooky door opening

/mob/living/simple_mob/ysbryd/death() //More clear death message.
	var/turf/our_turf = get_turf(src)
	if(our_turf)
		visible_message(span_warning("The creature fades away with an echoing, ethereal screech, briefly showing itself to all, before crumbling down into a heap... only the eerie skull remaining!"))
		var/obj/item/digestion_remains/skull/tajaran/new_skull = new /obj/item/digestion_remains/skull/unknown(our_turf)
		new_skull.name = "Avian skull"
		new_skull.desc = "A bleached, malformed avian skull. It has definitely has seen better times. Hard to tell what it belonged to."
	..()

/datum/ai_holder/simple_mob/ysbryd/handle_stance_strategical()
	var/mob/living/simple_mob/ysbryd/ghost = holder
	if(prob(2 + !ghost.chosen_target) && prob(10)) // Teleport around being a pest
		var/list/jump_list = list()
		for(var/obj/effect/landmark/R in GLOB.landmarks_list)
			if(R.name == "redexit")
				jump_list += R
			if(length(jump_list))
				ghost.disconnect_target()
				ghost.forceMove(pick(jump_list))
	. = ..()
