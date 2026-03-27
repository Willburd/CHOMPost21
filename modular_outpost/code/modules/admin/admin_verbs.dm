ADMIN_VERB(test_haunting_controller, R_EVENT, "Test Station Haunting", "Selects a haunting subsystem event to begin.", ADMIN_CATEGORY_EVENTS)
	var/mob/ply = tgui_input_list(usr,"Select player to haunt","Select Player", GLOB.player_list)
	if(!isliving(ply))
		return
	if(SShaunting.force_player_target(ply))
		var/list/all_haunt = subtypesof(/datum/station_haunt)
		SShaunting.set_haunting(tgui_input_list(usr,"Select haunting type","Select Haunt",all_haunt))

ADMIN_VERB(spawn_bad_body, R_EVENT, "Spawn Badbody", "Spawns a badbody haunting from a selectable list of the current crew.", ADMIN_CATEGORY_EVENTS)
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

ADMIN_VERB(escape_shuttle_force, R_EVENT, "Safely Move Escape Shuttle", "Forces the escape shuttle to move to and from the station without triggering round end.", ADMIN_CATEGORY_EVENTS)
	if(SSemergency_shuttle.shuttle.moving_status == SHUTTLE_INTRANSIT)
		to_chat(usr,"The shuttle is moving, please wait till it arrives to send it back with this verb.")
		return

	// MUST be called to avoid round-end
	SSemergency_shuttle.admin_override_mode = TRUE
	SSemergency_shuttle.evac = FALSE
	SSemergency_shuttle.autopilot = FALSE
	SSemergency_shuttle.shuttle.launch(usr)

ADMIN_VERB(make_red_exit, R_EVENT, "Make Redspace Exit Portal", "Allows players to escape from redspace. Spawns at your location", ADMIN_CATEGORY_EVENTS)
	var/turf/epicenter = usr.loc
	if(!epicenter)
		return
	create_redspace_wormhole( epicenter, epicenter, TRUE, 15 SECONDS, 45 SECONDS)

/* DO NOT USE THIS UNLESS TESTING
ADMIN_VERB(base_all_turfs, R_ADMIN, "All Turf To Base", "OH GOD NO.", ADMIN_CATEGORY_DEBUG_DANGEROUS)
	for(var/turf/T in world)
		var/turf/nw = get_base_turf_by_area(T)
		if(istype(nw,/turf/simulated/open) && (!HasBelow(T.z) || T.z == 1))
			admin_notice("Turf at [T.x].[T.y].[T.z] [get_area(T)]: becomes illegal openspace")
			continue
		var/planet = null
		if(T.z <= SSplanets.z_to_planet.len && SSplanets.z_to_planet[T.z])
			planet = SSplanets.z_to_planet[T.z]
		if((planet && istype(nw,/turf/space)) || istype(nw,/turf/unsimulated))
			admin_notice("Turf at [T.x].[T.y].[T.z] [get_area(T)]: is illegal, is a [T.type]")
			continue
		T.ChangeTurf(nw)
*/
