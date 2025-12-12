/datum/component/haunting_vision

/datum/component/haunting_vision/Initialize()
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/haunting_vision/RegisterWithParent()
	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(handle_comp))

/datum/component/haunting_vision/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_LIVING_LIFE)


// Signal handlers
//////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/component/haunting_vision/proc/handle_comp()
	SIGNAL_HANDLER
	var/mob/living/owner = parent
	if(!owner.client)
		return
	if(owner.stat == DEAD) //dead, don't process.
		return
	if(prob(60))
		return
	var/area/A = get_area(owner)
	if(!A || !A.haunted)
		return
	// Place at root turf offset from signal responder's turf using px offsets. So it will show up over visblocking.
	var/list/icos = list("redgate_hole","slash","red_static","drain","summoning")
	var/image/client_only/motion_echo/E = new /image/client_only/motion_echo('icons/effects/effects.dmi', get_turf(owner), pick(icos), OBFUSCATION_LAYER, SOUTH)
	var/rand_limit = 300
	E.pixel_x += rand(-rand_limit,rand_limit)
	E.pixel_y += rand(-rand_limit,rand_limit)
	E.append_client(owner.client)
	animate(E, alpha = 0,time = 1 SECOND)
