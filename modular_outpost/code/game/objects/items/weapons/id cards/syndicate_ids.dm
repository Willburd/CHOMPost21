/obj/item/card/id/syndicate/vox
	name = "alien card"
	icon_state = "generic-s"
	assignment = "Raider"

/obj/item/card/id/syndicate/vox/Initialize()
	. = ..()
	access |= access_trader
	access |= access_alien
