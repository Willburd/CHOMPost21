/datum/admin_secret_item/final_solution/summon_allisclean
	name = "Summon All Is Clean"

/datum/admin_secret_item/final_solution/summon_allisclean/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/choice = tgui_alert(user, "You sure you want to end the round and summon All Is Clean at your location? Misuse of this could result in removal of flags or hilarity.","WARNING!",list("ALL IS CLEAN", "Cancel"))
	if(choice == "ALL IS CLEAN")
		new /obj/singularity/allisclean(get_turf(user))
		for(var/mob/living/L in player_list)
			L.say("All will be clean.")
		command_announcement.Announce("Attention [station_name()]. Unidentified energy signals detected on all frequencies, are you seeing these readings-- All will be clean. --What was that!? ", new_sound = 'modular_outpost/sound/misc/allisclean.ogg')
		log_and_message_admins("has summoned All Is Clean, nothing can escape his scrubbing power.", user)
