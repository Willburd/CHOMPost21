/datum/event/weeping_statue
	announceWhen	= 90

/datum/event/weeping_statue/setup()
	announceWhen = rand(announceWhen, announceWhen + 60)

/datum/event/weeping_statue/announce()
	return // secret

/datum/event/weeping_statue/start()
	// Jump to a landmark if noone is looking at it
	var/list/jump_list = list()
	for(var/obj/effect/landmark/R in landmarks_list)
		if(R.name == "redexit")
			jump_list += R
	// Try picking randomy spots till we can!
	var/i = 20
	while(i-- > 0 && jump_list.len > 0)
		var/obj/effect/landmark/GOAL = pick(jump_list)
		jump_list.Remove(GOAL)
		var/list/scanlist = oviewers(12, GOAL)
		if(scanlist.len == 0)
			var/mob/living/simple_mob/animal/statue/S = new(GOAL.loc)
			S.player_has_activated = TRUE // More hostile, teleports if bored
			for(var/obj/machinery/light/L in oview(12, GOAL.loc))
				L.flicker(rand(20, 50))
				if(prob(40))
					L.broken()
			return
