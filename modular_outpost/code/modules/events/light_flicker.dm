/datum/event/light_flicker/start()
	var/severity_range = rand(7,12)
	while(machines.len && severity_range-- > 0)
		var/obj/machinery/M = pick(machines)
		if(istype(M,/obj/machinery/light))
			var/obj/machinery/light/L = M
			L.flicker(rand(10,20))
