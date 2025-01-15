/obj/structure/confinement_beam_generator/control_box
	name = "Confinement Control Console"
	desc = "Controls the confinement beam's power output and destination."
	icon_state = "control_box"
	base_icon = "control_box"
	var/found_dir = 0
	var/datum/confinement_pulse_data/data

/obj/structure/confinement_beam_generator/control_box/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	data = new()

/obj/structure/confinement_beam_generator/control_box/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
	qdel(data)

/obj/structure/confinement_beam_generator/control_box/process()
	// If in a valid state, attempt to pulse the beam's machinery
	if(!is_valid_state())
		return

	if(found_dir == 0)
		for(var/d in cardinal)
			var/obj/structure/confinement_beam_generator/gen/G = locate() in get_step(src,d)
			if(G)
				found_dir = d
	else
		var/obj/structure/confinement_beam_generator/gen/G = locate() in get_step(src,found_dir)
		if(!G || !G.is_valid_state())
			found_dir = 0
			return
		data.dir = found_dir
		G.pulse(WEAKREF(data))
