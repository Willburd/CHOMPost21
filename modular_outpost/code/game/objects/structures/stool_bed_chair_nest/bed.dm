/obj/structure/bed/roller/attackby(obj/item/W as obj, mob/user as mob)
	if(W.has_tool_quality(TOOL_SCREWDRIVER))
		anchored = !anchored
		to_chat(user, "You [anchored ? "lock" : "unlock"] \the [src]'s wheels.")
		return
	. = ..()

/obj/structure/bed/roller/examine(mob/user, infix, suffix)
	. = ..()
	if(anchored)
		. += span_notice("It's wheels are locked by a screw.")
