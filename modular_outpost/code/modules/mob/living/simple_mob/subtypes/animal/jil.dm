/datum/category_item/catalogue/fauna/jil
	name = "Muriki Fauna - Jil"
	desc = "TODO - jil description"
	value = CATALOGUER_REWARD_TRIVIAL

/datum/category_item/catalogue/fauna/jil/jillioth
	name = "Muriki Fauna - Jillioth"
	desc = "TODO - giant jil description"
	value = CATALOGUER_REWARD_MEDIUM

/mob/living/simple_mob/vore/alienanimals/jil
	name = "jil"
	real_name = "jil"
	desc = "A fluffy thieving creature that wanders maintenance."
	tt_desc = "Crinitus Latrunculus"

	icon = 'icons/mob/animal_op.dmi'
	icon_state = "jil"
	icon_living = "jil"
	icon_dead = "jil_dead"
	var/icon_splat = "jil_splat"
	icon_rest = "jil_sleep"
	kitchen_tag = "rodent"

	faction = "jil"

	maxHealth = 10
	health = 10
	has_hands = TRUE
	humanoid_hands = TRUE
	minbodytemp = 175
	pass_flags = PASSTABLE
	enzyme_affect = FALSE

	universal_understand = 1

	melee_damage_lower = 1
	melee_damage_upper = 1
	base_attack_cooldown = 1 SECOND
	attacktext = list("nipped", "bit", "chomped")

	movement_cooldown = 0
	animate_movement = SLIDE_STEPS

	layer = MOB_LAYER
	density = FALSE

	mob_size = MOB_TINY
	meat_amount = 1
	butchery_loot = list()

	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "stamps on"

	catalogue_data = list(/datum/category_item/catalogue/fauna/jil)

	has_langs = list("Jil")
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	say_list_type = /datum/say_list/jil
	ai_holder_type = /datum/ai_holder/simple_mob/intentional/jil
	melee_attack_delay = 0	// For some reason, having a delay makes item pick-up not work.

/mob/living/simple_mob/vore/alienanimals/jil/jillilah
	name = "jillilah"
	real_name = "jillilah"
	desc = "When you stare deep in her beady little eyes, you can feel an intense desire to declare independence..."
	tt_desc = "Crinitus Latrunculus"

	faction = "cargonia"

	// tiny suit!
	icon_state = "jil_cargo"
	icon_living = "jil_cargo"
	icon_dead = "jil_cargo_dead"
	icon_splat = "jil_cargo_splat"
	icon_rest = "jil_cargo_sleep"

/mob/living/simple_mob/vore/alienanimals/jil/bean
	name = "jilly-bean"
	real_name = "jilly-bean"
	desc = "They smell like diet cherry bepis..."
	tt_desc = "Crinitus Latrunculus"

	faction = "cargonia"

	// tiny suit!
	icon_state = "jil_bean"
	icon_living = "jil_bean"
	icon_dead = "jil_bean_dead"
	icon_splat = "jil_bean_splat"
	icon_rest = "jil_bean_sleep"

/mob/living/simple_mob/vore/alienanimals/jil/jillioth
	name = "jillioth"
	real_name = "jillioth"
	desc = "Here to collect."
	tt_desc = "Crinitus Robustus"

	maxHealth = 250
	health = 250
	density = TRUE

	catalogue_data = list(/datum/category_item/catalogue/fauna/jil/jillioth)

	melee_damage_lower = 20
	melee_damage_upper = 40

	mob_size = MOB_LARGE
	meat_amount = 25
	butchery_loot = list()

	// enlorgen
	icon_state = "jil_big"
	icon_living = "jil_big"
	icon_dead = "jil_big_dead"
	icon_splat = "jil_big_splat"
	icon_rest = "jil_big_sleep"

/mob/living/simple_mob/vore/alienanimals/jil/Initialize()
	. = ..()

	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide

	var/obj/structure/closet/C = locate( /obj/structure/closet, loc)
	if(C && !C.opened)
		// don't care about sizes, this will be funny when a jillioth is in a closet at map load
		src.forceMove(C)

/mob/living/simple_mob/vore/alienanimals/jil/Crossed(atom/movable/AM as mob|obj)
	if(AM.is_incorporeal())
		return
	if( ishuman(AM) )
		if(!stat)
			bonk(src,prob(15))
	..()

/mob/living/simple_mob/vore/alienanimals/jil/death()
	layer = MOB_LAYER
	playsound(src, 'sound/effects/mouse_squeak_loud.ogg', 35, 1)
	if(client)
		client.time_died_as_mouse = world.time
	..()

	if(istype(src,/mob/living/simple_mob/vore/alienanimals/jil/jillilah))
		// drop cap
		var/obj/item/clothing/head/soft/C = new /obj/item/clothing/head/soft // cargo hat!
		C.name = "Jillilah's cap"
		C.add_blood(src)
		C.desc = "A tiny cargo hat, clearly not sized for a person, soaked in the innocent blood of its owner."
		C.forceMove(src.loc) // drop on

/mob/living/simple_mob/vore/alienanimals/jil/proc/splat()
	death()
	src.icon_dead = icon_splat
	src.icon_state = icon_splat

/mob/living/simple_mob/vore/alienanimals/jil/proc/bonk(var/mob/M, var/sound_play)
	// bonk noise
	if(sound_play && sound_play)
		M.say("*merp")

/mob/living/simple_mob/vore/alienanimals/jil/proc/scream(var/mob/M, var/sound_play)
	// screaming noise
	if(sound_play)
		to_chat(M, pick("Squee!","Squeee!","Squeak!","Eeeee!"))
		playsound(M, 'sound/effects/mouse_squeak_loud.ogg', 35, 1)

/mob/living/simple_mob/vore/alienanimals/jil/update_icon()
	..()
	if(stat == DEAD)
		// leave icon as is, set by death
	else if(lying || resting || sleeping > 0)
		icon_state = icon_rest
	else
		icon_state = icon_living

/mob/living/simple_mob/vore/alienanimals/jil/Life()
	. = ..()
	if(stat != DEAD && !istype(loc,/obj/belly))
		if((!mind || !mind.active) && client == null)
			if(istype(loc,/obj/structure/closet))
				// sleep in locker
				if(sleeping < 3)
					Sleeping(3)
				// pop open!
				if(rand(1000) <= 2)
					var/obj/structure/closet/C = loc
					if(!C.opened && (C.can_open()))
						// WAKEUP! Try and escape!
						SetSleeping(0) // force a wakeup... weird I can't just use Sleeping for this...
						resting = FALSE
						lying = FALSE
						bonk(src,TRUE)
						update_icon()
						C.open(src)

			// adjust sleep here, needs mind to sleep otherwise...
			// adding the check so this doesn't conflict with life/handle_regular_status_updates()
			// catslugs added simple mobs healing while resting... so i don't need to do that myself!
			if(sleeping > 0)
				// sleep process
				AdjustSleeping(-1)
				resting = (sleeping >= 1)
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

/mob/living/simple_mob/vore/alienanimals/jil/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(stat == DEAD)
		return ..()
	if(istype(O, /obj/item/weapon/grab))
		return ..()
	if(istype(O, /obj/item/weapon/holder))
		return ..()
	if(user.a_intent != I_HELP)
		// num num num
		if(istype(O,/obj/item/weapon/reagent_containers/food))
			var/obj/item/weapon/reagent_containers/food/F = O
			F.attack(src,src)
	if(istype(O, /obj/item/weapon/newspaper))
		visible_message("<font color='blue'>[user] baps \the [src] on the nose with the rolled up [O]</font>")
		drop_l_hand()
		drop_r_hand()
		return
	return ..()

// Jil noises
/datum/say_list/jil
	speak = list()
	emote_hear = list("merps","mips","meeps")
	emote_see = list("runs in a circle", "shakes", "wiggles", "puffs up")

/datum/say_list/jil/jillioth
	speak = list()
	emote_hear = list("MERPS","MIPS","MEEPS")
	emote_see = list("jostles menacingly", "shakes threateningly", "wiggles ominously")

/*
	jil AI
*/

/datum/ai_holder/simple_mob/intentional/jil
	hostile = FALSE
	retaliate = TRUE // code doesn't allow targeting mobs, this is only so pickups still work, bluh at this hack
	vision_range = 10
	can_flee = TRUE
	flee_when_dying = TRUE
	use_astar = TRUE // oh no no no

	var/greed = 0	// The probability we will try to steal something. Increases over time if we are not holding something
	var/hoard_items = TRUE
	var/hoard_distance = 2	// How far an item can be from the Sakimm's home turf to be counted inside its 'hoard'.
	maximum_path_distance = 10 // jil lag distance help
	var/original_home_distance = null
	var/search_delay = 8 SECONDS	// How often can we look for item targets?
	var/last_search = 0

	intelligence_level = AI_DUMB // giveup easy
	var/home_turf_previous = null // if old hometurf exists and we're in range of it, reset home to it!
	var/home_turf_original = null //
	var/fear_run = 0

	base_wander_delay = 1
	max_home_distance = 850
	var/unreachable_locs = list()   //cleared when reaching nest/dropoff item, prevents window breaking spam
	var/forbidden_objs = list(/obj/item/weapon/deck,/obj/item/weapon/paper_bin,/obj/item/stack) // things that don't play well with jils
	var/last_pickup_turf = null // when a jil return an item to the nest, this turf is removed from the forbid, so lockers work better

/datum/ai_holder/simple_mob/intentional/jil/New()
	..()
	// pathing setup
	maximum_path_distance = world.view*1.5

	// search setup
	greed = rand(0,50)
	original_home_distance = max_home_distance
	search_delay = rand(5,9) SECONDS	// How often can we look for item targets?
	last_search = world.time + rand( 0, search_delay) // randomize

	// set first home
	home_turf_original = home_turf


/datum/ai_holder/simple_mob/intentional/jil/proc/set_new_home(atom/A)
	if(holder.loc && istype(A,/turf))
		// if first home away from home... then our origin_home can be set!
		home_turf_previous = home_turf
		home_turf = A // new nest!
		last_pickup_turf = null // clear


/datum/ai_holder/simple_mob/intentional/jil/pre_melee_attack(atom/A)
	if(istype(A, /obj/item))
		var/obj/item/I = A
		if(istype(I, /obj/item/weapon/reagent_containers/food))	// If we can't pick it up, or it's edible, go to harm.
			holder.a_intent = I_HURT
		else
			holder.a_intent = I_HELP
	else
		// bonk for all others
		holder.a_intent = I_HELP

	// update forbiddens
	update_forbidden_list()

	// jil vs jillioth bonk behavior
	if(!istype( holder, /mob/living/simple_mob/vore/alienanimals/jil/jillioth) || prob(5))
		// this is stupid, always set to 5 so it fails at first window bump, except the jillioth does random hits against it
		failed_breakthroughs = 4

		// if not a closet...
		if(!istype(A, /obj/structure/closet))
			// forbid turf, we picked it up or couldn't reach it
			if(target && istype(target.loc, /turf))
				unreachable_locs += target.loc // if not inside something!

		// check if we should make a new nest due to being trapped on our way back!
		if(prob(30) && holder.get_active_hand())
			set_new_home(holder.loc)

		// end path to target
		if(target && istype(target.loc, /turf))
			last_pickup_turf = target.loc // for closet fix
		give_up_movement()
		lose_target()
	else
		// if a closet that a jillioth has seen...
		if(istype(A, /obj/structure/closet))
			// stop slamming
			failed_breakthroughs = 4

			// cancel it once destroyed
			give_up_movement()
			lose_target()
		else
			// keep trying!
			failed_breakthroughs = 0


/datum/ai_holder/simple_mob/intentional/jil/post_melee_attack(atom/A)
	if(istype(A, /obj/item) && !holder.get_active_hand() && holder.Adjacent(A))
		if(istype(A, /obj/item/weapon/flame/lighter))
			var/obj/item/weapon/flame/lighter/R = A
			var/obj/item/I = A
			I.attack_hand(holder)
			spawn(5)
				if(!R.lit)
					R.attack_self(src)
				if(R.lit)
					holder.visible_message("<span class='danger'>\The [holder] bursts into flames!</span>")
					holder.add_modifier(/datum/modifier/fire/stack_managed/weak, 60 SECONDS)
					holder.light_range = 2
					holder.make_jittery(115)
					fear_run = 60
					playsound( holder, 'modular_outpost/sound/voice/ragescree.ogg', 35, 1)
					spawn(9 SECONDS)
						holder.drop_l_hand()
						holder.drop_r_hand()
						new /obj/effect/decal/cleanable/ash(holder.loc) // Turn it to ashes!
						holder.Destroy()
		else if(istype(A, /obj/item/device))
			var/obj/item/device/D = A
			if(!D.anchored)
				// attempt grab of target!
				D.attack_hand(holder)
			else
				// interact with anchored items
				if(istype(A, /obj/item/device/radio/intercom))
					var/obj/item/device/radio/intercom/Ic = D
					Ic.listening = !Ic.listening
		else
			// attempt grab of target!
			var/obj/item/I = A
			I.attack_hand(holder)

	else if(istype(A, /obj/structure/closet))
		// attempt to open!
		var/obj/structure/closet/C = A
		if(!C.opened && (C.can_open() || istype(holder,/mob/living/simple_mob/vore/alienanimals/jil/jillioth)))
			C.attack_hand(holder)
	/*
	else if(istype(A,/obj/machinery/atmospherics/unary/vent_pump) || istype(A,/obj/machinery/atmospherics/unary/vent_scrubber))
		// vent crawl
		holder.ventcrawl()
	*/

	// jil merp
	var/mob/living/simple_mob/vore/alienanimals/jil/J = holder
	if(holder.get_active_hand())
		J.bonk(J,TRUE)
	else
		J.bonk(J,prob(5))


/datum/ai_holder/simple_mob/intentional/jil/list_targets()
	. = hearers(vision_range, holder) - holder
	if(!hoard_items)
		return

	if(holder.get_active_hand())	// We don't want item targets if we have an item!
		return .

	if(world.time <= last_search + search_delay)	// Don't spam searching for item targets, since they can be in areas with a -lot- of items.
		return .
	last_search = world.time

	for(var/atom/A in view(holder, vision_range))
		// ignore if held by something else
		if(!istype(A.loc,/turf))
			continue

		// disable for things already in hoard, food needs to be eaten though
		if(!istype(A, /obj/item/weapon/reagent_containers/food) && get_dist(A, home_turf) < hoard_distance)
			continue

		// collect items!
		if(istype(A,/obj/item))
			var/obj/item/I = A
			if(!I.anchored && I.w_class <= ITEMSIZE_NORMAL) // jils are large enough to...
				. += I
		// bonus interactions!
		else if(istype(A,/obj/structure/closet)) // opening closets
			var/obj/structure/closet/C = A
			if(!C.opened && (C.can_open() || istype(holder,/mob/living/simple_mob/vore/alienanimals/jil/jillioth)))
				. += C
		// fight god!
		else if(istype(A,/obj/machinery/porta_turret) || istype(A,/obj/mecha))
			if(istype(holder,/mob/living/simple_mob/vore/alienanimals/jil/jillioth))
				. += A
		/*
		else if(istype(A,/obj/machinery/atmospherics/unary/vent_pump)) // entering vents
			var/obj/machinery/atmospherics/unary/vent_pump/P = A
			if(prob(5)) // only sometimes
				. += P
		else if(istype(A,/obj/machinery/atmospherics/unary/vent_scrubber)) // entering vents
			var/obj/machinery/atmospherics/unary/vent_scrubber/S = A
			if(prob(5)) // only sometimes
				. += S
		*/
	. -= holder.contents

/datum/ai_holder/simple_mob/intentional/jil/find_target(var/list/possible_targets, var/has_targets_list = FALSE)
	if(!hoard_items)
		return

	if(holder.is_ventcrawling || !istype(holder.loc,/turf))
		return

	. = list()
	if(!has_targets_list)
		possible_targets = list_targets()

	for(var/possible_target in possible_targets)
		var/atom/A = possible_target
		var/forbid = FALSE

		for(var/forbid_loc in unreachable_locs) // forbidden turf list
			if(A.loc == forbid_loc)
				forbid = TRUE
				break

		for(var/forbid_obj in forbidden_objs) // forbidden object list
			if(istype(A,forbid_obj))
				forbid = TRUE
				break

		if(can_attack(A) && !forbid && !isliving(A))
			// for item pickup targeting
			. += A

	for(var/obj/item/I in .)
		last_search = world.time
		if(!hoard_items || get_dist(I, home_turf) < hoard_distance)
			. -= I

	var/atom/new_target = pick_target(.)
	if(new_target && isturf(new_target.loc) && new_target.loc != holder.loc)
		give_target(new_target)
		return new_target
	return null


/datum/ai_holder/simple_mob/intentional/jil/should_go_home()
	if(!hoard_items)
		return TRUE

	if(holder.is_ventcrawling)
		return FALSE

	if(holder.health < 5) // HP FEAR, also makes jillioths robust when on lost hp lol
		return TRUE

	if((!returns_home && !holder.get_active_hand()) || !home_turf)	// If we have an item, we want to go home.
		return FALSE

	if(get_dist(holder, home_turf) > max_home_distance)
		if(!home_low_priority)
			return TRUE
		else if(!leader && !target)
			return TRUE
	return FALSE

/datum/ai_holder/simple_mob/intentional/jil/proc/update_forbidden_list()
	for(var/turf/forbid_loc in unreachable_locs) // forbidden turf list
		if(get_dist(holder.loc, forbid_loc) < 2)
			unreachable_locs -= forbid_loc // remove from list, enough to step to
		else if(get_dist(holder.loc, forbid_loc) > 30)
			unreachable_locs -= forbid_loc // remove from list, far enough to forget
		else if(istype( holder, /mob/living/simple_mob/vore/alienanimals/jil/jillioth) && prob(50))
			unreachable_locs -= forbid_loc // random retry, jillioth
		else if(prob(2))
			unreachable_locs -= forbid_loc // random retry

/datum/ai_holder/simple_mob/intentional/jil/handle_special_strategical()
	if(holder.stat == DEAD)
		return

	// nothing special if not a hoarder
	if(!hoard_items)
		return

	// vent crawler handling
	if(holder.is_ventcrawling || !istype(holder.loc,/turf))
		fear_run = 0
		return

	if(fear_run > 0)
		fear_run -= 1
		max_home_distance = original_home_distance

		// clean target
		if(target)
			lose_target()

		var/mob/living/simple_mob/vore/alienanimals/jil/J = holder
		J.scream(J,prob(30))

		// don't run if grabbed
		if(holder.grabbed_by.len)
			if(fear_run <= 0)
				fear_run = 10 // screw it
			return
		holder.IMove(get_step(holder, pick(alldirs)))
	else
		// rejuvinate nest!
		if(home_turf_previous)
			// reset to last home
			if(get_dist(holder.loc, home_turf_previous) < 2)
				home_turf = home_turf_previous
				home_turf_previous = null
		if(home_turf_original)
			// reset to origin home, all other homes give up
			if(home_turf_original && get_dist(holder.loc, home_turf_original) < 2)
				home_turf = home_turf_original
				home_turf_previous = null

		// too far from old nest? Find an item and make it the new nest
		if(holder.get_active_hand() && holder.loc && home_turf && istype(holder.loc,/turf) && (get_dist(holder.loc, home_turf) > 20 || holder.loc.z != home_turf.z))
			home_turf_previous = home_turf
			home_turf = holder.loc // new nest!

		// disable Astar most of the time, gives jils a dopey side for efficiency, but sometimes they just GOFORIT
		use_astar = FALSE
		if(target && istype(target,/mob))
			// need this to be super cheap...
			use_astar = FALSE
		else if(holder.get_active_hand())
			// long paths
			// use_astar = TRUE  // Outpost 21 TODO - Unbreak Astar
			maximum_path_distance = world.view*2
		else
			// short path to goal!
			//if(prob(50))
			// 	use_astar = TRUE  // Outpost 21 TODO - Unbreak Astar
			maximum_path_distance = world.view

		// clear old forbid turf
		if(prob(10))
			update_forbidden_list()

		// not holding something, get greedier, find way to target
		if(!holder.get_active_hand() && holder.health >= 5 && holder.sleeping <= 0)
			// oops, target is held by something else...
			if(target && !istype(target.loc,/turf))
				// lose target...
				if(target && istype(target.loc, /turf))
					unreachable_locs += target.loc // if not inside something!
				give_up_movement()
				lose_target()
				last_pickup_turf = null
				greed = 100 // REALLY WANT A NEW TARGET

			// scream at hostile
			if(target && istype(target,/mob) && retaliate)
				var/mob/living/simple_mob/vore/alienanimals/jil/J = holder
				J.scream(J,prob(30))

			// wander from nest
			max_home_distance = original_home_distance

			// find targets
			if(prob(10))
				greed++
			greed = min(95, greed)
			if(!target && prob(5 + greed))
				last_pickup_turf = null // new target, new cleanup turf
				find_target()
		else
			// clean target
			if(target)
				lose_target()

			// return home
			max_home_distance = hoard_distance-1
			if(get_dist(holder, home_turf) <= max_home_distance || holder.sleeping > 0)
				// drop item off at nest
				if(holder.get_active_hand())
					last_search = world.time
					greed = 0
					holder.drop_from_inventory(holder.get_active_hand(), get_turf(holder))
					if(last_pickup_turf)
						unreachable_locs -= last_pickup_turf // remove from list, far enough to forget
						last_pickup_turf = null // clear last pickup, we freaked out

				if(holder.sleeping > 0 || holder.health < 5 || prob(15))
					var/mob/living/simple_mob/vore/alienanimals/jil/J = holder
					if(J.sleeping <= 0)
						J.Sleeping( 30 + rand(50))
					holder.update_icon()


/datum/ai_holder/simple_mob/intentional/jil/special_flee_check()
	return holder.get_active_hand() || fear_run > 0

/datum/ai_holder/simple_mob/intentional/jil/react_to_attack(atom/movable/attacker, ignore_timers = FALSE)
	if(stance == STANCE_SLEEP) // If we're asleep, try waking up if someone's wailing on us.
		ai_log("react_to_attack() : AI is asleep. Waking up.", AI_LOG_TRACE)
		var/mob/living/simple_mob/vore/alienanimals/jil/J = holder
		J.SetSleeping(0)
		J.resting = FALSE
		J.lying = FALSE
		J.update_icon()

	if(holder.is_ventcrawling || !istype(holder.loc,/turf))
		return FALSE

	// drop item
	if(holder.get_active_hand())
		last_search = world.time
		greed = 0
		holder.drop_from_inventory(holder.get_active_hand(), get_turf(holder))

	if(holder.stat) // We're dead.
		return ..(attacker)

	// scream, but only retaliate if jillioth
	var/mob/living/simple_mob/vore/alienanimals/jil/J = holder
	J.scream(J,TRUE)
	if(!istype(holder,/mob/living/simple_mob/vore/alienanimals/jil/jillioth))
		fear_run = 10 + rand(30)
		if(target)
			// lose target...
			if(target && istype(target.loc, /turf))
				unreachable_locs += target.loc // if not inside something!
			last_pickup_turf = null // clear last pickup, we freaked out
			lose_target()
	return ..(attacker, ignore_timers)
