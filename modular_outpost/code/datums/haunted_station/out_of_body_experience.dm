/datum/haunting_entity/out_of_body_experience
	name = "ENTITY - Out of body experience"

/datum/haunting_entity/out_of_body_experience/New()
	. = ..()

	var/mob/living/carbon/human/target_mob = SShaunting.get_player_target()
	if(target_mob?.client && !target_mob?.away_from_keyboard)
		target_mob.AddComponent(/datum/component/out_of_body_experience)

	qdel(src)

/datum/haunting_entity/out_of_body_experience/process()
	qdel(src) // End instantly
