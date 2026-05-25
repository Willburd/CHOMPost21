/obj/item/circuitboard/needle_cleaner
	name = T_BOARD("needle cleaning centrifuge")
	build_path = /obj/machinery/needle_cleaner
	board_type = new /datum/frame/frame_types/machine
	matter = list(MAT_STEEL = 50, MAT_GLASS = 50)
	req_components = list(
							/obj/item/stock_parts/micro_laser = 4,
							/obj/item/stock_parts/motor = 2,
							/obj/item/stock_parts/gear = 1)
