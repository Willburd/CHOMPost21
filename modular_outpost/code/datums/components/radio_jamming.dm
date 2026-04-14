/datum/component/radio_jammer
	var/jam_range = 3

/datum/component/radio_jammer/Initialize()
	GLOB.active_radio_jammers += src

/datum/component/radio_jammer/Destroy(force)
	GLOB.active_radio_jammers -= src
	. = ..()

/datum/component/radio_jammer/proc/get_host_turf()
	if(QDELETED(parent))
		return null
	return get_turf(parent)
