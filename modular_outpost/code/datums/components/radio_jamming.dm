/datum/component/radio_jammer
	var/jam_range = 3
	var/enabled = TRUE

/datum/component/radio_jammer/Initialize()
	GLOB.active_radio_jammers += src

/datum/component/radio_jammer/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_SAY_PREPARE, PROC_REF(handle_prepare_say))

/datum/component/radio_jammer/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOB_SAY_PREPARE)
	. = ..()

/datum/component/radio_jammer/Destroy(force)
	GLOB.active_radio_jammers -= src
	. = ..()

/datum/component/radio_jammer/proc/get_host_turf()
	if(QDELETED(parent))
		return null
	return get_turf(parent)

/datum/component/radio_jammer/proc/handle_prepare_say(atom/source, list/message_pieces, datum/language/speaking, message, whispering, message_mode)
	SIGNAL_HANDLER
	if(!enabled)
		return
	// Lets a single message get past...
	enabled = FALSE
	VARSET_IN(src, enabled, TRUE, 1)
