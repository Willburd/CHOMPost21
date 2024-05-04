/obj/effect/map_effect/interval/redspaceexitcontroller
	name = "red space exit spawn controller"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	// used to spawn portals at /obj/effect/landmark/redspacestart locations
	always_run = TRUE
	interval_lower_bound = 15 SECONDS
	interval_upper_bound = 30 SECONDS
	var/list/redexitlist = list()


/obj/effect/map_effect/interval/redspaceexitcontroller/trigger()
	if(redexitlist.len == 0)
		// Lets only do this once
		for(var/obj/effect/landmark/R in landmarks_list)
			if(R.name == "redentrance")
				redexitlist += R
	// Pick a random portal location, or spawn one at this controller as a fallback
	if(redexitlist.len > 0)
		create_redspace_wormhole( pick(redexitlist).loc, pick(redexitlist).loc, TRUE, 15 SECONDS, 45 SECONDS)
	else
		create_redspace_wormhole( src.loc, src.loc, TRUE, 20, 30) // short portal time shows something is wrong.
