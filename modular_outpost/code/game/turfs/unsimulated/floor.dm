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
		// Outpost 21 edit(port) begin - multi-loc objects need to check if it's their actual loc, and not just a corner!
		if(!istype(src,/turf/unsimulated/deathdrop)) // If we stopped being a death drop, shuttles etc
			return
		if(ismovable(A))
			var/atom/movable/AM = A
			if(AM.locs.len > 1 && AM.loc != src)
				return
		// Outpost 21 edit end
		if(istype( A, /atom/movable))
			var/atom/movable/AM = A
			if(!AM.can_fall()) // flying checks
				return
		if(ismob( A))
			to_chat( A, span_danger(death_message))
		qdel(A)
