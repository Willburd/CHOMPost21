/obj/machinery/alarm/voxbox
	trace_gas = list(GAS_N2O) //list of other gases that this air alarm is able to detect

/obj/machinery/alarm/voxbox/first_run()
	. = ..()
	TLV[GAS_O2] =			list(-1.0, -1.0, 0, 0.5) // Partial pressure, kpa
	TLV[GAS_N2] =			list(0, 0, 135, 140) // Partial pressure, kpa
	TLV[GAS_CO2] = 			list(-1.0, -1.0, 5, 10) // Partial pressure, kpa
	TLV[GAS_PHORON] =		list(16, 19, 135, 140) // Partial pressure, kpa
	TLV[GAS_CH4] =		list(-1.0, -1.0, 0.5, 1.0) // Partial pressure, kpa
	TLV["other"] =			list(-1.0, -1.0, 0.5, 1.0) // Partial pressure, kpa
	TLV["pressure"] =		list(ONE_ATMOSPHERE * 0.80, ONE_ATMOSPHERE * 0.90, ONE_ATMOSPHERE * 1.10, ONE_ATMOSPHERE * 1.20) /* kpa */
	TLV["temperature"] =	list(T0C - 26, T0C, T0C + 40, T0C + 66) // K
