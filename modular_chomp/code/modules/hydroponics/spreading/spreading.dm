// BURNINATE THE COUNTRYSIDE
/obj/effect/plant/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	health -= (rand(1,3)*15)
	check_health()
	. = ..()
