/mob/living/simple_mob/ysbryd
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

/mob/living/simple_mob/ysbryd/death() //More clear death message.
	var/turf/our_turf = get_turf(src)
	if(our_turf)
		visible_message(span_warning("The creature fades away with an echoing, ethereal screech, briefly showing itself to all, before crumbling down into a heap... only the eerie skull remaining!"))
		var/obj/item/digestion_remains/skull/tajaran/new_skull = new /obj/item/digestion_remains/skull/unknown(our_turf)
		new_skull.name = "Avian skull"
		new_skull.desc = "A bleached, malformed avian skull. It has definitely has seen better times. Hard to tell what it belonged to."
	..()
