#define BEAM_HEAT_DIVISOR 50000

/obj/structure/confinement_beam_generator/inductor
	name = "Confinement Beam Inductor"
	desc = "Feeds electrical power into the beam generator. Must be directly wired to a power network. Also used to extract energy from a beam collector, requires adjacent heat exchange pipe for cooling if used with a collector."
	icon_state = "inductor"
	base_icon = "inductor"
	VAR_PRIVATE/minimum_power = 1000

/obj/structure/confinement_beam_generator/inductor/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/confinement_beam_generator/inductor/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/confinement_beam_generator/inductor/process()
	// If in a valid state, attempt to cool the device using a heat exchanger on either side
	if(!is_valid_state())
		return
	exchange_heat(0.32 )

/obj/structure/confinement_beam_generator/inductor/proc/get_cable_network(var/datum/powernet/prev_network)
	if(!is_valid_state())
		return null
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node() //check if we have a node cable on the machine turf, the first found is picked
	if(!C || !C.powernet)
		return null
	if(prev_network && C.powernet == prev_network) // Has already drawn from this network
		return null
	return C.powernet

/obj/structure/confinement_beam_generator/inductor/proc/get_network_power(var/datum/powernet/draw_network, var/draw_rate)
	if(!draw_network)
		return 0
	var/power_draw = draw_network.last_surplus() * draw_rate
	if(power_draw < minimum_power)
		return 0
	return draw_network.draw_power(power_draw)

// Pulsed by beam_collector
/obj/structure/confinement_beam_generator/inductor/pulse(datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return

	internal_heat += (data.power_level / BEAM_HEAT_DIVISOR) // check HEAT_OUTPUT_COEF, it is much less then original heat. Unlike in the focus!

	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node() //check if we have a node cable on the machine turf, the first found is picked
	if(!C || !C.powernet)
		return
	C.powernet.newavail += data.power_level * 0.23 // Need four of these for near full gain

#undef BEAM_HEAT_DIVISOR
