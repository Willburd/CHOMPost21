/client/proc/test_haunting_controller()
	set name = "Test Station Haunting"
	set desc = "Selects a haunting subsystem event to begin."
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN|R_EVENT))
		return
	var/mob/ply = tgui_input_list(usr,"Select player to haunt","Select Player", GLOB.player_list)
	if(!isliving(ply))
		return
	if(SShaunting.force_player_target(ply))
		var/list/all_haunt = subtypesof(/datum/station_haunt)
		SShaunting.set_haunting(tgui_input_list(usr,"Select haunting type","Select Haunt",all_haunt))

/client/proc/spawn_bad_body()
	set name = "Spawn Badbody"
	set desc = "Spawns a badbody haunting from a selectable list of the current crew."
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN|R_EVENT))
		return

	var/list/checks = list()
	for(var/client/C in GLOB.clients)
		if(C)
			checks["[C.ckey]"] = C
	var/CK = tgui_input_list(usr,"Choose a client to spawn a body from","Bad body spawn",checks)
	if(!CK)
		return
	var/client/spawn_client = checks[CK]
	var/datum/event/badbody/env = new(external_use = TRUE) // The fact someone already coded a fix as external_use is a godsend
	var/turf/T = get_turf(usr.loc)
	if(!T)
		return

	var/mob/living/carbon/human/badbody = env.spawn_body(spawn_client,T)
	spawn(1)
		var/datum/component/badbody/B = badbody.AddComponent(/datum/component/badbody)
		B.harm_body()
		B.set_items()
		log_world("## DEBUG: successfully spawned badbody [badbody.real_name] at [T.x] [T.y] [T.z].")
		qdel(env)

/client/proc/escape_shuttle_force()
	set name = "Safely Move Escape Shuttle"
	set desc = "Forces the escape shuttle to move to and from the station without triggering round end."
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN|R_EVENT))
		return
	if(emergency_shuttle.shuttle.moving_status == SHUTTLE_INTRANSIT)
		to_chat(usr,"The shuttle is moving, please wait till it arrives to send it back with this verb.")
		return

	// MUST be called to avoid round-end
	emergency_shuttle.admin_override_mode = TRUE
	emergency_shuttle.evac = FALSE
	emergency_shuttle.autopilot = FALSE
	emergency_shuttle.shuttle.launch(usr)
