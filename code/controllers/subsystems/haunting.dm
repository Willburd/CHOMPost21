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
	VAR_PRIVATE/haunt_score = MODE_SIZE / 2
	VAR_PRIVATE/world_mode = MODE_CALM
	init_order = INIT_ORDER_HAUNTING
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	VAR_PRIVATE/list/current_influences = list()
	VAR_PRIVATE/static/list/influences = list(
		HAUNTING_RESLEEVE 	= -0.4,
		HAUNTING_COMFORT 	= -0.1,
		HAUNTING_UNSETTLE 	=  0.1,
		HAUNTING_BLOOD 		=  0.3,
		HAUNTING_GHOSTS		=  0.9,
		HAUNTING_DEATH		=  1.2
	)

	VAR_PRIVATE/new_score = 0
	VAR_PRIVATE/next_haunt_time = 0
	VAR_PRIVATE/last_event = ""
	VAR_PRIVATE/datum/weakref/current_player_target = null
	VAR_PRIVATE/list/hauntings = list()
	var/datum/station_haunt/current_haunt = null
	var/total_haunts = 0

	var/list/used_haunt_entities = list()

/datum/controller/subsystem/haunting/Initialize()
	hauntings["[MODE_CALM]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/lurker
		)
	hauntings["[MODE_CONCERN]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/lights_off,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/distant_scream,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/vent_crawler,
		/datum/station_haunt/shuttle_move,
		/datum/station_haunt/lurker
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
		/datum/station_haunt/distant_scream,
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/heavy_breath,
		/datum/station_haunt/throw_item,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/vent_crawler,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/shuttle_move,
		/datum/station_haunt/lurker/can_appear
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
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/heavy_breath,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/blood_rain,
		/datum/station_haunt/entity_spawn,
		/datum/station_haunt/shuttle_move,
		/datum/station_haunt/lurker/can_appear
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
		/datum/station_haunt/open_nearby_door,
		/datum/station_haunt/hallucinate,
		/datum/station_haunt/knock_down,
		/datum/station_haunt/vent_crawler,
		/datum/station_haunt/bleeding,
		/datum/station_haunt/blood_rain,
		/datum/station_haunt/lurker/can_appear,
		/datum/station_haunt/lurker/pyromanic,
		/datum/station_haunt/entity_spawn,
		/datum/station_haunt/entity_spawn
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
		/datum/station_haunt/entity_spawn,
		/datum/station_haunt/entity_spawn,
		/datum/station_haunt/entity_spawn,
		/datum/station_haunt/entity_spawn,
		/datum/station_haunt/entity_spawn
		)

	next_haunt_time = world.time + (rand(15,30) MINUTES) // No instant ghosts
	return SS_INIT_SUCCESS

/datum/controller/subsystem/haunting/stat_entry(msg)
	msg = "Score: [haunt_score] | Mode: [world_mode] | Change: [new_score] | Who: [current_player_target?.resolve()] | Event: [last_event][current_haunt ? "" : "(finished)"] | Total: [total_haunts]"
	return ..()

/datum/controller/subsystem/haunting/fire()
	if(isnull(current_player_target?.resolve()) || prob(2))
		find_player_target()
	weigh_haunting()
	perform_haunt()

/datum/controller/subsystem/haunting/proc/intense_world_haunt()
	world_mode += 1
	if(world_mode > MODE_SUPERSPOOKY)
		world_mode = MODE_SUPERSPOOKY

/datum/controller/subsystem/haunting/proc/reset_world_haunt()
	world_mode = MODE_CALM
	haunt_score = 0

/datum/controller/subsystem/haunting/proc/find_player_target()
	var/mob/potential = get_random_player()
	if(!potential)
		return
	if(potential.away_from_keyboard || isAI(potential) || potential.is_incorporeal())
		return
	current_player_target = WEAKREF(potential)

/datum/controller/subsystem/haunting/proc/clear_player_target()
	current_player_target = null

/datum/controller/subsystem/haunting/proc/get_player_target()
	var/mob/M = current_player_target?.resolve()
	if(!M || M.away_from_keyboard || !M.client || M.is_incorporeal())
		clear_player_target()
		return null
	return M

/datum/controller/subsystem/haunting/proc/get_random_player()
	if(!global.player_list.len)
		return null
	return pick(global.player_list)

/datum/controller/subsystem/haunting/proc/get_world_haunt_attention(var/mob/M,var/notice_chance)
	if(!M || M.away_from_keyboard || !M.client || M.is_incorporeal())
		return
	if(!isnull(current_haunt)) // not during another event
		return
	if(!prob(notice_chance)) // we're probably gonna call it with a prob() anyway
		return
	clear_player_target()
	current_player_target = WEAKREF(M)

/datum/controller/subsystem/haunting/proc/get_haunt_area()
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
	// Accumulated haunts
	new_score = rand(-0.09,0.05)
	for(var/key in influences)
		if(!current_influences[key])
			continue
		new_score += current_influences[key] * influences[key] // number counter * multiplier of event spookyness
	current_influences.Cut()
	haunt_score += new_score

	// Change mode
	if(haunt_score >= MODE_SIZE)
		world_mode += 1
		haunt_score = MODE_SIZE / 2
		if(world_mode > MODE_SUPERSPOOKY)
			world_mode = MODE_SUPERSPOOKY
		return
	if(haunt_score <= 0)
		world_mode -= 1
		haunt_score = MODE_SIZE / 2
		if(world_mode < MODE_CALM)
			world_mode = MODE_CALM
		return

/datum/controller/subsystem/haunting/proc/station_is_haunted()
	return world_mode >= MODE_SUPERSPOOKY

/datum/controller/subsystem/haunting/proc/start_haunt(var/forced = FALSE)
	if(!forced)
		if(!isnull(current_haunt))
			return
		if(world.time < next_haunt_time)
			return
		next_haunt_time = world.time + (rand(40,600) SECONDS)
		var/skip_prob = 80
		if(world_mode >= MODE_UNNERVING)
			skip_prob = 75
		if(world_mode >= MODE_SUPERSPOOKY)
			skip_prob = 65
		if(prob(skip_prob))
			last_event = "SKIP"
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
				last_event = "SEARCH"
				return
		if(MODE_CONCERN)
			if(prob(10))
				clear_player_target()
				last_event = "SEARCH"
				return
		// Rarely allow spikes of activity
		if(MODE_UNNERVING)
			if(prob(5))
				clear_player_target()
				last_event = "SEARCH"
				return
			if(prob(1))
				intense_world_haunt()
			if(prob(1))
				intense_world_haunt()
			if(prob(1))
				intense_world_haunt()
		// Past here we try to clear the haunting state
		if(MODE_SCARY)
			if(prob(10))
				clear_player_target()
				last_event = "SEARCH"
				return
			if(prob(5))
				reset_world_haunt()
				last_event = "RESET"
				return
		if(MODE_SUPERSPOOKY)
			if(prob(5))
				clear_player_target()
				last_event = "SEARCH"
				return
			if(prob(15))
				reset_world_haunt()
				last_event = "RESET"
				return
	var/mob/M = current_player_target?.resolve()
	if(isnull(M))
		return
	// Players in the dark are treated worse
	var/bonus = world_mode
	var/turf/T = get_turf(M)
	if(T.get_lumcount() < 0.2)
		bonus += 1
	else
		// players in the light sometimes get a free pass even this late
		if(prob(5) && !forced)
			last_event = "SKIP"
			return
	if(bonus > MODE_SUPERSPOOKY)
		bonus = MODE_SUPERSPOOKY
	var/list/haunts = hauntings["[bonus]"]
	set_haunting(pick(haunts))

/datum/controller/subsystem/haunting/proc/perform_haunt()
	if(isnull(current_haunt))
		start_haunt()
	if(isnull(current_haunt))
		return
	current_haunt.fire()

/datum/controller/subsystem/haunting/proc/influence(var/type)
	if(isnull(current_influences[type]))
		current_influences[type] = 0
	current_influences[type] += 1

/datum/controller/subsystem/haunting/proc/set_haunting(var/path)
	// has to handle a verb input too...
	if(!path)
		return
	if(current_haunt)
		return
	var/list/all_haunt = subtypesof(/datum/station_haunt)
	if(!(path in all_haunt))
		return
	current_haunt = new path()
	last_event = current_haunt.name
	total_haunts++

#undef MODE_SIZE

#undef MODE_CALM
#undef MODE_CONCERN
#undef MODE_UNNERVING
#undef MODE_SPOOKY
#undef MODE_SCARY
#undef MODE_SUPERSPOOKY
