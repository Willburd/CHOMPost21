/obj/item/mecha_parts/component/emp_act(severity = 4, recursive)
	var/adjusted_resistance = FLOOR(emp_resistance / (emp_resistance > 0) ? 2 : 1,1) // Positive resistance to emp is halved
	if(severity + adjusted_resistance > 4)
		return
	severity = clamp(severity + adjusted_resistance, 1, 4)
	take_damage((4 - severity) * round(integrity * 0.1, 0.1))
