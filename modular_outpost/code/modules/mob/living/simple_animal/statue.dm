// A mob which only moves when it isn't being watched by living beings.
//Weeping angels/SCP-173 hype
//Horrible shitcoding and stolen code adaptations below. You have been warned.
//Above comment has been cleaned by the holy light of someone who knows vaguely what they are doing, and was told their ideas were pretty neato. - Willbird
var/global/statue_photos_allowed = 3 // Photos can spawn statues... Lets not let this be easily abused! Admins can manually set this if they want more during a round...

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

	movement_cooldown = -1 // Very fast
	base_attack_cooldown = 1 SECOND
	harm_intent_damage = 60
	melee_damage_lower = 50
	melee_damage_upper = 70
	attacktext = "clawed"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	response_help = "touches"
	response_disarm = "pushes"

	AI_ignores = TRUE // Nothing responds to this but players
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS

	ai_holder_type = /datum/ai_holder/simple_mob/intentional/statue
	var/datum/weakref/cached_watcher = null
	var/banishable = 0 // If the chaplain has any power here
	var/view_range = 8

	var/player_has_activated = FALSE // if true, allows it to start going to random places if bored
	var/bordom_counter = 500

// Cannot talk
/mob/living/simple_mob/animal/statue/say(var/message, var/datum/language/speaking = null, var/whispering = 0)
	return 0

// Turn to dust when killed
/mob/living/simple_mob/animal/statue/death()
	if(stat != DEAD)
		stat = DEAD
		dust()

// Turn to dust when gibbed
/mob/living/simple_mob/animal/statue/gib()
	if(stat != DEAD)
		stat = DEAD
		dust()

/mob/living/simple_mob/animal/statue/Life()
	. = ..()
	if(player_has_activated)
		bordom_counter--
	if(bordom_counter <= 0)
		// Could be any landmark, this is just good for our own map - Outpost 21
		bordom_counter = rand(4 MINUTES,8 MINUTES)
		var/list/jump_list = list()
		for(var/obj/effect/landmark/R in landmarks_list)
			if(R.name == "redexit")
				jump_list += R
		// Jump to a landmark if noone is looking at it
		var/obj/effect/landmark/GOAL = pick(jump_list)
		var/list/scanlist = oviewers(view_range, GOAL)
		if(scanlist.len == 0)
			forceMove(GOAL.loc)
			// Lets make it more fun
			for(var/obj/machinery/light/L in oview(12, loc))
				L.flicker(rand(20, 50))
				if(prob(40))
					L.broken()

/mob/living/simple_mob/animal/statue/attackby(var/obj/item/O as obj, var/mob/user as mob) //banishing the statue is a risky job
	if(istype(O, /obj/item/nullrod))
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
		animate_movement = SLIDE_STEPS
		return MOVEMENT_ON_COOLDOWN
	animate_movement = NO_STEPS // Do not animate movement, you jump around as you're a scary statue.
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
	// Preclear
	cached_watcher = null

	// Mirrors
	var/list/nearview = view(6, src)
	for(var/obj/structure/mirror/M in nearview) //Weeping angels hate mirrors. Probably because they're ugly af
		if((!M.shattered )||(!M.glass))
			cached_watcher = WEAKREF(M) //if it sees the mirror, it sees itself, right?
			return
 	// lamps
	for(var/obj/item/flashlight/F in nearview)
		if(F.on)
			cached_watcher = WEAKREF(F)
			return

	// floodlights
	for(var/obj/machinery/floodlight/F in nearview)
		if(F.on)
			cached_watcher = WEAKREF(F)
			return

	// loop for viewers. This is kinda terrible and needs to be optimizied further.
	var/list/mainview = viewers(view_range, src) - src
	for(var/mob/living/M in mainview)
		if(!check_mob_blind(M))
			var/turf/T = get_turf(src)
			if(T && T.get_lumcount() < 0.05) // No one can see us in the darkness, right? WRONG! Damn cats.
				if(M.see_in_dark > 5)
					bordom_reset(M.client)
					cached_watcher = WEAKREF(M)
					return
			bordom_reset(M.client)
			cached_watcher = WEAKREF(M)
			return

	// Mech check
	for(var/obj/mecha/M in mainview) //assuming if you can see them they can see you
		if(M.occupant && M.occupant.client)
			if(!check_mob_blind(M.occupant))
				bordom_reset(M.occupant.client)
				cached_watcher = WEAKREF(M.occupant)
				return

/mob/living/simple_mob/animal/statue/proc/bordom_reset(var/player)
	if(player)
		player_has_activated = TRUE
	bordom_counter = rand(900,2000)

/mob/living/simple_mob/animal/statue/proc/check_mob_blind(var/mob/living/M)
	if(isanimal(M))
		return M.blinded || (M.eye_blurry && prob(5)) || prob(20) // close enough to blinking for dumb animals
	if(M.isSynthetic())
		return M.blinded || (M.eye_blurry && prob(5))
	return ((M.sdisabilities & BLIND) || (M.blinded) || (M.eye_blurry && prob(5)))

/*
	statue AI
*/

/datum/ai_holder/simple_mob/intentional/statue
	hostile = TRUE
	vision_range = 35
	wander = TRUE
	can_flee = FALSE
	flee_when_dying = FALSE
	returns_home = FALSE
	threaten = FALSE
	mauling = TRUE

	use_astar = TRUE
	maximum_path_distance = 25
	intelligence_level = AI_SMART

	var/annoyance = 0 //stop staring you creep
	var/can_retaliate = TRUE //prevent spamming abilities

/datum/ai_holder/simple_mob/intentional/statue/handle_special_strategical()
	// Scan for if we're being watched. I've no idea how to handle this better, needs to be a pretty consistant update... At least everything else reads a cached state of it...
	var/mob/living/simple_mob/animal/statue/S = holder
	var/mob/watching = S.get_watcher()
	var/turf/T = get_turf(holder.loc)
	if(prob(40) || T.get_lumcount() < 0.1) // 40% chance to update watchers, but if we have a watcher and the rooms dark... Check faster.
		S.update_watcher()
		watching = S.get_watcher()
	if(watching)
		// Target watchers if irritated
		if(target && prob(annoyance) && istype(watching,/mob/living))
			if(get_dist(holder,watching) < get_dist(holder,target) && can_attack(watching))
				give_target(watching)
		//so it won't blind people 24/7
		if(can_retaliate)
			can_retaliate = FALSE
			if (annoyance > 10)
				if(prob(40 + annoyance) && istype(watching,/obj/structure/mirror))
					ability_mirrorshmash()
					lose_target() // stops target lockups
				else if(prob(30 + annoyance) && istype(watching,/obj/item/flashlight))
					var/obj/item/flashlight/F = watching
					if(F.on)
						F.visible_message("<span class='warning'>\The [F] flickers before going dull.</span>")
						playsound(F, 'sound/effects/sparks3.ogg', 10, 1, -3) //Small cue that your light went dull in your pocket. //VOREStation Edit
						F.on = 0
						F.update_brightness()
					lose_target() // stops target lockups
				else if(prob(30 + annoyance) && istype(watching,/obj/machinery/floodlight))
					var/obj/machinery/floodlight/F = watching
					if(F.on)
						F.visible_message("<span class='warning'>\The [F] flickers before going dull.</span>")
						F.turn_off(1)
					lose_target() // stops target lockups
				else if(prob(20 + (annoyance/2)))
					ability_blind()
					lose_target() // stops target lockups
				else if(prob(30) && T.get_lumcount() > 0.1)
					ability_flash()
					lose_target() // stops target lockups
				annoyance -= 5
			spawn(rand(10,30))
				can_retaliate = TRUE
		// Slowly get more grumpy
		if((annoyance + 1) < 800)
			annoyance += 1
	else if ((annoyance - 2) > 0)
		annoyance -= 2
	// punish pulling
	if(holder.pulledby)
		blind_target(holder.pulledby,FALSE)
		holder.pulledby.stop_pulling()
		holder.pulledby.Stun(4)
	if(holder.grabbed_by.len > 0)
		for(var/obj/item/grab/G in holder.grabbed_by)
			if(G.assailant != holder)
				blind_target(G.assailant,FALSE)
				G.assailant.Stun(4)
				qdel(G)

/datum/ai_holder/simple_mob/intentional/statue/can_attack(atom/movable/the_target, vision_required)
	if(isanimal(the_target))
		return FALSE
	. = ..()

/datum/ai_holder/simple_mob/intentional/statue/should_wander()
	var/mob/living/simple_mob/animal/statue/S = holder
	if(S.is_being_watched())
		return FALSE
	. = ..()

// Powers
/datum/ai_holder/simple_mob/intentional/statue/proc/ability_blind()
	var/mob/living/simple_mob/animal/statue/S = holder
	for(var/mob/living/L in oviewers(S.view_range, get_turf(S)))
		if(prob(90))
			blind_target(L)
	return

/datum/ai_holder/simple_mob/intentional/statue/proc/blind_target(var/mob/L,var/show_messages = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if (H.species == SPECIES_DIONA || H.species == SPECIES_PROMETHEAN || H.species == SPECIES_PROTEAN) // can't blink and organic
			return
	if(L.isSynthetic())
		if(show_messages)
			to_chat(L, span_cult(pick("Your camera flickers.","Your video feed flashes to static.")))
		spawn(5)
			L.eye_blurry += 20
			L.Life() // Hacky but gets instant feedback
	else
		if(show_messages)
			to_chat(L, span_cult(pick("Your eyes feel very heavy.", "You blink suddenly!", "Your eyes close involuntarily!")))
		spawn(5)
			L.Blind(2)
			L.Life() // Hacky but gets instant feedback

/datum/ai_holder/simple_mob/intentional/statue/proc/ability_flash()
	var/get_L = null
	for(var/obj/machinery/light/L in oview(12, holder))
		get_L = L
		L.flicker(rand(40, 90))
		spawn(rand(15,50))
			if(prob(50 + annoyance))
				L.broken()
	if(get_L)
		holder.visible_message(span_cult("\The [holder] slowly points at \the [get_L]."))
	return

/datum/ai_holder/simple_mob/intentional/statue/proc/ability_mirrorshmash()
	var/mob/living/simple_mob/animal/statue/S = holder
	var/list/mirrors = list()
	var/get_M = null
	for(var/obj/structure/mirror/M in oview(S.view_range, holder))
		if ((!M.shattered )||(!M.glass))
			get_M = M
			mirrors.Add(WEAKREF(M))
	if(get_M)
		holder.visible_message(span_cult("\The [holder] slowly points at \the [get_M]."))
	if(mirrors.len)
		set_busy(TRUE)
		spawn(2 SECONDS)
			for(var/datum/weakref/WM in mirrors)
				if(!WM)
					continue
				var/obj/structure/mirror/M = WM.resolve()
				if(M)
					M.shatter()
			set_busy(FALSE)
	return
