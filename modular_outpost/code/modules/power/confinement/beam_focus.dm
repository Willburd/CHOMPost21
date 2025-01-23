#define BEAM_HEAT_DIVISOR 3000 // Must be very high, or you can hook the hotline up to a thermal generator and scavenge more energy than you put in!
#define YIELD_MULTIPLIER 1.068 // Energy is multiplied by this every time a pulse passes through a focus.
#define HEAT_OUTPUT_COEF 0.92 // Heat transfer to gas, the total heat is always removed from the focus, but the heat transfered to the gas is multiplied by this.
#define OFFSET_RAND_MAX 250
#define MAXHP 100

/obj/structure/confinement_beam_generator/focus
	name = "Confinement Beam Focus"
	desc = "Refracts a narrow-band confinement beam using a complex assembly of super-conducting energy fields. Interacts with the beams fired from the generation chamber or from a lens. Requires adjacent heat exchange pipes for cooling."
	icon_state = "focus"
	base_icon = "focus"

	var/minimum_power = 30000 // Same as an emitter
	var/internal_heat = T0C

	var/health = MAXHP
	var/damage_temp = T0C + 1400
	var/dev_offset_x = 0
	var/dev_offset_y = 0

	var/datum/confinement_pulse_data/focus_data // Because each focus results in a modified beam...

/obj/structure/confinement_beam_generator/focus/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	// random deviation for damaged beam wandering at the destination
	focus_data = new()
	dev_offset_x = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)
	dev_offset_y = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)

/obj/structure/confinement_beam_generator/focus/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
	qdel(focus_data)

/obj/structure/confinement_beam_generator/focus/pulse(var/datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return
	if(data.power_level < minimum_power)
		return

	// copy it!
	var/dam = 1 - (health / MAXHP)
	focus_data.power_level = data.power_level * YIELD_MULTIPLIER // increase yield per each lense
	if(dam > 0.05) // damaged enough
		focus_data.target_x = data.target_x + (dev_offset_x * dam)
		focus_data.target_y = data.target_y + (dev_offset_y * dam)
	else
		focus_data.target_x = data.target_x
		focus_data.target_y = data.target_y
	focus_data.dir = data.dir
	focus_data.target_z = data.target_z
	focus_data.origin_machine = WEAKREF(src)

	// forward to next device, or fire a narrow-band beam
	flick("focus_h",src)
	internal_heat += focus_data.power_level / BEAM_HEAT_DIVISOR // Apply heat
	var/obj/structure/confinement_beam_generator/lens/inner_lens/L = locate() in get_step(src,dir)
	if(L && L.is_valid_state())
		L.pulse(WEAKREF(focus_data))
	else
		fire_narrow_beam(focus_data)

	// forward heat back to computer
	var/obj/structure/confinement_beam_generator/control_box/CB = data.origin_machine?.resolve()
	if(CB && istype(CB,/obj/structure/confinement_beam_generator/control_box))
		CB.check_focus_data(internal_heat,damage_temp,data.power_level,health,MAXHP)

/obj/structure/confinement_beam_generator/focus/process()
	// If in a valid state, attempt to cool the device using a heat exchanger on either side
	if(!is_valid_state())
		return

	if(internal_heat <= 0)
		return

	var/obj/machinery/atmospherics/unary/heat_exchanger/EXA = locate() in get_step(src,turn(dir,90))
	var/obj/machinery/atmospherics/unary/heat_exchanger/EXB = locate() in get_step(src,turn(dir,-90))
	var/transfer_ratio = 0.5 // Assume both exchangers
	if(!EXA || !EXA.network || EXA.air_contents.heat_capacity() <= 0 || !EXA.air_contents.total_moles || EXA.air_contents.temperature > internal_heat * HEAT_OUTPUT_COEF)
		EXA = null
		transfer_ratio = 1 // Only one exchanger
	if(!EXB || !EXB.network || EXB.air_contents.heat_capacity() <= 0 || !EXB.air_contents.total_moles || EXB.air_contents.temperature > internal_heat * HEAT_OUTPUT_COEF)
		EXB = null
		transfer_ratio = 1 // Only one exchanger
	// Exchange internal heat directly to the gas! If two exchangers, split it evenly, otherwise dump it all into one.
	if(EXA)
		EXA.air_contents.add_thermal_energy( EXA.air_contents.get_thermal_energy_change( EXA.air_contents.temperature + (internal_heat * transfer_ratio * HEAT_OUTPUT_COEF)) )
		EXA.network.update = 1
	if(EXB)
		EXB.air_contents.add_thermal_energy( EXB.air_contents.get_thermal_energy_change( EXB.air_contents.temperature + (internal_heat * transfer_ratio * HEAT_OUTPUT_COEF)) )
		EXB.network.update = 1

	// Damage and eventually explode
	if((internal_heat * HEAT_OUTPUT_COEF) >= damage_temp && prob(30) && health > 0)
		health -= 1
		if(health == 0)
			explosion(get_turf(src),2,3,5,7)
			qdel(src)
		else if(prob(20))
			dev_offset_x = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)
			dev_offset_y = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)

	// If heat exchange was successful then clear the current heat, the limiter should be the gas itself.
	if(EXA || EXB)
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/A = T.return_air()
		internal_heat = A.temperature // Reset to ambient for next cycle
		if(internal_heat < 0) internal_heat = 0

/obj/structure/confinement_beam_generator/focus/attackby(obj/item/W, mob/user)
	// Repairing the focus lens
	if(W.has_tool_quality(TOOL_WELDER))
		var/obj/item/weldingtool/WT = W.get_welder()
		if(!WT.isOn()) return
		if(WT.get_fuel() < 5) // uses up 5 fuel.
			to_chat(user, span_warning("You need more fuel to complete this task."))
			return
		user.visible_message("[user] starts to repair \the [src].", "You start to repair \the [src].")
		playsound(src, WT.usesound, 50, 1)
		if(do_after(user,25 * W.toolspeed))
			if(!src || !user || !WT.remove_fuel(5, user)) return
			to_chat(user, span_notice("You repair \the [src]."))
			health = MAXHP
		return
	. = ..()

/obj/structure/confinement_beam_generator/focus/update_parts_icons()
	..() // Update self
	var/obj/structure/confinement_beam_generator/lens/inner_lens/L = locate() in get_step(src,dir) // Update lens
	if(L)
		L.update_parts_icons()

#undef BEAM_HEAT_DIVISOR
#undef OFFSET_RAND_MAX
#undef YIELD_MULTIPLIER
#undef HEAT_OUTPUT_COEF
#undef MAXHP
