/mob/living/simple_mob/horror/foglurker
	name = "foglurker" // Base type, only use the subtypes
	icon = 'modular_outpost/icons/mob/foglurkers/residentdeadtrauma32x32.dmi'
	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive

// Gib when killed
/mob/living/simple_mob/horror/foglurker/death()
	if(stat == DEAD)
		return
	stat = DEAD
	split_lurker()
	gib()

/mob/living/simple_mob/horror/foglurker/proc/split_lurker()
	return
