ADMIN_VERB(test_haunting_controller, R_EVENT, "Test Station Haunting", "Selects a haunting subsystem event to begin.", ADMIN_CATEGORY_EVENTS)
	var/mob/ply = tgui_input_list(user,"Select player to haunt","Select Player", GLOB.player_list)
	if(!isliving(ply))
		return
	if(SShaunting.force_player_target(ply))
		var/list/all_haunt = subtypesof(/datum/station_haunt)
		SShaunting.set_haunting(tgui_input_list(user,"Select haunting type","Select Haunt",all_haunt))

ADMIN_VERB(pause_haunting_controller, R_EVENT, "Toggle Station Hauntings", "Pauses and resumes the haunting controller.", ADMIN_CATEGORY_EVENTS)
	SShaunting.is_paused = !SShaunting.is_paused
	to_chat(user, "haunting controller [SShaunting.is_paused ? "PAUSED" : "RESUMED"]")
	log_world("## DEBUG: haunting controller [SShaunting.is_paused ? "PAUSED" : "RESUMED"]")

ADMIN_VERB(spawn_bad_body, R_EVENT, "Spawn Badbody", "Spawns a badbody haunting from a selectable list of the current crew.", ADMIN_CATEGORY_EVENTS)
	var/list/checks = list()
	for(var/client/C in GLOB.clients)
		if(C)
			checks["[C.ckey]"] = C
	var/CK = tgui_input_list(user,"Choose a client to spawn a body from","Bad body spawn",checks)
	if(!CK)
		return
	var/client/spawn_client = checks[CK]
	var/datum/event/badbody/env = new(external_use = TRUE) // The fact someone already coded a fix as external_use is a godsend
	var/turf/T = get_turf(user.mob.loc)
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
		to_chat(user,"The shuttle is moving, please wait till it arrives to send it back with this verb.")
		return

	// MUST be called to avoid round-end
	SSemergency_shuttle.admin_override_mode = TRUE
	SSemergency_shuttle.evac = FALSE
	SSemergency_shuttle.autopilot = FALSE
	SSemergency_shuttle.shuttle.launch(user)

ADMIN_VERB(make_red_exit, R_EVENT, "Make Redspace Exit Portal", "Allows players to escape from redspace. Spawns at your location", ADMIN_CATEGORY_EVENTS)
	var/turf/epicenter = user.mob.loc
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

ADMIN_VERB_AND_CONTEXT_MENU(creepyradiomessage, R_EVENT, "Creepy Radio Message", "Force a radio to state a message.", ADMIN_CATEGORY_EVENTS, obj/item/radio/R in world)
	var/mob/current = user.mob
	if(!current)
		return
	// Prepare the message
	var/voice_name = tgui_input_text(user, "Enter the name of the voice speaking", "Say Name","Unknown", MAX_NAME_LEN)
	if(!voice_name)
		return
	var/speak_verb = tgui_input_text(user, "The verb used to describe what is being says, ex: says, states, whispers, roars, screams.", "Say Verb","Says", MAX_NAME_LEN)
	if(!speak_verb)
		return
	var/message = tgui_input_text(user, "The contents of the message. Can include language keys.", "Say Message","", MAX_MESSAGE_LEN, encode = FALSE)
	if(!message)
		return
	var/list/message_pieces = current.parse_languages(message)
	if(istype(message_pieces, /datum/multilingual_say_piece)) // No hivemind stuff please
		return
	if(!LAZYLEN(message_pieces))
		return

	// Transmit the message directly to the specific radio
	var/unknown_message = message_to_multilingual(pick(list("crackles","buzzes","garbles"))) // If the message cannot be understood
	var/datum/radio_frequency/connection = SSradio.return_frequency(PUB_FREQ)
	Broadcast_Message(connection, current, FALSE, unknown_message, null, message_pieces, voice_name, voice_name, voice_name, voice_name, DATA_FAKE, 0, list(0), PUB_FREQ, speak_verb, list(R))

	// We don't need the rest of saycode. So we also need to log what was said as well.
	current.log_talk(message, LOG_SAY, color="#c0c0c0")
