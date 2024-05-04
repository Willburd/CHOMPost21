/datum/map
	var/static/list/event_levels = list() // Events happen on these levels, even if not part of station!
	var/static/list/forced_airmix_levels = list() // z-levels where airmix slowly resets if outdoors, prevents saturating the atmosphere