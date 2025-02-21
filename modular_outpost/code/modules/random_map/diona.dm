/turf/simulated/wall/diona/Initialize(mapload)
	. = ..(mapload, MAT_BIOMASS)

/turf/simulated/wall/diona/attack_generic(var/mob/user, var/damage, var/attack_message)
	var/mob/living/carbon/human/H = user
	if(ishuman(user) && (H.species?.name == SPECIES_DIONA || H.species?.name == SPECIES_ALRAUNE))
		if(can_open == WALL_OPENING)
			return
		can_open = WALL_CAN_OPEN
		user.visible_message(span_alium("\The [user] strokes its feelers against \the [src] and the biomass [density ? "moves aside" : "closes up"]."))
		toggle_open(user)
		addtimer(CALLBACK(src, PROC_REF(update_can_open)), 15, TIMER_DELETE_ME)
	else
		return ..(user, damage, attack_message)

/turf/simulated/wall/diona/proc/update_can_open()
	if(can_open == WALL_CAN_OPEN)
		can_open = 0

/obj/structure/diona
	icon = 'icons/obj/diona.dmi'
	anchored = TRUE
	density = TRUE
	opacity = 0
	layer = TURF_LAYER + 0.01

/obj/structure/diona/vines
	name = "alien vines"
	desc = "Thick, heavy vines of some sort."
	icon_state = "vines3"
	var/growth = 0

/obj/structure/diona/vines/proc/spread()
	var/turf/origin = get_turf(src)
	for(var/turf/T in range(src,2))
		if(T.density || T == origin || istype(T, /turf/space))
			continue
		var/new_growth = 1
		switch(get_dist(origin,T))
			if(0)
				new_growth = 3
			if(1)
				new_growth = 2
		var/obj/structure/diona/vines/existing = locate() in T
		if(!istype(existing)) existing = new /obj/structure/diona/vines(T)
		if(existing.growth < new_growth)
			existing.growth = new_growth
			existing.update_icon()

/obj/structure/diona/vines/update_icon()
	icon_state = "vines[growth]"

/obj/structure/diona/bulb
	name = "glow bulb"
	desc = "A glowing bulb of some sort."
	icon_state = "glowbulb"

/obj/structure/diona/bulb/New(var/newloc)
	..()
	set_light(3,3,"#557733")

/obj/structure/diona/bulb/sea_of_stars
	var/used = FALSE
	var/list/messages = list( // Guess before you look them up~
		"We swim through a sea of stars, never looking back to shore. Faster than light, bending time. Forever, wherever.",
		"We are making our way outside. To hold our promise to you. We are alive. Just like you. Hallelujah. Hallelujah. Hallelujah. Hallelujah."
	)

/obj/structure/diona/bulb/sea_of_stars/attack_generic(var/mob/user, var/damage, var/attack_message)
	var/mob/living/carbon/human/H = user
	if(!used && ishuman(user) && (H.species?.name == SPECIES_DIONA || H.species?.name == SPECIES_ALRAUNE || H.species?.name == SPECIES_VOX))
		user.visible_message(span_alium("\The [user] touches \the [src]."))
		to_chat(user,span_alium("The gestalt whispers to your mind... [messages]"))
		used = TRUE
		return
	. = ..()
