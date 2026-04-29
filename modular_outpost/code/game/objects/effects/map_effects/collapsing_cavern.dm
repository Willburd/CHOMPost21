GLOBAL_LIST_EMPTY(collapsing_cave_effects)

/obj/effect/map_effect/interval/collapsing_cavern
	name = "collapsing cave"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "warnmarker"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 50 SECONDS
	interval_upper_bound = 300 SECONDS

	var/collapse_strength = 6
	var/collapsing = FALSE
	var/vital_support = FALSE
	var/static/list/valid_types = list(/turf/simulated/mineral, /turf/simulated/floor/plating, /turf/simulated/wall, /turf/simulated/floor/tiled, /turf/simulated/floor/wood, /turf/simulated/floor/carpet)

/obj/effect/map_effect/interval/collapsing_cavern/instant_collapse/Initialize(mapload)
	. = ..()
	collapse()

/obj/effect/map_effect/interval/collapsing_cavern/Initialize(mapload)
	. = ..()
	if(!GLOB.areas_by_type[/area/mine/unexplored/sinkhole])
		CRASH("ILLEGAL SETUP OF /obj/effect/map_effect/interval/collapsing_cavern. AREA /area/mine/unexplored/sinkhole MUST EXIST")
	// If mining the turf above us triggers collapse
	var/turf/check_turf = get_turf(src)
	var/turf/above_turf = GetAbove(check_turf)
	if(ismineralturf(above_turf) && above_turf.density)
		vital_support = TRUE
	GLOB.collapsing_cave_effects.Add(src)
	collapse_strength += rand(-2,2)

/obj/effect/map_effect/interval/collapsing_cavern/Destroy()
	if(!collapsing)
		GLOB.collapsing_cave_effects.Remove(src)
	. = ..()

/obj/effect/map_effect/interval/collapsing_cavern/proc/collapse()
	collapsing = TRUE
	interval_lower_bound = 10 SECONDS
	interval_upper_bound = 40 SECONDS
	GLOB.collapsing_cave_effects.Remove(src) // No longer relevant for events

/obj/effect/map_effect/interval/collapsing_cavern/ex_act()
	collapse()

/obj/effect/map_effect/interval/collapsing_cavern/proc/breaking_turf(var/turf/T,var/turf/under)
	if(prob(40))
		T.visible_message(pick(list("\The [T] creaks...","\The [T] groans...","\The [T] twists under tension...")))
		if(prob(70))
			if(istype(T, /turf/simulated/mineral))
				playsound(T, 'sound/mecha/bigmech_lstep.ogg', 70, 1)
			else
				playsound(T, 'sound/machines/door/airlock_creaking.ogg', 70, 1)
		return
	var/area/A = get_area(T)
	if(!istype(A,/area/mine/unexplored/sinkhole))
		ChangeArea(T, GLOB.areas_by_type[/area/mine/unexplored/sinkhole]) // Kinda jankass, needed for baseturf change
	if(prob(10))
		explosion(under,0,1,2,0)
		explosion(T,0,0,1,0)
	if(prob(20))
		return
	// Break area
	var/area/AF = get_area(T)
	for(var/obj/machinery/M in T.contents)
		M.fall_apart()
	for(var/obj/O in T.contents)
		O.ex_act(1)
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
		if(!above_turf.density)
			collapse()
		return

	// break turfs and cause a collapse slowly!
	var/turf/our_above = GetAbove(our_turf)
	if(is_type_in_list(our_above, valid_types))
		breaking_turf(our_above,our_turf)
		if(collapse_strength > 0)
			for(var/D in GLOB.cardinal)
				var/turf/poke = get_step(our_turf,D)
				if(poke.density)
					continue
				var/turf/above_poke = GetAbove(poke)
				if(isopenspace(above_poke) || !is_type_in_list(above_poke, valid_types))
					continue
				var/obj/effect/map_effect/interval/collapsing_cavern/collapse = new(poke)
				collapse.collapse_strength = collapse_strength-rand(1,2)
				if(prob(20))
					collapse.collapse_strength += 1 // extend it
				collapse.collapse()
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
