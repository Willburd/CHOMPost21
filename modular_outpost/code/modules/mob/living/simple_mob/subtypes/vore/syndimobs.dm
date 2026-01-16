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

/mob/living/simple_mob/vore/wolftaur/syndicate
	maxHealth = 275 //Editing to better match in-game values where HP is double what it says. You can reach 150 Hp easily without trait debt
	projectiletype = /obj/item/projectile/bullet/rifle/a762/ap // This is the bullet the Z8 actually fires, now with AP fun!
	projectilesound = 'sound/weapons/ballistics/a762.ogg' //Also makes it use the right SOUND
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
	// Internal suits
	enzyme_affect = FALSE
	min_oxy = 0
	// disable max atmos
	max_tox = 0
	max_co2 = 0
	max_n2 = 0
	max_ch4 = 0
	ai_holder_type = /datum/ai_holder/simple_mob/merc/ranged/torch //More aggressive AI holder, no warning, just shootin'
	needs_reload = TRUE //Lets have SOME mercy
	base_attack_cooldown = 6 //was 8. Lets let these guys shoot a bit faster... but not as fast as the others, they're the slow, continual fire.
	reload_time = 2.2 SECONDS //Trained reload speed. Probably horribly slow for what a hotkey player can do.

/mob/living/simple_mob/vore/wolftaur/syndicate/lmg
	projectiletype = /obj/item/projectile/bullet/rifle/a545/ap // Fixes this to use the same bullet as the actual LMG. Now with AP fun!
	projectile_dispersion = 8 // was 12. Lowering cuz these are trained taurs in a full suit. C'mon
	projectile_accuracy = -18 // was -25
	ai_holder_type = /datum/ai_holder/simple_mob/merc/ranged/torch/lmg
	base_attack_cooldown = 0.1 //Fully auto, should shoot the fastest
	reload_max = 75 //Lotta suppression before they need to reload
	reload_time = 5 SECONDS //gunna take a bit

/mob/living/simple_mob/vore/wolftaur/syndicate/smg
	loot_list = list(/obj/item/gun/projectile/automatic/c20r = 2) //Lets make these guys MEANER~
	projectiletype = /obj/item/projectile/ion/small //10mm haywire rounds.. these guys are gunna FUCK.
	projectilesound = 'sound/weapons/Gunshot1.ogg'
	ai_holder_type = /datum/ai_holder/simple_mob/merc/ranged/torch
	base_attack_cooldown = 4
	reload_max = 20 //Matches ammo to the real thing

/mob/living/simple_mob/vore/wolftaur/syndicate/awp
	projectiletype = /obj/item/projectile/bullet/rifle/a338/ap //Giving them AP rounds for full funny
	reload_time = 4 SECONDS

/mob/living/simple_mob/vore/wolftaur/syndicate/shotty //New shotgun boys. Nasty little shits~
	projectiletype = /obj/item/projectile/scatter/flechette
	loot_list = list(/obj/item/gun/projectile/shotgun/pump/shorty = 3)
	projectilesound = 'sound/weapons/gunshot_shotgun.ogg'
	projectile_dispersion = 8
	projectile_accuracy = -18 //Matching LMG for now... we'll see how it feels with the shotty.
	base_attack_cooldown = 0.1 //Rapid fire those barrels
	reload_max = 2 //double barrel
	reload_time = 3.5 SECONDS //Nasty hit, but long delay between shots. Should count in seconds.
	reload_sound = 'sound/weapons/shotgunpump.ogg'

	icon_dead = "synditaur_shotgun"
	icon_living = "synditaur_shotgun"
	icon_state = "synditaur_shotgun"
	icon_rest = "synditaur_shotgun"

//Apparently default wolftaurs have these, so giving these guys their own
/mob/living/simple_mob/vore/wolftaur/syndicate/load_default_bellies()
	. = ..()
	var/obj/belly/B = vore_selected
	B.name = "stomach"
	B.desc = "The taur gripped you firmly, their helmet retracting just long enough to jam your struggling shape down their throat, as you were sent down... into the forestomach, and right on down into that low hanging hammock underneath them.. normally spacious, now crushed in that tight armored suit, helping the stomach to knead and churn into you. You've gone from station defender, to a to-go meal for the mercenary... here's hoping your allies will rescue you before you're digested, or worse... kidnapped."
	B.mode_flags = DM_FLAG_THICKBELLY
	B.digest_brute = 2
	B.digest_burn = 2
	B.digest_oxy = 1
	B.digestchance = 100
	B.absorbchance = 0
	B.escapechance = 5
	B.selective_preference = DM_DIGEST
	B.escape_stun = 5
