SUBSYSTEM_DEF(motiontracker)
	name = "Motion Tracker"
	priority = FIRE_PRIORITY_MOTIONTRACKER
	wait = 2 SECOND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/min_range = 2
	var/max_range = 8
	var/list/used_this_tick = list()

/datum/controller/subsystem/motiontracker/stat_entry(msg)
	msg = "Es: [used_this_tick.len]"
	return ..()

/datum/controller/subsystem/motiontracker/fire(resumed = 0)
	if(!resumed)
		used_this_tick.Cut()

/datum/controller/subsystem/motiontracker/proc/ping(var/atom/source, var/hear_chance = 30)
	var/turf/T = get_turf(source)
	if(!isturf(T)) // ONLY call from turfs
		return
	if(!prob(hear_chance))
		return
	if(hear_chance <= 40)
		T = get_step(T,pick(cardinal))
		if(!T) // incase...
			return
	if(used_this_tick["[REF(T)]"] && hear_chance < 60) // Reduce spam of same tile events
		return
	used_this_tick["[REF(T)]"] = TRUE
	SEND_SIGNAL(src, COMSIG_MOVABLE_MOTIONTRACKER, WEAKREF(source), T)
