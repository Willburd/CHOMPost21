//
// Crashable shuttle. Boom etc.
//

/datum/shuttle
	var/list/crash_locations = null
	var/crash_message = "Oops. The shuttle blew up."	// Announcement made when shuttle crashes
	var/allow_short_crashes = FALSE // Outpost 21 edit - if shuttle can crash doing short jumps
	var/emagged_crash = FALSE // Outpost 21 edit - Emagging shuttles to crash

/datum/shuttle/New()
	if(crash_locations)
		var/crash_location_ids = crash_locations
		crash_locations = list()
		for(var/location_tag in crash_location_ids)
			var/obj/effect/shuttle_landmark/L = SSshuttles.get_landmark(location_tag)
			if(L)
				crash_locations += L
	..()

// Return 0 to let the jump continue, 1 to abort the jump.
// Default implementation checks if the shuttle should crash and if so crashes it.
/datum/shuttle/proc/process_longjump(var/obj/effect/shuttle_landmark/intended_destination)
	if(should_crash(intended_destination))
		do_crash(intended_destination)
		return 1

// Decide if this is the time we crash.  Return true for yes
/datum/shuttle/proc/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
	return FALSE

// Actually crash the shuttle
/datum/shuttle/proc/do_crash(var/obj/effect/shuttle_landmark/intended_destination)
	// Choose the target

	// Outpost 21 edit begin - Ensure we don't clobber ourselves when we crash, and Crash sites unique to this destination.
	var/list/discard_list = list()
	if(intended_destination)
		// Use local crash sites!
		for(var/location_tag in intended_destination.local_crash_sites)
			var/obj/effect/shuttle_landmark/L = SSshuttles.get_landmark(location_tag)
			if(L)
				discard_list += L

	// Use shuttle base crash sites too
	if(crash_locations)
		discard_list += crash_locations

	// Try to do find a site!
	var/obj/effect/shuttle_landmark/target = pick(discard_list)
	while(discard_list.len)
		var/turf/T = get_turf(target)
		var/turf/ourT = get_turf(current_location)
		// Found one!
		if(T.z != ourT.z || T.Distance(ourT) > 20)
			break
		// Remove offending one and try again
		discard_list -= target
		if(discard_list.len <= 0) // Giveup
			target = intended_destination // If all else fails crash at our landing site
			break
		target = pick(discard_list)

	ASSERT(istype(target))

	// Blow up the target area?
	//command_announcement.Announce(departure_message,(announcer ? announcer : "[using_map.boss_name]"))

	//What people are we dealing with here
	var/list/victims = list()
	for(var/area/A in shuttle_area)
		for(var/mob/living/L in A)
			victims += L
			shake_camera(L,2 SECONDS,4)

	//SHAKA SHAKA SHAKA
	addtimer(CALLBACK(src, PROC_REF(after_crash), victims, target), 2 SECONDS)

/datum/shuttle/proc/after_crash(var/list/victims, var/obj/effect/shuttle_landmark/target)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)

	// Move the shuttle
	if (!attempt_move(target))
		return // Lucky!

	// Hide people
	for(var/mob/living/L as anything in victims)
		victims[L] = get_turf(L)
		L.Sleeping(rand(10,20))
		L.Life()
		L.loc = null

	// Blow up the shuttle
	var/list/shuttle_turfs = list()
	for(var/area/A in shuttle_area)
		shuttle_turfs += get_area_turfs(A)
	// Outpost 21 edit begin - Better shuttle crashing
	var/max_boom = shuttle_turfs.len / 16 // Bigger shuttle = bigger boom
	for(var/i = 1 to max_boom)
		var/turf/epicenter = pick(shuttle_turfs)
		var/boomsize = rand(3,6)
		explosion(epicenter, 0, boomsize / 3, boomsize, boomsize*2)
	// Outpost 21 edit begin - Better shuttle crashing
	moving_status = SHUTTLE_CRASHED
	command_announcement.Announce("[crash_message]", "Shuttle Alert")

	// Put people back
	for(var/mob/living/L as anything in victims)
		L.loc = victims[L]
		L.adjustBruteLoss(5)
		L.adjustBruteLoss(10)
		L.adjustBruteLoss(15)

	SShaunting.intense_world_haunt() // Outpost 21 edit - It da spooky station!
