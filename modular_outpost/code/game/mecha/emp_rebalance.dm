/obj/item/mecha_parts/component/emp_act(severity = 4, recursive)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(severity + emp_resistance >= EMP_NONE)
		return

	var/adjusted_resistance = FLOOR(emp_resistance / (emp_resistance > 0) ? 2 : 1,1) // Positive resistance to emp is halved
	if(severity + adjusted_resistance >= EMP_NONE)
		return
	severity = clamp(severity + adjusted_resistance, EMP_HEAVY, EMP_HARMLESS)

	take_damage((EMP_HARMLESS - severity) * round(integrity * 0.1, 0.1))
