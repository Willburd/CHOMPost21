// We want our version of radio listening to consider the view as well, and not just being around the radio
/proc/get_mobs_in_radio_ranges(var/list/obj/item/radio/radios)

	. = list()
	// Returns a list of mobs who can hear any of the radios given in @radios
	for(var/obj/item/radio/R as anything in radios)
		if(get_turf(R))
			var/list/current_batch = list()

			// Get all turfs with stuff in it that could be listening
			for(var/turf/T in R.can_broadcast_to())
				for (var/atom/movable/hearing in T)
					if (hearing.recursive_listeners)
						current_batch |= hearing.recursive_listeners

			// We only want mobs who can reasonably hear us to get radio messages
			for(var/mob/M in current_batch)
				if(!M.client || !(R in view(world.view,get_turf(M))))
					current_batch -= M

			. |= current_batch

	for (var/mob/M as anything in .)
		if (!istype(M) || !M.client)
			. -= M
	for (var/mob/observer/O in GLOB.player_list)
		. |= O
