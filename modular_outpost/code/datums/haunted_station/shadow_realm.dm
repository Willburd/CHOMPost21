/datum/haunting_entity/shadow_realm
	name = "ENTITY - Sent to a bad place"

/datum/haunting_entity/shadow_realm/New()
	. = ..()

	var/mob/living/carbon/human/target_mob = SShaunting.get_player_target()
	if(target_mob?.client && !target_mob?.away_from_keyboard)
		target_mob.AddComponent(/datum/component/out_of_body_experience/no_bad_body/shadow_realm)

	qdel(src)

/datum/haunting_entity/shadow_realm/process()
	qdel(src) // End instantly
