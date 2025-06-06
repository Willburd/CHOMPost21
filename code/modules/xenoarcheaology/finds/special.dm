//endless reagents!
/obj/item/reagent_containers/glass/replenishing
	var/spawning_id

/obj/item/reagent_containers/glass/replenishing/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	for(var/x=1;x<=10;x++) //You got 10 chances to hit a reagent that is NOT banned.
		var/new_chem = pick(SSchemistry.chemical_reagents)
		if(new_chem in GLOB.obtainable_chemical_blacklist)
			continue
		else
			spawning_id = new_chem
			break
/obj/item/reagent_containers/glass/replenishing/process()
	reagents.add_reagent(spawning_id, 0.3)



//a talking gas mask!
/obj/item/clothing/mask/gas/poltergeist
	var/list/heard_talk = list()
	var/last_twitch = 0
	var/max_stored_messages = 100

/obj/item/clothing/mask/gas/poltergeist/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/mask/gas/poltergeist/process()
	if(heard_talk.len && isliving(src.loc) && prob(10))
		var/mob/living/M = src.loc
		M.say(pick(heard_talk))

/obj/item/clothing/mask/gas/poltergeist/hear_talk(mob/M, list/message_pieces, verb)
	..()
	if(heard_talk.len > max_stored_messages)
		heard_talk.Remove(pick(heard_talk))
	heard_talk.Add(multilingual_to_message(message_pieces))
	if(isliving(src.loc) && world.time - last_twitch > 50)
		last_twitch = world.time



//a vampiric statuette
//todo: cult integration
/obj/item/vampiric
	name = "statuette"
	icon_state = "statuette"
	icon = 'icons/obj/xenoarchaeology.dmi'
	var/charges = 0
	var/list/nearby_mobs = list()
	var/last_bloodcall = 0
	var/bloodcall_interval = 50
	var/last_eat = 0
	var/eat_interval = 100
	var/wight_check_index = 1
	var/list/shadow_wights = list()

/obj/item/vampiric/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/vampiric/process()
	//see if we've identified anyone nearby
	if(world.time - last_bloodcall > bloodcall_interval && nearby_mobs.len)
		var/mob/living/carbon/human/M = pop(nearby_mobs)
		if((M in view(7,src)) && M.health > 20)
			if(prob(50))
				bloodcall(M)
				nearby_mobs.Add(M)

	//suck up some blood to gain power
	if(world.time - last_eat > eat_interval)
		var/obj/effect/decal/cleanable/blood/B = locate() in range(2,src)
		if(B)
			last_eat = world.time
			B.loc = null
			if(istype(B, /obj/effect/decal/cleanable/blood/drip))
				charges += 0.25
			else
				charges += 1
				playsound(src, 'sound/effects/splat.ogg', 50, 1, -3)

	//use up stored charges
	if(charges >= 10)
		charges -= 10
		var/new_object = pick(/obj/item/soulstone, /obj/item/melee/artifact_blade, /obj/item/book/tome, /obj/item/clothing/head/helmet/space/cult, /obj/item/clothing/suit/space/cult, /obj/structure/constructshell, /obj/item/clothing/shoes/cult)
		new new_object(pick(RANGE_TURFS(1,src)))
		playsound(src, 'sound/effects/ghost.ogg', 50, 1, -3)

	if(charges >= 3)
		if(prob(5))
			charges -= 1
			var/spawn_type = pick(/mob/living/simple_mob/creature)
			new spawn_type(pick(RANGE_TURFS(1,src)))
			playsound(src, pick('sound/hallucinations/growl1.ogg','sound/hallucinations/growl2.ogg','sound/hallucinations/growl3.ogg'), 50, 1, -3)

	if(charges >= 1)
		if(shadow_wights.len < 5 && prob(5))
			shadow_wights.Add(new /obj/effect/shadow_wight(src.loc))
			playsound(src, 'sound/effects/ghost.ogg', 50, 1, -3)
			charges -= 0.1

	if(charges >= 0.1)
		if(prob(5))
			src.visible_message(span_red("[icon2html(src,viewers(src))] [src]'s eyes glow ruby red for a moment!"))
			charges -= 0.1

	//check on our shadow wights
	if(shadow_wights.len)
		wight_check_index++
		if(wight_check_index > shadow_wights.len)
			wight_check_index = 1

		var/obj/effect/shadow_wight/W = shadow_wights[wight_check_index]
		if(isnull(W))
			shadow_wights.Remove(wight_check_index)
		else if(isnull(W.loc))
			shadow_wights.Remove(wight_check_index)
		else if(get_dist(W, src) > 10)
			shadow_wights.Remove(wight_check_index)

/obj/item/vampiric/hear_talk(mob/M, list/message_pieces, verb)
	..()
	if(world.time - last_bloodcall >= bloodcall_interval && (M in view(7, src)))
		bloodcall(M)

/obj/item/vampiric/proc/bloodcall(var/mob/living/carbon/human/M)
	last_bloodcall = world.time
	if(istype(M))
		playsound(src, pick('sound/hallucinations/wail.ogg','sound/hallucinations/veryfar_noise.ogg','sound/hallucinations/far_noise.ogg'), 50, 1, -3)
		nearby_mobs.Add(M)

		var/target = pick(M.organs_by_name)
		M.apply_damage(rand(5, 10), BRUTE, target)
		to_chat(M, span_red("The skin on your [parse_zone(target)] feels like it's ripping apart, and a stream of blood flies out."))
		var/obj/effect/decal/cleanable/blood/splatter/animated/B = new(M.loc)
		B.target_turf = pick(range(1, src))
		B.add_blooddna(M.dna,M)
		M.remove_blood(rand(25,50))

//animated blood 2 SPOOKY
/obj/effect/decal/cleanable/blood/splatter/animated
	var/turf/target_turf
	var/loc_last_process

/obj/effect/decal/cleanable/blood/splatter/animated/Initialize(mapload, _age)
	. = ..()
	START_PROCESSING(SSobj, src)
	loc_last_process = src.loc

/obj/effect/decal/cleanable/blood/splatter/animated/process()
	if(target_turf && src.loc != target_turf)
		step_towards(src,target_turf)
		if(src.loc == loc_last_process)
			target_turf = null
		loc_last_process = src.loc

		//leave some drips behind
		if(prob(50))
			var/obj/effect/decal/cleanable/blood/drip/D = new(src.loc)
			D.init_forensic_data().merge_blooddna(forensic_data)
			if(prob(50))
				D = new(src.loc)
				D.init_forensic_data().merge_blooddna(forensic_data)
				if(prob(50))
					D = new(src.loc)
					D.init_forensic_data().merge_blooddna(forensic_data)
	else
		..()

/obj/effect/shadow_wight
	name = "shadow wight"
	icon = 'icons/mob/mob.dmi'
	icon_state = "shade"
	density = TRUE

/obj/effect/shadow_wight/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/shadow_wight/process()
	if(src.loc)
		src.loc = get_turf(pick(orange(1,src)))
		var/mob/living/carbon/M = locate() in src.loc
		if(M)
			playsound(src, pick('sound/hallucinations/behind_you1.ogg',\
			'sound/hallucinations/behind_you2.ogg',\
			'sound/hallucinations/i_see_you1.ogg',\
			'sound/hallucinations/i_see_you2.ogg',\
			'sound/hallucinations/im_here1.ogg',\
			'sound/hallucinations/im_here2.ogg',\
			'sound/hallucinations/look_up1.ogg',\
			'sound/hallucinations/look_up2.ogg',\
			'sound/hallucinations/over_here1.ogg',\
			'sound/hallucinations/over_here2.ogg',\
			'sound/hallucinations/over_here3.ogg',\
			'sound/hallucinations/turn_around1.ogg',\
			'sound/hallucinations/turn_around2.ogg',\
			), 50, 1, -3)
			to_chat(M, span_cult("The [src] phases right into your body, your entire form feeling cold and numb!")) //You just had a ghost possess / take residence you...YEAH, it's going to be alarming!
			M.visible_message(span_cult("[M]'s body glows bright red for a moment as glyphs spread across their form!")) //Let's try something fancy.
			M.Sleeping(rand(5, 10))

			src.loc = null
	else
		STOP_PROCESSING(SSobj, src)
		qdel(src) //Let's not just sit in nullspace forever, yeah?

/obj/effect/shadow_wight/Bump(var/atom/obstacle)
	to_chat(obstacle, span_red("You feel a chill run down your spine!"))
