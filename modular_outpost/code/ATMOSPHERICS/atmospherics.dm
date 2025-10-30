/obj/machinery/atmospherics/proc/blowout(mob/user)
	// Deconstruct turf
	var/turf/T = loc
	if(!T.is_plating() && istype(T,/turf/simulated/floor)) //intact floor, pop the tile
		var/turf/simulated/floor/F = T
		F.make_plating(TRUE)
	// Deconstruct pipe
	var/datum/gas_mixture/int_air = return_air()
	var/datum/gas_mixture/env_air = T.return_air()
	var/internal_pressure = int_air.return_pressure()-env_air.return_pressure()
	deconstruct()
	// Release pressure
	playsound(T, 'sound/effects/bang.ogg', 70, 0, 0)
	playsound(T, 'sound/effects/clang2.ogg', 70, 0, 0)
	if(internal_pressure > 2*ONE_ATMOSPHERE)
		unsafe_pressure_release(user, internal_pressure)
		playsound(T, 'sound/machines/hiss.ogg', 50, 0, 0)
