// TODO - Upport this all upstream for future maintenance
/proc/check_radio_jammers(turf/Tr)
	if(!Tr || !length(GLOB.active_radio_jammers))
		return null

	for(var/obj/item/radio_jammer/J as anything in GLOB.active_radio_jammers)
		// Component
		if(istype(J, /datum/component/radio_jammer))
			var/datum/component/radio_jammer/comp = J
			var/turf/Tcj = comp.get_host_turf()
			if(!Tcj)
				continue
			if(Tcj.z != Tr.z)
				continue
			var/dist = get_dist(Tcj,Tr)
			if(dist > comp.jam_range)
				continue
			return list("jammer" = comp, "distance" = dist)

		// Standard jammer
		var/turf/Tj = get_turf(J)
		if(J.on && Tj.z == Tr.z) //If we're on the same Z, it's worth checking.
			var/dist = get_dist(Tj,Tr)
			if(dist > J.jam_range)
				continue
			return list("jammer" = J, "distance" = dist)

	return null
