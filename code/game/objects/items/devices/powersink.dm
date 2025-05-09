// Powersink - used to drain station power

/obj/item/powersink
	name = "power sink"
	desc = "A nulling power sink which drains energy from electrical systems."
	icon_state = "powersink0"
	icon = 'icons/obj/device.dmi'
	w_class = ITEMSIZE_LARGE
	throwforce = 5
	throw_speed = 1
	throw_range = 2

	matter = list(MAT_STEEL = 750)

	origin_tech = list(TECH_POWER = 3, TECH_ILLEGAL = 5)
	var/drain_rate = 1500000		// amount of power to drain per tick
	var/apc_drain_rate = 5000 		// Max. amount drained from single APC. In Watts.
	var/dissipation_rate = 20000	// Passive dissipation of drained power. In Watts.
	var/power_drained = 0 			// Amount of power drained.
	var/max_power = 1e9				// Detonation point.
	var/mode = 0					// 0 = off, 1=clamped (off), 2=operating
	var/drained_this_tick = 0		// This is unfortunately necessary to ensure we process powersinks BEFORE other machinery such as APCs.

	var/datum/powernet/PN			// Our powernet
	var/obj/structure/cable/attached		// the attached cable

	pickup_sound = 'sound/items/pickup/device.ogg'
	drop_sound = 'sound/items/drop/device.ogg'

/obj/item/powersink/Destroy()
	STOP_PROCESSING(SSobj, src)
	STOP_PROCESSING_POWER_OBJECT(src)
	. = ..()

/obj/item/powersink/attackby(var/obj/item/I, var/mob/user)
	if(I.has_tool_quality(TOOL_SCREWDRIVER))
		if(mode == 0)
			var/turf/T = loc
			if(isturf(T) && !!T.is_plating())
				attached = locate() in T
				if(!attached)
					to_chat(user, "No exposed cable here to attach to.")
					return
				else
					anchored = TRUE
					mode = 1
					src.visible_message(span_notice("[user] attaches [src] to the cable!"))
					playsound(src, I.usesound, 50, 1)
					return
			else
				to_chat(user, "Device must be placed over an exposed cable to attach to it.")
				return
		else
			if (mode == 2)
				STOP_PROCESSING(SSobj, src) // Now the power sink actually stops draining the station's power if you unhook it. --NeoFite
				STOP_PROCESSING_POWER_OBJECT(src)
			anchored = FALSE
			mode = 0
			src.visible_message(span_notice("[user] detaches [src] from the cable!"))
			set_light(0)
			playsound(src, I.usesound, 50, 1)
			icon_state = "powersink0"

			return
	else
		..()

/obj/item/powersink/attack_ai()
	return

/obj/item/powersink/attack_hand(var/mob/user)
	switch(mode)
		if(0)
			..()
		if(1)
			src.visible_message(span_notice("[user] activates [src]!"))
			mode = 2
			icon_state = "powersink1"
			START_PROCESSING(SSobj, src)
			datum_flags &= ~DF_ISPROCESSING // Have to reset this flag so that PROCESSING_POWER_OBJECT can re-add it. It fails if the flag is already present. - Ater
			START_PROCESSING_POWER_OBJECT(src)
		if(2)  //This switch option wasn't originally included. It exists now. --NeoFite
			src.visible_message(span_notice("[user] deactivates [src]!"))
			mode = 1
			set_light(0)
			icon_state = "powersink0"
			STOP_PROCESSING(SSobj, src)
			STOP_PROCESSING_POWER_OBJECT(src)

/obj/item/powersink/pwr_drain()
	if(!attached)
		return 0

	if(drained_this_tick)
		return 1
	drained_this_tick = 1

	var/drained = 0

	if(!PN)
		return 1

	set_light(12)
	PN.trigger_warning()
	// found a powernet, so drain up to max power from it
	drained = PN.draw_power(drain_rate)
	// if tried to drain more than available on powernet
	// now look for APCs and drain their cells
	if(drained < drain_rate)
		for(var/obj/machinery/power/terminal/T in PN.nodes)
			// Enough power drained this tick, no need to torture more APCs
			if(drained >= drain_rate)
				break
			if(istype(T.master, /obj/machinery/power/apc))
				var/obj/machinery/power/apc/A = T.master
				if(A.operating && A.cell)
					var/cur_charge = A.cell.charge / CELLRATE
					var/drain_val = min(apc_drain_rate, cur_charge)
					A.cell.use(drain_val * CELLRATE)
					drained += drain_val
	power_drained += drained
	return 1


/obj/item/powersink/process()
	drained_this_tick = 0
	power_drained -= min(dissipation_rate, power_drained)
	if(power_drained > max_power * 0.95)
		playsound(src, 'sound/effects/screech.ogg', 100, 1, 1)
	if(power_drained >= max_power)
		explosion(src.loc, 3,6,9,12)
		qdel(src)
		return
	if(attached && attached.powernet)
		PN = attached.powernet
	else
		PN = null
