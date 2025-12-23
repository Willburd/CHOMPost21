/obj/machinery/lockdown_console
	name = "Lockdown Control Console"
	desc = "This device is used to control various lockdown shutters across the station."
	icon = 'modular_outpost/icons/obj/monitors.dmi'
	icon_state = "lockdown"
	layer = ABOVE_WINDOW_LAYER
	circuit = /obj/item/circuitboard/lockdown_console
	anchored = TRUE
	idle_power_usage = 2
	active_power_usage = 6
	req_one_access = list( ACCESS_KEYCARD_AUTH, ACCESS_HEADS, ACCESS_HEADS_VAULT, ACCESS_BRIG)
	VAR_PRIVATE/unlocked = FALSE
	VAR_PROTECTED/list/linked_states = list()
	VAR_PROTECTED/list/linked_lockdowns = list()
	VAR_PROTECTED/list/linked_jokes = list()

/obj/machinery/lockdown_console/Initialize(mapload)
	. = ..()
	for(var/link in linked_lockdowns)
		linked_states[link] = FALSE

/obj/machinery/lockdown_console/proc/add_button(name, key, joke)
	linked_lockdowns[name] = key
	linked_jokes[name] = joke
	linked_states[name] = FALSE

/obj/machinery/lockdown_console/proc/remove_button(name)
	linked_lockdowns -= name
	linked_jokes -= name
	linked_states -= name

/obj/machinery/lockdown_console/attack_ai(mob/user)
	attack_hand(user)
	return

/obj/machinery/lockdown_console/attackby(obj/item/W, mob/user)
	if(stat & (NOPOWER|BROKEN))
		to_chat(user, "This device is not powered.")
		return

	if(istype(W,/obj/item/card/id))
		if(check_access(W))
			unlocked = !unlocked
			updateUsrDialog()
		else
			// Nope!
			to_chat(user, span_danger("Access denied."))
			flick("lockdown_reject",src)
		return

	if(W.has_tool_quality(TOOL_SCREWDRIVER))
		to_chat(user, "You begin removing the faceplate from the [src]")
		playsound(src, W.usesound, 50, 1)
		if(do_after(user, 10 * W.toolspeed, target = src))
			to_chat(user, "You remove the faceplate from the [src]")
			var/obj/structure/frame/A = new /obj/structure/frame(loc)
			var/obj/item/circuitboard/M = new circuit(A)
			A.frame_type = M.board_type
			A.need_circuit = 0
			A.pixel_x = pixel_x
			A.pixel_y = pixel_y
			A.set_dir(dir)
			A.circuit = M
			A.anchored = TRUE
			for (var/obj/C in src)
				C.forceMove(loc)
			A.state = 3
			A.update_icon()
			M.deconstruct(src)
			qdel(src)
		return

	. = ..()

/obj/machinery/lockdown_console/power_change()
	..()
	if(stat & NOPOWER)
		icon_state = "lockdown_off"
		return
	icon_state = "lockdown"

/obj/machinery/lockdown_console/attack_hand(mob/user)
	if(..())
		return TRUE
	if(!Adjacent(user) && !isAI(user) && !isrobot(user))
		return TRUE
	tgui_interact(user)

/obj/machinery/lockdown_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LockdownButton", name)
		ui.open()

/obj/machinery/lockdown_console/tgui_data(mob/user)
	var/list/data = list()
	data["unlocked"] = unlocked || isrobot(user) || isAI(user)
	data["buttons"] = linked_jokes
	data["door_states"] = linked_states
	return data

/obj/machinery/lockdown_console/tgui_act(action, params, datum/tgui/ui)
	if(..())
		return TRUE
	add_fingerprint(ui.user)

	playsound(src, 'sound/machines/button.ogg', 100, 1)
	if(!unlocked && !isAI(ui.user) && !isrobot(ui.user))
		to_chat(ui.user, span_warning("Access denied."))
		flick("lockdown_reject",src)
		return FALSE

	switch(action)
		if("triggerevent")
			trigger_event(ui.user, params["triggerevent"])
			return TRUE

	return FALSE

/obj/machinery/lockdown_console/proc/trigger_event(mob/user,event)
	PRIVATE_PROC(TRUE)
	var/counter = 0
	for(var/link in linked_lockdowns)
		counter += 1
		if(counter >= 19) // clamp with number of icon's buttons
			counter = 1
		if(link != event)
			continue
		use_power(active_power_usage)

		var/obj/machinery/door/blast/last_door = null
		flick("lockdown_[counter]",src)
		var/id_door = linked_lockdowns[link]
		var/old_state = linked_states[link]
		linked_states[link] = !linked_states[link]
		var/is_operating = FALSE
		for(var/obj/machinery/door/blast/M in GLOB.machines)
			if(M.id != id_door)
				continue
			last_door = M
			// Still operating!
			if(M.operating)
				is_operating = TRUE
				continue
			// Toggle state
			if(linked_states[link])
				if(!M.density)
					M.close()
			else
				if(M.density)
					M.open()

		// Feedback
		if(!last_door)
			to_chat(user, span_danger("[event] is unlinked."))
			linked_states[link] = FALSE
			return
		if(is_operating)
			to_chat(user, span_warning("[event] still cycling... Please wait."))
			linked_states[link] = old_state
			return

		if(last_door.density)
			to_chat(user, span_info("[event] locked down."))
			return
		to_chat(user, span_info("[event] unlocked."))


///////////////////////////////////////////////////////////////////
/// SUBTYPES
///////////////////////////////////////////////////////////////////
/obj/machinery/lockdown_console/outpost21/Initialize(mapload)
	. = ..()
	add_button("Sensitive Areas", 		"sensitive_lock", 		"It locks down AI Core, Telecoms, and The Terraformer")
	add_button("Bridge", 				"bridge blast", 		"It locks down the bridge, congrats, you have trapped yourself.")
	add_button("Captain Office", 		"cap_office", 			"It locks the captain in their office. Finally, naptime can be achieved.")
	add_button("Medbay Quarantine", 	"medbayquar", 			"It locks down the medbay, except for the main entrance.")
	add_button("Medbay Entrance", 		"medbayrecquar", 		"A specialized lock to allow patients into the main entrance during a medical lockdown.")
	add_button("Security", 				"security_lockdown", 	"It locks down security, typically a good idea.")
	add_button("Prison", 				"Secure Gate", 			"It locks down the brigs, to prevent escapes.")
	add_button("Brig Observation", 		"brigobs", 				"It locks down the windows looking into the brigs")
	add_button("Security Check-in", 	"seccheck",				"It locks down the hallway to force newcomers to the station to get cleared through security")
	add_button("Engineering", 			"englockdown",			"It locks down engineering. Finally, a way to contain Taaa.")
	add_button("Atmospherics", 			"atmoslockdown",		"It locks down atmospherics, for when it explodes.")
	// add_button("Chemical Refinery", 	"refine_lock",			"It locks down the chemical refinery, for when someone is about to mix 5k units of oxygen and potassium.")
	add_button("Science",				"Scilock",				"It locks down science, but probably not for long.")
	add_button("Phoronics Emergency", 	"phoronic_lockdown", 	"It locks down phoronics, but its probably too little too late.")
	add_button("Virology Quarantine", 	"virologyquar", 		"It locks down the sniffle-zone.")
	add_button("Cargo", 				"cargolock",			"It locks down Cargonia... or more aptly, opens it when they shut themselves in.")
	add_button("Kitchen", 				"kitchen", 				"It locks down the kitchen. Like the chef deserves.")
