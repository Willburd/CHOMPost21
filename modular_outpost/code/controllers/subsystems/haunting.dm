/// WE THE SPOOKY STATION
#define MODE_CALM 0
#define MODE_CONCERN 1
#define MODE_UNNERVING 2
#define MODE_SPOOKY	3
#define MODE_SCARY 4
#define MODE_SUPERSPOOKY 5

#define MODE_SIZE 250

SUBSYSTEM_DEF(haunting)
	name = "Haunting"
	wait = 0.8 SECONDS
	VAR_PRIVATE/haunt_score = 0
	VAR_PRIVATE/world_mode = MODE_CALM
	dependencies = list(
		/datum/controller/subsystem/mobs
	)
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	VAR_PRIVATE/list/current_influences = list()
	VAR_PRIVATE/static/list/influences = list(
		HAUNTING_BLESSING	= -2,
		HAUNTING_RESLEEVE 	= -0.9,
		HAUNTING_COMFORT 	= -0.05,
		HAUNTING_UNSETTLE 	=  0.05,
		HAUNTING_BLOOD 		=  0.2,
		HAUNTING_GHOSTS		=  0.5,
		HAUNTING_DEATH		=  0.9
	)

	VAR_PRIVATE/new_score = 0
	VAR_PRIVATE/next_haunt_time = 0
	VAR_PRIVATE/last_event = ""
	VAR_PRIVATE/datum/weakref/current_player_target = null
	VAR_PRIVATE/list/hauntings = list()
	var/datum/station_haunt/current_haunt = null
	var/total_haunts = 0 // ACTUAL haunting count, and not just the list of events fired like prior_haunts is!
	VAR_PRIVATE/list/prior_haunts = list()

	var/list/used_haunt_entities = list()

/datum/controller/subsystem/haunting/Initialize()
	hauntings["[MODE_CALM]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/lurker,
		/datum/station_haunt/distant_alarm,
		/datum/station_haunt/camera_stare
		)
	hauntings["[MODE_CONCERN]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/lights_off,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/distant_scream,
		/datum/station_haunt/distant_alarm,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/vent_crawler,
		/datum/station_haunt/shuttle_move,
		/datum/station_haunt/change_nearby_display,
		/datum/station_haunt/camera_stare
		)
	hauntings["[MODE_UNNERVING]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/ghost_write,
		/datum/station_haunt/lights_off,
		/datum/station_haunt/banging_windows,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/vent_bugs,
		/datum/station_haunt/whispering_vents,
		/datum/station_haunt/heard_name,
		/datum/station_haunt/lock_doors,
		/datum/station_haunt/tesh_rush,
		/datum/station_haunt/tesh_encircle,
		/datum/station_haunt/distant_scream,
		/datum/station_haunt/distant_alarm,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/heavy_breath,
		/datum/station_haunt/throw_item,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/vent_crawler,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/shuttle_move,
		/datum/station_haunt/lurker/can_appear,
		/datum/station_haunt/change_nearby_display,
		/datum/station_haunt/camera_stare
		)
	hauntings["[MODE_SPOOKY]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/ghost_write,
		/datum/station_haunt/haunt_area,
		/datum/station_haunt/screaming_vents,
		/datum/station_haunt/banging_windows,
		/datum/station_haunt/vent_bugs,
		/datum/station_haunt/whispering_vents,
		/datum/station_haunt/heard_name,
		/datum/station_haunt/light_smash,
		/datum/station_haunt/trip_apc,
		/datum/station_haunt/lock_doors,
		/datum/station_haunt/tesh_rush,
		/datum/station_haunt/tesh_encircle,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/heavy_breath,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/blood_rain,
		/datum/station_haunt/shuttle_move,
		/datum/station_haunt/lurker/can_appear,
		/datum/station_haunt/change_nearby_display,
		/datum/station_haunt/camera_stare
		)
	hauntings["[MODE_SCARY]"] = list(
		/datum/station_haunt/ghost_write,
		/datum/station_haunt/haunt_area,
		/datum/station_haunt/screaming_vents,
		/datum/station_haunt/banging_windows,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/vent_bugs,
		/datum/station_haunt/smashing_windows,
		/datum/station_haunt/heard_name,
		/datum/station_haunt/light_smash,
		/datum/station_haunt/trip_apc,
		/datum/station_haunt/lock_doors,
		/datum/station_haunt/tesh_rush,
		/datum/station_haunt/tesh_encircle,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/vent_crawler,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/blood_rain,
		/datum/station_haunt/lurker/can_appear,
		/datum/station_haunt/lurker/pyromanic,
		/datum/station_haunt/camera_stare
		)
	hauntings["[MODE_SUPERSPOOKY]"] = list(
		/datum/station_haunt/ghost_write,
		/datum/station_haunt/screaming_vents,
		/datum/station_haunt/banging_windows,
		/datum/station_haunt/smashing_windows,
		/datum/station_haunt/light_smash,
		/datum/station_haunt/trip_apc,
		/datum/station_haunt/lock_doors,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/throw_item,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/blood_rain,
		/datum/station_haunt/lurker/will_appear,
		/datum/station_haunt/lurker/pyromanic,
		/datum/station_haunt/distant_alarm,
		/datum/station_haunt/camera_stare,
		/datum/station_haunt/tesh_encircle,
		/datum/station_haunt/shuttle_sabotage,
		/datum/station_haunt/entity_spawn
		)

	next_haunt_time = world.time + (rand(15,30) MINUTES) // No instant ghosts
	return SS_INIT_SUCCESS

/datum/controller/subsystem/haunting/stat_entry(msg)
	msg = "Score: [haunt_score] | Mode: [world_mode] | Change: [new_score] | Who: [current_player_target?.resolve()] | Event: [last_event][current_haunt ? "" : "(finished)"] | Total: [total_haunts]/[prior_haunts.len]"
	return ..()

/datum/controller/subsystem/haunting/fire()
	if(isnull(current_player_target?.resolve()) || prob(2))
		find_player_target()
	weigh_haunting()
	perform_haunt()

/datum/controller/subsystem/haunting/proc/intense_world_haunt()
	SHOULD_NOT_OVERRIDE(TRUE)
	haunt_score = MODE_SIZE / 2
	world_mode += 1
	if(world_mode > MODE_SUPERSPOOKY)
		world_mode = MODE_SUPERSPOOKY
	message_admins("Haunting level increased to [world_mode]")

/datum/controller/subsystem/haunting/proc/reduce_world_haunt()
	SHOULD_NOT_OVERRIDE(TRUE)
	haunt_score = MODE_SIZE / 2
	world_mode -= 1
	if(world_mode < MODE_CALM)
		world_mode = MODE_CALM
	message_admins("Haunting level decreased to [world_mode]")

/datum/controller/subsystem/haunting/proc/reset_world_haunt()
	SHOULD_NOT_OVERRIDE(TRUE)
	world_mode = MODE_CALM
	haunt_score = 0

/datum/controller/subsystem/haunting/proc/get_world_haunt()
	SHOULD_NOT_OVERRIDE(TRUE)
	return world_mode

/datum/controller/subsystem/haunting/proc/find_player_target()
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/mob/potential = get_random_player()
	if(!potential)
		return
	if(isnewplayer(potential))
		return
	if(potential.away_from_keyboard || isAI(potential) || potential.is_incorporeal())
		return
	current_player_target = WEAKREF(potential)

/datum/controller/subsystem/haunting/proc/clear_player_target()
	SHOULD_NOT_OVERRIDE(TRUE)
	current_player_target = null

/datum/controller/subsystem/haunting/proc/get_player_target()
	SHOULD_NOT_OVERRIDE(TRUE)
	var/mob/M = current_player_target?.resolve()
	if(!M || M.away_from_keyboard || !M.client || M.is_incorporeal() || istype(M.loc,/obj/belly))
		clear_player_target()
		return null
	var/turf/T = get_turf(M) // check for holy turf!
	var/area/A = get_area(T) // Dorm check
	if(!T || T.holy || (A.flag_check(AREA_FORBID_EVENTS)))
		clear_player_target()
		return null
	return M

/datum/controller/subsystem/haunting/proc/force_player_target(var/mob/potential)
	clear_player_target()
	if(!potential)
		return FALSE
	if(isnewplayer(potential))
		return FALSE
	if(potential.away_from_keyboard || isAI(potential) || potential.is_incorporeal())
		return FALSE
	current_player_target = WEAKREF(potential)
	return TRUE

/datum/controller/subsystem/haunting/proc/get_random_player()
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!GLOB.player_list.len)
		return null
	return pick(GLOB.player_list)

/datum/controller/subsystem/haunting/proc/get_world_haunt_attention(var/mob/M,var/notice_chance)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(isnewplayer(M))
		return
	if(!M || M.away_from_keyboard || !M.client || M.is_incorporeal())
		return
	if(!isnull(current_haunt)) // not during another event
		return
	if(!prob(notice_chance)) // we're probably gonna call it with a prob() anyway
		return
	clear_player_target()
	current_player_target = WEAKREF(M)

/datum/controller/subsystem/haunting/proc/get_haunt_area()
	SHOULD_NOT_OVERRIDE(TRUE)
	var/area/targ_area = pick(subtypesof(/area))
	var/mob/targ = current_player_target?.resolve()
	if(targ)
		var/turf/T = get_turf(targ)
		if(!(T.z in using_map.station_levels))
			clear_player_target() // not useful to us anymore
			return null
		targ_area = get_area(targ)
	return targ_area

/datum/controller/subsystem/haunting/proc/weigh_haunting()
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	// Accumulated haunts
	new_score = rand(-0.02,0.005)
	for(var/key in influences)
		if(!current_influences[key])
			continue
		new_score += current_influences[key] * influences[key] // number counter * multiplier of event spookyness
	current_influences.Cut()
	haunt_score += new_score

	// Change mode
	if(haunt_score >= MODE_SIZE)
		intense_world_haunt()
		return
	if(haunt_score <= 0)
		reduce_world_haunt()
		return

/datum/controller/subsystem/haunting/proc/station_is_haunted()
	SHOULD_NOT_OVERRIDE(TRUE)
	return world_mode >= MODE_SUPERSPOOKY

/datum/controller/subsystem/haunting/proc/start_haunt(var/forced = FALSE)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!forced)
		if(!isnull(current_haunt))
			return
		if(world.time < next_haunt_time)
			return
		next_haunt_time = world.time + (rand(40,400) SECONDS)
		var/skip_prob = 80
		if(world_mode >= MODE_UNNERVING)
			skip_prob = 85
		if(world_mode >= MODE_SUPERSPOOKY)
			skip_prob = 75
		if(prob(skip_prob))
			return
	else
		if(!isnull(current_haunt))
			current_haunt.end()
	// swapping players
	switch(world_mode)
		// Idly mess with players
		if(MODE_CALM)
			if(prob(30))
				clear_player_target()
				log_haunting("SEARCH")
				return
		if(MODE_CONCERN)
			if(prob(10))
				clear_player_target()
				log_haunting("SEARCH")
				return
		// Rarely allow spikes of activity
		if(MODE_UNNERVING)
			if(prob(5))
				clear_player_target()
				log_haunting("SEARCH")
				return
			if(prob(1))
				intense_world_haunt()
				log_haunting("INTENSIFTY")
			if(prob(1))
				intense_world_haunt()
				log_haunting("INTENSIFTY")
			if(prob(1))
				intense_world_haunt()
				log_haunting("INTENSIFTY")
		// Past here we try to clear the haunting state
		if(MODE_SCARY)
			if(prob(10))
				clear_player_target()
				log_haunting("SEARCH")
				return
			if(prob(1))
				intense_world_haunt()
				log_haunting("INTENSIFTY")
			if(prob(1))
				reset_world_haunt()
				log_haunting("RESET")
				return
		if(MODE_SUPERSPOOKY)
			if(prob(20))
				clear_player_target()
				log_haunting("SEARCH")
				return
			if(prob(5))
				reset_world_haunt()
				log_haunting("RESET")
				return
	var/mob/M = current_player_target?.resolve()
	if(isnull(M))
		return
	// Players in the dark are treated worse
	var/bonus = world_mode
	var/turf/T = get_turf(M)
	if(!T || T.holy) // Check for holy turfs too
		clear_player_target()
		log_haunting("BLOCKED")
		return
	if(T.get_lumcount() < 0.2)
		bonus += 1
	else
		// players in the light sometimes get a free pass even this late
		if(prob(5) && !forced)
			log_haunting("SKIP")
			return
	if(bonus > MODE_SUPERSPOOKY)
		bonus = MODE_SUPERSPOOKY
	var/list/haunts = hauntings["[bonus]"]
	set_haunting(pick(haunts),TRUE)

/datum/controller/subsystem/haunting/proc/perform_haunt()
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(isnull(current_haunt))
		start_haunt()
	if(isnull(current_haunt))
		return
	current_haunt.fire()

/datum/controller/subsystem/haunting/proc/influence(var/type)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(isnull(current_influences[type]))
		current_influences[type] = 0
	current_influences[type] += 1

/datum/controller/subsystem/haunting/proc/set_haunting(var/path)
	SHOULD_NOT_OVERRIDE(TRUE)
	// has to handle a verb input too...
	if(!path)
		return
	if(current_haunt)
		return
	var/list/all_haunt = subtypesof(/datum/station_haunt)
	if(!(path in all_haunt))
		return
	current_haunt = new path()
	total_haunts++

/datum/controller/subsystem/haunting/proc/log_haunting(var/LE,var/notify_admin = FALSE)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/mob/M = current_player_target?.resolve()
	if(M)
		prior_haunts.Add("[stationtime2text()] | [world_mode] | \the [M] - [LE]")
		last_event = "\the [M] - [LE]"
		if(notify_admin)
			message_admins("Haunting: [stationtime2text()] | [world_mode] | \the [M] - [LE]")
	else
		prior_haunts.Add("[stationtime2text()] | [world_mode] | NO TARGET - [LE]")
		last_event = "NO TARGET - [LE]"
		if(notify_admin)
			message_admins("Haunting: [stationtime2text()] | [world_mode] | NO TARGET - [LE]")

#undef MODE_SIZE

#undef MODE_CALM
#undef MODE_CONCERN
#undef MODE_UNNERVING
#undef MODE_SPOOKY
#undef MODE_SCARY
#undef MODE_SUPERSPOOKY
