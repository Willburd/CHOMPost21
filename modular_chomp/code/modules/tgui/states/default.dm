// Allows PAI to use specific objects, instead of being completely forbidden from everything
/mob/living/silicon/pai/default_can_use_tgui_topic(var/datum/src_object)
	if(!stat && src_object && (src_object.type in GLOB.pai_accessible_objects) && get_dist(src_object, src) <= 1) // direct paths are checked, this is not a type-check list
		return STATUS_INTERACTIVE

	. = ..()
