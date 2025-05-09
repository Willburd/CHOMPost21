/obj/machinery/computer/shuttle_control
	name = "shuttle control console"
	desc = "Used to control a linked shuttle."
	icon_keyboard = "atmos_key"
	icon_screen = "shuttle"
	circuit = null

	var/shuttle_tag  // Used to coordinate data in shuttle controller.
	var/hacked = 0   // Has been emagged, no access restrictions.

	var/skip_act = FALSE
	var/tgui_subtemplate = "ShuttleControlConsoleDefault"
	var/ai_control = TRUE	//VOREStation Edit - AI/Borgs shouldn't really be flying off in ships without crew help //ChompStation Edit: Flying is better prevented by restricting the helm console if wanted. This is only an unnecessary nuisance that also breaks various other uses for the shuttle console.

/obj/machinery/computer/shuttle_control/attack_hand(user as mob)
	if(..(user))
		return
	//VOREStation Addition Start
	if(!ai_control && issilicon(user))
		to_chat(user, span_warning("Access Denied."))
		return TRUE
	//VOREStation Addition End

	//src.add_fingerprint(user)	//shouldn't need fingerprints just for looking at it.
	if(!allowed(user))
		to_chat(user, span_warning("Access Denied."))
		return 1

	tgui_interact(user)

/obj/machinery/computer/shuttle_control/proc/shuttlerich_tgui_data(var/datum/shuttle/autodock/shuttle)
	var/shuttle_state
	switch(shuttle.moving_status)
		if(SHUTTLE_IDLE) shuttle_state = "idle"
		if(SHUTTLE_WARMUP) shuttle_state = "warmup"
		if(SHUTTLE_INTRANSIT) shuttle_state = "in_transit"

	var/shuttle_status
	switch(shuttle.process_state)
		if(IDLE_STATE)
			var/cannot_depart = shuttle.current_location.cannot_depart(shuttle)
			if (shuttle.in_use)
				shuttle_status = "Busy."
			else if(cannot_depart)
				shuttle_status = cannot_depart
			else
				shuttle_status = "Standing-by at \the [shuttle.get_location_name()]."

		if(WAIT_LAUNCH, FORCE_LAUNCH)
			shuttle_status = "Shuttle has received command and will depart shortly."
		if(WAIT_ARRIVE)
			shuttle_status = "Proceeding to \the [shuttle.get_destination_name()]."
		if(WAIT_FINISH)
			shuttle_status = "Arriving at destination now."

	return list(
		"shuttle_status" = shuttle_status,
		"shuttle_state" = shuttle_state,
		"has_docking" = shuttle.shuttle_docking_controller ? 1 : 0,
		"docking_status" = shuttle.shuttle_docking_controller?.get_docking_status(),
		"docking_override" = shuttle.shuttle_docking_controller?.override_enabled,
		"can_launch" = shuttle.can_launch(),
		"can_cancel" = shuttle.can_cancel(),
		"can_force" = shuttle.can_force(),
		"docking_codes" = shuttle.docking_codes,
		"subtemplate" = tgui_subtemplate,
	)

// This is a subset of the actual checks; contains those that give messages to the user.
// This enables us to give nice error messages as well as not even bother proceeding if we can't.
/obj/machinery/computer/shuttle_control/proc/can_move(var/datum/shuttle/autodock/shuttle, var/user)
	var/cannot_depart = shuttle.current_location.cannot_depart(shuttle)
	if(cannot_depart)
		to_chat(user, span_warning("[cannot_depart]"))
		if(shuttle.debug_logging)
			log_shuttle("Shuttle [shuttle] cannot depart [shuttle.current_location] because: [cannot_depart].")
		return FALSE
	if(!shuttle.next_location.is_valid(shuttle))
		to_chat(user, span_warning("Destination zone is invalid or obstructed."))
		if(shuttle.debug_logging)
			log_shuttle("Shuttle [shuttle] destination [shuttle.next_location] is invalid.")
		return FALSE
	return TRUE

/obj/machinery/computer/shuttle_control/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE
	if(skip_act)
		return

	add_fingerprint(ui.user)

	var/datum/shuttle/autodock/shuttle = SSshuttles.shuttles[shuttle_tag]
	if(!istype(shuttle))
		to_chat(ui.user, span_warning("Unable to establish link with the shuttle."))
		return TRUE

	switch(action)
		if("move")
			if(can_move(shuttle, ui.user))
				shuttle.launch(src)
			return TRUE

		if("force")
			if(can_move(shuttle, ui.user))
				shuttle.force_launch(src)
			return TRUE

		if("cancel")
			shuttle.cancel_launch(src)
			return TRUE

		if("set_codes")
			var/newcode = tgui_input_text(ui.user, "Input new docking codes", "Docking codes", shuttle.docking_codes, MAX_NAME_LEN)
			newcode = sanitize(newcode,MAX_NAME_LEN)
			if(newcode && !..())
				shuttle.set_docking_codes(uppertext(newcode))
			return TRUE

/obj/machinery/computer/shuttle_control/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShuttleControl", "[shuttle_tag] Shuttle Control") // 470, 360
		ui.open()

// We delegate populating data to another proc to make it easier for overriding types to add their data.
/obj/machinery/computer/shuttle_control/tgui_data(mob/user)
	var/datum/shuttle/autodock/shuttle = SSshuttles.shuttles[shuttle_tag]
	if(!istype(shuttle))
		to_chat(user, span_warning("Unable to establish link with the shuttle."))
		return

	return shuttlerich_tgui_data(shuttle)

// Call to set the linked shuttle tag; override to add behaviour to shuttle tag changes
/obj/machinery/computer/shuttle_control/proc/set_shuttle_tag(var/new_shuttle_tag)
	if(shuttle_tag == new_shuttle_tag)
		return FALSE
	shuttle_tag = new_shuttle_tag
	return TRUE

/obj/machinery/computer/shuttle_control/emag_act(var/remaining_charges, var/mob/user)
	// Outpost 21 edit begin - Crash it or hack it
	var/choice = tgui_input_list(user,"Hack this console to unlock it or cause the shuttle to crash on its next flight.", "Emagged",list("Hack","Crash"))
	if(!Adjacent(user))
		return 0
	switch(choice)
		if("Hack")
			if(hacked)
				to_chat(user, span_warning("The console is already hacked."))
				return 0
			if(!hacked)
				req_access = list()
				req_one_access = list()
				hacked = 1
				to_chat(user, "You short out the console's ID checking system. It's now available to everyone!")
				return 1
		if("Crash")
			var/datum/shuttle/S = SSshuttles.shuttles[shuttle_tag]
			if(S.emagged_crash)
				to_chat(user, span_warning("The shuttle is already rigged to crash."))
				return 0
			if(!istype(S))
				to_chat(user, span_warning("Unable to establish link with the shuttle."))
				return 0
			S.emagged_crash = TRUE
			to_chat(user, "You short out the shuttles's launch systems. It won't last long now...")
			return 1
	return 0
	// Outpost 21 edit end

/obj/machinery/computer/shuttle_control/bullet_act(var/obj/item/projectile/Proj)
	visible_message("\The [Proj] ricochets off \the [src]!")

/obj/machinery/computer/shuttle_control/ex_act()
	return

/obj/machinery/computer/shuttle_control/emp_act()
	return


GLOBAL_LIST_BOILERPLATE(papers_dockingcode, /obj/item/paper/dockingcodes)
/hook/roundstart/proc/populate_dockingcodes()
	for(var/obj/item/paper/dockingcodes/dcp as anything in GLOB.papers_dockingcode)
		dcp.populate_info()
	return TRUE

/obj/item/paper/dockingcodes
	name = "Docking Codes"
	var/codes_from_z = null //So you can put codes from the station other places to give to antags or whatever

/obj/item/paper/dockingcodes/proc/populate_info()
	var/dockingcodes = null
	var/turf/T = get_turf(src)
	var/our_z
	if(T)
		our_z = T.z
	var/z_to_check = codes_from_z ? codes_from_z : our_z
	if(using_map.use_overmap)
		var/obj/effect/overmap/visitable/location = get_overmap_sector(z_to_check)
		if(location && location.docking_codes)
			dockingcodes = location.docking_codes

	if(!dockingcodes)
		info = "<center><h2>Daily Docking Codes</h2></center><br>The docking security system is down for maintenance. Please exercise caution when shuttles dock and depart."
	else
		info = "<center><h2>Daily Docking Codes</h2></center><br>The docking codes for this shift are '[dockingcodes]'.<br>These codes are secret, as they will allow hostile shuttles to dock with impunity if discovered.<br>"
	info_links = info
	icon_state = "paper_words"
