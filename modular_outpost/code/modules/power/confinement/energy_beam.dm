/obj/item/projectile/beam/confinement
	name = "Confinement Beam"
	desc = "A concentrated beam of energy, behaving more like matter than light."
	icon_state = "confinement"
	icon = 'modular_outpost/icons/obj/projectiles.dmi'
	fire_sound = 'sound/weapons/emitter2.ogg'
	damage = 300
	incendiary = 3
	flammability = 4
	light_color = "#da420a"
	excavation_amount = 300
	hud_state = "laser_overcharge"
	range = 1000 // MUST hit the edge of map

	muzzle_type = null // /obj/effect/projectile/muzzle/laser_confinement
	tracer_type = /obj/effect/projectile/tracer/laser_confinement
	impact_type = null // /obj/effect/projectile/impact/laser_confinement

	can_miss = FALSE

	var/visual_only = TRUE
	var/datum/weakref/confinement_data = null

/obj/item/projectile/beam/confinement/on_hit(atom/target, blocked, def_zone)
	var/datum/confinement_pulse_data/data = confinement_data?.resolve()
	if(!visual_only && data) // Forward the beam to the next lens
		if(data.dir == target.dir && istype(target,/obj/structure/confinement_beam_generator/lens/inner_lens))
			var/obj/structure/confinement_beam_generator/lens/inner_lens/L = target
			if(L.is_valid_state())
				var/obj/structure/confinement_beam_generator/focus/F = locate() in get_step(L,data.dir)
				if(F)
					if(F.is_valid_state())
						F.pulse(confinement_data)
					else
						L.fire_narrow_beam(data)
				else
					L.fire_narrow_beam(data)
	. = ..()

/obj/item/projectile/beam/confinement/on_range()
	var/turf/T = trajectory.return_turf()
	var/datum/confinement_pulse_data/data = confinement_data?.resolve()
	if(data) // Send a pulse to the zlevel this is targetted at
		var/send = FALSE
		switch(data.dir)
			if(NORTH)
				send = (T.y == (world.maxy-1))
			if(SOUTH)
				send = (T.y == 2)
			if(EAST)
				send = (T.x == (world.maxx-1))
			if(WEST)
				send = (T.x == 2)
		if(send)
			data.transmit_beam_to_z(visual_only)
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////////////////////
// INCOMING BEAM
/obj/effect/confinment_beam_incoming
	name = ""
	desc = "A concentrated beam of energy, behaving more like matter than light."
	icon = 'icons/obj/machines/particle_accelerator2.dmi'
	icon_state = "particle3"
	dir = SOUTH
	anchored = TRUE
	density = TRUE
	movement_type = UNSTOPPABLE // for bumps to trigger
	var/datum/weakref/confinement_data = null
	var/visual_only = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/confinment_beam_incoming/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(move), 1), 1, TIMER_DELETE_ME)

/obj/effect/confinment_beam_incoming/Bump(atom/A)
	if(isobserver(A))
		return
	if(istype(A,/obj/effect))
		return
	if(A.is_incorporeal())
		return

	if(ismovable(A))
		var/atom/movable/AM = A
		if(!AM.anchored)
			var/atom/target = get_edge_target_turf(AM, pick(GLOB.alldirs))
			AM.throw_at(target, rand(100,150), 4)

	var/datum/confinement_pulse_data/data = confinement_data?.resolve()
	if(data && data.power_level > 0)
		A.ex_act(rand(1,3))

/obj/effect/confinment_beam_incoming/Bumped(atom/A)
	if(ismob(A))
		Bump(A)

/obj/effect/confinment_beam_incoming/ex_act(severity)
	qdel(src)

/obj/effect/confinment_beam_incoming/singularity_act()
	return

/obj/effect/confinment_beam_incoming/proc/move(var/lag)
	PRIVATE_PROC(TRUE)
	var/turf/T = get_turf(src)
	if(T)
		var/atom/A = pick(T.contents)
		if(A)
			A.ex_act(rand(1,3))
		var/explo = FALSE
		var/turf/beneath = GetBelow(T)
		if(!beneath)
			explo = TRUE
		else
			if(!istype(T,/turf/simulated/open)) // Destroy ceiling first... Needs to be a clear path to the collector!
				explo = TRUE
			else if(!can_fall_to(beneath))
				var/obj/structure/confinement_beam_generator/collector/C = locate() in beneath
				if(C && C.is_valid_state())
					var/datum/confinement_pulse_data/data = confinement_data?.resolve()
					if(data && !visual_only)
						C.pulse(confinement_data)
					QDEL_IN(src,5)
					return // picked up by collector
				else
					explo = TRUE
		if(explo && !visual_only)
			playsound(src, 'sound/weapons/emitter.ogg', 25, 1)
			if(prob(25))
				explosion(get_turf(A),1,1,3,6)
				explosion(beneath,1,1,2,3)
			else
				T.ex_act(rand(1,3))
			qdel(src)
			return
		loc = get_step(src,DOWN)
		if(!QDELETED(src))
			addtimer(CALLBACK(src, PROC_REF(move), lag), lag, TIMER_DELETE_ME)

/obj/effect/projectile/muzzle/laser_confinement
	icon_state = "muzzle_beam_heavy"
	light_range = 5
	light_power = 1
	light_color = "#ff8000"

/obj/effect/projectile/tracer/laser_confinement
	icon = 'modular_outpost/icons/obj/projectiles.dmi'
	icon_state = "confinement"
	light_range = 5
	light_power = 1
	light_color = "#ff8000"

/obj/effect/projectile/impact/laser_confinement
	icon_state = "impact_laser"
	light_range = 5
	light_power = 0.5
	light_color = "#ff8000"
