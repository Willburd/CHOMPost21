/obj/machinery/atmospherics/unary/vent_scrubber
	icon = 'icons/atmos/vent_scrubber.dmi'
	icon_state = "map_scrubber_off"
	pipe_state = "scrubber"

	name = "Air Scrubber"
	desc = "Has a valve and pump attached to it"
	use_power = USE_POWER_OFF
	idle_power_usage = 150		//internal circuitry, friction losses and stuff
	power_rating = 7500			//7500 W ~ 10 HP

	connect_types = CONNECT_TYPE_REGULAR|CONNECT_TYPE_SCRUBBER //connects to regular and scrubber pipes

	level = 1

	var/area/initial_loc
	var/id_tag = null
	var/frequency = 1439
	var/datum/radio_frequency/radio_connection

	var/scrubbing = 1 //0 = siphoning, 1 = scrubbing
	var/list/scrubbing_gas = list(GAS_CO2, GAS_PHORON, GAS_CH4) // Outpost 21 edit - Methane

	var/panic = 0 //is this scrubber panicked?

	var/area_uid
	var/radio_filter_out
	var/radio_filter_in

/obj/machinery/atmospherics/unary/vent_scrubber/on
	use_power = USE_POWER_IDLE
	icon_state = "map_scrubber_on"

/obj/machinery/atmospherics/unary/vent_scrubber/Initialize(mapload)
	. = ..()
	air_contents.volume = ATMOS_DEFAULT_VOLUME_FILTER

	icon = null
	initial_loc = get_area(loc)
	area_uid = "\ref[initial_loc]"
	if (!id_tag)
		assign_uid()
		id_tag = num2text(uid)

/obj/machinery/atmospherics/unary/vent_scrubber/proc/update_area()
	initial_loc = get_area(loc)
	area_uid = "\ref[initial_loc]"
	assign_uid()
	id_tag = num2text(uid)

/obj/machinery/atmospherics/unary/vent_scrubber/Destroy()
	SSmachines.wake_vent(WEAKREF(src)) // So we are removed from hibernating list
	unregister_radio(src, frequency)
	if(initial_loc)
		initial_loc.air_scrub_info -= id_tag
		initial_loc.air_scrub_names -= id_tag
	return ..()

/obj/machinery/atmospherics/unary/vent_scrubber/update_icon(var/safety = 0)
	if(!check_icon_cache())
		return

	cut_overlays()

	var/scrubber_icon = "scrubber"

	var/turf/T = get_turf(src)
	if(!istype(T))
		return

	if(welded)
		scrubber_icon += "weld"
	else if(!powered())
		scrubber_icon += "off"
	else
		scrubber_icon += "[use_power ? "[scrubbing ? "on" : "in"]" : "off"]"

	add_overlay(icon_manager.get_atmos_icon("device", , , scrubber_icon))

/obj/machinery/atmospherics/unary/vent_scrubber/update_underlays()
	if(..())
		underlays.Cut()
		var/turf/T = get_turf(src)
		if(!istype(T))
			return
		if(!T.is_plating() && node && node.level == 1 && istype(node, /obj/machinery/atmospherics/pipe))
			return
		else
			if(node)
				add_underlay(T, node, dir, node.icon_connect_type)
			else
				add_underlay(T,, dir)

/obj/machinery/atmospherics/unary/vent_scrubber/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, radio_filter_in)

/obj/machinery/atmospherics/unary/vent_scrubber/proc/broadcast_status()
	if(!radio_connection)
		return 0

	var/datum/signal/signal = new
	signal.transmission_method = TRANSMISSION_RADIO //radio signal
	signal.source = src
	signal.data = list(
		"area" = area_uid,
		"tag" = id_tag,
		"device" = "AScr",
		"timestamp" = world.time,
		"power" = use_power,
		"scrubbing" = scrubbing,
		"panic" = panic,
		"filter_o2" = (GAS_O2 in scrubbing_gas),
		"filter_n2" = (GAS_N2 in scrubbing_gas),
		"filter_co2" = (GAS_CO2 in scrubbing_gas),
		"filter_phoron" = (GAS_PHORON in scrubbing_gas),
		"filter_n2o" = (GAS_N2O in scrubbing_gas),
		"filter_fuel" = (GAS_VOLATILE_FUEL in scrubbing_gas),
		"filter_ch4" = (GAS_CH4 in scrubbing_gas),  // Outpost 21 edit - Methane
		"sigtype" = "status"
	)
	if(!initial_loc.air_scrub_names[id_tag])
		var/new_name = "[initial_loc.name] Air Scrubber #[initial_loc.air_scrub_names.len+1]"
		initial_loc.air_scrub_names[id_tag] = new_name
		src.name = new_name
	initial_loc.air_scrub_info[id_tag] = signal.data
	radio_connection.post_signal(src, signal, radio_filter_out)

	return 1

/obj/machinery/atmospherics/unary/vent_scrubber/atmos_init()
	..()
	radio_filter_in = frequency==initial(frequency)?(RADIO_FROM_AIRALARM):null
	radio_filter_out = frequency==initial(frequency)?(RADIO_TO_AIRALARM):null
	if (frequency)
		set_frequency(frequency)
		src.broadcast_status()

/obj/machinery/atmospherics/unary/vent_scrubber/process()
	..()

	if (!node)
		update_use_power(USE_POWER_OFF)
	//broadcast_status()
	if(!use_power || (stat & (NOPOWER|BROKEN)))
		return 0

	// Outpost 21 edit begin - Don't do anything if welded
	if(welded)
		SSmachines.hibernate_vent(src)
		return 0
	// Outpost 21 edit end

	var/datum/gas_mixture/environment = loc.return_air()

	var/power_draw = -1
	if(scrubbing)
		//limit flow rate from turfs
		var/transfer_moles = min(environment.total_moles, environment.total_moles*MAX_SCRUBBER_FLOWRATE/environment.volume)	//group_multiplier gets divided out here

		power_draw = scrub_gas(src, scrubbing_gas, environment, air_contents, transfer_moles, power_rating)
	else //Just siphon all air
		//limit flow rate from turfs
		var/transfer_moles = min(environment.total_moles, environment.total_moles*MAX_SIPHON_FLOWRATE/environment.volume)	//group_multiplier gets divided out here

		power_draw = pump_gas(src, environment, air_contents, transfer_moles, power_rating)

	if(scrubbing && power_draw < 0 && Master.iteration > 10)	//99% of all scrubbers
		//Fucking hibernate because you ain't doing shit.
		SSmachines.hibernate_vent(src)

	if (power_draw >= 0)
		last_power_draw = power_draw
		use_power(power_draw)

	if(network)
		network.update = 1

	return 1

/obj/machinery/atmospherics/unary/vent_scrubber/hide(var/i) //to make the little pipe section invisible, the icon changes.
	update_icon()
	update_underlays()

/obj/machinery/atmospherics/unary/vent_scrubber/receive_signal(datum/signal/signal)
	if(stat & (NOPOWER|BROKEN))
		return
	if(!signal.data["tag"] || (signal.data["tag"] != id_tag) || (signal.data["sigtype"]!="command"))
		return 0

	if(signal.data["power"] != null)
		update_use_power(text2num(signal.data["power"]))
	if(signal.data["power_toggle"] != null)
		update_use_power(!use_power)

	if(signal.data["panic_siphon"]) //must be before if("scrubbing" thing
		panic = text2num(signal.data["panic_siphon"])
		if(panic)
			update_use_power(USE_POWER_IDLE)
			scrubbing = 0
		else
			scrubbing = 1
	if(signal.data["toggle_panic_siphon"] != null)
		panic = !panic
		if(panic)
			update_use_power(USE_POWER_IDLE)
			scrubbing = 0
		else
			scrubbing = 1

	if(signal.data["scrubbing"] != null)
		scrubbing = text2num(signal.data["scrubbing"])
		if(scrubbing)
			panic = 0
	if(signal.data["toggle_scrubbing"])
		scrubbing = !scrubbing
		if(scrubbing)
			panic = 0

	var/list/toggle = list()

	if(!isnull(signal.data["o2_scrub"]) && text2num(signal.data["o2_scrub"]) != (GAS_O2 in scrubbing_gas))
		toggle += GAS_O2
	else if(signal.data["toggle_o2_scrub"])
		toggle += GAS_O2

	if(!isnull(signal.data["n2_scrub"]) && text2num(signal.data["n2_scrub"]) != (GAS_N2 in scrubbing_gas))
		toggle += GAS_N2
	else if(signal.data["toggle_n2_scrub"])
		toggle += GAS_N2

	if(!isnull(signal.data["co2_scrub"]) && text2num(signal.data["co2_scrub"]) != (GAS_CO2 in scrubbing_gas))
		toggle += GAS_CO2
	else if(signal.data["toggle_co2_scrub"])
		toggle += GAS_CO2

	if(!isnull(signal.data["tox_scrub"]) && text2num(signal.data["tox_scrub"]) != (GAS_PHORON in scrubbing_gas))
		toggle += GAS_PHORON
	else if(signal.data["toggle_tox_scrub"])
		toggle += GAS_PHORON

	if(!isnull(signal.data["n2o_scrub"]) && text2num(signal.data["n2o_scrub"]) != (GAS_N2O in scrubbing_gas))
		toggle += GAS_N2O
	else if(signal.data["toggle_n2o_scrub"])
		toggle += GAS_N2O

	if(!isnull(signal.data["fuel_scrub"]) && text2num(signal.data["fuel_scrub"]) != (GAS_VOLATILE_FUEL in scrubbing_gas))
		toggle += GAS_VOLATILE_FUEL
	else if(signal.data["toggle_fuel_scrub"])
		toggle += GAS_VOLATILE_FUEL

	// Outpost 21 edit begin - Methane
	if(!isnull(signal.data["ch4_scrub"]) && text2num(signal.data["ch4_scrub"]) != (GAS_CH4 in scrubbing_gas))
		toggle += GAS_CH4
	else if(signal.data["toggle_ch4_scrub"])
		toggle += GAS_CH4
	// Outpost 21 edit end

	scrubbing_gas ^= toggle

	if(signal.data["init"] != null)
		name = signal.data["init"]
		return

	if(signal.data["status"] != null)
		addtimer(CALLBACK(src, PROC_REF(broadcast_status)), 2, TIMER_DELETE_ME)
		return //do not update_icon

//			log_admin("DEBUG \[[world.timeofday]\]: vent_scrubber/receive_signal: unknown command \"[signal.data["command"]]\"\n[signal.debug_print()]")
	addtimer(CALLBACK(src, PROC_REF(broadcast_status)), 2, TIMER_DELETE_ME)
	update_icon()
	return

/obj/machinery/atmospherics/unary/vent_scrubber/power_change()
	var/old_stat = stat
	..()
	if(old_stat != stat)
		update_icon()

/obj/machinery/atmospherics/unary/vent_scrubber/attackby(var/obj/item/W as obj, var/mob/user as mob)
	// Outpost 21 edit begin - Allow welding these shut
	if(istype(W, /obj/item/weldingtool))
		var/obj/item/weldingtool/WT = W
		if (WT.remove_fuel(0,user))
			to_chat(user, span_notice("Now welding the vent."))

			if(do_after(user, 20 * WT.toolspeed))
				if(!src || !WT.isOn()) return
				playsound(src, WT.usesound, 50, 1)
				if(!welded)
					user.visible_message(span_notice("<b>\The [user]</b> welds the vent shut."), span_notice("You weld the vent shut."), "You hear welding.")
					welded = 1
					update_icon()
				else
					user.visible_message(span_notice("[user] unwelds the vent."), span_notice("You unweld the vent."), "You hear welding.")
					welded = 0
					update_icon()
			else
				to_chat(user, span_notice("The welding tool needs to be on to start this task."))
		else
			to_chat(user, span_warning("You need more welding fuel to complete this task."))
			return 1
	// Outpost 21 edit end
	if (!W.has_tool_quality(TOOL_WRENCH))
		return ..()
	if (!(stat & NOPOWER) && use_power)
		to_chat(user, span_warning("You cannot unwrench \the [src], turn it off first."))
		return 1
	var/turf/T = src.loc
	if (node && node.level==1 && isturf(T) && !T.is_plating())
		to_chat(user, span_warning("You must remove the plating first."))
		return 1
	// Outpost 21 edit begin - Allow welding these shut
	if (welded)
		to_chat(user, span_warning("You cannot unwrench \the [src], it is welded down firmly."))
		return 1
	// Outpost 21 edit end
	if(!can_unwrench())
		to_chat(user, span_warning("You cannot unwrench \the [src], it is too exerted due to internal pressure."))
		add_fingerprint(user)
		return 1
	playsound(src, W.usesound, 50, 1)
	to_chat(user, span_notice("You begin to unfasten \the [src]..."))
	if (do_after(user, 40 * W.toolspeed))
		user.visible_message( \
			span_infoplain(span_bold("\The [user]") + " unfastens \the [src]."), \
			span_notice("You have unfastened \the [src]."), \
			"You hear a ratchet.")
		deconstruct()

/obj/machinery/atmospherics/unary/vent_scrubber/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		. += "A small gauge in the corner reads [round(last_flow_rate, 0.1)] L/s; [round(last_power_draw)] W"
	else
		. += "You are too far away to read the gauge."
	// Outpost 21 edit begin - Allow welding these shut
	if(welded)
		. += "It seems welded shut."
	// Outpost 21 edit end
