/obj/machinery/reagent_refinery/pump
	name = "Industrial Chemical Pump"
	desc = "Transports large amounts of chemicals between machines."
	icon = 'modular_outpost/icons/obj/machines/refinery_machines.dmi'
	icon_state = "pump"
	density = TRUE
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 0
	active_power_usage = 50
	circuit = /obj/item/weapon/circuitboard/industrial_reagent_pump

/obj/machinery/reagent_refinery/pump/Initialize()
	. = ..()
	// TODO - Remove this bit once machines are converted to Initialize
	if(ispath(circuit))
		circuit = new circuit(src)
	default_apply_parts()
	update_icon()

/obj/machinery/reagent_refinery/pump/process()
	if(!anchored)
		return

	power_change()
	if(stat & (NOPOWER|BROKEN))
		return

	if (amount_per_transfer_from_this > 0 && reagents.total_volume > 0)
		// dump reagents to next refinery machine
		var/obj/machinery/reagent_refinery/target = locate(/obj/machinery/reagent_refinery) in get_step(get_turf(src),dir)
		if(target)
			transfer_tank( target, dir)

/obj/machinery/reagent_refinery/pump/update_icon()
	cut_overlays()
	if(reagents.total_volume >= 5)
		var/image/filling = image(icon, loc, "pump_r",dir = dir)
		filling.color = reagents.get_color()
		add_overlay(filling)

/obj/machinery/reagent_refinery/pump/attack_hand(mob/user)
	set_APTFT()

/obj/machinery/reagent_refinery/pump/verb/rotate_clockwise()
	set name = "Rotate Pump Clockwise"
	set category = "Object"
	set src in view(1)

	if (usr.stat || usr.restrained() || anchored)
		return

	src.set_dir(turn(src.dir, 270))
	update_icon()

/obj/machinery/reagent_refinery/pump/verb/rotate_counterclockwise()
	set name = "Rotate Pump Counterclockwise"
	set category = "Object"
	set src in view(1)

	if (usr.stat || usr.restrained() || anchored)
		return

	src.set_dir(turn(src.dir, 90))
	update_icon()

/obj/machinery/reagent_refinery/pump/examine(mob/user, infix, suffix)
	. = ..()
	. += "The meter shows [FLOOR((reagents.total_volume / reagents.maximum_volume) * 100,1)]% full."
