/*Composed of X parts

BI : Beam Injector
Handles beam aiming. Selects from a list of Zlevels with receiver lenses.
The receiver must be constructed fully, and the Zlevel must be allowed by
the map datum, otherwise it will not be present in the list.

CI : Confinement Inductor
Requires a wire node beneath it. Attaches to the power network. If the network
has enough power, and the beam injector is activated. Energy from the power
grid will be transfered into the confinment beam generator next to it. It has no
direction, and can only attach to a single beam generator.

CB : Confinment Beam Generator
The beam generator is a DIRECTIONAL machine. It behaves like an emitter. If the
beam injector is active, power transfered from the confinemnt inductors to the
left and right of the beam generator. Once sufficient charge has been reached, the
beam generator will fire a narrow-band confinment beam.

CF : Confinment Energy Focus
The energy focus is a machine that either links to the beam generator, or may be hit
by a narrow-band confinement beam. If this focus is hit. It will generate extreme amounts
of heat. /obj/machinery/atmospherics/unary/heat_exchanger pipes can be constructed on either
side of the machine, to transfer that heat to a pipe network. Beams that hit the focus
will be transfered to a lens on the other side of it. If the focus becomes damaged from
heat, it will begin to distort the beam's final destination x and y location. Causing
the transmission beam at the targeted zlevel to wander the map.

IL, OL :  Inner lens, Outer lens
The lens is constructed of two objects, an outer lens and an inner lens. two outer lenses
must be on each side of the inner lens, or the structure will not function.
The outer lenses must face the inner lense, When the complete lens structure recieves energy
from a energy focus, it will fire a wide-band confinement beam. When this beam leaves the map's
edge, the beam will be sent to the zlevel set by the beam injector. It will be sent as a
top-down energybeam from the highest zlevel above the target, fired downward.


Setup map
  |BI|
CI|CB|CI
-:|CF|:-
OL|IL|OL

*/

// The beam data is initially created in the beam_control module, this is where it is setup
// and passed to the generator, where it either becomes a useless emitter beam, or is passed
// into the focus. Every time a weakref to a pulse_datum is passed into a focus, it has its
// data copied to the focus_data of that focus, each focus has their own pulse_data datum.
// This is because each focus slightly mutates the datum, the more you have the more mutated
// it can become if you let the focuses overheat, but the higher beam multiplier you can get!

// Check modular_outpost\code\modules\power\confinement\beam_control.dm for initial datum creation.
// Check modular_outpost\code\modules\power\confinement\beam_focus.dm for how the datum copy happens.

/datum/confinement_pulse_data
	var/power_level = 1
	var/deviation_x = 0
	var/deviation_y = 0
	var/dir = NORTH
	var/target_z = -1

/datum/confinement_pulse_data/proc/transmit_beam_to_z()
	if(target_z == -1 || power_level == 0)
		return
	to_world("UPDATED BEAM : [power_level] - [deviation_x], [deviation_y], [target_z]")



/obj/structure/confinement_beam_generator
	name = "Confinement Beam Generator"
	desc = "Part of a Confinement Beam Generator."
	icon = 'modular_outpost/icons/obj/machines/confinement_beam.dmi'
	icon_state = "none"
	anchored = FALSE
	density = TRUE
	var/base_icon = "" // icon_state for each machine
	var/construction_state = 0

/obj/structure/confinement_beam_generator/Destroy()
	construction_state = 0
	. = ..()

/obj/structure/confinement_beam_generator/verb/rotate_clockwise()
	set name = "Rotate Clockwise"
	set category = "Object"
	set src in oview(1)

	if (src.anchored || usr:stat)
		to_chat(usr, "It is fastened to the floor!")
		return 0
	src.set_dir(turn(src.dir, 270))
	return TRUE

/obj/structure/confinement_beam_generator/verb/rotate_counterclockwise()
	set name = "Rotate Counter Clockwise"
	set category = "Object"
	set src in oview(1)

	if (src.anchored || usr:stat)
		to_chat(usr, "It is fastened to the floor!")
		return 0
	src.set_dir(turn(src.dir, 90))
	return TRUE

/obj/structure/confinement_beam_generator/examine(mob/user)
	. = ..()

	switch(construction_state)
		if(0)
			. += "Looks like it's not attached to the flooring."
		if(1)
			. += "It is missing some cables."
		if(2)
			. += "The panel is open."
		if(3)
			. += "It is assembled."

/obj/structure/confinement_beam_generator/attackby(obj/item/W, mob/user)
	if(istool(W))
		if(src.process_tool_hit(W,user))
			return
	. = ..()

/obj/structure/confinement_beam_generator/proc/has_power()
	var/turf/T = get_turf(src)
	var/area/A = get_area(src)
	return !((!A.power_equip && A.requires_power == 1) || istype(T, /turf/space))

/obj/structure/confinement_beam_generator/proc/update_parts_icons()
	update_icon()

/obj/structure/confinement_beam_generator/update_icon()
	switch(construction_state)
		if(0)
			icon_state="[base_icon]"	// Free
		if(1)
			icon_state="[base_icon]_a"	// Anchored
		if(2)
			icon_state="[base_icon]_w"	// Wired with panel open
		if(3)
			if(!has_power())
				icon_state="[base_icon]_c"	// Panel closed
			else
				icon_state="[base_icon]_p"	// Panel closed and powered
	return

/obj/structure/confinement_beam_generator/proc/process_tool_hit(var/obj/item/O, var/mob/user)
	if(!(O) || !(user))
		return FALSE
	if(!ismob(user) || !isobj(O))
		return FALSE
	var/temp_state = src.construction_state

	switch(src.construction_state)
		if(0)
			if(O.has_tool_quality(TOOL_WRENCH))
				playsound(src, O.usesound, 75, 1)
				src.anchored = TRUE
				user.visible_message("[user.name] secures the [src.name] to the floor.", \
					"You secure the external bolts.")
				temp_state++
		if(1)
			if(O.has_tool_quality(TOOL_WRENCH))
				playsound(src, O.usesound, 75, 1)
				src.anchored = FALSE
				user.visible_message("[user.name] detaches the [src.name] from the floor.", \
					"You remove the external bolts.")
				temp_state--
			else if(istype(O, /obj/item/stack/cable_coil))
				if(O:use(1,user))
					user.visible_message("[user.name] adds wires to the [src.name].", \
						"You add some wires.")
					temp_state++
		if(2)
			if(O.has_tool_quality(TOOL_WIRECUTTER))//TODO:Shock user if its on?
				user.visible_message("[user.name] removes some wires from the [src.name].", \
					"You remove some wires.")
				temp_state--
			else if(O.has_tool_quality(TOOL_SCREWDRIVER))
				user.visible_message("[user.name] closes the [src.name]'s access panel.", \
					"You close the access panel.")
				temp_state++
		if(3)
			if(O.has_tool_quality(TOOL_SCREWDRIVER))
				user.visible_message("[user.name] opens the [src.name]'s access panel.", \
					"You open the access panel.")
				temp_state--
	if(temp_state == src.construction_state)//Nothing changed
		return FALSE
	else
		construction_state = temp_state
		update_icon()
		return TRUE

/obj/structure/confinement_beam_generator/proc/is_valid_state()
	return get_turf(src) && construction_state == 3

/obj/structure/confinement_beam_generator/proc/pulse(var/datum/weakref/WF,var/dir)
	return

/obj/structure/confinement_beam_generator/proc/fire_narrow_beam(var/datum/confinement_pulse_data/data)
	playsound(src, 'sound/weapons/emitter.ogg', 25, 1)
	if(prob(35))
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
	var/obj/item/projectile/beam/emitter/B = new /obj/item/projectile/beam/emitter(get_turf(src))
	B.damage = round(data.power_level/EMITTER_DAMAGE_POWER_TRANSFER)
	B.firer = src
	B.fire(dir2angle(data.dir))

/obj/structure/confinement_beam_generator/proc/fire_wide_beam(var/turf/pos, var/datum/confinement_pulse_data/data)
	var/obj/effect/accelerated_particle/confinment_beam/A = new /obj/effect/accelerated_particle/confinment_beam(pos, data.dir)
	A.set_dir( data.dir)
	A.energy = data.power_level
	if(pos == loc) // Only the middle lens transmits
		A.confinement_data = WEAKREF(data)



// The actual particle beam effects
/obj/effect/accelerated_particle/confinment_beam
	icon_state = "particle3"
	var/datum/weakref/confinement_data = null
	movement_range = 500
	energy = 0

/obj/effect/accelerated_particle/confinment_beam/Moved(atom/old_loc, direction, forced, movetime)
	. = ..()
	// Check if we should transmit to the target zlevel
	if(!confinement_data)
		return
	var/datum/confinement_pulse_data/data = confinement_data.resolve()
	if(!data)
		return
	if(movement_range <= 0)
		return
	var/at_edge = FALSE
	if(dir == NORTH || dir == SOUTH)
		if(y == 0 || y == world.maxy-1)
			at_edge = TRUE
	if(dir == EAST || dir == WEST)
		if(x == 0 || x == world.maxx-1)
			at_edge = TRUE
	if(at_edge)
		data.transmit_beam_to_z()
		movement_range = 0 // Lets make sure we don't have any recursive/double-sending accidents
