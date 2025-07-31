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
--|BI|--
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

// Check beam_control.dm for initial datum creation.
// Check beam_focus.dm for how the datum copy happens.

#define EXPLODEHEAT T0C + 100000 // Instead of stacking heat forever it'll just explode at this temp
#define OFFSET_RAND_MAX 250
#define PROJECTILE_DELAY 4
#define NUMBER_OF_PROJECTILES 5

/datum/confinement_pulse_data
	var/power_level = 1
	var/target_x = 0
	var/target_y = 0
	// Drifting targeting
	var/dir = NORTH
	var/target_z = -1 // Beam to no level
	var/t_rate = 0.75 // Only used in generator
	var/datum/weakref/origin_machine = null

/datum/confinement_pulse_data/proc/clone_from(var/datum/confinement_pulse_data/source)
	for(var/A in vars - list(BLACKLISTED_COPY_VARS))
		vars[A] = source.vars[A]

/datum/confinement_pulse_data/proc/transmit_beam_to_z(var/fake_beam,var/datum/confinement_pulse_data/data)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(target_z == -1 || power_level == 0)
		return
	// BEAM TO CENTCOM
	if(target_z == 0)
		if(!fake_beam)
			transmit_beam_to_centcom()
		return
	if(target_x <= 0 || target_y <= 0)
		return
	// Update aim
	var/obj/structure/confinement_beam_generator/control_box/CB = data.origin_machine?.resolve()
	if(!CB)
		return
	CB.aim_beam(target_x,target_y)
	// Fire
	var/turf/T = CB.aim_turf(target_z)
	if(!T || !(T.z in using_map.confinement_beam_z_levels))
		return
	var/obj/effect/confinment_beam_incoming/I = new /obj/effect/confinment_beam_incoming(T)
	I.confinement_data = WEAKREF(src)
	I.visual_only = fake_beam

/datum/confinement_pulse_data/proc/transmit_beam_to_centcom(var/datum/confinement_pulse_data/data)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	var/obj/structure/confinement_beam_generator/control_box/CB = data.origin_machine?.resolve()
	if(!CB || !CB.on_target(target_x,target_y))
		return // Stop making mistakes
	var/org_wattage = SSsupply.watts_sold
	SSsupply.watts_sold += power_level * 0.92 // Sell to centcom
	var/new_wattage = SSsupply.watts_sold

	// Get points
	if(FLOOR(org_wattage / SSsupply.points_per_watt,1) != FLOOR(new_wattage / SSsupply.points_per_watt,1))
		SSsupply.points += 1

	// Give rewards/notices
	power_sold_message(""					 ,  0.5,	 15,org_wattage,new_wattage)
	power_sold_message(""					 ,	1,	 15,org_wattage,new_wattage)
	power_sold_message(""					 ,	5,	 25,org_wattage,new_wattage)
	power_sold_message(""					 ,	 10,	 25,org_wattage,new_wattage)
	power_sold_message(""					 ,	 15,	 25,org_wattage,new_wattage)
	power_sold_message(""					 ,	 20,	 50,org_wattage,new_wattage)
	power_sold_message(""					 ,	 25,	 50,org_wattage,new_wattage)
	power_sold_message(""					 ,	 50,	100,org_wattage,new_wattage)
	power_sold_message("What are you doing? ",  100,	200,org_wattage,new_wattage)
	power_sold_message(""					 ,  200,	200,org_wattage,new_wattage)
	power_sold_message(""					 ,  300,	300,org_wattage,new_wattage)
	power_sold_message(""					 ,  400,	400,org_wattage,new_wattage)
	power_sold_message("Holy shit. "		 ,  500,	500,org_wattage,new_wattage)
	power_sold_message("HOW!? "				 , 1000,   1000,org_wattage,new_wattage)
	power_sold_message(""				 	 , 2000,   1000,org_wattage,new_wattage)
	power_sold_message(""				 	 , 3000,   1000,org_wattage,new_wattage)
	power_sold_message(""				 	 , 4000,   1000,org_wattage,new_wattage)
	power_sold_message("OH MY GOD WE'RE DOOMED! ", 5000, 1000,org_wattage,new_wattage)
	power_sold_message("Congrats on winning. ", 10000,   1000,org_wattage,new_wattage)

/datum/confinement_pulse_data/proc/power_sold_message(var/pre_message,var/gigawatts,var/credits,var/org_wattage,var/new_wattage)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	if(check_sold_wattage(gigawatts GIGAWATTS,org_wattage,new_wattage))
		GLOB.global_announcer.autosay("[pre_message][gigawatts] total gigawatt[gigawatts != 1 ? "s" : ""] of excess power sold!", "Confinement Beam Monitor", pre_message == "" ? CHANNEL_ENGINEERING : CHANNEL_COMMON)
		GLOB.global_announcer.autosay("PTL bounty reached, [credits] additional supply points awarded.", "Confinement Beam Monitor", CHANNEL_SUPPLY)
		SSsupply.points += credits

/datum/confinement_pulse_data/proc/check_sold_wattage(var/threshold,var/org_wattage,var/new_wattage)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	if(new_wattage >= threshold && org_wattage < threshold)
		return TRUE
	return FALSE



/obj/structure/confinement_beam_generator
	name = "Confinement Beam Generator"
	desc = "Part of a Confinement Beam Generator."
	icon = 'modular_outpost/icons/obj/machines/confinement_beam.dmi'
	icon_state = "none"
	anchored = FALSE
	density = TRUE
	var/base_icon = "" // icon_state for each machine
	VAR_PROTECTED/construction_state = 0

	// For focus and inductors
	VAR_PROTECTED/datum/weakref/cached_controlbox = null
	VAR_PROTECTED/beam_wander_threshold = 0.2
	VAR_PROTECTED/dev_offset_x = 0
	VAR_PROTECTED/dev_offset_y = 0
	VAR_PROTECTED/internal_heat = T0C
	VAR_PROTECTED/max_hp = 100
	VAR_PROTECTED/health = 100
	VAR_PROTECTED/damage_temp = T0C + 1400
	VAR_PROTECTED/damage_alert = FALSE
	VAR_PROTECTED/critical_alert = FALSE

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
			. += span_notice("Looks like it's not attached to the flooring.")
		if(1)
			. += span_notice("It is missing some cables.")
		if(2)
			. += span_notice("The panel is open.")
		if(3)
			. += span_notice("It is assembled.")

/obj/structure/confinement_beam_generator/attackby(obj/item/W, mob/user)
	if(istool(W))
		if(process_tool_hit(W,user))
			return
	. = ..()

/obj/structure/confinement_beam_generator/proc/has_power()
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)
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
	PROTECTED_PROC(TRUE)
	if(!(O) || !(user))
		return FALSE
	if(!ismob(user) || !isobj(O))
		return FALSE
	var/temp_state = construction_state

	switch(construction_state)
		if(0)
			if(O.has_tool_quality(TOOL_WRENCH))
				playsound(src, O.usesound, 75, 1)
				anchored = TRUE
				user.visible_message("[user.name] secures the [name] to the floor.", \
					"You secure the external bolts.")
				temp_state++
		if(1)
			if(O.has_tool_quality(TOOL_WRENCH))
				playsound(src, O.usesound, 75, 1)
				anchored = FALSE
				user.visible_message("[user.name] detaches the [name] from the floor.", \
					"You remove the external bolts.")
				temp_state--
			else if(istype(O, /obj/item/stack/cable_coil))
				if(O:use(1,user))
					user.visible_message("[user.name] adds wires to the [name].", \
						"You add some wires.")
					temp_state++
		if(2)
			if(O.has_tool_quality(TOOL_WIRECUTTER))//TODO:Shock user if its on?
				user.visible_message("[user.name] removes some wires from the [name].", \
					"You remove some wires.")
				temp_state--
			else if(O.has_tool_quality(TOOL_SCREWDRIVER))
				user.visible_message("[user.name] closes the [name]'s access panel.", \
					"You close the access panel.")
				temp_state++
		if(3)
			if(O.has_tool_quality(TOOL_SCREWDRIVER))
				user.visible_message("[user.name] opens the [name]'s access panel.", \
					"You open the access panel.")
				temp_state--
	if(temp_state == construction_state)//Nothing changed
		return FALSE
	else
		construction_state = temp_state
		update_icon()
		return TRUE

/obj/structure/confinement_beam_generator/proc/is_valid_state()
	return get_turf(src) && construction_state == 3

/obj/structure/confinement_beam_generator/proc/pulse(var/datum/weakref/WF)
	return

/obj/structure/confinement_beam_generator/proc/fire_narrow_beam(var/datum/confinement_pulse_data/data)
	SHOULD_NOT_OVERRIDE(TRUE)
	playsound(src, 'sound/weapons/emitter.ogg', 25, 1)
	if(prob(35))
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
	var/obj/item/projectile/beam/emitter/B = new /obj/item/projectile/beam/emitter(get_turf(src))
	B.damage = round(data.power_level/EMITTER_DAMAGE_POWER_TRANSFER)
	B.firer = src
	B.fire(dir2angle(data.dir))

/obj/structure/confinement_beam_generator/proc/fire_wide_beam(var/turf/pos,var/datum/weakref/WF)
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)
	var/datum/confinement_pulse_data/data = WF?.resolve()
	if(!data)
		return
	var/turf/start = get_turf(src)
	var/damage = round(data.power_level/EMITTER_DAMAGE_POWER_TRANSFER)
	// needs to call on_range() which only happens on the end of the beam... on a turf... so if it's outside the map it does nothing
	// Yes this is aiming one turf closer than edge of map, if I don't do this then it goes off the edge and never calls on_range()
	var/range = 0
	var/angle = dir2angle(data.dir)
	switch(data.dir)
		if(NORTH)
			range = (world.maxy - start.y)-1
		if(SOUTH)
			range = start.y - 2
		if(EAST)
			range = (world.maxx - start.x)-1
		if(WEST)
			range = start.x - 2
	if(range)
		subshot_fire(start,range,angle,damage,WF,NUMBER_OF_PROJECTILES)

/obj/structure/confinement_beam_generator/proc/subshot_fire(var/turf/start,var/range,var/angle,var/damage,var/datum/weakref/WF,var/number_of_shots)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	var/obj/item/projectile/beam/confinement/B = new(start)
	B.visual_only = !(number_of_shots == NUMBER_OF_PROJECTILES) // This just controls if it sends data. It's still lethal.
	B.firer = src
	B.range = range
	B.confinement_data = WF
	B.damage = damage
	// fire the actual beam
	B.fire(angle)
	// Next!
	number_of_shots -= 1
	if(number_of_shots > 0)
		addtimer(CALLBACK(src, PROC_REF(subshot_fire), start,range,angle,damage,WF,number_of_shots), PROJECTILE_DELAY, TIMER_DELETE_ME)

/obj/structure/confinement_beam_generator/proc/find_highest_z() // collector and computer use this
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)
	var/turf/T = get_turf(src)
	if(!T)
		return -1
	while(HasAbove(T.z))
		T = GetAbove(T)
	return T.z

/obj/structure/confinement_beam_generator/proc/exchange_heat(var/transfer_coefficient)
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)
	// Alter deviation of beam
	if(prob(2) || (dev_offset_x == 0 && dev_offset_y == 0))
		dev_offset_x = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)
		dev_offset_y = rand(-OFFSET_RAND_MAX,OFFSET_RAND_MAX)
	// Heat transfer to gas, the total heat is always removed from the focus, but the heat transfered to the gas is multiplied by transfer_coefficient.
	var/obj/machinery/atmospherics/unary/heat_exchanger/EXA = locate() in get_step(src,turn(dir,90))
	var/obj/machinery/atmospherics/unary/heat_exchanger/EXB = locate() in get_step(src,turn(dir,-90))
	if(!EXA || !EXA.network || EXA.air_contents.heat_capacity() <= 0 || !EXA.air_contents.total_moles)
		EXA = null
	if(!EXB || !EXB.network || EXB.air_contents.heat_capacity() <= 0 || !EXB.air_contents.total_moles)
		EXB = null
	// Exchange internal heat directly to the gas! If two exchangers, split it evenly, otherwise dump it all into one.
	if(prob(50))
		use_exchanger(EXA,transfer_coefficient)
		use_exchanger(EXB,transfer_coefficient)
	else
		use_exchanger(EXB,transfer_coefficient)
		use_exchanger(EXA,transfer_coefficient)
	// Damage and eventually explode
	var/warns = FALSE
	if(istype(src,/obj/structure/confinement_beam_generator/focus))
		warns = TRUE
	var/turf/T = get_turf(src)
	var/true_heat = (internal_heat * transfer_coefficient)
	if((true_heat >= damage_temp && prob(30) && health > 0) || true_heat >= EXPLODEHEAT)
		health -= 1
		if(warns && !damage_alert)
			damage_alert = TRUE
			GLOB.global_announcer.autosay("WARNING: CONFINEMENT BEAM FOCUS AT \"[T.x], [T.y], [using_map.get_zlevel_name(T.z)]\" has begun to deform. Urgent repairs are required.", "Confinement Beam Monitor", CHANNEL_ENGINEERING)
			log_game("CONFINEMENT BEAM FOCUS([T.x],[T.y],[T.z]) emergency engineering announcement.")

		var/dam = 1 - (health / max_hp)
		if(warns && dam > beam_wander_threshold && !critical_alert)
			critical_alert = TRUE
			var/beam_emitting = FALSE
			var/obj/structure/confinement_beam_generator/control_box/CB = cached_controlbox?.resolve()
			if(CB && CB.pulse_enabled)
				beam_emitting = TRUE
			GLOB.global_announcer.autosay("WARNING: CONFINEMENT BEAM FOCUS AT \"[T.x], [T.y], [using_map.get_zlevel_name(T.z)]\" HAS REACHED CRITICAL DEFORMATION! [beam_emitting ? "BEAM IS MOBILE!" : "Priority warning!"]", "Confinement Beam Monitor")
			log_game("CONFINEMENT BEAM FOCUS([T.x],[T.y],[T.z]) CRITICAL engineering announcement.")

		if(warns && health == 5)
			GLOB.global_announcer.autosay("DANGER: CONFINEMENT BEAM FOCUS AT \"[T.x], [T.y], [using_map.get_zlevel_name(T.z)]\" SUPER CRITICAL!", "Confinement Beam Monitor")
			log_game("CONFINEMENT BEAM FOCUS([T.x],[T.y],[T.z]) SELF DESTRUCTING engineering announcement.")

		if(health == 0 || true_heat >= EXPLODEHEAT)
			explosion(get_turf(src),2,3,5,7)
			qdel(src)

/obj/structure/confinement_beam_generator/proc/use_exchanger(var/obj/machinery/atmospherics/unary/heat_exchanger/EXA,var/transfer_coefficient)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)
	if(!EXA)
		return
	var/transfer_amount = internal_heat - EXA.air_contents.temperature
	if(transfer_amount > 0)
		EXA.air_contents.add_thermal_energy( EXA.air_contents.get_thermal_energy_change( EXA.air_contents.temperature + (transfer_amount * transfer_coefficient)))
		EXA.network.update = 1
		internal_heat -= transfer_amount
	if(internal_heat < 0)
		internal_heat = 0

#undef EXPLODEHEAT
#undef OFFSET_RAND_MAX
#undef NUMBER_OF_PROJECTILES
