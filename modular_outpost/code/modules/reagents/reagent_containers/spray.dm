/obj/item/reagent_containers/spray/xenowatergun
	name = "water gun"
	desc = "Heavy duty water pistol, for dealing with rambunctious alien life."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cleaner-industrial"
	item_state = "cleaner-industrial"
	amount_per_transfer_from_this = 5
	max_transfer_amount = 5
	volume = 250

/obj/item/reagent_containers/spray/xenowatergun/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_WATER, 250)
