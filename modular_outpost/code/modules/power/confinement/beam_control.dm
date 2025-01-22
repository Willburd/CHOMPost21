/obj/structure/confinement_beam_generator/control_box
	name = "Confinement Control Console"
	desc = "Controls the confinement beam's power output and destination. Controls the output of a beam generator next to it."
	icon_state = "control_box"
	base_icon = "control_box"
	var/found_dir = 0
	var/datum/confinement_pulse_data/data
	var/has_gen = FALSE
	var/pulse_enabled = FALSE
	var/calibration_lock = FALSE
	var/last_temp = 0
	var/last_max = 0
	var/last_watt = "0W" // string of wattage

/obj/structure/confinement_beam_generator/control_box/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	data = new()
	data.origin_machine = WEAKREF(src)
	check_focus_temp() // Sets initial temps

/obj/structure/confinement_beam_generator/control_box/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
	qdel(data)

/obj/structure/confinement_beam_generator/control_box/process()
	// If in a valid state, attempt to pulse the beam's machinery
	has_gen = FALSE
	last_temp = LERP(last_temp, T20C, 0.1) // Drain temp slowly in UI
	last_watt = LERP(last_watt, 0, 0.1) // Drain wattage slowly in UI
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
			return
		// Ready to fire?
		if(pulse_enabled && data.target_z != -1)
			data.dir = found_dir
			G.pulse(WEAKREF(data))
		has_gen = TRUE

/obj/structure/confinement_beam_generator/control_box/proc/check_focus_temp(var/temp = T20C,var/max = T0C + 9000, var/watt = 0)
	last_temp = temp
	last_max = max

	var/units = ""
	// 10kW and less - Watts
	if(watt < 10000)
		units = "W"
	// 10MW and less - KiloWatts
	else if(watt < 10000000)
		units = "kW"
		watt = (round(watt/100) / 10)
	// More than 10MW - MegaWatts
	else if(watt < 10000000000)
		units = "MW"
		watt = (round(watt/10000) / 100)
	// More than 100MW - GigaWatts
	else
		units = "GW"
		watt = (round(watt/100000) / 1000)

	if (units == "W")
		last_watt = "[watt] W"
	else
		last_watt = "[watt] [units]"

/obj/structure/confinement_beam_generator/control_box/update_parts_icons()
	..() // Update self
	var/obj/structure/confinement_beam_generator/gen/G = locate() in get_step(src,dir) // Update generator
	if(G)
		G.update_parts_icons()

/obj/structure/confinement_beam_generator/control_box/process_tool_hit(var/obj/item/O, var/mob/user)
	. = ..()
	// force deactivate some stuff
	if(construction_state != 3)
		has_gen = FALSE
		calibration_lock = FALSE
		pulse_enabled = FALSE

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
		"last_watt" = last_watt
	)

	for(var/obj/structure/confinement_beam_generator/collector/C in GLOB.confinement_beam_collectors)
		var/turf/T = get_turf(C)
		if(T && C.is_valid_state())
			tgui_data["target_list"] += list( // appending lists would merge it if this wasn't a nested list
				list(
					"id" = "[T.x],[T.y],[T.z]",
					"x" = T.x,
					"y" = T.y,
					"z" = T.z,
					"z_str" = using_map.get_zlevel_name(T.z)
				)
			)

	return tgui_data

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
			addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 1 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
			return TRUE

		if("set_z")
			var/get_id = params["id"]
			calibration_lock = TRUE
			pulse_enabled = FALSE
			data.target_z = 1
			addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 3 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
			return TRUE

/obj/structure/confinement_beam_generator/control_box/proc/finish_calibrate()
	calibration_lock = FALSE
