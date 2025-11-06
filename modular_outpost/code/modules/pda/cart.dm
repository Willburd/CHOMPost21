
/obj/item/cartridge/teshpet
	name = "\improper Tesh Petter cartridge"
	icon_state = "cart-m"
	programs = list(
		new/datum/data/pda/app/tesh_pet)

/obj/item/cartridge/signal/engineering
	name = "\improper Signal Pro 2 cartridge"
	desc = "Complete with integrated radio signaler!"
	icon_state = "cart-tox"
	programs = list(
		new/datum/data/pda/utility/scanmode/gas,
		new/datum/data/pda/utility/scanmode/reagent,
		new/datum/data/pda/app/signaller)

// UAV type that spawns with a cart
/obj/item/uav/has_cart/Initialize(mapload)
	. = ..()
	new /obj/item/cartridge/uav_control(loc)

/obj/item/cartridge/uav_control
	name = "\improper UAV controller"
	desc = "Drone control program. Pair your PDA to a UAV and take off!"
	icon_state = "cart-m"
	programs = list(
		new/datum/data/pda/app/uav_control)
