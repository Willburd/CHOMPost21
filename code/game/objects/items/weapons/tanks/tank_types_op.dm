/*
 * Nitrophoric-Anesthetic
 */
/obj/item/weapon/tank/phoroanesthetic
	name = "Nitrophoric-anesthetic tank"
	desc = "A tank with an P/N2O gas mix."
	icon = 'icons/obj/tank_op.dmi'
	icon_state = "phoroanesthetic"

/obj/item/weapon/tank/phoroanesthetic/Initialize()
	. = ..()

	air_contents.gas["phoron"] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gas["nitrous_oxide"] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
	air_contents.update_values()
