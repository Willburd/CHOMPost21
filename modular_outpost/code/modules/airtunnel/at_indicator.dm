/**
 * at_indicator -- Provides a visual indication of airtunnel status
 *
 */

/obj/machinery/at_indicator
	name = "Air Tunnel Indicator"
	icon = 'modular_outpost/icons/obj/airtunnel/airtunnel.dmi'
	icon_state = "reader00"
	anchored = 1.0

/obj/machinery/at_indicator/process()
	if(! (stat & (BROKEN|NOPOWER)) )
		use_power(5, ENVIRON)
	update_icon()
	return

// update the icon_state, depending on the status of the airtunnel
/obj/machinery/at_indicator/proc/update_icon()
	if(stat & (BROKEN|NOPOWER) )
		icon_state = "reader_broken"
		return

	var/status = 0
	if (SS13_airtunnel.operating == 1)
		status = "r"
	else if (SS13_airtunnel.operating == 2)
		status = "e"
	else
		var/obj/move/airtunnel/connector/C = pick(SS13_airtunnel.connectors)
		if (C.current == C)
			status = 0
		else
			if (!( C.current.next ))
				status = 2
			else
				status = 1
	icon_state = text("reader[][]", (SS13_airtunnel.siphon_status == 2 ? "1" : "0"), status)
	return


// called when object is inside an explosion
/obj/machinery/at_indicator/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
			return
		if(2.0)
			if (prob(50))
				icon_state = "reader_broken"
				stat |= BROKEN
		if(3.0)
			if (prob(25))
				icon_state = "reader_broken"
				stat |= BROKEN
		else
	return

	// called when object is attacked by a blob

/obj/machinery/at_indicator/blob_act()
	if (prob(50))
		icon_state = "reader_broken"
		stat |= BROKEN
