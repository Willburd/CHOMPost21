/obj/machinery/power/generator/tgui_data(mob/user)
	var/list/data = ..()
	if(circ1)
		//The one on the left (or top)
		data["primary"]["reversed"] = circ1.reverse_pipes
	if(circ2)
		//Now for the one on the right (or bottom)
		data["secondary"]["reversed"] = circ2.reverse_pipes
	return data

/obj/machinery/power/generator/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	switch(action)
		if("reverse_primary")
			if(circ1)
				circ1.reverse_circulator()
			return TRUE
		if("reverse_secondary")
			if(circ2)
				circ2.reverse_circulator()
			return TRUE
