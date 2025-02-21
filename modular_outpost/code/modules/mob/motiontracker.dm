/mob
	VAR_PRIVATE/is_motion_tracking = FALSE // Prevent multiple unsubs and resubs, lets traits check if we should resub

/mob/proc/has_motiontracking() // USE THIS
	return is_motion_tracking

// Subscribing and unsubscribingto the motion tracker subsystem
/mob/proc/motiontracker_subscribe()
	if(!is_motion_tracking)
		is_motion_tracking = TRUE
		RegisterSignal(SSmotiontracker, COMSIG_MOVABLE_MOTIONTRACKER, PROC_REF(handle_motion_tracking))

/mob/proc/motiontracker_unsubscribe()
	if(is_motion_tracking)
		is_motion_tracking = FALSE
		UnregisterSignal(SSmotiontracker, COMSIG_MOVABLE_MOTIONTRACKER)

// For COMSIG_MOVABLE_MOTIONTRACKER
/mob/proc/handle_motion_tracking(mob/source, var/datum/weakref/RW, var/turf/T)
	SIGNAL_HANDLER
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	var/atom/echo_source = RW?.resolve()
	if(!echo_source || get_dist(src,echo_source) > 7 || src.z != echo_source.z)
		return
	if(!client || echo_source == src) // Not ours
		return
	var/obj/effect/motion_echo/E = new/obj/effect/motion_echo(T)
	E.send_echo(src) // ping!

// Actual effect that spawns the client side echo images
/obj/effect/motion_echo
	icon = null
	icon_state = null
	name = ""
	desc = ""
	density = FALSE
	anchored = TRUE
	var/image/currentimage = null

/obj/effect/motion_echo/Initialize(mapload)
	. = ..()
	QDEL_IN(src, 3 SECONDS)

/obj/effect/motion_echo/proc/send_echo(var/atom/caller)
	if(currentimage)
		return
	var/rand_limit = 16
	currentimage = image('icons/effects/effects.dmi',loc,"shuttle_warning",HUD_LAYER,rand(-rand_limit,rand_limit),rand(-rand_limit,rand_limit))
	currentimage.plane = PLANE_STATUS // Above vis
	if(caller)
		caller << currentimage // send to ONLY our client

/obj/effect/motion_echo/Destroy()
	. = ..()
	qdel_null(currentimage)
