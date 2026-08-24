/mob/living/simple_mob/ysbryd
	maxHealth = 900
	health = 900
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

/mob/living/simple_mob/ysbryd/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/radio_jammer)

/mob/living/simple_mob/ysbryd/GetAccess()
	return SSaccess.get_all_station_access().Copy() // Spooky door opening
