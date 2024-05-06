/*
 * Nitrophoric-Anesthetic
 */
/obj/item/weapon/tank/phoroanesthetic
	name = "Nitrophoric-anesthetic tank"
	desc = "A tank with an P/N2O gas mix."
	icon = 'icons/obj/tank_op.dmi'
	icon_state = "phoroanesthetic"
	gauge_cap = 3
	gauge_icon = "indicator_bigtank"

/obj/item/weapon/tank/phoroanesthetic/Initialize()
	. = ..()

	air_contents.gas["phoron"] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gas["nitrous_oxide"] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
	air_contents.update_values()


/*
 * Emergency tanks
 */

// Co2
/obj/item/weapon/tank/emergency/carbon_dioxide
	name = "emergency carbon dioxide tank"
	desc = "An emergency air tank hastily painted yellow."
	icon_state = "emergency_tst"
	gauge_icon = "indicator_emergency"

/obj/item/weapon/tank/emergency/carbon_dioxide/Initialize()
	. = ..()
	src.air_contents.adjust_gas("carbon_dioxide", (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

// Methane
/obj/item/weapon/tank/emergency/methane
	name = "emergency methane tank"
	desc = "An emergency air tank hastily painted yellow."
	icon_state = "emergency_tst"
	gauge_icon = "indicator_emergency"
	gauge_cap = 3

/obj/item/weapon/tank/emergency/methane/Initialize()
	. = ..()
	src.air_contents.adjust_gas("methane", (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))


/*
 * Full size tanks
 */

// Co2
/obj/item/weapon/tank/carbon_dioxide
	name = "carbon dioxide tank"
	desc = "A tank of carbon dioxide."
	icon_state = "oxygen_f"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD

/obj/item/weapon/tank/carbon_dioxide/Initialize()
	. = ..()
	src.air_contents.adjust_gas("carbon_dioxide", (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/carbon_dioxide/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas["carbon_dioxide"] < 10))
		. += "<span class='danger'>The meter on \the [src] indicates you are almost out of carbon dioxide!</span>"
		//playsound(user, 'sound/effects/alert.ogg', 50, 1)

// Methane
/obj/item/weapon/tank/methane
	name = "methane tank"
	desc = "A tank of methane."
	icon = 'icons/obj/tank_op.dmi'
	icon_state = "methane"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD

/obj/item/weapon/tank/methane/Initialize()
	. = ..()
	src.air_contents.adjust_gas("methane", (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/methane/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas["methane"] < 10))
		. += "<span class='danger'>The meter on \the [src] indicates you are almost out of methane!</span>"
		//playsound(user, 'sound/effects/alert.ogg', 50, 1)
