/proc/power_kill_quick()
	for(var/obj/machinery/power/smes/S in GLOB.smeses)
		if(isNotStationLevel(S.z))
			continue
		if(S.is_critical)
			continue
		S.charge = 0
		S.output_level = 0
		S.output_attempt = 1
		S.input_attempt = 1
		S.update_icon()
		S.power_change()

	for(var/obj/machinery/power/apc/A in GLOB.apcs)
		if(isNotStationLevel(A.z))
			continue
		if(A.is_critical)
			continue
		if(A.cell)
			A.cell.charge = 0
