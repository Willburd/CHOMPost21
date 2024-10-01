/obj/item/circuitboard/lockdown_console
	name = T_BOARD("lockdown console")
	build_path = /obj/machinery/lockdown_console
	board_type = new /datum/frame/frame_types/lockdown_console
	matter = list(MAT_STEEL = 50, MAT_GLASS = 50)

/obj/item/circuitboard/metal_detector
	name = T_BOARD("threat scanner")
	build_path = /obj/machinery/metal_detector //metal_detector temp
	board_type = new /datum/frame/frame_types/metal_detector
	origin_tech = list(TECH_MAGNET = 4, TECH_BIO = 2, TECH_DATA = 2)
	req_components = list(
							/obj/item/stock_parts/scanning_module = 4,
							/obj/item/stock_parts/capacitor/adv = 1,		//for the JUICE
							/obj/item/stock_parts/motor = 2,
							/obj/item/stack/cable_coil = 5)

/obj/item/circuitboard/smart_centrifuge
	name = T_BOARD("smart centrifuge")
	build_path = /obj/machinery/smart_centrifuge
	board_type = new /datum/frame/frame_types/smart_centrifuge
	matter = list(MAT_STEEL = 50, MAT_GLASS = 50)
	origin_tech = list(TECH_MAGNET = 1, TECH_DATA = 2)
	req_components = list(
							/obj/item/stock_parts/scanning_module = 1,
							/obj/item/stock_parts/motor = 1,
							/obj/item/stock_parts/gear = 3,
							/obj/item/stack/material/glass/reinforced = 1)

// Refinery machines
/obj/item/circuitboard/industrial_reagent_grinder
	name = T_BOARD("industrial chemical grinder")
	build_path = /obj/machinery/reagentgrinder/industrial
	board_type = new /datum/frame/frame_types/industrial_reagent_grinder
	req_components = list(
							/obj/item/stock_parts/capacitor = 1,
							/obj/item/stock_parts/motor = 2,
							/obj/item/stock_parts/gear = 2,
							/obj/item/reagent_containers/glass/beaker/large = 1)

/obj/item/circuitboard/industrial_reagent_pump
	name = T_BOARD("industrial chemical pump")
	build_path = /obj/machinery/reagent_refinery/pump
	board_type = new /datum/frame/frame_types/industrial_reagent_pump
	req_components = list(
							/obj/item/stock_parts/motor = 1,
							/obj/item/stack/material/glass/reinforced = 1)

/obj/item/circuitboard/industrial_reagent_filter
	name = T_BOARD("industrial chemical filter")
	build_path = /obj/machinery/reagent_refinery/filter
	board_type = new /datum/frame/frame_types/industrial_reagent_filter
	req_components = list(
							/obj/item/stock_parts/motor = 1,
							/obj/item/stock_parts/scanning_module = 1,
							/obj/item/stock_parts/motor = 1,
							/obj/item/stock_parts/gear = 1,
							/obj/item/stack/material/glass/reinforced = 1)

/obj/item/circuitboard/industrial_reagent_vat
	name = T_BOARD("industrial chemical vat")
	build_path = /obj/machinery/reagent_refinery/vat
	board_type = new /datum/frame/frame_types/industrial_reagent_vat
	req_components = list(
							/obj/item/stock_parts/motor = 1,
							/obj/item/stack/material/glass/reinforced = 1)

/obj/item/circuitboard/industrial_reagent_pipe
	name = T_BOARD("industrial chemical pipe")
	build_path = /obj/machinery/reagent_refinery/pipe
	board_type = new /datum/frame/frame_types/industrial_reagent_pipe
	req_components = list( /obj/item/stack/material/glass/reinforced = 1)

/obj/item/circuitboard/industrial_reagent_waste_processor
	name = T_BOARD("industrial chemical waste processor")
	build_path = /obj/machinery/reagent_refinery/waste_processor
	board_type = new /datum/frame/frame_types/industrial_reagent_waste_processor
	req_components = list(
							/obj/item/stock_parts/capacitor = 4,
							/obj/item/stock_parts/micro_laser = 4,
							/obj/item/stock_parts/manipulator = 1,
							/obj/item/stack/material/glass/reinforced = 1)

/obj/item/circuitboard/industrial_reagent_hub
	name = T_BOARD("industrial chemical hub")
	build_path = /obj/machinery/reagent_refinery/hub
	board_type = new /datum/frame/frame_types/industrial_reagent_hub
	req_components = list(
							/obj/item/stock_parts/motor = 1,
							/obj/item/stock_parts/manipulator = 1)

/obj/item/circuitboard/industrial_reagent_reactor
	name = T_BOARD("industrial chemical reactor")
	build_path = /obj/machinery/reagent_refinery/reactor
	board_type = new /datum/frame/frame_types/industrial_reagent_reactor
	req_components = list(
							/obj/item/stock_parts/motor = 1,
							/obj/item/stock_parts/capacitor = 4,
							/obj/item/stock_parts/micro_laser = 4,
							/obj/item/stock_parts/manipulator = 1,
							/obj/item/stack/material/glass/reinforced = 1)

/obj/item/circuitboard/industrial_reagent_furnace
	name = T_BOARD("industrial chemical sintering furnace")
	build_path = /obj/machinery/reagent_refinery/furnace
	board_type = new /datum/frame/frame_types/industrial_reagent_furnace
	req_components = list(
							/obj/item/stock_parts/motor = 2,
							/obj/item/stock_parts/capacitor = 4,
							/obj/item/stock_parts/scanning_module = 1,
							/obj/item/stock_parts/manipulator = 1,
							/obj/item/stock_parts/gear = 2)
