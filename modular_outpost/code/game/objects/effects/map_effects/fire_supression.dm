// DO NOT MAP PLACE THESE
/obj/effect/map_effect/interval/fire_supression
	name = "fire supression"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"

	always_run = TRUE
	interval_lower_bound = 2 SECONDS
	interval_upper_bound = 3 SECONDS

	var/list/turfs = list()
	var/list/mist_list = list()
	var/datum/looping_sound/weather/rain/soundloop

/obj/effect/map_effect/interval/fire_supression/Initialize(mapload,var/area/our_area)
	soundloop = new(list(src), FALSE)
	soundloop.start()
	for(var/turf/T in our_area)
		turfs += T
	return ..()

/obj/effect/map_effect/interval/fire_supression/Destroy()
	soundloop.stop()
	QDEL_NULL(soundloop)
	remove_mist()
	turfs.Cut()
	return ..()

/obj/effect/map_effect/interval/fire_supression/trigger()
	var/reps = rand(4,12)
	while(reps-- > 0)
		if(prob(20))
			continue
		var/turf/T = pick(turfs)
		if(T && istype(T,/turf/simulated/floor))
			spawn_mist(T)

/obj/effect/map_effect/interval/fire_supression/proc/spawn_mist(var/turf/T)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(locate(/obj/effect/mist/fire_suppression) in T)
		return
	var/obj/effect/mist/fire_suppression/S = new(T)
	mist_list.Add(S)
	addtimer(CALLBACK(src, PROC_REF(remove_mist), S), rand(15,22) SECONDS, TIMER_DELETE_ME)

/obj/effect/map_effect/interval/fire_supression/proc/remove_mist(var/obj/effect/mist/fire_suppression/mist = null)
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(mist)
		mist_list -= mist
		qdel(mist)
		return
	QDEL_LIST_NULL(mist_list)

/obj/effect/mist/fire_suppression
	icon = 'modular_chomp/icons/effects/weather.dmi'
	icon_state = "rain"

/obj/effect/mist/fire_suppression/Initialize(mapload)
	. = ..()
	create_reagents(500)
	START_PROCESSING(SSobj, src)
	// add ground mist
	if(prob(70))
		var/datum/effect/effect/system/effect_system = new /datum/effect/effect/system/smoke_spread/mist()
		effect_system.attach(src)
		effect_system.set_up(rand(1,2), 0, loc)
		effect_system.start()

/obj/effect/mist/fire_suppression/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/effect/mist/fire_suppression/proc/do_wash(atom/movable/O as obj|mob)
	if(isliving(O))
		var/mob/living/L = O
		L.extinguish_mob()
		L.adjust_fire_stacks(-20) //Douse ourselves with water to avoid fire more easily

	if(iscarbon(O))
		//flush away reagents on the skin
		var/mob/living/carbon/M = O
		if(M.touching)
			var/remove_amount = M.touching.maximum_volume * M.reagent_permeability() //take off your suit first
			M.touching.remove_any(remove_amount)
	O.wash(CLEAN_SCRUB)

	if(istype(O,/obj/item/storage/box/monkeycubes))
		var/obj/item/storage/box/monkeycubes/M = O
		M.soaked()
	if(istype(O,/obj/item/reagent_containers/food/snacks/monkeycube/wrapped))
		var/obj/item/reagent_containers/food/snacks/monkeycube/C = O
		C.soaked()

	reagents.splash(O, 10, min_spill = 0, max_spill = 0)

/obj/effect/mist/fire_suppression/proc/wash_floor()
	var/turf/T = get_turf(src)
	T.wash(CLEAN_SCRUB)
	reagents.splash(T, 10, min_spill = 0, max_spill = 0)

/obj/effect/mist/fire_suppression/process()
	for(var/atom/movable/AM in loc)
		if(AM.simulated)
			do_wash(AM)
	wash_floor()
	reagents.add_reagent(REAGENT_ID_WATER, reagents.get_free_space())
