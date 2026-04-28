/mob/living/simple_mob/clowns
	ai_holder_type = /datum/ai_holder/simple_mob/melee/angryclowns
	maxbodytemp = 350 // die to fire

	meat_amount = 5
	meat_type = /obj/item/reagent_containers/food/snacks/meat/human

/mob/living/simple_mob/clowns/attackby(obj/item/O, mob/user)
	. = ..()
	if(user?.mind?.assigned_role == JOB_CHAPLAIN && istype(O, /obj/item/nullrod))
		exorcise_demon(TRUE, src)

/mob/living/simple_mob/clowns/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/undead_revival, rev_time = 45 SECONDS, rev_chance = 80, rev_hppercent = 50)


/mob/living/simple_mob/clowns/big
	meat_amount = 10


/datum/ai_holder/simple_mob/melee/clowns
	can_breakthrough = TRUE
	violent_breakthrough = TRUE
