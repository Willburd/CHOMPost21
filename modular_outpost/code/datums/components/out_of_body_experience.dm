// Spawns a clone of the character at a bad body location, puts them in charge of it, then waits a bit to swap them back to their real body
/datum/component/out_of_body_experience
	VAR_PRIVATE/mob/living/carbon/human/badbody
	VAR_PRIVATE/cached_key
	VAR_PROTECTED/leave_body = TRUE
	VAR_PROTECTED/landmark_id = "badbody"
	VAR_PROTECTED/min_time = 10 SECONDS
	VAR_PROTECTED/max_time = 20 SECONDS

// Leaves no badbody behind
/datum/component/out_of_body_experience/no_bad_body
	leave_body = FALSE

// Special evil one
/datum/component/out_of_body_experience/no_bad_body/shadow_realm
	landmark_id = "halluspawn"
	min_time = 15 SECONDS
	max_time = 35 SECONDS

// Nightmare man
/datum/component/out_of_body_experience/no_bad_body/nightmare_man
	landmark_id = "halluspawn"
	min_time = 25 SECONDS
	max_time = 45 SECONDS

/datum/component/out_of_body_experience/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	var/list/spawn_locations = list()
	for(var/obj/effect/landmark/C in GLOB.landmarks_list)
		if(C.name == landmark_id)
			spawn_locations.Add(get_turf(C))
	// Check if valid
	var/mob/living/carbon/human/host = parent
	if(!length(spawn_locations) || !host.client || !meets_badbody_criteria(host.client) || host.away_from_keyboard)
		QDEL_IN(src, 1)
		return
	var/turf/T = pick(spawn_locations)
	if(!T)
		QDEL_IN(src, 1)
		return
	// Validhunt
	var/datum/event/badbody/env = new(external_use = TRUE) // The fact someone already coded a fix as external_use is a godsend
	cached_key = host.ckey
	badbody = env.spawn_body(host.client,T)
	spawn(1)
		if(!badbody || !host.client)
			QDEL_IN(src, 1)
			return
		if(badbody.real_name != host.real_name) // Why you LYIINNNGGGG
			QDEL_NULL(badbody)
			QDEL_IN(src, 1)
			return
		badbody.ckey = cached_key // Swap!
		badbody.revive() // UGH
		qdel(env)
		log_world("## DEBUG: successfully spawned out of body experience [badbody.real_name] at [T.x] [T.y] [T.z].")
		addtimer(CALLBACK(src, PROC_REF(return_to_original)), rand(min_time, max_time), TIMER_DELETE_ME)

/datum/component/out_of_body_experience/Destroy(force)
	. = ..()
	badbody = null

/datum/component/out_of_body_experience/proc/return_to_original()
	var/mob/living/carbon/human/host = parent
	if(QDELETED(host))
		log_world("## DEBUG: failed return on out of body experience for [badbody.real_name].")
		qdel(src) // Welp, guess you live here now. This should probably never happen because of host Destroy() works
		return
	// Check if we returned to our body
	host.ckey = cached_key
	if(!host.client)
		// Retry
		addtimer(CALLBACK(src, PROC_REF(return_to_original)), rand(3,5) SECONDS, TIMER_DELETE_ME)
		return
	// Finish with the final present...
	log_world("## DEBUG: successfully finished out of body experience [host.real_name].")
	if(leave_body)
		var/datum/component/badbody/B = badbody.AddComponent(/datum/component/badbody)
		B.harm_body()
	else
		QDEL_NULL(badbody)
	qdel(src)
