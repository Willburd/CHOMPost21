/obj/structure/door_assembly/door_assembly_outpost_refinery
	base_icon_state = "ref"
	icon = 'modular_outpost/icons/obj/door_assembly.dmi'
	base_name = "Refinery airlock"
	glass_type = "/glass_outpost_refinery"
	airlock_type = "/outpost_refinery"

/obj/machinery/door/airlock/outpost_refinery
	name = "Refinery Airlock"
	icon = 'modular_outpost/icons/obj/doors/doorref.dmi'
	req_one_access = list(ACCESS_MEDICAL,ACCESS_ENGINE)
	assembly_type = /obj/structure/door_assembly/door_assembly_outpost_refinery
	open_sound_powered = 'sound/machines/door/hall1o.ogg'
	close_sound_powered = 'sound/machines/door/hall1c.ogg'
	department_open_powered = 'sound/machines/door/med1o.ogg'
	department_close_powered = 'sound/machines/door/med1c.ogg'
	security_level = 1.5

/obj/machinery/door/airlock/glass_outpost_refinery
	name = "Refinery Airlock"
	icon = 'modular_outpost/icons/obj/doors/doorrefglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_outpost_refinery
	glass = 1
	req_one_access = list(ACCESS_MEDICAL,ACCESS_ENGINE)
	open_sound_powered = 'sound/machines/door/hall1o.ogg'
	close_sound_powered = 'sound/machines/door/hall1c.ogg'
	department_open_powered = 'sound/machines/door/med1o.ogg'
	department_close_powered = 'sound/machines/door/med1c.ogg'
	security_level = 1.5



//Makes alien door unhackable by making it impossible to remove it's panel or use tools on it
/obj/machinery/door/airlock/alien/attackby(obj/item/C, mob/user)
	if(C.has_tool_quality(TOOL_SCREWDRIVER))
		p_open = FALSE
		return
	if(istype(C, /obj/item/multitool))
		p_open = FALSE
		return
	. = ..()

/obj/machinery/door/airlock/alien/emag_act(remaining_charges)
	return
