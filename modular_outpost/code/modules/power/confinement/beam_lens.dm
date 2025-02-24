/obj/structure/confinement_beam_generator/lens
	name = "Confinement Beam Lens"
	desc = "Focuses confined energy beams from narrow-band to wide-band. Requires anchors on both sides for support, and must face correctly in order to function."

// Only needs anchors
/obj/structure/confinement_beam_generator/lens/process_tool_hit(var/obj/item/O, var/mob/user)
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

/obj/structure/confinement_beam_generator/lens/update_icon() // Doesn't change state
	return

/obj/structure/confinement_beam_generator/lens/inner_lens
	icon_state = "lens_center"
	base_icon = "lens_center"

/obj/structure/confinement_beam_generator/lens/inner_lens/is_valid_state()
	var/obj/structure/confinement_beam_generator/focus/F = locate() in get_step(src,dir) // Must be facing the focus
	if(!F)
		return FALSE
	for(var/D in list(90,-90))
		var/get_dir = turn(dir,D)
		var/obj/structure/confinement_beam_generator/lens/outer_lens/L = locate() in get_step(src,get_dir)
		if(!L || !L.is_valid_state())
			return FALSE
		if(L.dir != reverse_dir[get_dir]) // Must be facing into middle lense
			return FALSE
	. = ..()

/obj/structure/confinement_beam_generator/lens/inner_lens/pulse(datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return
	// Prevent procspamming
	addtimer(CALLBACK(src, PROC_REF(fire_wide_beam), loc, WF), 0, TIMER_DELETE_ME) // Only this one sends energy

/obj/structure/confinement_beam_generator/focus/update_parts_icons()
	..() // Update self
	for(var/D in list(90,-90)) // Update outside lenes
		var/obj/structure/confinement_beam_generator/lens/outer_lens/L = locate() in get_step(src,turn(dir,D))
		if(L)
			L.update_parts_icons()

/obj/structure/confinement_beam_generator/lens/outer_lens
	name = "Confinement Beam Lens Anchor"
	desc = "Supports a confinement beam lens."
	icon_state = "lens_edge"
	base_icon = "lens_edge"
