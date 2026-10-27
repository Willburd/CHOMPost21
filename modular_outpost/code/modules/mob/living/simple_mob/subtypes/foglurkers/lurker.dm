/mob/living/simple_mob/horror/foglurker/lurker
	name = "lurker"
	icon_state = "lurker"
	maxHealth = 50
	health = 50

/mob/living/simple_mob/horror/foglurker/lurker/split_lurker()
	new /mob/living/simple_mob/horror/foglurker/headspider(get_turf(src))
