GLOBAL_LIST_INIT(confinement_beam_collectors, list())

/obj/structure/confinement_beam_generator/collector
	name = "Confinement Beam Collector"
	desc = "Final reciever for wide-band confinement beam. Must be aligned manually from orbit. Transfers energy into surrounding inductors."
	icon_state = "collector"
	base_icon = "collector"

/obj/structure/confinement_beam_generator/collector/Initialize(mapload)
	. = ..()
	GLOB.confinement_beam_collectors += src

/obj/structure/confinement_beam_generator/collector/Destroy()
	GLOB.confinement_beam_collectors -= src
	. = ..()

/obj/structure/confinement_beam_generator/collector/pulse(datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return
	flick("collector_f",src)
	playsound(src, 'sound/weapons/emitter.ogg', 25, 1)
	playsound(src, 'sound/effects/lightningshock.ogg', 100, 1, extrarange = 5)
	for(var/D in cardinal)
		var/obj/structure/confinement_beam_generator/inductor/I = locate() in get_step(src,D)
		if(I && I.dir == reverse_dir[D] && I.is_valid_state())
			I.pulse(WF)
