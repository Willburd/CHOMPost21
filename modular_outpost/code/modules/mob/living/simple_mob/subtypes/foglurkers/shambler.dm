/mob/living/simple_mob/horror/foglurker/shambler
	name = "shambler"
	icon_state = "shambler"
	maxHealth = 85
	health = 85

/mob/living/simple_mob/horror/foglurker/shambler/split_lurker()
	new /mob/living/simple_mob/horror/foglurker/headspider(get_turf(src))
