/obj/effect/landmark/holiday_event_spawn
	name = "holiday item spawn"
	icon = 'icons/obj/flora/pumpkins.dmi'
	icon_state = "spawner-jackolantern"

/obj/effect/landmark/holiday_event_spawn/New()
	// get time from our own web domain, intentionally fails, we only want the time...
	Holiday_Event_Spawn_Object(src.loc)
	del(src)


//////////////////////////////////////////////////////////////////////////////
// Proc decides what spawns for all the holiday event objects ---------------------------------------------------------
/proc/Holiday_Event_Spawn_Object(var/turf/here)
	var/MM	=	text2num(time2text(world.timeofday, "MM")) 	// get the current month
	var/DD	=	text2num(time2text(world.timeofday, "DD")) 	// get the current day
	switch(MM)
		//if(1)	//Jan TODO
		//	switch(DD)
		//		if(1)
		//			return new /obj/item/toy/figure/clown(here)

		if(3)   //April
			switch(DD)
				if(11)
					var/pillow = pick(/obj/item/toy/plushie/pillow,/obj/item/toy/plushie/pillow/red,/obj/item/toy/plushie/pillow/green,/obj/item/toy/plushie/pillow/blue)
					new pillow(here)
					// this is a clone of /obj/random/plushie/item_to_spawn()
					var/randomplush = pick(/obj/item/toy/plushie/nymph,
						/obj/item/toy/plushie/mouse,
						/obj/item/toy/plushie/kitten,
						/obj/item/toy/plushie/lizard,
						/obj/item/toy/plushie/black_cat,
						/obj/item/toy/plushie/black_fox,
						/obj/item/toy/plushie/blue_fox,
						/obj/random/carp_plushie,
						/obj/item/toy/plushie/coffee_fox,
						/obj/item/toy/plushie/corgi,
						/obj/item/toy/plushie/crimson_fox,
						/obj/item/toy/plushie/deer,
						/obj/item/toy/plushie/girly_corgi,
						/obj/item/toy/plushie/grey_cat,
						/obj/item/toy/plushie/marble_fox,
						/obj/item/toy/plushie/octopus,
						/obj/item/toy/plushie/orange_cat,
						/obj/item/toy/plushie/orange_fox,
						/obj/item/toy/plushie/pink_fox,
						/obj/item/toy/plushie/purple_fox,
						/obj/item/toy/plushie/red_fox,
						/obj/item/toy/plushie/robo_corgi,
						/obj/item/toy/plushie/siamese_cat,
						/obj/item/toy/plushie/spider,
						/obj/item/toy/plushie/tabby_cat,
						/obj/item/toy/plushie/tuxedo_cat,
						/obj/item/toy/plushie/white_cat,
						//VOREStation Add Start
						/obj/item/toy/plushie/lizardplushie,
						/obj/item/toy/plushie/lizardplushie/kobold,
						/obj/item/toy/plushie/slimeplushie,
						/obj/item/toy/plushie/box,
						/obj/item/toy/plushie/borgplushie,
						/obj/item/toy/plushie/borgplushie/medihound,
						/obj/item/toy/plushie/borgplushie/scrubpuppy,
						/obj/item/toy/plushie/foxbear,
						/obj/item/toy/plushie/nukeplushie,
						/obj/item/toy/plushie/otter,
						/obj/item/toy/plushie/vox,
						//VOREStation Add End
						//YawnWider Add Start
						/obj/item/toy/plushie/teshari/_yw,
						/obj/item/toy/plushie/teshari/w_yw,
						/obj/item/toy/plushie/teshari/b_yw,
						/obj/item/toy/plushie/teshari/y_yw,
						//YawnWider Add End
						//Outpost Add Start
						/obj/item/toy/plushie/tinytin,
						/obj/item/toy/plushie/jil,
						/obj/item/toy/plushie/chu)
						//Outpost Add End
					return new randomplush(here)						// hug a friend day

		if(4)   //April
			switch(DD)
				if(1)
					return new /obj/item/toy/figure/clown(here)					// april fools
				if(22)
					return new /obj/random/pottedplant(here)					// Earth day

		if(5)	//May
			switch(DD)
				if(18)
					return new /obj/structure/flora/pottedplant/small(here)		// Armistice Day

		if(9)	//Sep
			switch(DD)
				if(19)
					return new /obj/item/flag/pirate(here)						// talk like a pirate date

		if(10)	//Oct
			return new /obj/effect/landmark/carved_pumpkin_spawn(here)			// SPOOKYMONTH

		if(12)	//Dec
			if(DD < 26)
				return new /obj/structure/flora/pottedplant/xmas(here)							// CRIMBO

	// default plant spawn
	return new /obj/machinery/holoplant(here)
