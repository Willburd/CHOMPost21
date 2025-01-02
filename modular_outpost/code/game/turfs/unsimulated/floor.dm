/turf/unsimulated/deathdrop
	// overridable, instantkill floors
	name = "floor"
	icon = 'icons/turf/open_space.dmi'
	icon_state = "black_open"
	var/death_message = "You fall to an unavoidable death."

/turf/unsimulated/deathdrop/Entered(atom/A)
	spawn(0)
		if(A.is_incorporeal())
			return
		if(istype( A, /atom/movable))
			var/atom/movable/AM = A
			if(!AM.can_fall()) // flying checks
				return
		if(ismob( A))
			to_chat( A, span_danger(death_message))
		qdel(A)
