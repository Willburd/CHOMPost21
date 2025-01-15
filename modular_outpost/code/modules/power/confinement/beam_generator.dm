/obj/structure/confinement_beam_generator/gen
	name = "Confinement Beam Generator"
	desc = "Fires a condensed, narrow-band beam of confined energy."
	icon_state = "fuel_chamber"
	base_icon = "fuel_chamber"

/obj/structure/confinement_beam_generator/gen/pulse(var/datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF.resolve()
	if(!data)
		return
	if(data.dir != dir) // must be facing same direction as incoming direction
		return
	// Get the status of the inductors, and if they have any power to give us
	var/total_power = 0
	for(var/D in list(90,-90))
		var/obj/structure/confinement_beam_generator/inductor/I = locate() in get_step(src,turn(data.dir,D))
		if(I && I.is_valid_state())
			total_power += I.get_network_power()
	// Pass the power to the focus, otherwise fire a beam
	data.power_level = total_power
	var/obj/structure/confinement_beam_generator/focus/F = locate() in get_step(src,data.dir)
	if(F && F.is_valid_state())
		F.pulse(WF)
	else
		fire_narrow_beam(data)
