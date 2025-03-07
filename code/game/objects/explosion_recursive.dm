/client/proc/kaboom()
	var/power = tgui_input_number(src, "power?", "power?")
	var/turf/T = get_turf(src.mob)
	explosion(T, power)

/obj
	var/explosion_resistance

/turf
	var/explosion_resistance

/turf/space
	explosion_resistance = 3

/turf/simulated/open
	explosion_resistance = 3

/turf/simulated/floor
	explosion_resistance = 1

/turf/simulated/mineral
	explosion_resistance = 2

/turf/simulated/shuttle/floor
	explosion_resistance = 1

/turf/simulated/shuttle/floor4
	explosion_resistance = 1

/turf/simulated/shuttle/plating
	explosion_resistance = 1

/turf/simulated/shuttle/wall
	explosion_resistance = 10

/turf/simulated/wall
	explosion_resistance = 10
	
/* Old recursive explosion code
//Code-wise, a safe value for power is something up to ~25 or ~30.. This does quite a bit of damage to the station.
//direction is the direction that the spread took to come to this tile. So it is pointing in the main blast direction - meaning where this tile should spread most of it's force.
/turf/proc/explosion_spread(power, direction, var/list/explosion_turfs)
	if(power <= 0)
		return
	if(src in explosion_turfs)
		if(explosion_turfs[src] >= power)
			return //The turf already sustained and spread a power greated than what we are dealing with. No point spreading again.
	explosion_turfs[src] = power

	var/spread_power = power - src.explosion_resistance //This is the amount of power that will be spread to the tile in the direction of the blast
	for(var/obj/O in src)
		if(O.explosion_resistance)
			spread_power -= O.explosion_resistance

	var/turf/T = get_step(src, direction)
	if(T)
		T.explosion_spread(spread_power, direction, explosion_turfs)
		T = get_step(src, turn(direction,90))
		if(T)
			T.explosion_spread(spread_power, turn(direction,90), explosion_turfs)
		T = get_step(src, turn(direction,-90))
		if(T)
			T.explosion_spread(spread_power, turn(direction,-90), explosion_turfs)

/turf/unsimulated/explosion_spread(power)
	return //So it doesn't get to the parent proc, which simulates explosions
*/
