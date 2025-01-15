#define BEAM_HEAT_DIVISOR 4500
#define OFFSET_RAND_MAX 250
#define YIELD_MULTIPLIER 1.1
#define HEAT_TRANSFER_COEF 0.72

/obj/structure/confinement_beam_generator/focus
	name = "Confinement Beam Focus"
	desc = "Refracts a narrow-band confinement beam using a complex assembly of super-conducting energy fields."
	icon_state = "power_box"
	base_icon = "power_box"

	var/internal_heat = T0C
	var/heat_capacity = 420 // j/kg, same as steel

	var/health = 100
	var/damage_temp = T0C + 2000
	var/dev_offset_x = 0
	var/dev_offset_y = 0

	var/datum/confinement_pulse_data/focus_data // Because each focus results in a modified beam...

/obj/structure/confinement_beam_generator/focus/Initialize(mapload)
	. = ..()
	// random deviation for damaged beam wandering at the destination
	focus_data = new()
	dev_offset_x = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)
	dev_offset_y = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)

/obj/structure/confinement_beam_generator/focus/Destroy()
	. = ..()
	qdel(focus_data)

/obj/structure/confinement_beam_generator/focus/pulse(var/datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF.resolve()
	if(!data)
		return

	var/dam = 1 - (health / 100)
	internal_heat += data.power_level / BEAM_HEAT_DIVISOR

	// copy it!
	focus_data.power_level = data.power_level * YIELD_MULTIPLIER // increase yield per each lense
	focus_data.deviation_x = data.deviation_x + dev_offset_x * dam
	focus_data.deviation_y = data.deviation_y + dev_offset_y * dam
	focus_data.dir = data.dir
	focus_data.target_z = data.target_z

	// forward to next device, or fire a narrow-band beam
	var/obj/structure/confinement_beam_generator/lens/inner_lens/L = locate() in get_step(src,dir)
	if(L && L.is_valid_state())
		L.pulse(WEAKREF(focus_data))
	else
		fire_narrow_beam(focus_data)

/obj/structure/confinement_beam_generator/focus/process()
	. = ..()

	// If in a valid state, attempt to pulse the beam's machinery
	if(!is_valid_state())
		return

	// Damage and eventually explode
	if(internal_heat >= damage_temp && prob(30) && health > 0)
		health -= 1
		if(health == 0)
			explosion(get_turf(src),2,3,5,7)
			qdel(src)
		else if(prob(20))
			dev_offset_x = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)
			dev_offset_y = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)

	// Attempt to cool the device
	var/D = pick(list(90,-90)) // Choose a random heater... Used to prevent it having a preference for one side due to list order
	var/obj/machinery/atmospherics/unary/heat_exchanger/EX = locate() in get_step(src,turn(dir,D))
	if(!EX)
		EX = locate() in get_step(src,turn(dir,D + 180)) // try again if a single...
	if(!EX || !EX.network || EX.air_contents.heat_capacity() <= 0)
		return
	// Transfer the internal temp to the pipe network
	if(EX.air_contents.total_moles && EX.air_contents.temperature < internal_heat)
		var/transfer = internal_heat * HEAT_TRANSFER_COEF
		EX.air_contents.add_thermal_energy(transfer)
		EX.network.update = 1
		internal_heat -= transfer


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
			health = 100
		return
	. = ..()

#undef BEAM_HEAT_DIVISOR
#undef OFFSET_RAND_MAX
#undef YIELD_MULTIPLIER
#undef HEAT_TRANSFER_COEF
