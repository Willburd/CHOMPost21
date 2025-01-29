/obj/effect/confinment_beam
	name = "Confinement Beam"
	desc = "A concentrated beam of energy, behaving more like matter than light."
	icon = 'icons/obj/machines/particle_accelerator2.dmi'
	icon_state = "particle3"
	anchored = TRUE
	density = TRUE
	movement_type = UNSTOPPABLE // for bumps to trigger
	VAR_PRIVATE/anti_spam = 0
	VAR_PRIVATE/movement_range = 500
	var/datum/weakref/confinement_data = null

/obj/effect/confinment_beam/New(loc, dir = 2)
	src.loc = loc
	src.set_dir(dir)
	addtimer(CALLBACK(src, PROC_REF(move), 1), 0, TIMER_DELETE_ME)

/obj/effect/confinment_beam/Bump(atom/A)
	if(isobserver(A))
		return
	if(istype(A,/obj/effect))
		return

	if(ismovable(A))
		var/atom/movable/AM = A
		if(!AM.anchored)
			var/atom/target = get_edge_target_turf(AM, pick(alldirs))
			AM.throw_at(target, rand(100,150), 4)

	if(isliving(A))
		var/mob/living/L = A
		if(L.is_incorporeal())
			return
		var/shock_damage = min(rand(90,140),rand(40,200))
		L.electrocute_act(shock_damage, src, 1, BP_TORSO)
		var/datum/confinement_pulse_data/data = confinement_data?.resolve()
		if(data && data.power_level > 100000 && prob(CLAMP(data.power_level / 1000000,0,100)))
			L.gib()

/obj/effect/confinment_beam/Bumped(atom/A)
	if(ismob(A))
		Bump(A)

/obj/effect/confinment_beam/ex_act(severity)
	qdel(src)

/obj/effect/confinment_beam/singularity_act()
	return

/obj/effect/confinment_beam/proc/move(var/lag)
	PROTECTED_PROC(TRUE)
	make_effects()
	// Check if we should transmit to the target zlevel
	var/datum/confinement_pulse_data/data = confinement_data?.resolve()
	if(data && data.target_z != 0) // 0 sends to centcom
		if(!(data.target_z in using_map.confinement_beam_z_levels))
			movement_range = 0 // -1 or an invalid Z
			qdel(src)
			return
	var/at_edge = FALSE
	if(dir == NORTH || dir == SOUTH)
		if(y == 0 || y == world.maxy-1)
			at_edge = TRUE
	if(dir == EAST || dir == WEST)
		if(x == 0 || x == world.maxx-1)
			at_edge = TRUE
	if(at_edge)
		if(data)
			data.transmit_beam_to_z()
		qdel(src)
		return
	// Move toward direction
	if(!step(src,dir))
		src.loc = get_step(src,dir)
	movement_range--
	if(movement_range <= 0)
		qdel(src)
		return
	addtimer(CALLBACK(src, PROC_REF(move), lag), lag, TIMER_DELETE_ME)

/obj/effect/confinment_beam/Destroy()
	movement_range = 0
	confinement_data = null
	. = ..()

/obj/effect/confinment_beam/proc/make_effects()
	PROTECTED_PROC(TRUE)
	anti_spam--
	if(anti_spam <= 0)
		if(prob(30))
			// make field effects
			anti_spam = rand(5,10)
			var/obj/effect/confinment_beam/field/A = new /obj/effect/confinment_beam/field(loc, dir)
			A.set_dir( dir)




//////////////////////////////////////////////////////////////////////////////////////////////////////
// Fancy sparkles
/obj/effect/confinment_beam/field
	name = "Confinement Field"
	desc = "Particles rotated on an imaginary bluespace axis, probably not good to touch."
	icon = 'icons/obj/machines/particle_accelerator.dmi'
	icon_state = "particle"

/obj/effect/confinment_beam/field/New(loc, dir = 2)
	src.loc = loc
	src.set_dir(dir)
	if(prob(20))
		icon = 'icons/obj/machines/shielding_vr.dmi'
		icon_state = "shieldsparkles"
	movement_range = rand(5,9)
	addtimer(CALLBACK(src, PROC_REF(move), rand(2,5)), 0, TIMER_DELETE_ME)

/obj/effect/confinment_beam/field/Bump(atom/A)
	if(isobserver(A))
		return
	if(istype(A,/obj/effect))
		return
	if(A.is_incorporeal())
		return

	if(ismovable(A))
		var/atom/movable/AM = A
		if(!AM.anchored)
			var/atom/target = get_edge_target_turf(AM, pick(alldirs))
			AM.throw_at(target, rand(10,15), 2)

	var/datum/confinement_pulse_data/data = confinement_data?.resolve()
	if(!data)
		return

	if(isliving(A))
		var/mob/living/L = A
		if(data.power_level >= 1000)
			var/damage = log(1.1,data.power_level)
			damage = damage - (log(1.1,damage)*1.5)
			L.electrocute_act(damage, src, 1, BP_TORSO)
	if(data.power_level > 0)
		A.ex_act(rand(1,3))

/obj/effect/confinment_beam/field/make_effects()
	return




//////////////////////////////////////////////////////////////////////////////////////////////////////
// INCOMING BEAM
/obj/effect/confinment_beam_incoming
	name = "Confinement Beam"
	desc = "A concentrated beam of energy, behaving more like matter than light."
	icon = 'icons/obj/machines/particle_accelerator2.dmi'
	icon_state = "particle3"
	dir = SOUTH
	anchored = TRUE
	density = TRUE
	movement_type = UNSTOPPABLE // for bumps to trigger
	var/datum/weakref/confinement_data = null

/obj/effect/confinment_beam_incoming/New(loc)
	src.loc = loc
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
			var/atom/target = get_edge_target_turf(AM, pick(alldirs))
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
					if(data)
						C.pulse(confinement_data)
					qdel(src)
					return // picked up by collector
				else
					explo = TRUE
		if(explo)
			playsound(src, 'sound/weapons/emitter.ogg', 25, 1)
			if(prob(25))
				explosion(get_turf(A),1,1,3,6)
				explosion(beneath,1,1,2,3)
			else
				T.ex_act(rand(1,3))
			qdel(src)
			return
		src.loc = get_step(src,DOWN)
		addtimer(CALLBACK(src, PROC_REF(move), lag), lag, TIMER_DELETE_ME)
