/datum/event/launch_rocket
	announceWhen = 2
	startWhen = 10

/datum/event/launch_rocket/announce()
	if(!GLOB.outpost_rocket_pods.len)
		return
	var/list/targets = list(" chunk of orbital debris"," rogue asteroid","n incoming dronepod","n enemy kinetic weapon","n enemy reconnaissance device")
	GLOB.command_announcement.Announce("A[pick(targets)]'s trajectory has been discovered on short-range scanners. Launching surface-to-space countermeasures.", "Artillery Subsystem")

/datum/event/launch_rocket/start()
	if(!GLOB.outpost_rocket_pods.len)
		return
	var/obj/structure/prop/war/tgmc_missile_rack/rocket = pick(GLOB.outpost_rocket_pods)
	if(rocket)
		rocket.fire_rocket()
