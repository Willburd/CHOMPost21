/mob/living/simple_mob/mechanical/mecha/combat/honker
	name = "Jester"
	desc = "A Gygax exosuit modelled after the infamous combat-troubadors of Earth's distant past. Terrifying to behold."
	catalogue_data = list(/datum/category_item/catalogue/technology/gygax)
	icon_state = "honker"
	movement_cooldown = 1.5
	faction = FACTION_CLOWN
	wreckage = /obj/structure/loot_pile/mecha/honker
	maxHealth = 500
	deflect_chance = 10
	sight = SEE_SELF | SEE_MOBS
	armor = list(
				"melee"		= 50,
				"bullet"	= 55,
				"laser"		= 40,
				"energy"	= 30,
				"bomb"		= 30,
				"bio"		= 100,
				"rad"		= 100
				)
	melee_damage_lower = 45
	melee_damage_upper = 45
	base_attack_cooldown = 8 SECONDS
	projectiletype = /obj/item/projectile/bullet/srmrocket/weak
	pilot_type = /mob/living/simple_mob/clowns/big/normal
	turn_sound = "clownstep" // HONK

/obj/structure/loot_pile/mecha/honker
	name = "jester wreckage"
	desc = "The ruins of something horrid. Perhaps something is salvageable."
	icon_state = "honker-broken"
	loot_element_path = /datum/element/lootable/mecha/honker
