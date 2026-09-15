/**
 * Restores pipe turbines as an emergency form of power that can be constructed with minimal tools.
 */

/obj/machinery/atmospherics/pipeturbine
	name = "emergency turbine impeller"
	desc = "A gas turbine. Converting pressure into energy since 1884. For use in cold-start station emergencies, where all other options have failed."
	circuit = /obj/item/circuitboard/pipeturbine

/obj/machinery/atmospherics/pipeturbine/attackby(obj/item/W, mob/user)
	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	. = ..()


/obj/machinery/power/turbinemotor
	name = "emergency turbine generator"
	desc = "Electrogenerator. Converts rotation into power. For use in cold-start station emergencies, where all other options have failed."
	circuit = /obj/item/circuitboard/turbinemotor

/obj/machinery/power/turbinemotor/attackby(obj/item/W, mob/user)
	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	. = ..()


/obj/item/circuitboard/pipeturbine
	name = T_BOARD("emergency turbine impeller")
	desc = "The circuitboard for an emergency turbine impeller."
	build_path = /obj/machinery/atmospherics/pipeturbine
	board_type = new /datum/frame/frame_types/pipeturbine
	contain_parts = FALSE
	req_components = list()
	hidden = TRUE // This is created by alternative means

/obj/item/circuitboard/turbinemotor
	name = T_BOARD("emergency turbine generator")
	desc = "The circuitboard for an emergency turbine generator."
	build_path = /obj/machinery/power/turbinemotor
	board_type = new /datum/frame/frame_types/turbinemotor
	hidden = TRUE // This is created by alternative means
	req_components = list()
	contain_parts = FALSE


/datum/frame/frame_types/pipeturbine
	name = "Emergency Turbine Impeller"
	icon_override = 'modular_outpost/icons/obj/stock_parts.dmi'
	frame_class = FRAME_CLASS_MACHINE
	circuit = /obj/item/circuitboard/pipeturbine

/datum/frame/frame_types/turbinemotor
	name = "Emergency Turbine Generator"
	icon_override = 'modular_outpost/icons/obj/stock_parts.dmi'
	frame_class = FRAME_CLASS_MACHINE
	circuit = /obj/item/circuitboard/turbinemotor
