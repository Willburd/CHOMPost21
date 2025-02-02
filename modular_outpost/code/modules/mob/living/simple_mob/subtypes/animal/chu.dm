/datum/category_item/catalogue/fauna/chu
	name = "Majoraes Fauna - Chu'uraka Parasite"
	desc = "TODO - chu description"
	value = CATALOGUER_REWARD_HARD

// Chu noises
/datum/say_list/chu
	speak = list()
	emote_hear = list("hiss","giggles","hiss","hiss")
	emote_see = list("twitches")
	threaten_sound = 'sound/voice/hiss4.ogg'
	stand_down_sound = 'sound/voice/hiss3.ogg'

/mob/living/simple_mob/vore/alienanimals/chu
	name = "chu"
	real_name = "chu"
	desc = "A \"friendly\" creature that wanders maintenance."
	tt_desc = "Chitter"
	player_msg = "Eat others, and infest them with your strange parasitic powers!"

	icon = 'modular_outpost/icons/mob/animal.dmi'
	icon_state = "chu"
	icon_living = "chu"
	icon_dead = "chu_dead"
	icon_rest = "chu_rest"
	kitchen_tag = "rodent"

	faction = "chu"
	glow_range = 2
	glow_toggle = 1
	glow_color = "#75ebeb"

	can_be_antagged = TRUE

	// durable...
	maxHealth = 90
	health = 90
	enzyme_affect = FALSE

	universal_understand = 1
	melee_damage_lower = 4
	melee_damage_upper = 6
	base_attack_cooldown = 1 SECOND
	attacktext = list("bit", "chomped", "scratched")

	movement_cooldown = 0
	animate_movement = SLIDE_STEPS

	layer = MOB_LAYER

	pass_flags = PASSTABLE

	vore_default_mode = DM_HOLD
	vore_active = TRUE
	vore_standing_too = TRUE
	vore_capacity = 2
	vore_pounce_chance = 20

	nutrition = 500 // to prevent hunger issues at start

	has_hands = FALSE
	response_help  = "pets"
	response_disarm = "pushes aside"
	response_harm   = "stamps on"

	catalogue_data = list(/datum/category_item/catalogue/fauna/chu)

	has_langs = list(LANGUAGE_CHU)
	meat_type = /obj/item/reagent_containers/food/snacks/meat

	say_list_type = /datum/say_list/chu
	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive/chu
	melee_attack_delay = 0	// For some reason, having a delay makes item pick-up not work.

	var/isinfesting = FALSE
	var/isOriginal = TRUE
	var/list/overlay_colors = list(
		"Body" = "#FFFFFF",
		"Eyes" = "#FFFFFF",
		"Blood" = "#FFFFFF"
	)

/mob/living/simple_mob/vore/alienanimals/chu/Initialize()
	. = ..()
	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide
	verbs += /mob/living/simple_mob/vore/alienanimals/chu/proc/infest
	update_icon()

/mob/living/simple_mob/vore/alienanimals/chu/proc/infest()
	set category = "Abilities"
	set name = "Infest Prey"

	// select bellied prey one by one!
	if(stat == DEAD)
		to_chat(src, "<span class='warning'>You are too dead to be infesting anything!</span>")
		return

	if(isinfesting)
		to_chat(src, "<span class='warning'>You are already infesting someone!</span>")
		return

	var/obj/belly/foundbelly = null
	var/mob/living/foundprey = null
	if(!isnull(vore_organs) && vore_organs.len > 0)
		for(var/obj/belly/B in vore_organs)
			for(var/mob/living/L in B)
				if(L.stat <= UNCONSCIOUS)
					continue
				if(issilicon(L) || isrobot(L) || L.isSynthetic())
					continue
				if(ishuman(L))
					var/mob/living/carbon/human/Hu = L
					if(istype(Hu.wear_suit, /obj/item/clothing/suit/space) && istype(Hu.head,/obj/item/clothing/head/helmet/space))
						continue
				if(istype(L,/mob/living/simple_mob/vore/alienanimals/chu))
					continue
				foundprey = L
				foundbelly = B
				break
			// allow us to still give feedback! Attempt loop again but with no restrictions
			if(isnull(foundprey))
				for(var/mob/living/L in B)
					foundprey = L
					foundbelly = B
					break
	else
		to_chat(src, "<span class='warning'>Remember to set your bellies! A chu can only infest things they have eaten!</span>")
		return

	if(isnull(foundprey) || isnull(foundbelly))
		to_chat(src, "<span class='warning'>You must have prey inside you to infest them!</span>")
		return

	if(!isliving(foundprey) || (ishuman(foundprey) && foundprey.isSynthetic()) || isrobot(foundprey) || issilicon(foundprey))
		to_chat(src, "<span class='warning'>\The [foundprey] is not compatible with our biology.</span>")
		return

	if(ishuman(foundprey))
		var/mob/living/carbon/human/Hu = foundprey
		if(istype(Hu.wear_suit, /obj/item/clothing/suit/space) && istype(Hu.head,/obj/item/clothing/head/helmet/space))
			to_chat(src, "<span class='warning'>Your body cannot penetrate \the [foundprey]'s suit!</span>")
			return

	if(foundprey.stat == DEAD)
		to_chat(src, "<span class='warning'>\The [foundprey] is dead!</span>")
		return

	if(istype(foundprey,/mob/living/simple_mob/vore/alienanimals/chu))
		to_chat(src, "<span class='warning'>\The [foundprey] is already a chu!</span>")
		return

	// convert others to chus!
	var/mob/living/carbon/human/T = foundprey
	isinfesting = TRUE
	for(var/stage = 1, stage<=3, stage++)
		switch(stage)
			if(1)
				to_chat(src, "<span class='notice'>[foundprey] is being infested. Hold still...</span>")
				to_chat(foundprey, "<span class='danger'>You feel something strange begin to happen...</span>")
			if(2)
				to_chat(src, "<span class='notice'>You begin to press close to [foundprey].</span>")
				to_chat(foundprey, "<span class='warning'>[src] presses uncomfortably close, crushing you inside of them!</span>")
				if(ishuman(foundprey))
					T.emote("gasp")
			if(3)
				to_chat(src, "<span class='notice'>You begin to sink [foundprey] into yourself, you are becoming one!</span>")
				to_chat(foundprey, "<span class='danger'>You begin to sink into [src]'s body, it feels like you're being torn apart at the seams!</span>")

				if(ishuman(foundprey))
					T.emote("scream")
					var/obj/item/organ/external/affecting = T.get_organ(BP_TORSO)
					if(affecting.take_damage(12,0,1,0,"infesting mass"))
						T.UpdateDamageIcon()
				add_attack_logs(src,T,"Infest (chu)")

		if(!do_mob(src, foundprey, 90))
			to_chat(src, "<span class='warning'>Your infestation of [foundprey] has been interrupted!</span>")
			isinfesting = FALSE
			return
	isinfesting = FALSE

	if(foundprey.loc != foundbelly)
		to_chat(src, "<span class='warning'>[foundprey] has escaped our belly, your infestation has been interrupted!</span>")
		return

	var/hostname = foundprey.name
	to_chat(src, "<span class='notice'>You have infested [foundprey]!</span>")
	to_chat(foundprey, "<span class='danger'>You have been infested by \the [src]!</span>")

	var/allowghost = FALSE
	var/mob/living/simple_mob/vore/alienanimals/chu/CC = null
	if(!ishuman(foundprey) || !isnull(T.species.greater_form)) // Kinda hacky monkey check
		// simple conversion
		CC = new /mob/living/simple_mob/vore/alienanimals/chu(foundprey.loc)
		if(!isnull(foundprey.key))
			CC.key = foundprey.key
		else
			allowghost = TRUE
	else
		// human infesting
		CC = T.chuify()
		CC.tt_desc = "Reminds you of [hostname]..."
		CC.desc = "A \"friendly\" creature that wanders maintenance. Has a superficial resemblance to [hostname]..."

	if(!isnull(CC))
		// transfer contents of prey to new body
		QDEL_LIST_NULL(CC.vore_organs)
		CC.vore_organs = list()
		for(var/obj/belly/PB as anything in foundprey.vore_organs)
			PB.loc = CC
			PB.forceMove(CC)
			PB.owner = CC
			foundprey.vore_organs -= PB
			CC.vore_organs += PB

		// release it! and destroy old body
		foundbelly.release_specific_contents(CC)
		foundprey.Destroy()
		CC.update_icon()
		update_icon() // self too

		// emote a bit
		sleep(rand(2,6))
		CC.emote(pick("choke","gasp"))

		// ghost check
		if(allowghost && isnull(CC.key))
			// ghost request
			var/datum/ghost_query/Q = new /datum/ghost_query/chu()
			var/list/winner = Q.query()
			if(winner.len)
				var/mob/observer/dead/D = winner[1]
				CC.key = D.key

	else if(!isnull(T))
		// what happened?
		foundbelly.release_specific_contents(T)

	// spit all the rest of if it's items
	if(!isnull(vore_organs) && vore_organs.len > 0)
		for(var/obj/belly/B in vore_organs)
			for(var/I in B)
				if(istype(I,/obj/item))
					B.release_specific_contents(I)	// spit out items
				if(isliving(I))
					var/mob/living/L = I
					if(L.stat == DEAD)
						B.release_specific_contents(I) // spit out dead mobs

/mob/living/simple_mob/vore/alienanimals/chu/update_icon()
	. = ..()
	cut_overlays()
	if(stat == DEAD)
		icon_state = icon_dead
	else if(lying || resting || sleeping > 0)
		icon_state = icon_rest
	else
		icon_state = icon_living

	// always handle belly overlay!
	if(stat != DEAD)
		var/hasbelly = FALSE
		if(!isnull(vore_organs) && vore_organs.len > 0)
			for(var/obj/belly/B in vore_organs)
				if(B.contents.len > 0)
					hasbelly = TRUE
					break
		if(hasbelly)
			var/mutable_appearance/I = mutable_appearance(icon,  "[icon_state]-belly")
			I.appearance_flags |= PIXEL_SCALE
			add_overlay(I)

	// overlays for cursed players~
	if(isOriginal)
		return

	var/mutable_appearance/I = mutable_appearance(icon,  "[icon_state]-fur")
	I.color = overlay_colors["Body"]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	add_overlay(I)

	if(stat != DEAD)
		I = mutable_appearance(icon,  "[icon_state]-eyes")
		I.color = overlay_colors["Eyes"]
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		I.blend_mode = BLEND_MULTIPLY
		add_overlay(I)
	else
		I = mutable_appearance(icon,  "[icon_state]-blood")
		I.color = overlay_colors["Blood"]
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		I.blend_mode = BLEND_MULTIPLY
		add_overlay(I)

/mob/living/simple_mob/vore/alienanimals/chu/Life()
	. = ..()
	// adjust sleep here, needs mind to sleep otherwise...
	// adding the check so this doesn't conflict with life/handle_regular_status_updates()
	// catslugs added simple mobs healing while resting... so i don't need to do that myself!
	if(stat != DEAD && !istype(loc,/obj/belly))
		if((!mind || !mind.active) && client == null)
			if(sleeping > 0)
				AdjustSleeping(-1)
				resting = (sleeping > 0)
				if(!resting)
					lying = FALSE
					update_icon()
			else if(icon_state == icon_rest)
				// resting when not sleeping?
				resting = FALSE
				lying = FALSE
				update_icon()
		else
			if(sleeping > 0)
				SetSleeping(0)
				lying = FALSE
				update_icon()

/datum/ai_holder/simple_mob/melee/evasive/chu
	hostile = TRUE
	can_flee = TRUE
	flee_when_outmatched = TRUE
	unconscious_vore = TRUE
	outmatched_threshold = 100
	max_home_distance = 50
	var/obj/machinery/atmospherics/unary/vent_pump/vent_found = null

/datum/ai_holder/simple_mob/melee/evasive/chu/handle_special_strategical()
	if(!isnull(vent_found))
		// sanity
		if(!vent_found.Adjacent(holder))
			vent_found = null
			return
		if(!(vent_found.loc.z in using_map.event_levels)) // how did you manage this? Shuttle?
			vent_found = null
			return

		// find a vent
		var/i = 5
		var/obj/machinery/attemptgoal
		while(i > 0)
			attemptgoal = pick(machines)
			if(istype(attemptgoal,/obj/machinery/atmospherics/unary/vent_pump))
				break;
			i--
		if(!istype(attemptgoal,/obj/machinery/atmospherics/unary/vent_pump))
			vent_found = null
			return
		var/obj/machinery/atmospherics/unary/vent_pump/goalvent = attemptgoal
		if(!(goalvent.loc.z in using_map.event_levels) || !goalvent.welded)
			vent_found = null
			return

		// attempt to ventcrawl!
		if(goalvent && vent_found.network && (vent_found.network.normal_members.len || vent_found.network.line_members.len))
			holder.set_AI_busy(1)

			holder.fade_towards(vent_found,45)
			holder.prepping_to_ventcrawl = 1
			spawn(50)
				holder.prepping_to_ventcrawl = 0
			if(!do_after(holder, 45, vent_found, 1, 1))
				return

			// spit out
			holder.set_AI_busy(0)
			holder.visible_message("<B>[holder] scrambles into the ventilation ducts!</B>", "You climb into the ventilation system.")
			holder.visible_message("You hear something squeezing through the ducts.", "You climb out the ventilation system.")
			holder.forceMove(goalvent.loc)
			var/turf/findhome = get_turf(holder)
			if(isturf(findhome))
				home_turf = findhome
			vent_found = null
		return

	if(holder.sleeping > 0)
		return

	// try stalking along with player chus
	if(!target && leader == null && prob(80))
		for(var/mob/living/simple_mob/vore/alienanimals/chu/C in range(4,holder))
			if(!isnull(C.key))
				// try to stick around player chus, they can just tell!
				set_follow(C, follow_for = 6 SECONDS)
				break

	if(leader != null && prob(55))
		if(prob(5))
			holder.emote(pick("giggle","hiss","hiss","hiss","twitches"))
			playsound(holder, pick('sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg') , 50, 0)
		var/turf/findhome = get_turf(holder)
		if(isturf(findhome))
			home_turf = findhome

	else if(prob(5))
		var/turf/findhome = get_turf(holder)
		if(isturf(findhome))
			home_turf = findhome

	var/wantcorrupt = FALSE
	if(!target && prob(20))
		if(!isnull(holder.vore_organs) || holder.vore_organs.len == 0)
			for(var/obj/belly/B in holder.vore_organs)
				for(var/thing in B)
					if(ishuman(thing))
						var/mob/living/carbon/human/H = thing
						if(!H.isSynthetic() && H.stat != DEAD)
							wantcorrupt = TRUE
						else
							B.release_specific_contents(thing)
					else
						B.release_specific_contents(thing)

		if(wantcorrupt)
			var/mob/living/simple_mob/vore/alienanimals/chu/C = holder
			C.infest()
			C.Sleeping(40)
			holder.update_icon()
			var/turf/findhome = get_turf(C)
			if(isturf(findhome))
				home_turf = findhome
		else if(prob(10) && holder.health < 30 && get_dist(holder, home_turf) < 40)
			holder.Sleeping(50)
			holder.update_icon()
			var/turf/findhome = get_turf(holder)
			if(isturf(findhome))
				home_turf = findhome

	else if((prob(10) && !target) ||(prob(60) && should_flee()))
		// VENT TIME
		if(holder.loc.z in using_map.event_levels)
			for(var/obj/machinery/atmospherics/unary/vent_pump/searchvent in holder.loc.contents)
				if(!searchvent.welded)
					vent_found = searchvent

/datum/ai_holder/simple_mob/melee/evasive/chu/react_to_attack(atom/movable/attacker, ignore_timers = FALSE)
	if(stance == STANCE_SLEEP) // If we're asleep, try waking up if someone's wailing on us.
		ai_log("react_to_attack() : AI is asleep. Waking up.", AI_LOG_TRACE)
		var/mob/living/simple_mob/vore/alienanimals/chu/C = holder
		C.SetSleeping(0)
		C.resting = FALSE
		C.lying = FALSE
		C.update_icons()

	return ..(attacker, ignore_timers)
