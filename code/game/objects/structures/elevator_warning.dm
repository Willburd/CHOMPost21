/obj/machinery/elevator_warning
	name = "elevator warning light"
	desc = "Flashes when the bunker cargo elevator is in motion!"
	icon = 'icons/obj/elevator_warning.dmi'
	icon_state = "base_off"
	light_color = "#eccb0d"
	anchored = TRUE
	idle_power_usage = 0
	active_power_usage = 3
	var/lightphaselength = 0.5 SECOND
	var/nexttrigger = -1
	var/inverted = FALSE
	var/invert_delay_cycle = 2
	var/lastphase = -1

/obj/machinery/elevator_warning/Initialize()
	. = ..()
	activate()


/obj/machinery/elevator_warning/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()

/obj/machinery/elevator_warning/process()
	if(use_power == USE_POWER_ACTIVE) // power on?
		// check if shuttle is called, or if emagged
		if(emagged || emergency_shuttle.online())
			// only trigger light updates on an actual change!
			if(world.time > nexttrigger)
				nexttrigger = round((world.time / lightphaselength) - 0.4) * lightphaselength
				nexttrigger += lightphaselength // always next world synced flash

				// inverted light waits a single extra cycle to change
				if(inverted)
					if(invert_delay_cycle < 1)
						invert_delay_cycle += 1
						icon_state = "base_on_low"
						return // no light change!

				if(!light_on) 
					set_light(3) // ON!
					icon_state = "base_on_high"
				else
					set_light(0) // OFF!
					icon_state = "base_on_low"

		else if(light_on)
			// force light off...
			invert_delay_cycle = 0
			set_light(0)
			icon_state = "base_off"
		else
			// force cycle wipe
			invert_delay_cycle = 0
			icon_state = "base_off"

/obj/machinery/elevator_warning/proc/activate()
	if(!anchored || stat & (NOPOWER|BROKEN))
		return
	nexttrigger = -1
	update_use_power(USE_POWER_ACTIVE)

/obj/machinery/elevator_warning/proc/deactivate()
	set_light(0) // always turn off!
	invert_delay_cycle = 0
	update_use_power(USE_POWER_OFF)
	icon_state = "base_off"

/obj/machinery/elevator_warning/power_change()
	..()
	if(stat & NOPOWER)
		deactivate()
	else
		activate()

/obj/machinery/elevator_warning/emag_act()
	if(emagged)
		return
	emagged = TRUE

/obj/machinery/elevator_warning/inverted
	inverted = TRUE