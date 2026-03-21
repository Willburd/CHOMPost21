/mob/living/simple_mob/clowns/
	tt_desc = "E Homo sapiens corydon" //this is a clown
	faction = FACTION_CLOWN
	movement_sound = 'sound/effects/clownstep2.ogg'
	attack_sound = 'sound/effects/Whipcrack.ogg'

	faction = FACTION_CLOWN

	maxHealth = 100
	health = 100
	see_in_dark = 8

	has_hands = TRUE
	humanoid_hands = TRUE

	melee_damage_lower = 5
	melee_damage_upper = 30

	ai_holder_type = /datum/ai_holder/simple_mob/melee/clowns

	loot_list = list(/obj/item/bikehorn = 100)

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	// maxbodytemp = 700 // Outpost 21 edit - Die normally to fire

	// Outpost 21 edit begin - Clown butchering
	meat_amount = 5
	meat_type = /obj/item/reagent_containers/food/snacks/meat/human
	// Outpost 21 edit end

/datum/ai_holder/simple_mob/melee/clowns
	can_breakthrough = TRUE // Outpost 21 edit - ANGRY CLOWNS
	violent_breakthrough = TRUE // Outpost 21 edit - ANGRY CLOWNS
	hostile = FALSE // The majority of simplemobs are hostile, gaslamps are nice.
	cooperative = FALSE
	retaliate = TRUE //so the monster can attack back
	returns_home = FALSE
	can_flee = FALSE
	speak_chance = 3
	wander = TRUE
	base_wander_delay = 9
