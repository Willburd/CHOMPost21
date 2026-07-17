// Nitrophoric
/obj/machinery/portable_atmospherics/canister/nitrophoric_oxide
	name = "Canister: \[PN2O\]"
	icon_state = "purple"
	canister_color = "purple"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/nitrophoric_oxide/Initialize(mapload)
	..()
	var/list/air_mix = StandardAirMix()
	src.air_contents.adjust_multi(GAS_PHORON, air_mix[GAS_O2], GAS_N2O, air_mix[GAS_N2])

	src.update_icon()
	return 1

// Empty varients
/obj/machinery/portable_atmospherics/canister/empty/nitrophoric_oxide
	name = "Canister \[PN2O\]"
	icon_state = "purple"
	canister_color = "purple"
