// Used on the INTERIOR side like the exterior/shuttle is
/obj/machinery/airlock_sensor/offset_facing/return_air()
	var/turf/T = get_step(src, dir)
	if(isnull(T))
		return ..()
	return T.return_air()
