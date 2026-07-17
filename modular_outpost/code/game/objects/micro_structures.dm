/obj/structure/micro_tunnel/attackby(obj/item/I, mob/user)
	if(I.has_tool_quality(TOOL_WELDER))
		var/obj/item/weldingtool/WT = I.get_welder()
		if(!WT.isOn())
			return
		if(WT.get_fuel() < 5) //uses up 5 fuel.
			to_chat(user, span_notice("You need more fuel to complete this task."))
			return
		playsound(src, WT.usesound, 50, 1)
		if(do_after(user, 5 SECONDS, target = src))
			visible_message("\The [user] welds \the [src] shut.")
			qdel(src)
			return
	. = ..()
