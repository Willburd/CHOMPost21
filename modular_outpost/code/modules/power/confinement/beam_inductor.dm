/obj/structure/confinement_beam_generator/inductor
	name = "Confinement Beam Inductor"
	desc = "Feeds electrical power into the beam generator."
	icon_state = "inductor"
	base_icon = "inductor"
	var/draw_rate = 0.95 // Use up this percent of the surplus power in the grid
	var/minimum_power = 1000

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
