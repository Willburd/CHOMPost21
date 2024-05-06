/obj/item/integrated_circuit/input/methane_sensor
	name = "integrated methane sensor"
	desc = "A tiny methane gas sensor module similar to that found in a PDA atmosphere analyser."
	icon_state = "medscan_adv"
	complexity = 3
	inputs = list()
	outputs = list(
		"methane"       = IC_PINTYPE_NUMBER
	)
	activators = list("scan" = IC_PINTYPE_PULSE_IN, "on scanned" = IC_PINTYPE_PULSE_OUT)
	spawn_flags = IC_SPAWN_RESEARCH
	origin_tech = list(TECH_ENGINEERING = 3, TECH_DATA = 3)
	power_draw_per_use = 20

/obj/item/integrated_circuit/input/methane_sensor/do_work()
	var/turf/T = get_turf(src)
	if(!istype(T)) //Invalid input
		return
	var/datum/gas_mixture/environment = T.return_air()

	var/total_moles = environment.total_moles

	if (total_moles)
		var/methane_level = environment.gas["methane"]/total_moles
		set_pin_data(IC_OUTPUT, 1, round(methane_level*100,0.1))
	else
		set_pin_data(IC_OUTPUT, 1, 0)
	push_data()
	activate_pin(2)
