/proc/create_redspace_wormhole(var/turf/enter as turf, var/turf/exit as turf, var/is_return_portal, var/min_duration = 30 SECONDS, var/max_duration = 60 SECONDS)
	set waitfor = FALSE
	var/obj/effect/portal/portal_redspace/P = new /obj/effect/portal/portal_redspace( enter )
	P.target = exit
	P.creator = null
	P.failchance = 0
	P.name = "wormhole"
	if(is_return_portal)
		P.icon = 'icons/effects/effects.dmi'
		P.icon_state = "rift"
		P.return_portal = is_return_portal
		P.set_light(4, 9, "#d678d7")
	spawn(rand(min_duration,max_duration))
		qdel(P)
