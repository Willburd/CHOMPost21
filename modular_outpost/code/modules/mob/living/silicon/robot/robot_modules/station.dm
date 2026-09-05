
/obj/item/robot_module/robot/security/Initialize(mapload)
	channels |= list(CHANNEL_SEC_ALPHA = 1, CHANNEL_SEC_BRAVO = 1, CHANNEL_SEC_CHARLIE = 1, CHANNEL_SEC_DELTA = 1)
	. = ..()

/obj/item/robot_module/robot/chound/Initialize(mapload)
	channels |= list(CHANNEL_SEC_ALPHA = 1, CHANNEL_SEC_BRAVO = 1, CHANNEL_SEC_CHARLIE = 1, CHANNEL_SEC_DELTA = 1)
	. = ..()
