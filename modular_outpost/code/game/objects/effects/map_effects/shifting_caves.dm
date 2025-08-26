#define CAVE_CHANGE_RANGE 12
GLOBAL_LIST_EMPTY(shifting_cave_effects)

/obj/effect/map_effect/interval/shifting_cave
	name = "closing_cave"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 7 SECONDS
	interval_upper_bound = 20 SECONDS

	light_color = "#eccb0d"

	var/player_detected = FALSE
	var/before_turf_path = /turf/simulated/mineral/floor
	var/after_turf_path = /turf/simulated/mineral
	var/list/turf/additional_turfs = list()

/obj/effect/map_effect/interval/shifting_cave/Initialize(mapload)
	..()
	GLOB.shifting_cave_effects += src
	return INITIALIZE_HINT_LATELOAD

/obj/effect/map_effect/interval/shifting_cave/LateInitialize()
	if(QDELETED(src))
		return
	var/turf/T = get_turf(src)
	before_turf_path = T.type
	for(var/obj/effect/map_effect/interval/shifting_cave/SC in GLOB.shifting_cave_effects)
		if(SC == src)
			continue
		var/turf/find_turf = get_turf(SC)
		if(T.Distance(find_turf) > CAVE_CHANGE_RANGE)
			continue
		if(find_turf.type != before_turf_path)
			continue
		additional_turfs += find_turf
		qdel(SC)

/obj/effect/map_effect/interval/shifting_cave/Destroy()
	GLOB.shifting_cave_effects -= src
	. = ..()

/obj/effect/map_effect/interval/shifting_cave/trigger()
	var/see_player = FALSE
	for(var/mob/M in orange(CAVE_CHANGE_RANGE,get_turf(src)))
		if(!M.client)
			continue
		if(M.is_incorporeal())
			continue
		if(isobserver(M))
			continue
		player_detected = TRUE
		see_player = TRUE
		break

	if(!player_detected)
		return
	if(!see_player)
		for(var/turf/T in additional_turfs)
			if(T.type != before_turf_path)
				continue
			T.ChangeTurf(after_turf_path)
		qdel(src)

/obj/effect/map_effect/interval/shifting_cave/opening
	before_turf_path = /turf/simulated/mineral/floor
	after_turf_path = /turf/simulated/mineral


// Map types
/obj/effect/map_effect/interval/shifting_cave/muriki
	before_turf_path = /turf/simulated/mineral/floor/turfpack/muriki
	after_turf_path = /turf/simulated/mineral/turfpack/muriki

/obj/effect/map_effect/interval/shifting_cave/opening/muriki
	before_turf_path = /turf/simulated/mineral/turfpack/muriki
	after_turf_path = /turf/simulated/mineral/floor/turfpack/muriki

#undef CAVE_CHANGE_RANGE
