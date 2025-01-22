GLOBAL_LIST_INIT(confinement_beam_collectors, list())

/obj/structure/confinement_beam_generator/collector
	name = "Confinement Beam Collector"
	desc = "Final reciever for wide-band confinement beam. Must be aligned manually from orbit. Transfers energy into surrounding inductors."
	icon_state = "collector"
	base_icon = "collector"

/obj/structure/confinement_beam_generator/collector/Initialize(mapload)
	. = ..()
	confinement_beam_collectors += src

/obj/structure/confinement_beam_generator/collector/Destroy()
	confinement_beam_collectors -= src
	. = ..()

// Only needs anchors
/obj/structure/confinement_beam_generator/collector/process_tool_hit(var/obj/item/O, var/mob/user)
	if(!(O) || !(user))
		return FALSE
	if(!ismob(user) || !isobj(O))
		return FALSE

	if(O.has_tool_quality(TOOL_WRENCH))
		playsound(src, O.usesound, 75, 1)
		if(!construction_state || !anchored)
			anchored = TRUE
			construction_state = 3
			user.visible_message("[user.name] secures the [src.name] to the floor.", \
				"You secure the external bolts.")
		else
			anchored = FALSE
			construction_state = 0
			user.visible_message("[user.name] detaches the [src.name] from the floor.", \
				"You remove the external bolts.")

		update_icon()
		return TRUE
	return FALSE

/obj/structure/confinement_beam_generator/collector/update_icon() // Doesn't change state
	return

/obj/structure/confinement_beam_generator/collector/pulse(datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return
	for(var/D in cardinal)
		var/obj/structure/confinement_beam_generator/inductor/I = locate() in get_step(src,D)
		if(I && I.dir == reverse_dir[D] && I.is_valid_state())
			I.pulse(WF)
