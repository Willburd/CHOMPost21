// Nitrophoric
/obj/machinery/portable_atmospherics/canister/nitrophoric_oxide
	name = "Canister: \[PN2O\]"
	icon_state = "purple"
	canister_color = "purple"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/nitrophoric_oxide/Initialize()
	..()
	var/list/air_mix = StandardAirMix()
	src.air_contents.adjust_multi("phoron", air_mix["oxygen"], "nitrous_oxide", air_mix["nitrogen"])

	src.update_icon()
	return 1

// Methane
/obj/machinery/portable_atmospherics/canister/methane
	name = "Canister: \[CH4\]"
	icon_state = "green"
	canister_color = "green"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/methane/Initialize()
	..()

	src.air_contents.adjust_gas("methane", MolesForPressure())
	src.update_icon()
	return 1


// Empty varients
/obj/machinery/portable_atmospherics/canister/empty/nitrophoric_oxide
	name = "Canister \[PN2O\]"
	icon_state = "purple"
	canister_color = "purple"

/obj/machinery/portable_atmospherics/canister/empty/methane
	name = "Canister \[CH4\]"
	icon_state = "green"
	canister_color = "green"
