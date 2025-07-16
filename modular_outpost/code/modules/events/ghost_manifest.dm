/datum/event/ghost_manifest/start()
	if(!GLOB.observer_mob_list.len)
		return
	var/mob/observer/dead/D = pick(GLOB.observer_mob_list)
	if(D && istype(D,/mob/observer/dead) && D.timeofdeath > 0 && D.icon_state != "brain1")
		D.manifest()
