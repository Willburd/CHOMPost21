/proc/resolve_multiloc_distance(atom/origin, atom/movable/the_target)
	var/distance = get_dist(origin, the_target)
	if(distance > 1 && istype(the_target) && length(the_target.locs) > 1)
		for(var/check_loc in the_target.locs) // Get our nearest loc
			var/check_dist = get_dist(origin, check_loc)
			if(check_dist < distance)
				distance = check_dist
	return distance

/proc/resolve_multiloc_adjacent(atom/origin, atom/movable/the_target, turf/check_turf)
	if(istype(the_target) && length(the_target.locs) > 1)
		for(var/turf/check_loc in the_target.locs)
			if(check_loc.AdjacentQuick(origin))
				return TRUE
		return FALSE
	return check_turf.AdjacentQuick(origin)
