/////SINGULARITY SPAWNER
/obj/machinery/the_singularitygen/
	name = "Gravitational Singularity Generator"
	desc = "An Odd Device which produces a Gravitational Singularity when set up."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "TheSingGen"
	anchored = FALSE
	density = TRUE
	use_power = USE_POWER_OFF
	var/energy = 0
	var/creation_type = /obj/singularity

/obj/machinery/the_singularitygen/examine()
	. = ..()
	if(anchored)
		. += span_notice("It has been securely bolted down and is ready for operation.")
	else
		. += span_warning("It is not secured!")

/obj/machinery/the_singularitygen/process()
	var/turf/T = get_turf(src)
	if(src.energy >= 200)
		// Outpost 21 edit begin - Prevent atmo griefing
		if(T && creation_type == /obj/singularity && SSplanets.z_to_planet.len >= T.z)
			var/datum/planet/P = SSplanets.z_to_planet[T.z]
			if(P)
				admin_notice(span_danger("Singularity generation attempted on planet [P.name]"))
				src.energy = 0
				visible_message("[src] flashes and refuses to generate a singularity while on [P.name]!")
				return
		// Outpost 21 edit end - Prevent atmo griefing
		new creation_type(T, 50)
		if(src) qdel(src)

/obj/machinery/the_singularitygen/attackby(obj/item/W, mob/user)
	if(W.has_tool_quality(TOOL_WRENCH))
		anchored = !anchored
		playsound(src, W.usesound, 75, 1)
		if(anchored)
			user.visible_message("[user.name] secures [src.name] to the floor.", \
				"You secure the [src.name] to the floor.", \
				"You hear a ratchet.")
		else
			user.visible_message("[user.name] unsecures [src.name] from the floor.", \
				"You unsecure the [src.name] from the floor.", \
				"You hear a ratchet.")
		return
	if(W.has_tool_quality(TOOL_SCREWDRIVER))
		panel_open = !panel_open
		playsound(src, W.usesound, 50, 1)
		visible_message(span_infoplain(span_bold("\The [user]") + " adjusts \the [src]'s mechanisms."))
		if(panel_open && do_after(user, 30))
			to_chat(user, span_notice("\The [src] looks like it could be modified."))
			if(panel_open && do_after(user, 80 * W.toolspeed))	// We don't have skills, so a delayed hint for engineers will have to do for now. (Panel open check for sanity)
				playsound(src, W.usesound, 50, 1)
				to_chat(user, span_cult("\The [src] looks like it could be adapted to forge advanced materials via particle acceleration, somehow.."))
		else
			to_chat(user, span_notice("\The [src]'s mechanisms look secure."))
	if(istype(W, /obj/item/smes_coil/super_io) && panel_open)
		visible_message(span_infoplain(span_bold("\The [user]") + " begins to modify \the [src] with \the [W]."))
		if(do_after(user, 300))
			user.drop_from_inventory(W)
			visible_message(span_infoplain(span_bold("\The [user]") + " installs \the [W] onto \the [src]."))
			qdel(W)
			var/turf/T = get_turf(src)
			var/new_machine = /obj/machinery/particle_smasher
			new new_machine(T)
			qdel(src)
	return ..()

// Outpost 21 edit begin - Climbing is kinda critical for these
/obj/machinery/the_singularitygen/verb/climb_on()
	set name = "Climb structure"
	set desc = "Climbs onto a structure."
	set category = "Object"
	set src in oview(1)

	do_climb(usr)

/obj/machinery/the_singularitygen/MouseDrop_T(mob/target, mob/user)
	var/mob/living/H = user
	if(istype(H) && can_climb(H) && target == user)
		do_climb(target)
	else
		return ..()
// Outpost 21 edit end
