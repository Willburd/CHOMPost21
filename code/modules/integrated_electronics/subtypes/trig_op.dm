
// Sine //

/obj/item/integrated_circuit/trig/arc_sine
	name = "arcsin circuit"
	desc = "Outputs the arcsine of A."
	icon = 'modular_outpost/icons/obj/integrated_electronics/electronic_components.dmi'
	icon_state = "arcsine"
	inputs = list("A" = IC_PINTYPE_NUMBER)
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH

/obj/item/integrated_circuit/trig/arc_sine/do_work()
	pull_data()
	var/result = null
	var/A = get_pin_data(IC_INPUT, 1)
	if(!isnull(A))
		result = arcsin(A)

	set_pin_data(IC_OUTPUT, 1, result)
	push_data()
	activate_pin(2)

// Cosine //

/obj/item/integrated_circuit/trig/arc_cosine
	name = "arccos circuit"
	desc = "Outputs the arccosine of A."
	icon = 'modular_outpost/icons/obj/integrated_electronics/electronic_components.dmi'
	icon_state = "arccosine"
	inputs = list("A" = IC_PINTYPE_NUMBER)
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH

/obj/item/integrated_circuit/trig/arc_cosine/do_work()
	pull_data()
	var/result = null
	var/A = get_pin_data(IC_INPUT, 1)
	if(!isnull(A))
		result = arccos(A)

	set_pin_data(IC_OUTPUT, 1, result)
	push_data()
	activate_pin(2)

// Tangent //

/obj/item/integrated_circuit/trig/arc_tangent
	name = "arctan circuit"
	desc = "Outputs the arctangent of A."
	icon = 'modular_outpost/icons/obj/integrated_electronics/electronic_components.dmi'
	icon_state = "arctangent"
	inputs = list("A" = IC_PINTYPE_NUMBER)
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH

/obj/item/integrated_circuit/trig/arc_tangent/do_work()
	pull_data()
	var/result = null
	var/A = get_pin_data(IC_INPUT, 1)
	if(!isnull(A))
		result = arctan(A)

	set_pin_data(IC_OUTPUT, 1, result)
	push_data()
	activate_pin(2)
