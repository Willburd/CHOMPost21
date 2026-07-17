/obj/item/peng
	name = "\proper Peng"
	icon = 'modular_outpost/icons/obj/peng.dmi'
	icon_state = "peng"
	desc = "There is always peng."

/obj/item/peng/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/sellable/peng)


/obj/effect/landmark/pengmark
	name = "pengmark"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "rest0"
	var/static/landmark_list = list()

/obj/effect/landmark/pengmark/Initialize(mapload)
	..()
	landmark_list += src
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/pengmark/Destroy(force)
	landmark_list -= src
	. = ..()

/obj/effect/landmark/pengmark/LateInitialize()
	// We only do this once!
	if(islist(landmark_list) && length(landmark_list))
		var/obj/effect/landmark/mark =  pick(landmark_list)
		var/turf/spawn_pos = get_turf(mark)
		if(spawn_pos)
			new /obj/item/peng(spawn_pos)
			log_world("Peng spawned at: [spawn_pos.x].[spawn_pos.y].[spawn_pos.z]")
		landmark_list = null
