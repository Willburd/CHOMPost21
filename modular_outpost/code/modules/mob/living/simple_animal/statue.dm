// A mob which only moves when it isn't being watched by living beings.
//Weeping angels/SCP-173 hype
//Horrible shitcoding and stolen code adaptations below. You have been warned.
//Above comment has been cleaned by the holy light of someone who knows vaguely what they are doing, and was told their ideas were pretty neato. - Willbird
/mob/living/simple_mob/animal/statue
	name = "statue" // matches the name of the statue with the flesh-to-stone spell
	desc = "An incredibly lifelike marble statue, depicting an angellic figure." // same as an ordinary statue with the added "eye following you" description
	tt_desc = "angelum weepicus"

	icon = 'icons/obj/statue_ch.dmi'
	icon_state = "Angel_Female_ch"
	icon_living = "Angel_Female_ch"
	icon_dead = "Angel_Female_ch"

	faction = "statue"
	maxHealth = 50000
	health = 50000

	has_hands = TRUE
	enzyme_affect = FALSE
	a_intent = I_HURT

	layer = MOB_LAYER
	mob_size = MOB_HUGE
	density = TRUE
	status_flags = CANPUSH
	mob_bump_flag = HEAVY
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY

	see_in_dark = 13
	universal_understand = 1

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 9000

	base_attack_cooldown = 1 SECOND
	harm_intent_damage = 60
	melee_damage_lower = 50
	melee_damage_upper = 70
	attacktext = "clawed"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	movement_cooldown = -1 // Very fast
	animate_movement = NO_STEPS // Do not animate movement, you jump around as you're a scary statue.

	response_help = "touches"
	response_disarm = "pushes"

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS

	ai_holder_type = /datum/ai_holder/simple_mob/intentional/statue
	var/datum/weakref/cached_watcher = null
	var/banishable = 0 // If the chaplain has any power here
	var/view_range = 8

// Cannot talk
/mob/living/simple_mob/animal/statue/say(var/message, var/datum/language/speaking = null, var/whispering = 0)
	return 0

// Turn to dust when killed
/mob/living/simple_mob/animal/statue/death()
	dust()

// Turn to dust when gibbed
/mob/living/simple_mob/animal/statue/gib()
	dust()

/mob/living/simple_mob/animal/statue/attackby(var/obj/item/O as obj, var/mob/user as mob) //banishing the statue is a risky job
	if(istype(O, /obj/item/weapon/nullrod))
		visible_message("<span class='warning'>[user] tries to banish [src] with [O]!</span>")
		if(do_after(user, 15, src))
			if(banishable)
				visible_message("<span class='warning'>[src] crumbles into dust!</span>")
				gib()
			else
				visible_message("<span class='warning'>[src] is too strong to be banished!</span>")
				Paralyse(rand(8,15))
		return
	. = ..()

/mob/living/simple_mob/animal/statue/attack_target(mob/living/L)
	if(is_being_watched())
		return FALSE
	. = ..()

/mob/living/simple_mob/animal/statue/IMove(turf/newloc, safety = TRUE)
	update_watcher() // Directly update it here. Otherwise it'll be tied to just the AI's strat updates
	if(is_being_watched())
		return MOVEMENT_ON_COOLDOWN
	. = ..()

/mob/living/simple_mob/animal/statue/face_atom(var/atom/A)
	if(is_being_watched())
		return
	. = ..()

// Use these when checking... Limit the update_watcher() proc's use as much as possible
/mob/living/simple_mob/animal/statue/proc/is_being_watched()
	return !isnull(get_watcher())

/mob/living/simple_mob/animal/statue/proc/get_watcher()
	if(isnull(cached_watcher))
		return null
	return cached_watcher.resolve()

/mob/living/simple_mob/animal/statue/proc/update_watcher()
	// Mirrors
	for(var/obj/structure/mirror/M in view(3, src)) //Weeping angels hate mirrors. Probably because they're ugly af
		if((!M.shattered )||(!M.glass))
			cached_watcher = WEAKREF(src) //if it sees the mirror, it sees itself, right?
			return

	// loop for viewers. This is kinda terrible and needs to be optimizied further.
	for(var/mob/living/M in viewers(view_range, src) - src)
		if(!check_mob_blind(M))
			var/turf/T = get_turf(src)
			if(T && T.get_lumcount() < 0.04) // No one can see us in the darkness, right? WRONG! Damn cats.
				if(M.see_in_dark > 5)
					cached_watcher = WEAKREF(M)
					return
			cached_watcher = WEAKREF(M)
			return

	// Mech check
	for(var/obj/mecha/M in view(view_range, src)) //assuming if you can see them they can see you
		if(M.occupant && M.occupant.client)
			if(!check_mob_blind(M.occupant))
				cached_watcher = WEAKREF(M.occupant)
				return

	cached_watcher = null
	return

/mob/living/simple_mob/animal/statue/proc/check_mob_blind(var/mob/living/M)
	if(M.isSynthetic())
		return M.blinded || (M.eye_blurry && prob(5))
	return ((M.sdisabilities & BLIND) || (M.blinded) || (M.eye_blurry && prob(5)))

/*
	statue AI
*/

/datum/ai_holder/simple_mob/intentional/statue
	hostile = TRUE
	vision_range = 35
	wander = FALSE
	can_flee = FALSE
	flee_when_dying = FALSE
	returns_home = FALSE
	threaten = FALSE

	use_astar = FALSE // Temporary until unbroken
	maximum_path_distance = 15
	intelligence_level = AI_SMART

	var/annoyance = 0 //stop staring you creep
	var/can_retaliate = TRUE //prevent spamming abilities

/datum/ai_holder/simple_mob/intentional/statue/handle_special_strategical()
	// Scan for if we're being watched. I've no idea how to handle this better, needs to be a pretty consistant update... At least everything else reads a cached state of it...
	var/mob/living/simple_mob/animal/statue/S = holder
	var/mob/watching = S.get_watcher()
	var/turf/T = get_turf(holder.loc)
	if(prob(20) || (watching && T.get_lumcount() < 0.04)) // 20% chance to update watchers, but if we have a watcher and the rooms dark... Check faster.
		S.update_watcher()
		watching = S.get_watcher()
	if(watching)
		// Handle annoyances
		if(istype(watching,/obj/structure/mirror))
			annoyance += 2
			if(prob(annoyance))
				if(can_retaliate)
					ability_mirrorshmash()
					annoyance -= 50
					spawn(rand(20,50))
						can_retaliate = TRUE
		//so it won't blind people 24/7
		if(can_retaliate)
			can_retaliate = FALSE
			if (annoyance > 30)
				if(prob(30) && T.get_lumcount() > 0.15)
					ability_flash()
					annoyance -= 30
				else if(prob(40))
					ability_blind()
					annoyance -= 30
			spawn(rand(20,50))
				can_retaliate = TRUE
		// Slowly get more grumpy
		if((annoyance + 1) < 800)
			annoyance += 1
	else if ((annoyance - 2) > 0)
		annoyance -= 2

// Powers
/datum/ai_holder/simple_mob/intentional/statue/proc/ability_blind()
	for(var/mob/living/L in oviewers(6, holder))
		if (prob(70))
			if(ishuman(L))
				var/mob/living/carbon/human/H = L
				if (H.species == SPECIES_DIONA || H.species == SPECIES_PROMETHEAN || H.species == SPECIES_PROTEAN) // can't blink and organic
					return
			to_chat(L, SPAN_OCCULT(pick("Your eyes feel very heavy.", "You blink suddenly!", "Your eyes close involuntarily!")))
			spawn(5)
				L.Blind(3)
				L.Life() // Hacky but gets instant feedback
	return

/datum/ai_holder/simple_mob/intentional/statue/proc/ability_flash()
	if(prob(60))
		holder.visible_message(SPAN_OCCULT("The statue slowly points at a light."))
		for(var/obj/machinery/light/L in oview(12, holder))
			L.flicker(rand(20, 50))
		var/area/A = get_area(holder.loc)
		// Kill the lights if they were on, flickering barely works!
		if(prob(40))
			spawn(rand(15,35))
				if(A && A.lightswitch)
					A.lightswitch = FALSE
					spawn(rand(5,25))
						A.lightswitch = TRUE
	return

/datum/ai_holder/simple_mob/intentional/statue/proc/ability_mirrorshmash()
	var/list/mirrors = list()
	for(var/obj/structure/mirror/M in oview(4, holder))
		if ((!M.shattered )||(!M.glass))
			if(mirrors.len == 0)
				set_busy(TRUE)
				holder.visible_message(SPAN_OCCULT("The statue slowly points at a mirror."))
			mirrors.Add(WEAKREF(M))
	if(mirrors.len)
		spawn(2 SECONDS)
			for(var/datum/weakref/WM in mirrors)
				if(!WM)
					continue
				var/obj/structure/mirror/M = WM.resolve()
				if(M)
					M.shatter()
			set_busy(FALSE)
	return
