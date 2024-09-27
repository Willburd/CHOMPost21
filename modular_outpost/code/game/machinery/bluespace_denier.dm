/obj/machinery/bluespace_denier
	name = "bluespace desyncronizer"
	desc = "A portable device that causes small disruptions to bluespace when its sensors detect activity within it nearby. Wrench to activate and deactivate."
	icon = 'icons/obj/stationobjs_op.dmi'
	icon_state = "pflash1"
	layer = ABOVE_WINDOW_LAYER
	var/range = 4
	var/last_flash = 0 //Don't want it getting spammed like regular flashes
	var/base_state = "mflash"
	anchored = FALSE
	base_state = "pflash"
	density = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 2

/obj/machinery/bluespace_denier/Initialize()
	. = ..()
	// if already anchored, setup the proxity check
	spawn(100)
		if(anchored)
			add_overlay("[base_state]-s")
			sense_proximity(callback = TYPE_PROC_REF(/atom,HasProximity))

/obj/machinery/bluespace_denier/power_change()
	..()
	if(!(stat & NOPOWER))
		icon_state = "[base_state]1"
//		sd_SetLuminosity(2)
	else
		icon_state = "[base_state]1-p"
//		sd_SetLuminosity(0)

//Let the AI trigger them directly.
/obj/machinery/bluespace_denier/attack_ai()
	if(anchored)
		return flash()
	else
		return

/obj/machinery/bluespace_denier/proc/flash()
	if(!(powered()))
		return

	if((last_flash && world.time < last_flash + 150))
		return

	playsound(src, 'sound/weapons/flash.ogg', 100, 1)
	flick("[base_state]_flash", src)
	last_flash = world.time
	use_power(1500)

	for (var/mob/O in viewers(src, null))
		if(get_dist(src, O) > range)
			continue
		if(ishuman(O))
			var/mob/living/carbon/human/H = O
			if(H.get_species() == SPECIES_SHADEKIN && (H.ability_flags & AB_PHASE_SHIFTED))
				H.attack_dephase(null, src)

/obj/machinery/bluespace_denier/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		..(severity)
		return
	if(prob(75/severity))
		flash()
	..(severity)

/obj/machinery/bluespace_denier/HasProximity(turf/T, datum/weakref/WF, oldloc)
	SIGNAL_HANDLER
	if(isnull(WF))
		return

	var/atom/movable/AM = WF.resolve()
	if(isnull(AM))
		log_debug("DEBUG: HasProximity called with [AM] on [src] ([usr]).")
		return

	if(!anchored || (last_flash && world.time < last_flash + 150))
		return

	if(ishuman(AM))
		flash()

/obj/machinery/bluespace_denier/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(W.has_tool_quality(TOOL_WRENCH))
		add_fingerprint(user)
		anchored = !anchored

		if(!anchored)
			user.show_message(text("<span class='warning'>[src] can now be moved.</span>"))
			cut_overlays()
			unsense_proximity(callback = TYPE_PROC_REF(/atom,HasProximity)) // CHOMPEdit

		else if(anchored)
			user.show_message(text("<span class='warning'>[src] is now secured.</span>"))
			add_overlay("[base_state]-s")
			sense_proximity(callback = TYPE_PROC_REF(/atom,HasProximity)) // CHOMPEdit
