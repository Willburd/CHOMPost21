/datum/haunting_entity/frigid_darkness
	name = "ENTITY - frigid darkness"

/datum/haunting_entity/frigid_darkness/New()
	. = ..()

	// Change the weather suddenly
	var/mob/target = get_target()
	if(!target)
		return

	var/turf/T = get_turf(target)
	if(T.z == 0 || T.z > SSplanets.z_to_planet.len)
		return
	var/datum/planet/P = SSplanets.z_to_planet[T.z]
	if(!P)
		return
	P.weather_holder.change_weather(WEATHER_COLDDARKNESS)

/datum/haunting_entity/frigid_darkness/process()
	qdel(src) // End instantly
