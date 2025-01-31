#define BEAM_HEAT_DIVISOR 30000 // Must be very high, or you can hook the hotline up to a thermal generator and scavenge more energy than you put in!
#define YIELD_MULTIPLIER 1.068 // Energy is multiplied by this every time a pulse passes through a focus.

/obj/structure/confinement_beam_generator/focus
	name = "Confinement Beam Focus"
	desc = "Refracts a narrow-band confinement beam using a complex assembly of super-conducting energy fields. Interacts with the beams fired from the generation chamber or from a lens. Requires adjacent heat exchange pipes for cooling."
	icon_state = "focus"
	base_icon = "focus"

	VAR_PRIVATE/minimum_power = 30000 // Same as an emitter
	VAR_PRIVATE/datum/confinement_pulse_data/focus_data // Because each focus results in a modified beam...

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
	if(data.power_level < minimum_power)
		return

	// copy it!
	var/dam = 1 - (health / max_hp)
	focus_data.power_level = data.power_level * YIELD_MULTIPLIER // increase yield per each lense
	if(dam > beam_wander_threshold) // damaged enough
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
		CB.check_focus_data(internal_heat,damage_temp,data.power_level,health,max_hp)

/obj/structure/confinement_beam_generator/focus/process()
	// If in a valid state, attempt to cool the device using a heat exchanger on either side
	if(!is_valid_state())
		return
	exchange_heat(0.92)

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
		if(do_after(user,25 * W.toolspeed))
			if(!src || !user || !WT.remove_fuel(5, user)) return
			to_chat(user, span_notice("You repair \the [src]."))
			health = max_hp
			damage_alert = FALSE
			critical_alert = FALSE
		return
	. = ..()

/obj/structure/confinement_beam_generator/focus/update_parts_icons()
	..() // Update self
	var/obj/structure/confinement_beam_generator/lens/inner_lens/L = locate() in get_step(src,dir) // Update lens
	if(L)
		L.update_parts_icons()

#undef BEAM_HEAT_DIVISOR
#undef YIELD_MULTIPLIER
