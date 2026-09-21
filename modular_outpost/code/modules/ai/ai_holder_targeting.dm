/mob/living/simple_mob/vore/vore_hostile/gelatinous_cube
	movement_cooldown = 40 // Lower delay
	ai_holder_type = /datum/ai_holder/simple_mob/vore/gelatinous_cube

/datum/ai_holder/simple_mob/vore/gelatinous_cube
	hostile = FALSE // Nope

/datum/ai_holder/simple_mob/vore/gelatinous_cube/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(!holder.checkMoveCooldown())
		return FALSE
	. = ..()
