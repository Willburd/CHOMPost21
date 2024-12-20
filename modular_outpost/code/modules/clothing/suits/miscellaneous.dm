/obj/item/clothing/suit/omnitag
	name = "universal laser tag armour"
	desc = "Laser tag armor with no allegiance. For the true renegade, or a free for all."
	icon = 'modular_outpost/icons/inventory/suit/item.dmi'
	icon_override = 'modular_outpost/icons/inventory/suit/mob.dmi'
	icon_state = "omnitag"
	item_icons = list(slot_l_hand_str = 'modular_outpost/icons/mob/items/lefthand_suits.dmi', slot_r_hand_str = 'modular_outpost/icons/mob/items/righthand_suits.dmi')
	item_state_slots = list(slot_r_hand_str = "tdomni", slot_l_hand_str = "tdomni")
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO
	allowed = list (/obj/item/gun/energy/lasertag)
	siemens_coefficient = 3.0
	var/lasertag_health = LASER_TAG_HEALTH

/*
/obj/item/clothing/suit/omnitag/switch
	name = "Switch Armor"
	desc = "Replica armor commonly worn by (TODO - add dumb switch joke armor...)" //Supposed to be an anti-omni armor. Juggernaught type deal
	icon_state = "omnitag2"
*/

/obj/item/clothing/head/helmet/lasertag
	name = "laser tag helmet"
	desc = "A simple helmet with reflective strips, and a visor for eye protection. It offers next to no protection, but it makes you look cool!"
	icon_state = "helmet_reflec"
	item_state_slots = list(slot_r_hand_str = "helmet", slot_l_hand_str = "helmet")
	armor = list(melee = 5, bullet = 0, laser = 0 ,energy = 0, bomb = 0, bio = 0, rad = 0)
	body_parts_covered = HEAD|FACE|EYES
	siemens_coefficient = 3.0
	valid_accessory_slots = null
