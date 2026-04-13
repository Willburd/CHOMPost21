/mob/new_player/proc/equip_robot_accessories(mob/living/silicon/robot/bot)
	if(!(bot?.client?.prefs))
		return
	// Give medals
	var/list/active_gear_list = LAZYACCESS(bot.client.prefs.gear_list, "[bot.client.prefs.gear_slot]")
	for(var/thing in active_gear_list)
		var/datum/gear/G = GLOB.gear_datums[thing]
		if(!G) //Not a real gear datum (maybe removed, as this is loaded from their savefile)
			continue
		if(G.slot != slot_tie)
			continue

	// Give rank
