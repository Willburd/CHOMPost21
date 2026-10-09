// Allow scewdrivers to drain handheld tanks
/obj/item/tank/attackby(obj/item/W as obj, mob/user as mob)
	if(W.has_tool_quality(TOOL_SCREWDRIVER))
		var/turf/T = user.loc
		if(!isturf(T))
			user.visible_message(span_danger("You can't do that here!"))
			return
		user.visible_message(span_danger("\The [user] tries to force \the [src]'s regulator open with \the [W]!"))
		if(do_after(user, 4 SECONDS, target = src))
			T = user.loc // Check again
			if(!isturf(T))
				user.visible_message(span_danger("You can't do that here!"))
				return

			// Vent gas to the environment
			var/datum/gas_mixture/environment = loc.return_air()
			var/env_pressure = environment.return_pressure()
			var/pressure_delta = distribute_pressure - env_pressure

			if((air_contents.temperature > 0) && (pressure_delta > 0))
				var/transfer_moles = calculate_transfer_moles(air_contents, environment, pressure_delta)
				transfer_moles = min(transfer_moles, ((volume*0.34)/air_contents.volume)*air_contents.total_moles) //flow rate limit
				var/returnval = pump_gas_passive(src, air_contents, environment, transfer_moles)

				if(returnval >= 0)
					update_icon()
					to_chat(user, span_danger("\The [src] vents some of it's gas!"))
					log_and_message_admins("[src] was forced to vent its contents by [user] at \the [get_area(loc)], last touched by [forensic_data?.get_lastprint()]", user)
				else
					to_chat(user, span_warning("\The [src] does nothing!"))
		return
	. = ..()
