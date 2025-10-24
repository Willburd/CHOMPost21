// Change ai holder mode to be instantly hostile
/mob/living/simple_mob/vore/otie/syndicate/Initialize(mapload)
	. = ..()
	ai_holder.threaten = FALSE
	ai_holder.returns_home = FALSE

//Serdy's syndie subtypes, but tweaked to make it make sense. Do edits here.
/mob/living/simple_mob/vore/otie/syndicate
	armor = list(		// Half the values of the actual syndies, rounded down.
				"melee" = 37,
				"bullet" = 30,
				"laser" = 20,
				"energy" = 7,
				"bomb" = 0,
				"bio" = 100, //Except these
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 0, // all set to 0, upstream wants to move away from armor soak apparently
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 0,
				"rad" = 0
				)

/mob/living/simple_mob/vore/otie/syndicate/chubby
	armor = list(			// Values for normal getarmor() checks // Half the values of the actual syndies, rounded down.
				"melee" = 40, //slightly better cuz chumky
				"bullet" = 32,
				"laser" = 20,
				"energy" = 5,
				"bomb" = 0,
				"bio" = 100, //Except these
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 0, // all set to 0, upstream wants to move away from armor soak apparently
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 0,
				"rad" = 0
				)

/mob/living/simple_mob/vore/wolf/direwolf/syndicate
	armor = list(			// Values for normal getarmor() checks // Half the values of the actual syndies, rounded down.
				"melee" = 37,
				"bullet" = 30,
				"laser" = 20,
				"energy" = 7,
				"bomb" = 0,
				"bio" = 100, //Except these
				"rad" = 100
				)
	armor_soak = list(		// Values for getsoak() checks.
				"melee" = 0, // all set to 0, upstream wants to move away from armor soak apparently
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 0,
				"rad" = 0
				)

/mob/living/simple_mob/vore/wolftaur/syndicate
	maxHealth = 275 //Editing to better match in-game values where HP is double what it says. You can reach 150 Hp easily without trait debt
	projectiletype = /obj/item/projectile/bullet/rifle/a762 // This is the bullet the Z8 actually fires
	armor = list(			// Values for normal getarmor() checks
			"melee" = 75, // was 40
			"bullet" = 60, // was 30
			"laser" = 40, // was 20
			"energy" = 15, // was 5
			"bomb" = 45, // was 50
			"bio" = 100, // was 100
			"rad" = 100 // Actual should be 60, but mobs get REALLY unhappy and break with less than 100 rad
			) // Changes these values to match wearing an actual syndie suit. They're as close to 1-1 as I can get
	base_attack_cooldown = 4 //small fire rate buff. Was 8

/mob/living/simple_mob/vore/wolftaur/syndicate/lmg
	projectiletype = /obj/item/projectile/bullet/rifle/a545 // Fixes this to use the same bullet as the actual LMG
	projectile_dispersion = 8 // was 12. Lowering cuz these are trained taurs in a full suit. C'mon
	projectile_accuracy = -18 // was -25

/mob/living/simple_mob/vore/wolftaur/syndicate/smg
	projectiletype = /obj/item/projectile/bullet/pistol // The actual bullet the p90 uses. Technically this one is a nerf.
	loot_list = list(/obj/item/gun/projectile/automatic/p90 = 1) //Matching with others. I think this is percent?
