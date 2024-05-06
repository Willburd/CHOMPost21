/obj/machinery/atmospherics/pipe/tank/methane
	name = "Pressure Tank (Methane)"
	icon = 'icons/atmos/tank_op.dmi'
	icon_state = "ch4_map"
	connect_types = CONNECT_TYPE_REGULAR|CONNECT_TYPE_FUEL

/obj/machinery/atmospherics/pipe/tank/methane/New()
	air_temporary = new
	air_temporary.volume = volume
	air_temporary.temperature = T20C

	air_temporary.adjust_gas("methane", (start_pressure)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature))

	..()
	icon_state = "ch4"
