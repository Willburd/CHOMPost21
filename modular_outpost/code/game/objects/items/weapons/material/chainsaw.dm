/obj/item/chainsaw/alt
	icon = 'modular_outpost/icons/obj/chainweapons.dmi'
	name = "chainsaw"
	desc = "Vroom vroom."
	var/base_icon = "chainsaw"

/obj/item/chainsaw/alt/Initialize(mapload)
	. = ..()
	default_worn_icon = icon
	update_icon()

/obj/item/chainsaw/alt/update_icon()
	icon_state = "[base_icon][on]"
	item_state = icon_state
	item_state_slots = list(slot_r_hand_str = "[icon_state]_righthand", slot_l_hand_str = "[icon_state]_lefthand")

// Axes have a higher inactive force when out of fuel
/obj/item/chainsaw/alt/axe
	name = "chainaxe"
	base_icon = "chainaxe"
	inactive_force = 30

/obj/item/chainsaw/alt/axered
	name = "chainaxe"
	base_icon = "chainaxe-red"
	inactive_force = 30

// Swords have a higher active force but pretty much nothing if out of fuel
/obj/item/chainsaw/alt/sword
	name = "chainsword"
	base_icon = "chainsword"
	active_force = 60
	inactive_force = 5

/obj/item/chainsaw/alt/swordred
	name = "chainsword"
	base_icon = "chainsword-goldred"
	active_force = 60
	inactive_force = 5
