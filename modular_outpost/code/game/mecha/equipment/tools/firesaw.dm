/obj/item/mecha_parts/mecha_equipment/tool/powertool/firesaw
	name = "fire-rescue saw"
	desc = "An exosuit-mounted anti-material circular saw with multiple safety guards. Designed for fire rescue operations."
	icon = 'modular_outpost/icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_firesaw"
	equip_cooldown = 4
	energy_drain = 20
	range = MECH_MELEE
	equip_type = EQUIP_UTILITY
	ready_sound = 'sound/items/Ratchet.ogg'
	required_type = list(/obj/mecha/working/ripley/firefighter)
	tooltype = /obj/item/material/twohanded/fireaxe

/obj/item/mecha_parts/mecha_equipment/tool/powertool/firesaw/attach(obj/mecha/M)
	..()
	range = MECH_MELEE
	my_tool.reach = TRUE
	var/obj/item/material/twohanded/fireaxe/axe = my_tool
	axe.wielded = TRUE
	axe.tool_qualities = list(TOOL_CROWBAR)

/obj/item/mecha_parts/mecha_equipment/tool/powertool/firesaw/action(atom/target)
	if(!action_checks(target))
		return FALSE
	if(isliving(target))
		return FALSE
	if(target.attackby(my_tool, chassis.occupant) != ITEM_INTERACT_SUCCESS)
		my_tool.afterattack(target, chassis.occupant, TRUE)
