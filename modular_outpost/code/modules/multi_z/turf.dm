/turf/simulated/open
	var/datum/looping_sound/weather/wind/cavern_hole/soundloop

/turf/simulated/open/Initialize(mapload)
	. = ..()
	if(is_lethal_fall()) // Uggghhh this is going to suck for init time
		for(var/turf/simulated/open/check in orange(5, src))
			if(check.soundloop) // Drop out early if we have a soundloop already around us
				return
		soundloop = new(list(src), FALSE)
		soundloop.start()

/turf/simulated/open/Destroy()
	if(soundloop)
		soundloop.stop()
		QDEL_NULL(soundloop)
	. = ..()

/turf/simulated/open/proc/is_lethal_fall()
	if(!HasBelow(z))
		return FALSE
	// Recursively look for lethal fall holes
	var/turf/beneath = GetBelow(src)
	while(beneath)
		if(beneath.z in using_map.deadly_fall_levels)
			return TRUE
		if(!HasBelow(z))
			return FALSE
		if(!isopenspace(beneath))
			return FALSE
		beneath = GetBelow(beneath)
