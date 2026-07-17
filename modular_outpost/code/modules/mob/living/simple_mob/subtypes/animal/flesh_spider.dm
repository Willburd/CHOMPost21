/datum/category_item/catalogue/fauna/giant_spider/flesh_spider
	name = "Giant Spider - Flesh"
	desc = "WHAT THE FUCK IS THAT - TODO."
	value = CATALOGUER_REWARD_HARD

/**
 * Spider-esque mob summoned by changelings.
 * A hit and run evasive spider with lower hp, but revives after death
 * Port from TG station, including icons
 */
/mob/living/simple_mob/animal/giant_spider/flesh
	name = "flesh spider"
	desc = "A odd fleshy creature in the shape of a spider. Its eyes are pitch black and soulless."
	tt_desc = "Caro Atraxus"
	catalogue_data = list(/datum/category_item/catalogue/fauna/giant_spider/flesh_spider)

	icon = 'modular_outpost/icons/mob/flesh_spider.dmi'
	icon_state = "flesh"
	icon_living = "flesh"
	icon_dead = "flesh_dead"
	has_eye_glow = FALSE

	pass_flags = PASSTABLE
	faction = FACTION_BLOB // A faction so they don't fight eachother
	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive

	maxHealth = 50
	health = 50

	melee_damage_lower = 15
	melee_damage_upper = 20

	poison_type = REAGENT_ID_STOMACID
	heat_resist = 1
	cold_resist = -0.75

	meat_amount = 2
	meat_type = /obj/item/reagent_containers/food/snacks/meat/human

/mob/living/simple_mob/animal/giant_spider/flesh/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/undead_revival, rev_time = 15 SECONDS, rev_chance = 60, rev_hppercent = 50)

/mob/living/simple_mob/animal/giant_spider/flesh/IIsAlly(mob/living/L)
	if(is_changeling(L))
		return TRUE
	. = ..()


// Meatspider babies
/obj/effect/spider/spiderling/flesh
	icon = 'modular_outpost/icons/mob/flesh_spider.dmi'
	icon_state = "flesh_spiderling"
	faction = FACTION_BLOB
	grow_as = list(/mob/living/simple_mob/animal/giant_spider/flesh)
