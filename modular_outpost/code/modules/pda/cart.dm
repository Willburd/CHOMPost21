
/obj/item/cartridge/teshpet
	name = "\improper Tesh Petter cartridge"
	icon_state = "cart-m"
	programs = list(
		/datum/data/pda/app/tesh_pet)

/obj/item/cartridge/signal/engineering
	name = "\improper Signal Pro 2 cartridge"
	desc = "Complete with integrated radio signaler!"
	icon_state = "cart-tox"
	programs = list(
		new/datum/data/pda/utility/scanmode/gas,
		new/datum/data/pda/utility/scanmode/reagent,
		new/datum/data/pda/app/signaller)
