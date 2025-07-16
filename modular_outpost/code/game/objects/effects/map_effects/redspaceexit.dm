/obj/effect/map_effect/interval/redspaceexitcontroller
	name = "red space exit spawn controller"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	// used to spawn portals at /obj/effect/landmark/redspacestart locations
	always_run = TRUE
	interval_lower_bound = 15 SECONDS
	interval_upper_bound = 30 SECONDS

	var/static/list/redexitlist = list()

/obj/effect/map_effect/interval/redspaceexitcontroller/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/map_effect/interval/redspaceexitcontroller/LateInitialize()
	// Lets only do this once
	redexitlist.Cut()
	for(var/obj/effect/landmark/R in GLOB.landmarks_list)
		if(R.name == "redentrance")
			redexitlist += get_turf(R)

/obj/effect/map_effect/interval/redspaceexitcontroller/trigger()
	// Pick a random portal location, or spawn one at this controller as a fallback
	if(redexitlist.len > 0)
		var/turf/L = pick(redexitlist)
		create_redspace_wormhole( L, L, TRUE, 15 SECONDS, 45 SECONDS)
	else
		var/turf/T = get_turf(src)
		create_redspace_wormhole( T, T, TRUE, 20, 30) // short portal time shows something is wrong.
