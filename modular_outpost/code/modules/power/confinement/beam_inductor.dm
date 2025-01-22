#define BEAM_HEAT_DIVISOR 100000
#define HEAT_OUTPUT_COEF 0.32 // Heat transfer to gas, the total heat is always removed from the focus, but the heat transfered to the gas is multiplied by this.

/obj/structure/confinement_beam_generator/inductor
	name = "Confinement Beam Inductor"
	desc = "Feeds electrical power into the beam generator. Must be directly wired to a power network. Also used to extract energy from a beam collector, requires adjacent heat exchange pipe for cooling if used with a collector."
	icon_state = "inductor"
	base_icon = "inductor"
	var/draw_rate = 0.95 // Use up this percent of the surplus power in the grid
	var/minimum_power = 1000
	var/health = 100
	var/damage_temp = T0C + 5000
	var/internal_heat = 0

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

	if(internal_heat <= 0)
		return

	var/obj/machinery/atmospherics/unary/heat_exchanger/EXA = locate() in get_step(src,turn(dir,90))
	var/obj/machinery/atmospherics/unary/heat_exchanger/EXB = locate() in get_step(src,turn(dir,-90))
	var/transfer_ratio = 0.5 // Assume both exchangers
	if(!EXA || !EXA.network || EXA.air_contents.heat_capacity() <= 0 || !EXA.air_contents.total_moles || EXA.air_contents.temperature > internal_heat * HEAT_OUTPUT_COEF)
		EXA = null
		transfer_ratio = 1 // Only one exchanger
	if(!EXB || !EXB.network || EXB.air_contents.heat_capacity() <= 0 || !EXB.air_contents.total_moles || EXB.air_contents.temperature > internal_heat * HEAT_OUTPUT_COEF)
		EXB = null
		transfer_ratio = 1 // Only one exchanger
	// Exchange internal heat directly to the gas! If two exchangers, split it evenly, otherwise dump it all into one.
	if(EXA)
		EXA.air_contents.add_thermal_energy( EXA.air_contents.get_thermal_energy_change( EXA.air_contents.temperature + (internal_heat * transfer_ratio * HEAT_OUTPUT_COEF)) )
		EXA.network.update = 1
	if(EXB)
		EXB.air_contents.add_thermal_energy( EXB.air_contents.get_thermal_energy_change( EXB.air_contents.temperature + (internal_heat * transfer_ratio * HEAT_OUTPUT_COEF)) )
		EXB.network.update = 1
	// If heat exchange was successful then clear the current heat, the limiter should be the gas itself.
	if(EXA || EXB)
		internal_heat = 0

	// Damage and eventually explode
	if(internal_heat >= damage_temp && prob(30) && health > 0)
		health -= 1
		if(health == 0)
			explosion(get_turf(src),2,3,5,7)
			qdel(src)

/obj/structure/confinement_beam_generator/inductor/proc/get_network_power()
	if(!is_valid_state())
		return

	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node() //check if we have a node cable on the machine turf, the first found is picked
	if(!C || !C.powernet)
		return

	var/power_draw = C.powernet.last_surplus() * draw_rate
	if(power_draw < minimum_power)
		return

	return C.powernet.draw_power(power_draw)

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
#undef HEAT_OUTPUT_COEF
