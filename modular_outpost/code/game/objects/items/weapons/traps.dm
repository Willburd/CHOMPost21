/obj/item/beartrap/proc/attackby(obj/item/W, mob/user)
	if (!deployed && !anchored && W.has_tool_quality(TOOL_WRENCH))
		user.visible_message(
			span_danger("\The [user] disassembles \the [src]."),
			span_notice("You disassemble \the [src]!")
			)
		new /obj/item/stack/material/steel(get_turf(user), 3)
		qdel(src)
		return TRUE
	. = ..()
