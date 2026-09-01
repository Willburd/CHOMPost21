/obj/item/mine/claymore
	name = "claymore"
	desc = "A small directional explosive loaded with pellets similar to a shotgun blast. Front towards enemy."
	icon = 'modular_outpost/icons/obj/claymore.dmi'
	icon_state = "claymore"
	minetype = /obj/effect/mine/claymore


/obj/effect/mine/claymore
	name = "claymore"
	desc = "A directional claymore. Using a infrared sensor to detect targets in a short range in front of it."
	icon = 'modular_outpost/icons/obj/claymore.dmi'
	icon_state = "landmine"
	mineitemtype = /obj/item/mine/claymore
	var/list/lasers = list()
	// Note: Manually fire()ing projectiles userless does not run submunitions code. Use submunitions DIRECTLY with the count fired!
	var/shell_type = /obj/item/projectile/bullet/shotgun/buckshot
	var/shell_count = 8 // Buckshot rounds

/obj/effect/mine/claymore/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(setup_laserline)), 3 SECONDS, TIMER_DELETE_ME)

/obj/effect/mine/claymore/Destroy()
	for(var/atom/A in lasers)
		qdel(A) // cleanup lasers
	lasers.Cut()
	. = ..()

/obj/effect/mine/claymore/explode(mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	var/turf/O = get_turf(src)
	if(!O)
		return
	while(shell_count > 0)
		shell_count--
		var/obj/item/projectile/P = new shell_type(src)
		P.firer = src
		P.old_style_target(get_step(get_turf(loc),dir))
		P.setAngle(P.Angle + rand(-5,5))
		P.fire()
	visible_message("\The [src.name] detonates!")
	playsound(src, 'sound/weapons/gunshot2.ogg')
	spawn(0)
		qdel(s)
		qdel(src)

/obj/effect/mine/claymore/Crossed(atom/movable/AM)
	if(istype(AM, /mob/observer) || AM.is_incorporeal())
		return
	if(istype(AM,/obj/effect))
		return
	if(ismob(AM))
		var/mob/M = AM
		if(M.m_intent == I_WALK)
			return // safely moved onto it
		visible_message(span_danger("\The [M] carelessly runs into and bumps \the [src]!"))
	. = ..()

/obj/effect/mine/claymore/proc/setup_laserline()
	if(QDELETED(src) || triggered)
		return
	var/turf/T = get_turf(src)
	var/max_length_of_laser = 9
	while(TRUE)
		// next turf, check if solid
		T = get_turf(get_step(T,dir))
		// Check for opening doors
		var/obj/machinery/door/D = locate() in T.contents
		if(D && D.density)
			var/obj/effect/step_trigger/claymore_laser/las = new(T)
			las.owner = WEAKREF(src)
			las.invisibility = 99 // hide this one!
			lasers.Add(las)
			return
		if(!T.CanPass(src, T))
			return
		for(var/atom/A in T)
			if(!A.CanPass(src, T))
				return
		// Extend laser until it reaches limit, or hits impassable wall
		var/obj/effect/step_trigger/claymore_laser/las = new(T)
		las.owner = WEAKREF(src)
		las.dir = dir
		lasers.Add(las)
		if(lasers.len >= max_length_of_laser)
			return


/obj/effect/step_trigger/claymore_laser
	name = ""
	icon = 'modular_outpost/icons/obj/claymore.dmi'
	icon_state = "laser"
	affect_ghosts = 0
	stopper = 0
	invisibility = 0 // visible!
	layer = ABOVE_JUNK_LAYER
	var/datum/weakref/owner

/obj/effect/step_trigger/claymore_laser/Initialize(mapload)
	. = ..()
	update_icon()

/obj/effect/step_trigger/claymore_laser/Destroy()
	owner = null
	. = ..()

/obj/effect/step_trigger/claymore_laser/Trigger(atom/movable/A)
	if(istype(A,/obj/effect))
		return
	if(istype(A,/obj/item/projectile))
		return
	if(!owner?.resolve())
		qdel(src)
		return
	var/obj/effect/mine/claymore/C = owner.resolve()
	if(!C)
		qdel(src)
		return
	if(ismob(A))
		var/mob/M = A
		if(M.m_intent == I_WALK)
			return // safely moved onto it
	// Trigger the boom!
	C.explode(A)

/obj/effect/step_trigger/claymore_laser/update_icon()
	cut_overlays()
	. = list()
	. += emissive_appearance(icon, icon_state, alpha = 50)
	add_overlay(.)



//////////////////////////////////////////////////////////////////////////////////////
// Varients
//////////////////////////////////////////////////////////////////////////////////////

/obj/item/mine/claymore/donksoft
	name = "claymore"
	desc = "A Donksoft brand foam-dart claymore. Front towards enemy."
	icon = 'modular_outpost/icons/obj/claymore.dmi'
	icon_state = "claymore"
	minetype = /obj/effect/mine/claymore/donksoft

/obj/effect/mine/claymore/donksoft
	icon = 'modular_outpost/icons/obj/claymore.dmi'
	icon_state = "landmine"
	mineitemtype = /obj/item/mine/claymore/donksoft
	shell_type = /obj/item/projectile/bullet/foam_dart
	shell_count = 12


/obj/item/mine/claymore/flechette
	name = "claymore"
	desc = "A small directional explosive loaded with anti-personal flechettes. Front towards enemy."
	minetype = /obj/effect/mine/claymore/flechette

/obj/effect/mine/claymore/flechette
	mineitemtype = /obj/item/mine/claymore/flechette
	shell_type = /obj/item/projectile/bullet/magnetic/flechette/small
	shell_count = 8
