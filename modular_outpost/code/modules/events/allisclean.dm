/datum/event/allisclean
	startWhen	= 0
	endWhen		= 600

/datum/event/allisclean/start()
	command_announcement.Announce("Attention [station_name()]. Unidentified energy signals detected on all frequencies, are you seeing these readings-- All will be clean. --What was that!? ", new_sound = 'modular_outpost/sound/misc/allisclean.ogg')
	for(var/mob/living/L in player_list)
		L.say("All will be clean.")
	var/list/spots = list()
	for(var/obj/effect/landmark/start/sloc in landmarks_list)
		if(sloc.name == "Janitor")
			spots += sloc
	if(spots.len)
		new /obj/singularity/allisclean(pick(spots))

/datum/event/allisclean/end()
