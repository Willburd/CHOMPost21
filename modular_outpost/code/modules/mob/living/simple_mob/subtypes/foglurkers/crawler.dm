/mob/living/simple_mob/horror/foglurker/crawler
	name = "crawler"
	icon = 'modular_outpost/icons/mob/foglurkers/residentdeadtrauma64x64.dmi'
	icon_state = "crawler"
	maxHealth = 220
	health = 220

/mob/living/simple_mob/horror/foglurker/crawler/split_lurker()
	new /mob/living/simple_mob/horror/foglurker/headspider(get_turf(src))
