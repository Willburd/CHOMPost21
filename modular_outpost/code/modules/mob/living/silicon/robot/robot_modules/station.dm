
/obj/item/robot_module/robot/security/Initialize(mapload)
	channels |= list(CHANNEL_SEC_ALPHA = 1, CHANNEL_SEC_BRAVO = 1, CHANNEL_SEC_CHARLIE = 1, CHANNEL_SEC_DELTA = 1)
	. = ..()

/obj/item/robot_module/robot/chound/Initialize(mapload)
	channels |= list(CHANNEL_SEC_ALPHA = 1, CHANNEL_SEC_BRAVO = 1, CHANNEL_SEC_CHARLIE = 1, CHANNEL_SEC_DELTA = 1)
	. = ..()

// Borgowatch
/obj/item/robot_module/robot/janitor
	networks = list(NETWORK_THUNDER)

/obj/item/robot_module/robot/booze
	networks = list(NETWORK_THUNDER)

/obj/item/robot_module/robot/honkborg
	networks = list(NETWORK_THUNDER)

/obj/item/robot_module/robot/butler
	networks = list(NETWORK_THUNDER)
