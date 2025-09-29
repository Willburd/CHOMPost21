/datum/component/hear_dead
	var/mob/our_listener

/datum/component/hear_dead/Initialize()
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	our_listener = parent
	RegisterSignal(SSdcs, COMSIG_OUTPOST_HEAR_DEAD, PROC_REF(hear_dead))
	// TODO - Popup a tutorial message saying not to abuse this

/datum/component/hear_dead/Destroy(force)
	UnregisterSignal(SSdcs, COMSIG_OUTPOST_HEAR_DEAD)
	our_listener = null
	. = ..()

/datum/component/hear_dead/proc/hear_dead(mob/source, message)
	SIGNAL_HANDLER
	var/turf/our_turf = get_turf(our_listener)
	var/turf/ghost_turf = get_turf(source)
	var/dist = our_turf.Distance(ghost_turf)
	var/say_sound = pick(list("whimpers","cries","whispers","gasps"))
	if(our_listener.stat != CONSCIOUS)
		return
	if(dist > 11)
		return
	if(dist > 8)
		if(prob(60))
			return
		to_chat(our_listener, span_deadsay("Something distant [say_sound], \"[Gibberish(message, 100)]\""))
		return
	if(dist > 4)
		if(prob(30))
			return
		to_chat(our_listener, span_deadsay("Something close [say_sound], \"[Gibberish(message, 50)]\""))
		return
	to_chat(our_listener, span_deadsay("Something beside you [say_sound], \"[Gibberish(message, 20)]\""))
