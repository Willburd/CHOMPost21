/obj/machinery/reagent_refinery/pipe
	name = "Industrial Chemical Pipe"
	desc = "A large pipe made for transporting industrial chemicals. It has a low-power passive pump. The red marks show where the flow is coming from. Does not require power."
	icon = 'modular_outpost/icons/obj/machines/refinery_machines.dmi'
	icon_state = "pipe"
	density = TRUE
	anchored = TRUE
	use_power = USE_POWER_OFF // Does not require power for pipes
	idle_power_usage = 0
	active_power_usage = 0
	circuit = /obj/item/circuitboard/industrial_reagent_pipe
	default_max_vol = 60 // smoll

/obj/machinery/reagent_refinery/pipe/Initialize()
	. = ..()
	// TODO - Remove this bit once machines are converted to Initialize
	if(ispath(circuit))
		circuit = new circuit(src)
	default_apply_parts()
	// Can't be set on these
	src.verbs -= /obj/machinery/reagent_refinery/verb/set_APTFT
	// Update neighbours and self for state
	update_neighbours()
	update_icon()

/obj/machinery/reagent_refinery/pipe/process()
	if(!anchored)
		return

	if(stat & (BROKEN))
		return

	if (amount_per_transfer_from_this <= 0 || reagents.total_volume <= 0)
		return

	// dump reagents to next refinery machine
	var/obj/machinery/reagent_refinery/target = locate(/obj/machinery/reagent_refinery) in get_step(loc,dir)
	if(target)
		transfer_tank( reagents, target, dir)

/obj/machinery/reagent_refinery/pipe/update_icon()
	cut_overlays()
	if(anchored)
		for(var/direction in cardinal)
			var/turf/T = get_step(get_turf(src),direction)
			var/obj/machinery/other = locate(/obj/machinery/reagent_refinery) in T
			if(!other) // snowflake grinders...
				other = locate(/obj/machinery/reagentgrinder/industrial) in T
			if(other && other.anchored)
				// Waste processors do not connect to anything as outgoing
				if(istype(other,/obj/machinery/reagent_refinery/waste_processor))
					continue
				// weird handling for side connections... Otherwise, anything pointing into use gets connected back!
				if(istype(other,/obj/machinery/reagent_refinery/filter))
					var/obj/machinery/reagent_refinery/filter/filt = other
					var/check_dir = 0
					if(filt.get_filter_side() == 1)
						check_dir = turn(filt.dir, 270)
					else
						check_dir = turn(filt.dir, 90)
					if(check_dir == reverse_dir[direction] && dir != direction)
						var/image/intake = image(icon, icon_state = "pipe_intakes", dir = direction)
						add_overlay(intake)
						continue
				if(other.dir == reverse_dir[direction] && dir != direction)
					var/image/intake = image(icon, icon_state = "pipe_intakes", dir = direction)
					add_overlay(intake)

/obj/machinery/reagent_refinery/pipe/verb/rotate_clockwise()
	set name = "Rotate Pipe Clockwise"
	set category = "Object"
	set src in view(1)

	if (usr.stat || usr.restrained() || anchored)
		return

	src.set_dir(turn(src.dir, 270))
	update_icon()

/obj/machinery/reagent_refinery/pipe/verb/rotate_counterclockwise()
	set name = "Rotate Pipe Counterclockwise"
	set category = "Object"
	set src in view(1)

	if (usr.stat || usr.restrained() || anchored)
		return

	src.set_dir(turn(src.dir, 90))
	update_icon()

/obj/machinery/reagent_refinery/pipe/handle_transfer(var/atom/origin_machine, var/datum/reagents/RT, var/source_forward_dir, var/filter_id = "")
	// no back/forth, filters don't use just their forward, they send the side too!
	if(dir == reverse_dir[source_forward_dir])
		return 0
	. = ..(origin_machine, RT, source_forward_dir, filter_id)

/obj/machinery/reagent_refinery/pipe/examine(mob/user, infix, suffix)
	. = ..()
	. += "The meter shows [reagents.total_volume]u / [reagents.maximum_volume]u."
