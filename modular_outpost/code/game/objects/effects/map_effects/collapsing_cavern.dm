GLOBAL_LIST_EMPTY(collapsing_cave_effects)

/obj/effect/map_effect/interval/collapsing_cavern
	name = "collapsing cave"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "warnmarker"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 50 SECONDS
	interval_upper_bound = 300 SECONDS

	var/collapsing = FALSE
	var/vital_support = FALSE

/obj/effect/map_effect/interval/collapsing_cavern/Initialize(mapload)
	. = ..()
	if(!GLOB.areas_by_type[/area/mine/unexplored/sinkhole])
		CRASH("ILLEGAL SETUP OF /obj/effect/map_effect/interval/collapsing_cavern. AREA /area/mine/unexplored/sinkhole MUST EXIST")

	// Only open ground counts
	var/turf/check_turf = get_turf(src)
	if(!ismineralturf(check_turf) || check_turf.density)
		return INITIALIZE_HINT_QDEL

	// If mining the turf above us triggers collapse
	var/turf/above_turf = GetAbove(check_turf)
	if(ismineralturf(above_turf) && above_turf.density)
		vital_support = TRUE

/obj/effect/map_effect/interval/collapsing_cavern/proc/collapse()
	collapsing = TRUE
	interval_lower_bound = 6 SECONDS
	interval_upper_bound = 20 SECONDS

/obj/effect/map_effect/interval/collapsing_cavern/proc/breaking_turf(var/turf/T,var/turf/under)
	if(prob(40))
		T.visible_message(pick(list("\The [src] creaks...","\The [src] groans...","\The [src] twists under tension...")))
		return
	if(!prob(20))
		return
	var/area/A = get_area(T)
	if(!istype(A,/area/mine/unexplored/sinkhole))
		ChangeArea(T, GLOB.areas_by_type[/area/mine/unexplored/sinkhole]) // Kinda jankass, needed for baseturf change
	if(prob(20))
		explosion(under,1,1,2,0)
	if(!prob(40))
		return
	// Break area
	var/area/AF = get_area(T)
	if(prob(30))
		T.visible_message("\The [src] gives way!")
	T.ChangeTurf(AF.base_turf)

/obj/effect/map_effect/interval/collapsing_cavern/trigger()
	var/turf/our_turf = get_turf(src)
	if(!collapsing)
		// We shouldn't bother
		if(!vital_support)
			return
		// Check if we should break
		var/turf/above_turf = GetAbove(our_turf)
		if(ismineralturf(above_turf) && !above_turf.density)
			collapse()
		return

	// Get highest Z
	var/turf/break_turf
	var/turf/T = GetAbove(our_turf)
	while(HasAbove(T.z))
		// Check if we should break
		if(!isopenspace(T))
			break_turf = T
			break
		// Next
		T = GetAbove(T)

	// break turfs and cause a collapse slowly!
	if(break_turf)
		breaking_turf(break_turf,our_turf)
		return

	// We've broken them all, SPREAD and stop ourselves
	for(var/D in GLOB.cardinal)
		var/turf/poke = get_step(our_turf,D)
		var/obj/effect/map_effect/interval/collapsing_cavern/C = locate(/obj/effect/map_effect/interval/collapsing_cavern) in poke
		C?.collapse()
	qdel(src) // done


// MUST BE MAPPED INTO MISC LEVEL
// THIS AREA MUST EXIST ON WORLD LOAD
// Change area on collapse
/area/mine/unexplored/sinkhole
	name = "\improper Sink Hole"
	base_turf = /turf/simulated/open
	sound_env = SOUND_ENVIRONMENT_PARKING_LOT
	flags = AREA_BLOCK_GHOST_SIGHT|AREA_FLAG_IS_NOT_PERSISTENT
	icon_state = "dk_yellow"
	color_grading = COLORTINT_DIM
