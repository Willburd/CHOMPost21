/mob/living/simple_mob/vore/wolftaur/syndicate/Initialize(mapload)
	. = ..()
	// Ours work different
	ai_holder.threaten = FALSE
	ai_holder.returns_home = FALSE
