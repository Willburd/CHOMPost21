//Original Source: Southern Cross

//Pilot

/obj/item/clothing/suit/storage/toggle/bomber/pilot
	name = "pilot jacket"
	desc = "A thick, blue bomber jacket."
	icon_state = "pilot_bomber"
	item_icons = list(slot_wear_suit_str = 'maps/yw/icons/mob/sc_suit.dmi')
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")
	icon = 'maps/yw/icons/obj/sc_suit.dmi'
	sprite_sheets = list(
			"Teshari" = 'maps/yw/icons/mob/species/teshari/sc_suit.dmi'
			)
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE

//Misc

/obj/item/clothing/suit/storage/hooded/wintercoat/medical/sar
	name = "search and rescue winter coat"
	desc = "A heavy winter jacket. A white star of life is emblazoned on the back, with the words search and rescue written underneath."
	icon_state = "coatsar"
	item_icons = list(slot_wear_suit_str = 'maps/yw/icons/mob/sc_suit.dmi')
	icon = 'maps/yw/icons/obj/sc_suit.dmi'
	armor = list(melee = 15, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 5)
	valid_accessory_slots = (ACCESSORY_SLOT_INSIGNIA)
	allowed = list (/obj/item/gun,/obj/item/pen, /obj/item/paper, /obj/item/flashlight,/obj/item/tank/emergency/oxygen,/obj/item/tank/emergency/nitrogen,/obj/item/tank/emergency/phoron,/obj/item/tank/emergency/carbon_dioxide,/obj/item/tank/emergency/methane, /obj/item/storage/fancy/cigarettes,
	/obj/item/storage/box/matches, /obj/item/reagent_containers/food/drinks/flask, /obj/item/suit_cooling_unit, /obj/item/analyzer,/obj/item/stack/medical,
	/obj/item/dnainjector,/obj/item/reagent_containers/dropper,/obj/item/reagent_containers/syringe,/obj/item/reagent_containers/hypospray,
	/obj/item/healthanalyzer,/obj/item/reagent_containers/glass/bottle,/obj/item/reagent_containers/glass/beaker,
	/obj/item/reagent_containers/pill,/obj/item/storage/pill_bottle)
