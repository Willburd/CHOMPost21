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

/obj/structure/confinement_beam_generator/control_box/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	data = new()

/obj/structure/confinement_beam_generator/control_box/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
	qdel(data)

/obj/structure/confinement_beam_generator/control_box/process()
	// If in a valid state, attempt to pulse the beam's machinery
	has_gen = FALSE
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
	var/data[0]

	data = list(
		"has_gen" = has_gen,
		"pulse_enable" = pulse_enabled,
		"calibrating" = calibration_lock,
		"target_z" = data.target_z,
	)

	return data

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
			calibration_lock = TRUE
			pulse_enabled = FALSE
			data.target_z = 1
			addtimer(CALLBACK(src, PROC_REF(finish_calibrate)), 3 SECONDS, TIMER_DELETE_ME) // Prevent procspamming
			return TRUE

/obj/structure/confinement_beam_generator/proc/finish_calibrate()
	calibration_lock = FALSE
