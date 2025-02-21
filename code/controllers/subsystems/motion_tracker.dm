SUBSYSTEM_DEF(motiontracker)
	name = "Motion Tracker"
	flags = SS_NO_TICK_CHECK

/datum/controller/subsystem/motiontracker/stat_entry(msg)
	msg = ""
	return ..()

/datum/controller/subsystem/motiontracker/fire(resumed = 0)
	return

/datum/controller/subsystem/motiontracker/proc/ping(var/atom/source, var/hear_chance = 30)
	var/turf/T = get_turf(source)
	if(!isturf(T)) // ONLY call from turfs
		return
	if(!prob(hear_chance))
		return
	if(hear_chance <= 30)
		T = get_step(T,pick(cardinal))
		if(!T) // incase...
			return
	SEND_SIGNAL(src, COMSIG_MOVABLE_MOTIONTRACKER, WEAKREF(source), T)
