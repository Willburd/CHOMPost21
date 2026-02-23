/obj/machinery/shower/automated
	name = "motion activated shower"
	icon = 'icons/obj/watercloset.dmi'

/obj/machinery/shower/automated/Crossed(atom/A)
	// motion sensor shower for autoresleever
	if(!on)
		on = TRUE
		START_MACHINE_PROCESSING(src)
		process()
		soundloop.start()
	addtimer(CALLBACK(src, PROC_REF(auto_stop)), 10 SECONDS, TIMER_DELETE_ME)

/obj/machinery/shower/automated/proc/auto_stop()
	if(!on)
		return
	on = FALSE
	soundloop.stop()


// Harmless duckies

/obj/item/bikehorn/rubberducky/red_harmless
	name = "rubber ducky"
	desc = "From the depths of hell it arose, feathers glistening with crimson, a honk that struck fear into all men."	//thanks doohl
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_red"
	item_state = "rubberducky_red"

/obj/item/bikehorn/rubberducky/blue_harmless
	name = "rubber ducky"
	desc = "The see me rollin', they hatin'."	//thanks doohl
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_blue"
	item_state = "rubberducky_blue"

/obj/item/bikehorn/rubberducky/pink_harmless
	name = "rubber ducky"
	desc = "It's extra squishy!"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_pink"
	item_state = "rubberducky_pink"

/obj/item/bikehorn/rubberducky/grey_harmless
	name = "rubber ducky"
	desc = "There's something otherworldly about this particular duck..."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_grey"
	item_state = "rubberducky_grey"

/obj/item/bikehorn/rubberducky/green_harmless
	name = "rubber ducky"
	desc = "Like a true Nature’s child, we were born, born to be wild."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_green"
	item_state = "rubberducky_green"

/obj/item/bikehorn/rubberducky/white_harmless
	name = "rubber ducky"
	desc = "It's so full of energy, such a happy little guy, I just wanna give him a squeeze."	//thanks doohl
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_white"
	item_state = "rubberducky_white"

/obj/item/grenade/anti_photon/rubberducky/black_harmless
	desc = "Good work NanoTrasen Employee, you struck fear within the Syndicate."
	name = "rubber ducky"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_black"
	item_state = "rubberducky_black"

/obj/item/bikehorn/rubberducky/gold_harmless
	name = "rubber ducky"
	desc = "You could give your very life for this duck."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_gold"
	item_state = "rubberducky_gold"

/obj/item/bikehorn/rubberducky/viking_harmless
	name = "rubber ducky"
	desc = "Honking is a duckie exclusive power."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_viking"
	item_state = "rubberducky_viking"
	honk_sound = 'sound/voice/scream_jelly_m1.ogg'
	honk_text = "DUK ROH DAH!"

/obj/item/bikehorn/rubberducky/galaxy_harmless
	name = "rubber ducky"
	desc = "In the vastness of space all things center around thing, somewhere, a core."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky_galaxy"
	item_state = "rubberducky_galaxy"
