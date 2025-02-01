#define NOTARG "No Target"
#define NOWATT "0 W"

/obj/structure/confinement_beam_generator/control_box
	name = "Confinement Control Console"
	desc = "Controls the confinement beam's power output and destination. Controls the output of a beam generator next to it."
	icon_state = "control_box"
	base_icon = "control_box"
	VAR_PRIVATE/found_dir = 0
	VAR_PRIVATE/datum/confinement_pulse_data/data
	VAR_PRIVATE/has_gen = FALSE
	VAR_PRIVATE/pulse_enabled = FALSE
	VAR_PRIVATE/calibration_lock = FALSE
	VAR_PRIVATE/last_temp = 0
	VAR_PRIVATE/last_max = 0
	VAR_PRIVATE/last_watt = NOWATT // string of wattage
	VAR_PRIVATE/current_target = NOTARG
	VAR_PRIVATE/last_health = 0
	VAR_PRIVATE/max_health = 0

/obj/structure/confinement_beam_generator/control_box/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	data = new()
	data.origin_machine = WEAKREF(src)
	check_focus_data() // Sets initial temps

/obj/structure/confinement_beam_generator/control_box/Destroy()
	has_gen = FALSE
	calibration_lock = FALSE
	pulse_enabled = FALSE
	SStgui.close_uis(src)
	STOP_PROCESSING(SSobj, src)
	. = ..()
	qdel(data)

/obj/structure/confinement_beam_generator/control_box/process()
	// If in a valid state, attempt to pulse the beam's machinery
	has_gen = FALSE
	var/turf/T = get_turf(src)
	var/datum/gas_mixture/A = T.return_air()
	last_temp = LERP(last_temp, A.temperature, 0.05) // Drain temp in UI
	last_watt = NOWATT
	if(!is_valid_state())
		calibration_lock = FALSE
		pulse_enabled = FALSE
		return

	if(!has_power())
		if(icon_state == "control_box_p") // powered, now wants unpowered
			update_parts_icons()
		return
	if(icon_state == "control_box_c") // unpowered, now wants powered
		update_parts_icons()

	if(found_dir == 0)
		for(var/d in cardinal)
			var/obj/structure/confinement_beam_generator/gen/G = locate() in get_step(src,d)
			if(G)
				found_dir = d
	else
		var/obj/structure/confinement_beam_generator/gen/G = locate() in get_step(src,found_dir)
		if(!G || !G.is_valid_state())
			found_dir = 0
			pulse_enabled = FALSE // cancel beam automatically if generator was removed
			SStgui.update_uis(src)
			return
		has_gen = TRUE
		// Ready to fire?
		if(pulse_enabled && data.target_z != -1)
			data.dir = found_dir
			G.pulse(WEAKREF(data))

/obj/structure/confinement_beam_generator/control_box/proc/check_focus_data(var/temp = T20C,var/max = T0C + 1400, var/watt = 0, var/health = 100, var/mhealth = 100)
	last_temp = temp
	last_max = max

	last_health = health
	max_health = mhealth

	last_watt = val_to_watts(watt)

/obj/structure/confinement_beam_generator/control_box/proc/val_to_watts(var/watt)
	var/units = ""
	// 10kW and less - Watts
	if(watt < 10000)
		units = "W"
	// 10MW and less - KiloWatts
	else if(watt < 10000000)
		units = "kW"
		watt = (round(watt/100) / 10)
	// More than 10MW - MegaWatts
	else
		units = "MW"
		watt = (round(watt/10000) / 100)

	if (units == "W")
		return "[watt] W"
	else
		return "[watt] [units]"

/obj/structure/confinement_beam_generator/control_box/update_parts_icons()
	..() // Update self
	var/obj/structure/confinement_beam_generator/gen/G = locate() in get_step(src,dir) // Update generator
	if(G)
		G.update_parts_icons()

/obj/structure/confinement_beam_generator/control_box/process_tool_hit(var/obj/item/O, var/mob/user)
	. = ..()
	// force deactivate some stuff
	has_gen = FALSE
	calibration_lock = FALSE
	pulse_enabled = FALSE
	if(construction_state != 3)
		SStgui.close_uis(src)
	else // construction should instantly check for generator
		process()

/obj/structure/confinement_beam_generator/control_box/attack_ai(mob/user)
	if(..())
		return
	tgui_interact(user)

/obj/structure/confinement_beam_generator/control_box/attack_hand(user as mob)
	if(..())
		return
	add_fingerprint(user)
	tgui_interact(user)

/obj/structure/confinement_beam_generator/control_box/tgui_interact(mob/user, datum/tgui/ui)
	if(!has_power())
		return FALSE
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ConfinementBeamControl", name)
		ui.open()

/obj/structure/confinement_beam_generator/control_box/tgui_data(mob/user)
	// this is the data which will be sent to the ui
	var/tgui_data[0]

	tgui_data = list(
		"has_gen" = has_gen,
		"pulse_enable" = pulse_enabled,
		"calibrating" = calibration_lock,
		"target_z" = data.target_z,
		"target_list" = list(),
		"last_temp" = last_temp,
		"max_temp" = last_max,
		"last_watt" = last_watt,
		"current_target" = current_target,
		"last_health" = last_health,
		"max_health" = max_health,
		"t_rate" = data.t_rate * 100
	)

	// Target centcomm
	tgui_data["target_list"] += list( // appending lists would merge it if this wasn't a nested list
		list(
			"id" = "[using_map.company_name] PTL Electricity Export Satellite - 672, 821, 98",
			"x" = 4,
			"y" = 4,
			"z" = 0,
			"enb" = TRUE
		)
	)
	// Target all others
	for(var/obj/structure/confinement_beam_generator/collector/C in GLOB.confinement_beam_collectors)
		var/turf/T = get_turf(C)
		if(T && C.is_valid_state())
			tgui_data["target_list"] += list( // appending lists would merge it if this wasn't a nested list
				list(
					"id" = format_z_id(C),
					"x" = T.x,
					"y" = T.y,
					"z" = T.z,
					"enb" = validate_turf(T)
				)
			)

	return tgui_data

/obj/structure/confinement_beam_generator/control_box/proc/validate_turf(var/turf/T)
	var/area/A = get_area(T)
	return (T.z in using_map.confinement_beam_z_levels) && !istype(A,/area/shuttle) && !istype(A,/area/turbolift)

/obj/structure/confinement_beam_generator/control_box/proc/format_z_id(var/obj/structure/confinement_beam_generator/collector/C)
	var/turf/T = get_turf(C)
	if(T && C.is_valid_state())
		var/area/A = get_area(T)
		return "[A.name] - [T.x], [T.y], [using_map.get_zlevel_name(T.z)]"
	return null

/obj/structure/confinement_beam_generator/control_box/tgui_act(action, params, datum/tgui/ui)
	if(..())
		return TRUE
	if(calibration_lock || !has_gen)
		return FALSE

	add_fingerprint(ui.user)
	playsound(src, "keyboard", 40)

	switch(action)
		if("toggle_beam")
			pulse_enabled = !pulse_enabled
			calibration_lock = TRUE
			if(!pulse_enabled)
				current_target = NOTARG
				// Reset Targeting
				data.target_x = 0
				data.target_y = 0
				data.target_z = -1
				// Reset aim
				data.current_x = -1
				data.current_y = -1
			addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 1 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
			return TRUE

		if("set_z")
			var/get_id = params["id"]
			var/get_x = params["x"]
			var/get_y = params["y"]
			var/get_z = params["z"]
			if(get_id == "") // Release target
				if(data.target_z != -1)
					current_target = NOTARG
					calibration_lock = TRUE
					pulse_enabled = FALSE
					// Reset Targeting
					data.target_x = 0
					data.target_y = 0
					data.target_z = -1
					// Reset aim
					data.current_x = -1
					data.current_y = -1
					addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 1 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
					return TRUE
				return FALSE
			if(get_z == 0) // Target centcom
				current_target = get_id
				calibration_lock = TRUE
				pulse_enabled = FALSE
				// Reset Targeting
				data.target_x = 500
				data.target_y = 500
				data.target_z = 0
				// Reset aim
				data.current_x = -1
				data.current_y = -1
				addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 3 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
				return TRUE
			// check for data validity by scanning the list for a matching id
			for(var/obj/structure/confinement_beam_generator/collector/C in GLOB.confinement_beam_collectors)
				var/turf/T = get_turf(C)
				if(get_x == T.x && get_y == T.y && get_z == T.z && C.is_valid_state()) // is valid gen?
					if(!validate_turf(T))
						admin_notice("[ui.user] - possible hrefhacks. Passed [get_id] while button was disabled. Beam z destination is forbidden by map datum.")
						return
					current_target = format_z_id(C)
					calibration_lock = TRUE
					pulse_enabled = FALSE
					// Reset Targeting
					data.target_x = T.x
					data.target_y = T.y
					data.target_z = C.find_highest_z() // fire from above to it!
					// Reset aim
					data.current_x = -1
					data.current_y = -1
					addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 3 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
					return TRUE
			return FALSE

		if("transmission_rate")
			var/get_val = params["value"]
			get_val = CLAMP(get_val,0,100)
			data.t_rate = get_val / 100
			return TRUE

		else
			return FALSE

/obj/structure/confinement_beam_generator/control_box/proc/finish_calibrate()
	calibration_lock = FALSE

#undef NOTARG
#undef NOWATT
