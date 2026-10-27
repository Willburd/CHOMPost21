/mob/living/simple_mob/horror/foglurker/centaur
	name = "centaur"
	icon = 'modular_outpost/icons/mob/foglurkers/residentdeadtrauma64x64.dmi'
	icon_state = "centaur"
	maxHealth = 450
	health = 450

/mob/living/simple_mob/horror/foglurker/centaur/split_lurker()
	new /mob/living/simple_mob/horror/foglurker/crawler(get_turf(src))
