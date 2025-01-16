/obj/structure/confinement_beam_generator/lens
	name = "Confinement Beam Lens"
	desc = "Focuses confined energy beams from narrow-band to wide-band. Requires anchors on both sides for support."

/obj/structure/confinement_beam_generator/lens/Crossed(O)
	. = ..()
	if(istype(O,/obj/effect/accelerated_particle/confinment_beam))
		// The wideband beams will always be qdelled!
		var/obj/effect/accelerated_particle/confinment_beam/CB = O
		if(!CB.confinement_data)
			qdel(O)
			return
		var/datum/confinement_pulse_data/data = CB.confinement_data.resolve()
		if(!data)
			qdel(O)
			return
		// transmit beam to focus, must be the middle lens, and the beam transmitted from the prior middle lens
		if(istype(src,/obj/structure/confinement_beam_generator/lens/inner_lens) && is_valid_state())
			var/obj/structure/confinement_beam_generator/focus/F = locate() in get_step(src,data.dir)
			if(F)
				F.pulse(CB.confinement_data)
			else
				fire_narrow_beam(data)
		qdel(O)

/obj/structure/confinement_beam_generator/lens/inner_lens
	icon_state = "emitter_center"
	base_icon = "emitter_center"

/obj/structure/confinement_beam_generator/lens/inner_lens/is_valid_state()
	for(var/D in list(90,-90))
		var/get_dir = turn(dir,D)
		var/obj/structure/confinement_beam_generator/lens/outer_lens/L = locate() in get_step(src,get_dir)
		if(!L || !L.is_valid_state())
			return FALSE
		if(L.dir != reverse_dir[get_dir]) // Must be facing into middle lense
			return FALSE
	. = ..()

/obj/structure/confinement_beam_generator/lens/inner_lens/pulse(datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF.resolve()
	if(!data)
		return
	for(var/atom/pos in list( loc, get_step(src,turn(dir,90)), get_step(src,turn(dir,-90))))
		fire_wide_beam(pos,data)

/obj/structure/confinement_beam_generator/lens/outer_lens
	name = "Confinement Beam Lens Anchor"
	desc = "Supports a confinement beam lense."
	icon_state = "emitter_right"
	base_icon = "emitter_right"
