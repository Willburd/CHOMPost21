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

/mob/living/carbon/human/motiontracker_unsubscribe()
	// Block unsub if our species has vibration senses
	if(species?.has_vibration_sense)
		return
	. = ..()

// For COMSIG_MOVABLE_MOTIONTRACKER
/mob/proc/handle_motion_tracking(mob/source, var/datum/weakref/RW, var/turf/T)
	SIGNAL_HANDLER
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	var/atom/echo_source = RW?.resolve()
	if(stat) // Ded
		return
	if(!echo_source || get_dist(src,echo_source) > SSmotiontracker.max_range  || get_dist(src,echo_source) < SSmotiontracker.min_range  || src.z != echo_source.z)
		return
	if(!client || echo_source == src) // Not ours
		return
	if(T.get_lumcount() >= 0.20 && can_see(src, T, 7)) // cheaper than oviewers
		return // we already see it
	var/rand_limit = 12
	var/turf/root = get_turf(src)
	var/xx = (T.x - root.x) * 32 // px offsets
	var/yy = (T.y - root.y) * 32 // px offsets
	xx += rand(-rand_limit,rand_limit)
	yy += rand(-rand_limit,rand_limit)
	var/image/currentimage = image('icons/effects/effects.dmi',root,"shuttle_warning",OBFUSCATION_LAYER, pixel_x = xx, pixel_y = yy)
	currentimage.plane = PLANE_FULLSCREEN
	src << currentimage
	QDEL_IN(currentimage, 2 SECONDS)
