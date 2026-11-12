/obj/item/reagent_containers/food/drinks/cans/attackby(obj/item/W, mob/user)
	if(W.has_tool_quality(TOOL_WELDER))
		if(cant_open)
			to_chat(user, span_warning("\The [src] is already a can't!"))
			return
		var/obj/item/weldingtool/WT = W.get_welder()
		if(!WT.isOn())
			return
		if(WT.get_fuel() < 1)
			to_chat(user, span_warning("You need more fuel to complete this task."))
			return
		playsound(src, WT.usesound, 50, 1)
		if(do_after(user, 1 SECONDS * WT.toolspeed, target = src))
			if(!src || !user || !WT.remove_fuel(1, user)) return
			user.visible_message("[user] welds \the [src] into a can't!.", "You weld \the [src] into a can't")
			cant_open = TRUE
	. = ..()
