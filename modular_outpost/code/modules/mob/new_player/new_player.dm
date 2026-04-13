/mob/new_player/proc/equip_robot_accessories(mob/living/silicon/robot/bot)
	if(!(bot?.client?.prefs))
		return
	// Add rank
	if(isAI(bot))
		bot.accessories += new /obj/item/clothing/accessory/rank_eshui/ai(bot)
	else if(istype(bot, /mob/living/silicon/robot/drone) || istype(bot.mmi, /obj/item/mmi/digital/robot))
		bot.accessories += new /obj/item/clothing/accessory/rank_eshui/drone(bot)
	else
		bot.accessories += new /obj/item/clothing/accessory/rank_eshui/borg(bot)

	// Add medals
	var/list/active_gear_list = LAZYACCESS(bot.client.prefs.gear_list, "[bot.client.prefs.gear_slot]")
	for(var/thing in active_gear_list)
		var/datum/gear/G = GLOB.gear_datums[thing]
		if(!G) //Not a real gear datum (maybe removed, as this is loaded from their savefile)
			continue
		if(!(G.path in subtypesof(/obj/item/clothing/accessory)))
			continue
		var/obj/item/clothing/accessory/access = G.path
		if(!access.allow_borg)
			continue
		var/metadata = active_gear_list[G.display_name]
		bot.accessories += G.spawn_item(bot, metadata)
