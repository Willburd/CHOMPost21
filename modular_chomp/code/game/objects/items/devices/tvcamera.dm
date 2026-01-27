/obj/item/clothing/accessory/bodycam/yobro
	name = "YoBro Camera"
	desc = "The Yohan Broadcaster is a small, sturdy camera made by Yohan Logistics enabling every daredevil to be their own content creator! YoBro, Watch This. Comes with a clip to attach to any standard suit. Make sure to adjust the settings before you share your adventures!"
	channel = "YoBro Default Feed"

/obj/item/clothing/accessory/bodycam/yobro/Initialize(mapload)
	. = ..()
	bcamera.network = list(NETWORK_THUNDER)
	bradio.set_frequency(ENT_FREQ)
