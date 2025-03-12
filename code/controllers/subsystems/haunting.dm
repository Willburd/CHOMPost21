/// WE THE SPOOKY STATION
#define MODE_CALM 0
#define MODE_CONCERN 1
#define MODE_UNNERVING 2
#define MODE_SPOOKY	3
#define MODE_SCARY 4
#define MODE_SUPERSPOOKY 5

#define MODE_SIZE 30

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
		HAUNTING_BLOOD 		=  0.2,
		HAUNTING_DEATH		=  0.6,
		HAUNTING_GHOSTS		=  0.9
	)

	VAR_PRIVATE/next_haunt_time = 0
	VAR_PRIVATE/last_event = ""
	VAR_PRIVATE/datum/weakref/current_player_target = null
	VAR_PRIVATE/list/hauntings = list()
	var/datum/station_haunt/current_haunt = null

/datum/controller/subsystem/haunting/Initialize()
	hauntings["[MODE_CALM]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		)
	hauntings["[MODE_CONCERN]"] = list(
		/datum/station_haunt/light_flicker,
		/datum/station_haunt/lights_off,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/whispering_vents,
		/datum/station_haunt/heard_name,
		/datum/station_haunt/tesh_rush,
		/datum/station_haunt/distant_scream,
		/datum/station_haunt/open_nearby_door
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
		/datum/station_haunt/heavy_breath
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
		/datum/station_haunt/heavy_breath
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
		/datum/station_haunt/open_nearby_door
		)
	hauntings["[MODE_SUPERSPOOKY]"] = list(
		/datum/station_haunt/ghost_write,
		/datum/station_haunt/screaming_vents,
		/datum/station_haunt/banging_windows,
		/datum/station_haunt/watching_me,
		/datum/station_haunt/chills,
		/datum/station_haunt/smashing_windows,
		/datum/station_haunt/heard_name,
		/datum/station_haunt/light_smash,
		/datum/station_haunt/trip_apc,
		/datum/station_haunt/lock_doors,
		/datum/station_haunt/tesh_rush,
		/datum/station_haunt/open_nearby_door
		)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/haunting/stat_entry(msg)
	msg = "Score: [haunt_score] | Mode: [world_mode] | Who: [current_player_target?.resolve()] | Event: [last_event][current_haunt ? "" : "(finished)"]"
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
	if(!global.player_list.len)
		return
	var/mob/potential = pick(global.player_list)
	if(isAI(potential))
		return
	if(potential.away_from_keyboard)
		return
	current_player_target = WEAKREF(potential)

/datum/controller/subsystem/haunting/proc/clear_player_target()
	current_player_target = null

/datum/controller/subsystem/haunting/proc/get_player_target()
	var/mob/M = current_player_target?.resolve()
	if(M.away_from_keyboard || !M.client)
		clear_player_target()
		return null
	return M

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
	var/new_score = 0
	for(var/key in influences)
		if(!current_influences[key])
			continue
		new_score += current_influences[key] * influences[key] // number counter * multiplier of event spookyness
	current_influences.Cut()
	haunt_score += new_score
	haunt_score += rand(-0.001,0.001)

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

/datum/controller/subsystem/haunting/proc/start_haunt(var/forced = FALSE)
	if(!forced)
		if(!isnull(current_haunt))
			return
		if(world.time < next_haunt_time)
			return
		next_haunt_time = world.time + (rand(0.25,1.75) MINUTES)
		if(prob(99))
			return
	else
		if(!isnull(current_haunt))
			current_haunt.end()
	// swapping players
	switch(world_mode)
		// Idly mess with players
		if(MODE_CALM)
			if(prob(90))
				clear_player_target()
		if(MODE_CONCERN)
			if(prob(60))
				clear_player_target()
		// Rarely allow spikes of activity
		if(MODE_UNNERVING)
			if(prob(5))
				clear_player_target()
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
			if(prob(5))
				reset_world_haunt()
				return
		if(MODE_SUPERSPOOKY)
			if(prob(20))
				clear_player_target()
			if(prob(15))
				reset_world_haunt()
				return
	if(isnull(current_player_target?.resolve()))
		return
	var/list/haunts = hauntings["[world_mode]"]
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
	current_haunt.init()
	last_event = current_haunt.name

#undef MODE_CALM
#undef MODE_CONCERN
#undef MODE_UNNERVING
#undef MODE_SPOOKY
#undef MODE_SCARY
#undef MODE_SUPERSPOOKY
