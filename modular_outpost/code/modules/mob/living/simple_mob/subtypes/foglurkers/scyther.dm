/mob/living/simple_mob/horror/foglurker/scyther
	name = "scyther"
	icon_state = "scyther"
	maxHealth = 75
	health = 75

/mob/living/simple_mob/horror/foglurker/scyther/split_lurker()
	new /mob/living/simple_mob/horror/foglurker/headspider(get_turf(src))
