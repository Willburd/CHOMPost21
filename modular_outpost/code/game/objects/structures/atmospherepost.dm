/obj/structure/atmopost
	name = "atmospheric probe"
	desc = "A tall pole with a machine mounted on it. It displays the current atmospheric conditions on a sign beneath it. It reads: "
	icon = 'modular_outpost/icons/obj/32x64.dmi'
	icon_state = "atmopost"
	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	opacity = FALSE

/obj/structure/atmopost/examine(mob/living/user)
	. = ..()

	var/datum/gas_mixture/environment = loc.return_air()
	var/pressure = environment.return_pressure()
	var/total_moles = environment.total_moles
	. += "[round(environment.temperature-T0C,0.1)]&deg;C([round(environment.temperature,0.1)]K) "
	if(total_moles)
		for(var/g in environment.gas)
			. += "[gas_data.name[g]]: [round((environment.gas[g] / total_moles) * 100)]% "
	. += "[round(pressure,0.1)] kPa"
