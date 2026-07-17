/mob/living/simple_mob/clowns
	ai_holder_type = /datum/ai_holder/simple_mob/melee/angryclowns
	maxbodytemp = 350 // die to fire
	density = FALSE // Allows this mob to swarm

	meat_amount = 5
	meat_type = /obj/item/reagent_containers/food/snacks/meat/human

/mob/living/simple_mob/clowns/attackby(obj/item/O, mob/user)
	. = ..()
	if(user?.mind?.assigned_role == JOB_CHAPLAIN && istype(O, /obj/item/nullrod))
		exorcise_demon(TRUE, src)

/mob/living/simple_mob/clowns/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/undead_revival, rev_time = 45 SECONDS, rev_chance = 80, rev_hppercent = 50)
	AddComponent(/datum/component/swarming, max_x = 16, max_y = 16)

// Allows this mob to swarm
/mob/living/simple_mob/clowns/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover) && !istype(mover, /mob/living/simple_mob/clowns) && mover.density == TRUE && stat != DEAD)
		return FALSE
	return ..()

/mob/living/simple_mob/clowns/big
	meat_amount = 10


/datum/ai_holder/simple_mob/melee/clowns
	can_breakthrough = TRUE
	violent_breakthrough = TRUE
