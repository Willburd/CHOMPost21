/mob/living/simple_mob/vore/horse/gift
	name = "gift horse"
	var/datum/effect/effect/system/confetti_spread

/mob/living/simple_mob/vore/horse/gift/Initialize(mapload)
	. = ..()
	start_effect_sprayer(confetti_spread, rand(2,3), 'sound/effects/confetti_ball.ogg')
	confetti_spread = new /datum/effect/effect/system/confetti_spread()
	confetti_spread.attach(src)
	QDEL_IN(src, 2 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(gifting)), 20 SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/vore/horse/gift/Destroy()
	QDEL_NULL(confetti_spread)
	new /obj/item/a_gift(loc)
	new /obj/item/a_gift(loc)
	new /obj/item/a_gift(loc)
	start_effect_sprayer(confetti_spread, rand(2,3), 'sound/effects/confetti_ball.ogg')
	. = ..()

/mob/living/simple_mob/vore/horse/gift/proc/gifting()
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	start_effect_sprayer(confetti_spread, rand(2,3), 'sound/effects/confetti_ball.ogg')
	if(prob(30))
		new /obj/item/a_gift(loc)
	addtimer(CALLBACK(src, PROC_REF(gifting)), rand(8,12) SECONDS, TIMER_DELETE_ME)

/mob/living/simple_mob/vore/horse/gift/proc/start_effect_sprayer(datum/effect/effect/system/spraying, duration, sound_play, start_data = null)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	playsound(loc, sound_play, 50, 1, -3)
	spraying.set_up(10, 0, loc)
	effect_spraying(spraying, duration, start_data)

/mob/living/simple_mob/vore/horse/gift/proc/effect_spraying(datum/effect/effect/system/spraying, duration, start_data)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	spraying.start(start_data)
	if(!duration)
		return
	addtimer(CALLBACK(src, PROC_REF(effect_spraying), spraying, --duration), 0.5 SECOND, TIMER_DELETE_ME)



// This is chaos
/obj/effect/falling_effect/gift_horse
	name = "PRESENTS!"
	crushing = TRUE

/obj/effect/falling_effect/gift_horse/Initialize(mapload)
	..()
	falling_type = /mob/living/simple_mob/vore/horse/gift
	return INITIALIZE_HINT_LATELOAD
