/obj/machinery/button/remote/admin_only
	name = "secure remote object control"
	desc = "It controls objects, remotely and with extreme prejudice."

/obj/machinery/button/remote/admin_only/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/button/remote/admin_only/attack_ghost(mob/user)
	return attack_hand(user)

/obj/machinery/button/remote/admin_only/attack_robot(mob/living/user)
	return attack_hand(user)

/obj/machinery/button/remote/admin_only/attackby(obj/item/W, mob/user as mob)
	return attack_hand(user)

/obj/machinery/button/remote/admin_only/emag_act(var/remaining_charges, var/mob/user)
	return

/obj/machinery/button/remote/admin_only/ex_act(severity)
	return

/obj/machinery/button/remote/admin_only/allowed(mob/M)
	return M && M.client && M.client.holder && M.client.holder.rights & R_ADMIN

/obj/machinery/button/remote/admin_only/Adjacent(atom/neighbor)
	if(!istype(neighbor,/mob) || !allowed(neighbor))
		return FALSE
	return TRUE

/obj/machinery/button/remote/admin_only/attack_hand(mob/user as mob)
	if(!allowed(user))
		to_chat(user, span_warning("Access Denied"))
		flick("doorctrl-denied",src)
		return

	icon_state = "doorctrl1"
	desiredstate = !desiredstate
	trigger(user)
	spawn(15)
		update_icon()

// Outpost 21 hardcoded lockdown and turrets
/obj/machinery/button/remote/admin_only/trigger()
	for(var/obj/machinery/door/blast/M in machines)
		if(M.id == id)
			if(M.density)
				spawn(0)
					M.open()
			else
				spawn(0)
					M.close()

	for(var/obj/machinery/porta_turret/M in machines)
		if(get_area(M) == get_area(src))
			M.enabled = !M.enabled
			if(M.enabled)
				M.visible_message(pick("Get down on the floor!","Drop to the ground and stay down!","Get down and do not move!","Get down, don't move!"))
				M.check_synth = FALSE
				M.check_access = FALSE
				M.check_arrest = TRUE
				M.check_records = TRUE
				M.check_weapons = TRUE
				M.check_anomalies = FALSE
				M.check_all = FALSE
				M.check_down = TRUE
				M.lethal = TRUE
