//The perfect adminboos device?
/obj/item/perfect_tele
	name = "personal translocator"
	desc = "Seems absurd, doesn't it? Yet, here we are. Allows the user to teleport themselves and others to a pre-set beacon."
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "hand_tele"
	w_class = ITEMSIZE_SMALL
	origin_tech = list(TECH_MAGNET = 5, TECH_BLUESPACE = 5, TECH_ILLEGAL = 7)

	var/cell_type = /obj/item/cell/device/weapon
	var/obj/item/cell/power_source
	var/charge_cost = 800 // cell/device/weapon has 2400
	var/battery_lock = 0	//If set, weapon cannot switch batteries

	var/longrange = 0 //Can teleport very long distances
	var/abductor = 0 //Can be used on teleportation blocking turfs

	var/list/beacons = list()
	var/loc_network = null //Used if you want to create pre-made beacons on the maps
	var/ready = 1
	var/beacons_left = 3
	var/failure_chance = 5 //Percent
	var/obj/item/perfect_tele_beacon/destination
	var/datum/effect/effect/system/spark_spread/spk
	var/list/warned_users = list()
	var/list/logged_events = list()

	var/list/radial_images = list()

	var/static/radial_plus = image(icon = 'icons/mob/radial_vr.dmi', icon_state = "tl_plus")
	var/static/radial_set = image(icon = 'icons/mob/radial_vr.dmi', icon_state = "tl_set")
	var/static/radial_seton = image(icon = 'icons/mob/radial_vr.dmi', icon_state = "tl_seton")

	pickup_sound = 'sound/items/pickup/device.ogg'
	drop_sound = 'sound/items/drop/device.ogg'

/obj/item/perfect_tele/Initialize(mapload)
	. = ..()

	flags |= NOBLUDGEON
	if(cell_type)
		power_source = new cell_type(src)
	else
		power_source = new /obj/item/cell/device(src)
	spk = new(src)
	spk.set_up(5, 0, src)
	spk.attach(src)

	rebuild_radial_images()

/obj/item/perfect_tele/Destroy()
	// Must clear the beacon's backpointer or we won't GC. Someday maybe do something nicer even.
	for(var/obj/item/perfect_tele_beacon/B in beacons)
		B.tele_hand = null
	beacons.Cut()
	QDEL_NULL(power_source)
	QDEL_NULL(spk)
	return ..()

/obj/item/perfect_tele/update_icon()
	if(!power_source)
		icon_state = "[initial(icon_state)]_o"
	else if(ready && (power_source.check_charge(charge_cost) || power_source.fully_charged()))
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]_w"

	..()

/obj/item/perfect_tele/proc/rebuild_radial_images()
	radial_images.Cut()

	var/index = 1
	for(var/bcn in beacons) //Grumble
		var/image/I = image(icon = 'icons/mob/radial_vr.dmi', icon_state = "tl_[index]")

		var/obj/item/perfect_tele_beacon/beacon = beacons[bcn]
		if(destination == beacon)
			I.add_overlay(radial_seton)
		else
			I.add_overlay(radial_set)

		radial_images[bcn] = I

		index++

	if(beacons_left)
		var/image/I = image(icon = 'icons/mob/radial_vr.dmi', icon_state = "tl_[index]")
		I.add_overlay(radial_plus)
		radial_images["New Beacon"] = I

/obj/item/perfect_tele/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		unload_ammo(user)
	else
		return ..()

/obj/item/perfect_tele/proc/unload_ammo(mob/user, var/ignore_inactive_hand_check = 0)
	if(battery_lock)
		to_chat(user,span_notice("[src] does not have a battery port."))
		return
	if((user.get_inactive_hand() == src || ignore_inactive_hand_check) && power_source)
		to_chat(user,span_notice("You eject \the [power_source] from \the [src]."))
		user.put_in_hands(power_source)
		power_source = null
		update_icon()
	else
		to_chat(user,span_notice("[src] does not have a power cell."))

/obj/item/perfect_tele/proc/check_menu(var/mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/perfect_tele/attack_self(mob/user, var/radial_menu_anchor = src)
	if(loc_network)
		for(var/obj/item/perfect_tele_beacon/stationary/nb in GLOB.premade_tele_beacons)
			if(nb.tele_network == loc_network)
				beacons[nb.tele_name] = nb
		loc_network = null //Consumed

	if(!(user.ckey in warned_users))
		warned_users |= user.ckey
		tgui_alert_async(user,{"
This device can be easily used to break ERP preferences due to the nature of teleporting and tele-vore.
Make sure you carefully examine someone's OOC prefs before teleporting them if you are going to use this device for ERP purposes.
This device records all warnings given and teleport events for admin review in case of pref-breaking, so just don't do it.
"},"OOC Warning")
	var/choice = show_radial_menu(user, radial_menu_anchor, radial_images, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)

	if(!choice)
		return

	else if(choice == "New Beacon")
		if(beacons_left <= 0)
			to_chat(user, span_warning("The translocator can't support any more beacons!"))
			return

		var/new_name = html_encode(tgui_input_text(user,"New beacon's name (2-20 char):","[src]",null,20))
		if(!check_menu(user))
			return

		if(length(new_name) > 20 || length(new_name) < 2)
			to_chat(user, span_warning("Entered name length invalid (must be longer than 2, no more than than 20)."))
			return

		if(new_name in beacons)
			to_chat(user, span_warning("No duplicate names, please. '[new_name]' exists already."))
			return

		var/obj/item/perfect_tele_beacon/nb = new(get_turf(src))
		nb.tele_name = new_name
		nb.tele_hand = src
		nb.creator = user.ckey
		beacons[new_name] = nb
		beacons_left--
		if(isliving(user))
			var/mob/living/L = user
			L.put_in_any_hand_if_possible(nb)
		rebuild_radial_images()

	else
		destination = beacons[choice]
		rebuild_radial_images()

/obj/item/perfect_tele/attackby(obj/W, mob/user)
	if(istype(W,cell_type) && !power_source)
		power_source = W
		power_source.update_icon() //Why doesn't a cell do this already? :|
		user.unEquip(power_source)
		power_source.forceMove(src)
		to_chat(user,span_notice("You insert \the [power_source] into \the [src]."))
		update_icon()

	else if(istype(W,/obj/item/perfect_tele_beacon))
		var/obj/item/perfect_tele_beacon/tb = W
		if(tb.tele_name in beacons)
			to_chat(user,span_notice("You re-insert \the [tb] into \the [src]."))
			beacons -= tb.tele_name
			user.unEquip(tb)
			qdel(tb)
			beacons_left++
		else
			to_chat(user,span_notice("\The [tb] doesn't belong to \the [src]."))
			return
	else
		..()

/obj/item/perfect_tele/proc/teleport_checks(mob/living/target,mob/living/user)
	//Uhhuh, need that power source
	if(!power_source)
		to_chat(user,span_warning("\The [src] has no power source!"))
		return FALSE

	//Check for charge
	if((!power_source.check_charge(charge_cost)) && (!power_source.fully_charged()))
		to_chat(user,span_warning("\The [src] does not have enough power left!"))
		return FALSE

	//Only mob/living need apply.
	if(!istype(user) || !istype(target))
		return FALSE

	//No, you can't teleport buckled people.
	if(target.buckled)
		to_chat(user,span_warning("The target appears to be attached to something..."))
		return FALSE

	//No, you can't teleport if it's not ready yet.
	if(!ready)
		to_chat(user,span_warning("\The [src] is still recharging!"))
		return FALSE

	//No, you can't teleport if there's no destination.
	if(!destination)
		to_chat(user,span_warning("\The [src] doesn't have a current valid destination set!"))
		return FALSE

	//No, you can't teleport if there's a jammer.
	if(is_jammed(src) || is_jammed(destination))
		var/area/our_area = get_area(src)
		if(!our_area.no_comms)	//I don't actually want this to block teleporters, just comms
			to_chat(user,span_warning("\The [src] refuses to teleport you, due to strong interference!"))
			return FALSE

	//No, you can't port to or from away missions. Stupidly complicated check.
	var/turf/uT = get_turf(user)
	var/turf/dT = get_turf(destination)
	var/list/dat = list()
	dat["z_level_detection"] = using_map.get_map_levels(uT.z)

	if(!uT || !dT)
		return FALSE

	if(!longrange)
		if( (uT.z != dT.z) && (!(dT.z in dat["z_level_detection"])) )
			to_chat(user,span_warning("\The [src] can't teleport you that far!"))
			return FALSE

	if(!abductor)
		if(uT.block_tele || dT.block_tele)
			to_chat(user,span_warning("Something is interfering with \the [src]!"))
			return FALSE

	//Seems okay to me!
	return TRUE

/obj/item/perfect_tele/afterattack(mob/living/target, mob/living/user, proximity, var/ignore_fail_chance = 0)
	//No, you can't teleport people from over there.
	if(!proximity)
		return

	if(!teleport_checks(target,user))
		return //The checks proc can send them a message if it wants.

	if(isliving(target))
		var/mob/living/L = target
		if(!L.stat)
			if(L != user)
				if(L.a_intent != I_HELP || L.has_AI())
					to_chat(user, span_notice("[L] is resisting your attempt to teleport them with \the [src]."))
					to_chat(L, span_danger(" [user] is trying to teleport you with \the [src]!"))
					if(!do_after(user, 30, L))
						return

	//Bzzt.
	ready = 0
	power_source.use(charge_cost)

	//Unbuckle taur riders
	if(isliving(target))
		var/mob/living/L = target
		if(LAZYLEN(L.buckled_mobs))
			var/datum/riding/R = L.riding_datum
			for(var/rider in L.buckled_mobs)
				R.force_dismount(rider)

	//Failure chance
	if (!ignore_fail_chance)
		if(prob(failure_chance) && beacons.len >= 2)
			var/list/wrong_choices = beacons - destination.tele_name
			var/wrong_name = pick(wrong_choices)
			destination = beacons[wrong_name]
			to_chat(user,span_warning("\The [src] malfunctions and sends you to the wrong beacon!"))

	// Outpost 21 edit begin - Teleport redspace chance
	else if(prob(1))
		var/list/redlist = list()
		for(var/obj/effect/landmark/R in landmarks_list)
			if(R.name == "redentrance")
				redlist += R
		if(redlist.len > 0)
			// if teleport worked, drop out... otherwise just teleport normally, it means there was no redspace spawns!
			destination = pick(redlist)
			to_chat(user,span_danger("Something feels wrong..."))
	// Outpost 21 edit end

	//Destination beacon vore checking
	var/turf/dT = get_turf(destination)
	var/atom/real_dest = dT

	var/atom/real_loc = destination.loc
	if(isbelly(real_loc))
		real_dest = real_loc
	if(isliving(real_loc))
		var/mob/living/L = real_loc
		if(L.vore_selected)
			real_dest = L.vore_selected
		else if(L.vore_organs.len)
			real_dest = pick(L.vore_organs)

	//Confirm televore
	var/televored = FALSE
	if(isbelly(real_dest))
		var/obj/belly/B = real_dest
		// CHOMPEdit Start - Making pref checks work properly
		if(target.devourable && target.can_be_drop_prey && B.owner != target)
			televored = TRUE
			to_chat(target,span_vwarning("\The [src] teleports you right into \a [lowertext(real_dest.name)]!"))
		else
			to_chat(target,span_vwarning("\The [src] narrowly avoids teleporting you right into \a [lowertext(real_dest.name)]!"))
			real_dest = dT //Nevermind!
		// CHOMPEdit End
	//Phase-out effect
	phase_out(target,get_turf(target))

	//Move them
	target.forceMove(real_dest)

	//Phase-in effect
	phase_in(target,get_turf(target))

	//And any friends!
	for(var/obj/item/grab/G in target.contents)
		if(G.affecting && (G.state >= GRAB_AGGRESSIVE))

			//Phase-out effect for grabbed person
			phase_out(G.affecting,get_turf(G.affecting))

			//Move them, and televore if necessary
			G.affecting.forceMove(real_dest)
			if(televored)
				to_chat(target,span_warning("\The [src] teleports you right into \a [lowertext(real_dest.name)]!"))

			//Phase-in effect for grabbed person
			phase_in(G.affecting,get_turf(G.affecting))

	update_icon()
	spawn(30 SECONDS)
		ready = 1
		update_icon()

	logged_events["[world.time]"] = "[user] teleported [target] to [real_dest] [televored ? "(Belly: [lowertext(real_dest.name)])" : null]"

/obj/item/perfect_tele/proc/phase_out(var/mob/M,var/turf/T)

	if(!M || !T)
		return

	spk.set_up(5, 0, M)
	spk.attach(M)
	playsound(T, "sparks", 50, 1)
	anim(T,M,'icons/mob/mob.dmi',,"phaseout",,M.dir)

/obj/item/perfect_tele/proc/phase_in(var/mob/M,var/turf/T)

	if(!M || !T)
		return

	spk.start()
	playsound(T, 'sound/effects/phasein.ogg', 25, 1)
	playsound(T, 'sound/effects/sparks2.ogg', 50, 1)
	anim(T,M,'icons/mob/mob.dmi',,"phasein",,M.dir)
	spk.set_up(5, 0, src)
	spk.attach(src)

/obj/item/perfect_tele_beacon
	name = "translocator beacon"
	desc = "That's unusual."
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "motion2"
	w_class = ITEMSIZE_TINY

	var/tele_name
	var/obj/item/perfect_tele/tele_hand
	var/creator
	var/warned_users = list()
	var/tele_network = null
	flags = NOBLUDGEON

/obj/item/perfect_tele_beacon/Destroy()
	tele_name = null
	tele_hand = null
	return ..()

/obj/item/perfect_tele_beacon/attack_hand(mob/user)
	if((user.ckey != creator) && !(user.ckey in warned_users))
		warned_users |= user.ckey
		var/choice = tgui_alert(user, {"
This device is a translocator beacon. Having it on your person may mean that anyone
who teleports to this beacon gets teleported into your selected vore-belly. If you are prey-only
or don't wish to potentially have a random person teleported into you, it's suggested that you
not carry this around."}, "OOC Warning", list("Take It","Leave It"))
		if(choice == "Leave It")
			return
	return ..()

/obj/item/perfect_tele_beacon/stationary
	name = "stationary translocator beacon"
	icon = 'icons/obj/radio_vr.dmi'
	icon_state = "floor_beacon"
	w_class = ITEMSIZE_HUGE
	anchored = TRUE

GLOBAL_LIST_BOILERPLATE(premade_tele_beacons, /obj/item/perfect_tele_beacon/stationary)

/obj/item/perfect_tele_beacon/attack_self(mob/user)
	if(!isliving(user))
		return
	var/mob/living/L = user
	var/confirm = tgui_alert(user, "You COULD eat the beacon...", "Eat beacon?", list("Eat it!", "No, thanks."))
	if(confirm == "Eat it!")
		var/obj/belly/bellychoice = tgui_input_list(user, "Which belly?","Select A Belly", L.vore_organs)
		if(bellychoice)
			user.visible_message(span_warning("[user] is trying to stuff \the [src] into [user.gender == MALE ? "his" : user.gender == FEMALE ? "her" : "their"] [bellychoice.name]!"),span_notice("You begin putting \the [src] into your [bellychoice.name]!"))
			if(do_after(user,5 SECONDS,src))
				user.unEquip(src)
				forceMove(bellychoice)
				user.visible_message(span_warning("[user] eats a telebeacon!"),"You eat the the beacon!")

// A single-beacon variant for use by miners (or whatever)
/obj/item/perfect_tele/one_beacon
	name = "mini-translocator"
	desc = "A more limited translocator with a single beacon, useful for some things, like setting the mining department on fire accidentally."
	icon_state = "minitrans"
	beacons_left = 1 //Just one
	cell_type = /obj/item/cell/device
	origin_tech = list(TECH_MAGNET = 5, TECH_BLUESPACE = 5)

/*
/obj/item/perfect_tele/one_beacon/teleport_checks(mob/living/target,mob/living/user)
	var/turf/T = get_turf(destination)
	if(T && user.z != T.z)
		to_chat(user,span_warning("\The [src] is too far away from the beacon. Try getting closer first!"))
		return FALSE
	return ..()
*/

/obj/item/perfect_tele/alien
	name = "alien translocator"
	desc = "This strange device allows one to teleport people and objects across large distances."
	icon_state = "alientele"

	cell_type = /obj/item/cell/device/weapon/recharge/alien
	charge_cost = 400
	beacons_left = 6
	failure_chance = 0 //Percent
	longrange = 1
	abductor = 1

/obj/item/perfect_tele/alien/bluefo
	name = "hybrid translocator"
	desc = "This strange device allows one to teleport people and objects across large distances. It has only a single preprogrammed destination, though."
	icon_state = "alientele"

	cell_type = /obj/item/cell/device/weapon/recharge/alien
	charge_cost = 400
	beacons_left = 0
	failure_chance = 0
	longrange = 1
	abductor = 1
	loc_network = "hybridshuttle"

/obj/item/perfect_tele/frontier
	icon_state = "frontiertrans"
	beacons_left = 1 //Just one
	battery_lock = 1
	unacidable = TRUE
	failure_chance = 0 //Percent

	var/phase_power = 75
	var/recharging = 0

/obj/item/perfect_tele/frontier/unload_ammo(mob/user, var/ignore_inactive_hand_check = 0)
	if(recharging)
		return
	recharging = 1
	update_icon()
	user.visible_message(span_notice("[user] opens \the [src] and starts pumping the handle."), \
						span_notice("You open \the [src] and start pumping the handle."))
	while(recharging)
		if(!do_after(user, 10, src))
			break
		playsound(src,'sound/items/change_drill.ogg',25,1)
		if(power_source.give(phase_power) < phase_power)
			break

	recharging = 0
	update_icon()

/obj/item/perfect_tele/frontier/update_icon()
	if(recharging)
		icon_state = "[initial(icon_state)]_o"
		update_held_icon()
		return
	..()

/obj/item/perfect_tele/frontier/staff
	name = "centcom translocator"
	desc = "Similar to translocator technology, however, most of its destinations are hardcoded."
	charge_cost = 1200 // Enough for one person and their partner
	loc_network = "centcom"
	longrange = 1

/obj/item/perfect_tele/frontier/unknown
	name = "modified translocator"
	desc = "This crank-charged translocator has only one beacon, but it already has a destination preprogrammed into it."
	charge_cost = 1200 // Enough for one person and their partner
	longrange = 1
	abductor = 1

/obj/item/perfect_tele/frontier/unknown/one
	loc_network = "unkone"
/obj/item/perfect_tele/frontier/unknown/two
	loc_network = "unktwo"
/obj/item/perfect_tele/frontier/unknown/three
	loc_network = "unkthree"
/obj/item/perfect_tele/frontier/unknown/four
	loc_network = "unkfour"
/obj/item/perfect_tele/frontier/unknown/five
	loc_network = "unkfive"
/obj/item/perfect_tele/frontier/unknown/six
	loc_network = "unksix"
