/obj/machinery/door/airlock/centcom/nameddorm
	name = "Residence"
	var/matchnames = list("Put","Real","Names","Here")

/obj/machinery/door/airlock/centcom/nameddorm/check_access(obj/item/I)
	// special dorm airlock that checks for names instead of req_access
	if(!istype(I,/obj/item/card/id))
		return FALSE
	var/obj/item/card/id/D = I
	for(var/name in matchnames)
		if(name == D.registered_name)
			return TRUE
	return FALSE
