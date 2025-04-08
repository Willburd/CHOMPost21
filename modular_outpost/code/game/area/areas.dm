/area
	var/broken_light_chance = -1 // if -1 use light's own breaking chance, if above use this instead, including 0.
	var/haunted = FALSE // area has unique behaviors for certain objects. Makes it scary!
	var/use_maint_night_color = FALSE // If it uses alternate nightshift colors
	var/use_emergency_overlay = FALSE // If area flashes red when station is in a state of emergency (only hallways did this before!)
	var/obj/effect/map_effect/interval/fire_supression/fire_supress = null

/area/maintenance
	use_maint_night_color = TRUE

/area/mine
	use_maint_night_color = TRUE

/area/proc/fire_supression_set(var/enable)
	if(enable)
		// spawn supression
		if(fire_supress)
			return
		fire_supress = new(src,src)
		return
	// end supression
	if(!fire_supress)
		return
	qdel_null(fire_supress)
