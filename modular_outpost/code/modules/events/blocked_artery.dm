/datum/event/blocked_artery
	announceWhen = -1
	var/turf/simulated/flesh/artery/toob

/datum/event/blocked_artery/setup()
	endWhen = rand(5, 10)
	if(length(GLOB.terraformer_arteries))
		toob = pick(GLOB.terraformer_arteries)

/datum/event/blocked_artery/start()
	if(!toob || !toob.density)
		return
	toob.cause_blockage()

	var/str = "A blockage has been detected within the terraformer circulatory system. Blockage isolated to junction \"[toob.junction_id]\", located at \[[toob.x].[toob.y].[using_map.get_zlevel_name(toob.z)]\]. Repairs to the terraforming unit have maximum priority."
	GLOB.global_announcer.autosay(str, "Terraformer System Monitor", CHANNEL_COMMAND)
	GLOB.global_announcer.autosay(str, "Terraformer System Monitor", CHANNEL_MEDICAL)
	GLOB.global_announcer.autosay(str, "Terraformer System Monitor", CHANNEL_ENGINEERING)
