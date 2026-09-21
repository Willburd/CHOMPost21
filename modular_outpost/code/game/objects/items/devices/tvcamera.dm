/obj/item/clothing/accessory/bodycam/yobro
	name = "YoBro Camera"
	desc = "The Yohan Broadcaster is a small, sturdy camera made by Yohan Logistics enabling every daredevil to be their own content creator! YoBro, Watch This. Comes with a clip to attach to any standard suit. Make sure to adjust the settings before you share your adventures!"
	channel = "YoBro Default Feed"
	icon = 'modular_outpost/icons/obj/weapons.dmi'
	icon_state = "yobro"
	item_state = "yobro"

/obj/item/clothing/accessory/bodycam/yobro/Initialize(mapload)
	. = ..()
	bcamera.network = list(NETWORK_THUNDER)
	bradio.set_frequency(ENT_FREQ)


/obj/item/clothing/accessory/bodycam/raidercast
	name = "Raidercast Camera"
	desc = "A modified Yobro camera for sharing those special final moments with your merry band of mercs."
	channel = "Raidercast Feed"
	icon = 'modular_outpost/icons/obj/weapons.dmi'
	icon_state = "yobro"
	item_state = "yobro"

/obj/item/clothing/accessory/bodycam/raidercast/Initialize(mapload)
	. = ..()
	bcamera.network = list(NETWORK_MERCENARY)
	bradio.set_frequency(SYND_FREQ)


// Bodycameras are blocked by radio jammers
/obj/item/clothing/accessory/bodycam/hear_talk(mob/M, list/message_pieces, verb)
	if(islist(check_radio_jammers(get_turf(src))))
		return
	. = ..()

/obj/machinery/camera/network/bodycamera/can_use()
	. = ..() // Check the base proc, if we can't see, then don't run an expensive jammer check, if we can see, then run the jammer check to see if that's blocked too.
	if(. && islist(check_radio_jammers(get_turf(src))))
		return FALSE
