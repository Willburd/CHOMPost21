// Pretty much everything here is stolen from the dna scanner FYI

/obj/machinery/metal_detector
	name = "Threat Detector"
	icon = 'modular_outpost/icons/obj/machines/metal_detector.dmi'
	icon_state = "detector_0"
	density = FALSE
	anchored = TRUE
	unacidable = TRUE
	circuit = /obj/item/circuitboard/metal_detector
	use_power = USE_POWER_IDLE
	idle_power_usage = 10
	active_power_usage = 200
	var/cooldown = 0
	var/lighttrigger = 0
	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER

/obj/machinery/metal_detector/Initialize()
	. = ..()
	default_apply_parts()

/obj/machinery/metal_detector/proc/green_alert()
	icon_state = "detector_1" // reset
	cooldown = world.time + (1 SECONDS)
	light_color = LIGHT_COLOR_GREEN
	lighttrigger = world.time + 0.03 SECOND
	set_light(3) // ON!
	visible_message("<span class='warning'>[src] flashes green. No threatening objects detected!</span>")
	playsound(src, 'sound/machines/defib_success.ogg', 25, 0, 4, volume_channel = VOLUME_CHANNEL_ALARMS)
	return

/obj/machinery/metal_detector/proc/yellow_alert()
	icon_state = "detector_2" // reset
	cooldown = world.time + (2 SECONDS)
	light_color = LIGHT_COLOR_YELLOW
	lighttrigger = world.time + 0.03 SECOND
	set_light(3) // ON!
	visible_message("<span class='warning'>[src] flashes yellow. Potentially suspicious object detected!</span>")
	playsound(src, 'sound/machines/defib_safetyOff.ogg', 25, 0, 4, volume_channel = VOLUME_CHANNEL_ALARMS)
	return

/obj/machinery/metal_detector/proc/red_alert()
	icon_state = "detector_3" // reset
	cooldown = world.time + (2 SECONDS)
	light_color = LIGHT_COLOR_FLARE
	lighttrigger = world.time + 0.03 SECOND
	set_light(3) // ON!
	visible_message("<span class='warning'>[src] flashes red in a panic. Highly dangerous object detected!</span>")
	playsound(src, 'sound/machines/defib_failed.ogg', 25, 0, 4, volume_channel = VOLUME_CHANNEL_ALARMS)
	return

/obj/machinery/metal_detector/process()
	..()

	if((!anchored || stat & (NOPOWER|BROKEN)) && icon_state != "detector_0")
		icon_state = "detector_0" // reset
		set_light(0) // OFF!
		return
	if(world.time >= cooldown && icon_state != "detector_0")
		icon_state = "detector_0" // reset
		set_light(0) // OFF!
		return

/obj/machinery/metal_detector/Crossed(atom/movable/AM as mob|obj)
	if(AM.is_incorporeal() || istype(AM,/mob/observer)) // ectoplasm begone
		return
	if(stat & (NOPOWER|BROKEN) || !anchored)
		return
	if(world.time >= cooldown)
		if(can_use_power_oneoff(active_power_usage))
			// drain power
			use_power_oneoff(active_power_usage)
			// detect threats in player inventory, and do an alert!
			var/alert_lev = 0
			var/mob/living/zapmob = null

			if(istype(AM,/obj/mecha) || issilicon(AM))
				// pretty much always is
				alert_lev = 2

			else if(istype(AM,/obj/))
				// push in a raw object?
				var/obj/O = AM
				alert_lev = slot_scan(O)
				// if a mob is on a buckled object, detect it!
				if(O.buckled_mobs.len)
					for(var/mob/M in O.buckled_mobs)
						for(var/obj/item/I in M.contents)
							alert_lev = max( alert_lev, slot_scan(I))

			else if(istype(AM,/mob/))
				// inventory check... Surprisingly this easily finds stuff even in pockets on vests!
				for(var/obj/item/I in AM.contents)
					alert_lev = max( alert_lev, slot_scan(I))

				if(isliving(AM))
					zapmob = AM

			// boop!
			switch(alert_lev)
				if(0)
					green_alert()
				if(1)
					yellow_alert()
				if(2)
					red_alert()
					if(zapmob && emagged)
						//emagged zaps people on red alarm
						if(electrocute_mob( zapmob, get_area(src), src, 0.7))
							var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
							s.set_up(5, 1, src)
							s.start()

/obj/machinery/metal_detector/proc/slot_scan(var/atom/thing)
	if(!thing)
		return -1
	var/alert_lev = 0
	alert_lev = obj_check(thing)
	// mmmm recursion, I can't see how this will go wrong at all!
	for(var/obj/item/I in thing.contents)
		if(I != thing) // should never happen, but lets be safe...
			alert_lev = max( alert_lev, slot_scan(I))
	return alert_lev

/obj/machinery/metal_detector/proc/obj_check(var/obj/item/thing)
	if(!thing)
		return -1
	if( \
		istype(thing,/obj/item/tool/prybar) || \
		istype(thing,/obj/item/tank/emergency) || \
		istype(thing,/obj/item/melee/umbrella) || \
		istype(thing,/obj/item/grenade/chem_grenade/cleaner) \
	)
		return 0
	else if( \
		istype(thing,/obj/item/tool/crowbar/brace_jack) || \
		istype(thing,/obj/item/flamethrower) || \
		istype(thing,/obj/item/disk/nuclear) || \
		istype(thing,/obj/item/camera_bug) || \
		istype(thing,/obj/item/melee) || \
		istype(thing,/obj/item/electric_hand) || \
		istype(thing,/obj/item/finger_lockpick) || \
		istype(thing,/obj/item/card/emag) || \
		istype(thing,/obj/item/material/sword) || \
		istype(thing,/obj/item/material/twohanded) || \
		istype(thing,/obj/item/material/knife) || \
		istype(thing,/obj/item/material/whip) || \
		istype(thing,/obj/item/material/butterfly) || \
		istype(thing,/obj/item/material/harpoon) || \
		istype(thing,/obj/item/material/knife) || \
		istype(thing,/obj/item/material/star) || \
		istype(thing,/obj/item/mine) || \
		istype(thing,/obj/item/reagent_containers/hypospray) || \
		istype(thing,/obj/item/reagent_containers/syringe) || \
		istype(thing,/obj/item/dnainjector) || \
		istype(thing,/obj/item/surgical) || \
		istype(thing,/obj/item/syndie) || \
		istype(thing,/obj/item/hand_tele) || \
		istype(thing,/obj/item/beartrap) || \
		istype(thing,/obj/item/nullrod) || \
		istype(thing,/obj/item/grenade) || \
		istype(thing,/obj/item/implanter) || \
		istype(thing,/obj/item/implantpad) || \
		istype(thing,/obj/item/chainsaw) || \
		istype(thing,/obj/item/deadringer) || \
		istype(thing,/obj/item/telecube) || \
		istype(thing,/obj/item/gun) || \
		istype(thing,/obj/item/pickaxe) || \
		istype(thing,/obj/item/broken_gun) || \
		istype(thing,/obj/item/bluespace_harpoon) || \
		istype(thing,/obj/item/arrow) || \
		istype(thing,/obj/item/spike) || \
		istype(thing,/obj/item/mecha_parts) || \
		istype(thing,/obj/item/clothing/gloves/yellow) || \
		istype(thing,/obj/item/clothing/gloves/fyellow) \
	)
		return 2
	else if( \
		istype(thing,/obj/item/tank) || \
		istype(thing,/obj/item/tank) || \
		istype(thing,/obj/item/disk) || \
		istype(thing,/obj/item/storage/pill_bottle) || \
		istype(thing,/obj/item/storage/firstaid) || \
		istype(thing,/obj/item/storage/toolbox) || \
		istype(thing,/obj/item/stock_parts) || \
		istype(thing,/obj/item/material/shard) || \
		istype(thing,/obj/item/weldingtool) || \
		istype(thing,/obj/item/circuitboard) || \
		istype(thing,/obj/item/tool) || \
		istype(thing,/obj/item/reagent_containers/pill) || \
		istype(thing,/obj/item/reagent_containers/chem_disp_cartridge) || \
		istype(thing,/obj/item/shockpaddles) || \
		istype(thing,/obj/item/handcuffs) || \
		istype(thing,/obj/item/extinguisher) || \
		istype(thing,/obj/item/inducer) || \
		istype(thing,/obj/item/rcd) || \
		istype(thing,/obj/item/shield) || \
		istype(thing,/obj/item/weldpack) || \
		istype(thing,/obj/item/clothing/gloves/telekinetic) \
	)
		return 1
	else
		// backup for all others, safe...
		return 0

/obj/machinery/metal_detector/attackby(obj/item/W, mob/user)
	if(W.is_wrench() || W.is_screwdriver() || W.is_crowbar() || istype(W, /obj/item/storage/part_replacer))
		if(default_unfasten_wrench(user, W))
			return
		if(default_deconstruction_screwdriver(user, W))
			return
		if(default_deconstruction_crowbar(user, W))
			return
		if(default_part_replacement(user, W))
			return
	return ..()
