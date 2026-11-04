/mob/living/simple_mob/horror/foglurker/headspider
	name = "headspider"
	icon_state = "headspider"
	maxHealth = 45
	health = 45

/mob/living/simple_mob/horror/foglurker/headspider/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/swarming)
