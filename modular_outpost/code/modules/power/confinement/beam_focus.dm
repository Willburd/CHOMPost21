#define BEAM_HEAT_DIVISOR 30000 // Must be very high, or you can hook the hotline up to a thermal generator and scavenge more energy than you put in!
#define YIELD_MULTIPLIER 1.068 // Energy is multiplied by this every time a pulse passes through a focus.

/obj/structure/confinement_beam_generator/focus
	name = "Confinement Beam Focus"
	desc = "Refracts a narrow-band confinement beam using a complex assembly of super-conducting energy fields. Interacts with the beams fired from the generation chamber or from a lens. Requires adjacent heat exchange pipes for cooling."
	icon_state = "focus"
	base_icon = "focus"

	VAR_PRIVATE/minimum_power = 30000 // Same as an emitter
	VAR_PRIVATE/datum/confinement_pulse_data/focus_data // Because each focus results in a modified beam...
	VAR_PRIVATE/light_time = -1

/obj/structure/confinement_beam_generator/focus/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	// random deviation for damaged beam wandering at the destination
	focus_data = new()

/obj/structure/confinement_beam_generator/focus/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
	qdel(focus_data)

/obj/structure/confinement_beam_generator/focus/pulse(var/datum/weakref/WF)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return
	var/obj/structure/confinement_beam_generator/control_box/CB = data.origin_machine?.resolve()
	if(CB)
		// Update controlbox reference if it exists
		cached_controlbox = WEAKREF(CB)
		if(data.power_level < minimum_power)
			return

		// Clone and update data
		focus_data.clone_from(data)
		var/dam = 1 - (health / max_hp)
		focus_data.power_level = data.power_level * YIELD_MULTIPLIER // increase yield per each lense
		focus_data.origin_machine = cached_controlbox
		if(dam > beam_wander_threshold) // damaged enough
			focus_data.target_x = data.target_x + (dev_offset_x * dam)
			focus_data.target_y = data.target_y + (dev_offset_y * dam)

		// forward to next device, or fire a narrow-band beam
		flick("focus_h",src)
		internal_heat += focus_data.power_level / BEAM_HEAT_DIVISOR // Apply heat
		var/obj/structure/confinement_beam_generator/lens/inner_lens/L = locate() in get_step(src,dir)
		if(L && L.is_valid_state())
			L.pulse(WEAKREF(focus_data))
			if(light_time < 0)
				set_light(9,2,"#e9a40f",FALSE)
			light_time = world.time + 3 SECONDS
		else
			fire_narrow_beam(focus_data)

		// Update controlbox info
		CB.check_focus_data(internal_heat,damage_temp,data.power_level,-1,-1)
	else
		cached_controlbox = null

/obj/structure/confinement_beam_generator/focus/process()
	if(light_time >= 0 && light_time < world.time)
		set_light(0,0,0,FALSE)
		light_time = -1

	// While passively sitting and not being heated, cool down automagically
	var/datum/gas_mixture/G = return_air()
	if(internal_heat > G.temperature)
		var/amnt = rand(1,3)
		internal_heat -= amnt
		if(internal_heat < 0)
			internal_heat = 0
		if(G)
			G.add_thermal_energy(amnt * 1000)

	// If in a valid state, attempt to cool the device using a heat exchanger on either side
	if(!is_valid_state())
		cached_controlbox = null
		return
	exchange_heat(0.92)

	// Update the state of the controlbox
	var/obj/structure/confinement_beam_generator/control_box/CB = cached_controlbox?.resolve()
	if(istype(CB) && CB.is_valid_state())
		CB.check_focus_data(internal_heat,damage_temp,-1,health,max_hp)
	else
		cached_controlbox = null

/obj/structure/confinement_beam_generator/focus/examine(mob/user)
	. = ..()
	if(internal_heat >= damage_temp)
		. += span_danger("It is overheating!")
	if(health < 20)
		. += span_danger("It is severely damaged!")
	else if(health < 60)
		. += span_danger("It is heavily damaged!")
	else if(health < 94)
		. += span_danger("It is damaged!")

/obj/structure/confinement_beam_generator/focus/ex_act(severity)
	if(severity == 1)
		health -= rand(30,40)
	if(severity == 2)
		health -= rand(1,5)
	. = ..()

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
		if(health == max_hp)
			to_chat(user, span_notice("\The [src] does not need any repairs."))
		else if(do_after(user,25 * W.toolspeed))
			if(!src || !user || !WT.remove_fuel(5, user)) return
			to_chat(user, span_notice("You repair \the [src]."))
			health = max_hp
			damage_alert = FALSE
			critical_alert = FALSE
			// Update control box
			var/obj/structure/confinement_beam_generator/control_box/CB = cached_controlbox?.resolve()
			if(istype(CB) && CB.is_valid_state())
				CB.check_focus_data(-1,-1,-1,max_hp,max_hp)
				CB.pulse()
			else
				cached_controlbox = null
		return
	. = ..()

/obj/structure/confinement_beam_generator/focus/update_parts_icons()
	..() // Update self
	var/obj/structure/confinement_beam_generator/lens/inner_lens/L = locate() in get_step(src,dir) // Update lens
	if(L)
		L.update_parts_icons()

#undef BEAM_HEAT_DIVISOR
#undef YIELD_MULTIPLIER
