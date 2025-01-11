/obj/effect/landmark/redspacestart
	name = "redentrance" // places in redspace where mobs are placed when they enter it
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"

/obj/effect/landmark/redspaceexit
	name = "redexit" // places in realspace that are legal to eject mobs to
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"

/obj/effect/landmark/late_antag/chu
	name = "Chu - Lateload"
	antag_id = MODE_CHU

/obj/effect/landmark/late_antag/synx
	name = "Synx - Lateload"
	antag_id = MODE_SYNX

/obj/effect/landmark/late_antag/zombie
	name = "Zombie - Lateload"
	antag_id = MODE_ZOMBIE

/obj/effect/landmark/redspacemonsterspawn
	name = "redmonster"

/obj/effect/landmark/redspacemonsterspawn/Initialize()
	. = ..()

	if(prob(80))
		return // leave redspace mostly empty, so it feels dangerous when you do find something, not just insane and cruel

	if(!isturf(src.loc))
		return

	var/list/mobs = list(
			/mob/living/simple_mob/clowns/normal,
			/mob/living/simple_mob/shadekin/red/dark,
			/mob/living/simple_mob/animal/synx/ai,
			/mob/living/simple_mob/vore,
			/mob/living/simple_mob/vore/alienanimals/chu,
			// Cult
			/mob/living/simple_mob/creature,
			/mob/living/simple_mob/vore/aggressive/corrupthound,
			/mob/living/simple_mob/vore/demon/wendigo,
			/mob/living/simple_mob/vore/demon/engorge,
			/mob/living/simple_mob/humanoid/cultist/noodle,
			/mob/living/simple_mob/humanoid/cultist/tesh,
			// Candy
			/mob/living/simple_mob/vore/candy/redcabold,
			/mob/living/simple_mob/vore/candy/bluecabold,
			/mob/living/simple_mob/vore/candy/yellowcabold,
			/mob/living/simple_mob/vore/candy/marshmellowserpent,
			// Cyber horror
			/mob/living/simple_mob/mechanical/cyber_horror/vox,
			/mob/living/simple_mob/mechanical/cyber_horror/ling_cyber_horror,
			/mob/living/simple_mob/mechanical/cyber_horror/corgi,
			/mob/living/simple_mob/mechanical/cyber_horror/tajaran,
			/mob/living/simple_mob/mechanical/cyber_horror/grey,
			/mob/living/simple_mob/mechanical/cyber_horror/cat_cyber_horror,
		)
	var/mob_path = pick(mobs);
	if(mob_path == /mob/living/simple_mob/clowns/normal)
		// clowns are the most complex, taken right from the clune infestation event
		var/spawncount = pick(1,2)
		while((spawncount >= 1))
			// normal ones...
			var/subcount = pick(2,3)
			while((subcount >= 1))
				var/mob/living/simple_mob/clowns/normal/C = new /mob/living/simple_mob/clowns/normal()
				C.loc = src.loc
				subcount--

			// what in gods name.
			subcount = pick(1,2)
			while((subcount >= 1))
				var/chosen_clown = pick(
				list(/mob/living/simple_mob/clowns/big/honkling
				, /mob/living/simple_mob/clowns/big/blob
				, /mob/living/simple_mob/clowns/big/mutant
				, /mob/living/simple_mob/clowns/big/flesh
				, /mob/living/simple_mob/clowns/big/scary
				, /mob/living/simple_mob/clowns/big/giggles
				, /mob/living/simple_mob/clowns/big/longface
				, /mob/living/simple_mob/clowns/big/hulk
				, /mob/living/simple_mob/clowns/big/thin
				, /mob/living/simple_mob/clowns/big/wide
				, /mob/living/simple_mob/clowns/big/perm
				, /mob/living/simple_mob/clowns/big/thicc
				, /mob/living/simple_mob/clowns/big/punished
				, /mob/living/simple_mob/clowns/big/cluwne
				, /mob/living/simple_mob/clowns/big/honkmunculus
				, /mob/living/simple_mob/clowns/big/tunnelclown
				, /mob/living/simple_mob/clowns/big/sentinel
				, /mob/living/simple_mob/clowns/big/destroyer
				, /mob/living/simple_mob/clowns/big/chlown
				, /mob/living/simple_mob/clowns/big/clowns
				, /mob/living/simple_mob/clowns/big/mayor
				, /mob/living/simple_mob/clowns/big/honkling))
				new chosen_clown(src.loc)
				subcount--
			spawncount--
		return
	// otherwise just spawn something!
	new mob_path(src.loc)


/obj/effect/landmark/hostile_xenobio
	name = "dangerous xeno spawner"

/obj/effect/landmark/hostile_xenobio/Initialize()
	. = ..()

	if(prob(20))
		return // likely to be empty, so xenobio doesn't need to clear it out any time they want to do stuff

	if(!isturf(src.loc))
		return

	var/mob_path = pick(
		// Wildlife
		prob(75);/mob/living/simple_mob/vore/alienanimals/jil,
		prob(25);/mob/living/simple_mob/vore/alienanimals/jil/jillioth,
		prob(90);/mob/living/simple_mob/animal/synx/ai,
		prob(75);/mob/living/simple_mob/vore/vore_hostile/gelatinous_cube,
		prob(90);/mob/living/simple_mob/animal/space/carp,
		prob(90);/mob/living/simple_mob/animal/giant_spider,
		prob(35);/mob/living/simple_mob/vore/leopardmander,
		prob(90);/mob/living/simple_mob/animal/space/goose,
		prob(90);/mob/living/simple_mob/vore/oregrub,
		prob(25);/mob/living/simple_mob/vore/pitcher_plant,
		prob(35);/mob/living/simple_mob/vore/alienanimals/dustjumper,
		prob(75);/mob/living/simple_mob/clowns/normal,
		prob(90);/mob/living/simple_mob/vore/otie/feral,
		prob(90);/mob/living/simple_mob/vore/aggressive/rat,
		prob(90);/mob/living/simple_mob/vore/aggressive/giant_snake,
		prob(90);/mob/living/simple_mob/vore/slug,
		prob(55);/mob/living/simple_mob/vore/scel,
		// Ohno
		prob(5);/mob/living/simple_mob/vore/alienanimals/chu,
		prob(55);/mob/living/simple_mob/animal/space/bear,
		prob(75);/mob/living/simple_mob/shadekin/red/dark,
		prob(35);/mob/living/simple_mob/clowns/big/flesh,
		prob(35);/mob/living/simple_mob/clowns/big/scary,
		prob(35);/mob/living/simple_mob/clowns/big/longface,
		prob(75);/mob/living/simple_mob/animal/space/carp/large,
		prob(5);/mob/living/simple_mob/vore/otie/syndicate,
		// Troidin
		prob(75);/mob/living/simple_mob/metroid/juvenile/baby,
		prob(55);/mob/living/simple_mob/metroid/juvenile/alpha,
		prob(35);/mob/living/simple_mob/metroid/juvenile/gamma,
		prob(15);/mob/living/simple_mob/metroid/juvenile/zeta,
		prob(5);/mob/living/simple_mob/metroid/juvenile/omega,
		// Ayys
		prob(55);/mob/living/simple_mob/animal/space/alien,
		prob(55);/mob/living/simple_mob/animal/space/alien/sentinel,
		// Candy
		prob(15);/mob/living/simple_mob/vore/candy/redcabold,
		prob(15);/mob/living/simple_mob/vore/candy/bluecabold,
		prob(15);/mob/living/simple_mob/vore/candy/yellowcabold,
		prob(15);/mob/living/simple_mob/vore/candy/marshmellowserpent,
		// Cyber horror
		prob(15);/mob/living/simple_mob/mechanical/cyber_horror/vox,
		prob(15);/mob/living/simple_mob/mechanical/cyber_horror/ling_cyber_horror,
		prob(25);/mob/living/simple_mob/mechanical/cyber_horror/corgi,
		prob(25);/mob/living/simple_mob/mechanical/cyber_horror/cat_cyber_horror,
	)
	new mob_path(src.loc)


/obj/effect/landmark/dangerous_situation
	name = "dangerous situation spawner"

/obj/effect/landmark/dangerous_situation/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/dangerous_situation/LateInitialize()
	. = ..()

	if(!isturf(src.loc))
		return

	// creates stuff like ruptured gas tanks, and landmines
	switch(rand(1,4))
		if(1)
			var/newpath = pick(/obj/machinery/portable_atmospherics/canister/carbon_dioxide/broken,/obj/machinery/portable_atmospherics/canister/nitrous_oxide/broken,/obj/machinery/portable_atmospherics/canister/phoron/broken)
			var/obj/machinery/portable_atmospherics/canister/tank = new newpath()
			tank.loc = src.loc

		if(2)
			var/newpath = pick(prob(30);/obj/effect/mine,
				prob(25);/obj/effect/mine/frag,
				prob(2);/obj/effect/mine/emp,
				prob(1);/obj/effect/mine/dnascramble,
				prob(10);/obj/effect/mine/stun,
				prob(10);/obj/effect/mine/incendiary,
				prob(10);/obj/effect/mine/spiders,
				prob(10);/obj/effect/mine/portal)
			var/obj/effect/mine/M = new newpath()
			if(prob(60))
				M.camo_net = TRUE
				M.alpha = 50 // Wish this was part of a proc instead of magic num
			M.loc = src.loc

		if(3)
			var/obj/structure/largecrate/animal/pred/crate = new /obj/structure/largecrate/animal/pred()
			crate.name = "Kobby Friend Crate [rand(999,9999)]"
			crate.loc = src.loc

		if(4)
			var/obj/structure/largecrate/animal/dangerous/crate = new /obj/structure/largecrate/animal/dangerous()
			crate.name = "Super Kobby Friend Crate [rand(999,9999)]"
			crate.loc = src.loc




/obj/effect/landmark/step_trap
	name = "step trap spawner"

/obj/effect/landmark/step_trap/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/step_trap/LateInitialize()
	. = ..()

	if(prob(40))
		return;

	if(!isturf(src.loc))
		return

	// creates stuff like ruptured gas tanks, and landmines
	switch(rand(1,3))
		if(1)
			var/newpath = pick(
				/obj/effect/mine/emp,
				/obj/effect/mine/stun,
				/obj/effect/mine/training,
				/obj/effect/mine/lasertag/red,
				/obj/effect/mine/lasertag/blue,
				/obj/effect/mine/lasertag/omni,
				/obj/effect/mine/lasertag/all,
				/obj/effect/mine/spiders,
				/obj/effect/mine/portal,
				/obj/effect/mine/glue,
				/obj/effect/mine/confetti,
				/obj/effect/mine/lube,
				/obj/effect/mine/dnascramble)
			var/obj/effect/mine/M = new newpath()
			if(prob(20))
				M.camo_net = TRUE
				M.alpha = 50 // Wish this was part of a proc instead of magic num
			M.loc = src.loc

		if(2)
			var/turf/srcturf = get_turf(src)
			if(srcturf.outdoors == OUTDOORS_NO)
				if(prob(20))
					// rare spawn!
					var/obj/item/lego/L = new /obj/item/lego()
					L.loc = src.loc
				else
					var/obj/item/assembly/mousetrap/armed/M = new /obj/item/assembly/mousetrap/armed();
					M.loc = src.loc

		if(3)
			var/obj/item/beartrap/M = new /obj/item/beartrap();
			M.deployed = TRUE
			M.update_icon()
			M.loc = src.loc
