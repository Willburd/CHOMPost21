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

/obj/item/circuitboard/supply_request_computeralt
	name = T_BOARD("request console computer")
	build_path = /obj/machinery/computer/supply_request_computeralt
	matter = list(MAT_STEEL = 50, MAT_GLASS = 50)
