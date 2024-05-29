/area
	var/broken_light_chance = -1 // if -1 use light's own breaking chance, if above use this instead, including 0.
	var/haunted = FALSE // area has unique behaviors for certain objects. Makes it scary!
	var/use_maint_night_color = FALSE // If it uses alternate nightshift colors

/area/maintenance
	use_maint_night_color = TRUE
