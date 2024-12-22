/datum/event/ghost_manifest/start()
	if(!observer_mob_list.len)
		return
	var/mob/observer/dead/D = pick(observer_mob_list)
	if(D && istype(D,/mob/observer/dead))
		D.manifest()
