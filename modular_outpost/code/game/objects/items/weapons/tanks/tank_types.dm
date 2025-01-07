/*
 * Nitrophoric-Anesthetic
 */
/obj/item/tank/phoroanesthetic
	name = "Nitrophoric-anesthetic tank"
	desc = "A tank with an P/N2O gas mix."
	icon = 'modular_outpost/icons/obj/tank.dmi'
	icon_state = "phoroanesthetic"
	gauge_cap = 3
	gauge_icon = "indicator_bigtank"

/obj/item/tank/phoroanesthetic/Initialize()
	. = ..()

	air_contents.gas[GAS_PHORON] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gas[GAS_N2O] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
	air_contents.update_values()


/*
 * Emergency tanks
 */

// Co2
/obj/item/tank/emergency/carbon_dioxide
	name = "emergency carbon dioxide tank"
	desc = "An emergency air tank hastily painted yellow."
	icon_state = "emergency_tst"
	gauge_icon = "indicator_emergency"

/obj/item/tank/emergency/carbon_dioxide/Initialize()
	. = ..()
	src.air_contents.adjust_gas(GAS_CO2, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

// Methane
/obj/item/tank/emergency/methane
	name = "emergency methane tank"
	desc = "An emergency air tank hastily painted yellow."
	icon_state = "emergency_tst"
	gauge_icon = "indicator_emergency"
	gauge_cap = 3

/obj/item/tank/emergency/methane/Initialize()
	. = ..()
	src.air_contents.adjust_gas(GAS_CH4, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))


/*
 * Full size tanks
 */

// Methane
/obj/item/tank/methane
	name = "methane tank"
	desc = "A tank of methane."
	icon = 'modular_outpost/icons/obj/tank.dmi'
	icon_state = "methane"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD

/obj/item/tank/methane/Initialize()
	. = ..()
	src.air_contents.adjust_gas(GAS_CH4, (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/tank/methane/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas[GAS_CH4] < 10))
		. += span_danger("The meter on \the [src] indicates you are almost out of methane!")
		//playsound(user, 'sound/effects/alert.ogg', 50, 1)
