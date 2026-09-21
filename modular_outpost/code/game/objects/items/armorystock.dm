/obj/item/paper/armorystock
	name = "Armory Stock"
	info = "Current stock of "
	var/area_path = /area/security/tactical

/obj/item/paper/armorystock/Initialize(mapload, text, title)
	. = ..()
	var/area/get_area = GLOB.areas_by_type[area_path]
	if(!get_area)
		return

	var/list/stock = list()
	for(var/obj/item/found_item in get_area.contents)
		append_stock(stock, found_item)

	for(var/obj/structure/closet/closet in get_area.contents)
		for(var/obj/item/found_item in closet.contents)
			append_stock(stock, found_item)

	for(var/obj/machinery/machine in get_area.contents)
		if(machine.anchored)
			continue
		append_stock(stock, machine)

	name = "[get_area] Stock"
	info += "[get_area]:<br>"
	gen_list(stock)

/obj/item/paper/armorystock/proc/append_stock(list/current_list, obj/item/stocking)
	if(istype(stocking, /obj/item/radio/intercom))
		return
	if(istype(stocking, /obj/item/geiger/wall))
		return
	if(istype(stocking, /obj/item/storage/box)) // Nested boxes
		for(var/obj/item/found_item in stocking.contents)
			append_stock(current_list, found_item)
		return

	if(!current_list[stocking.type])
		current_list[stocking.type] = 1;
	else
		current_list[stocking.type] += 1

/obj/item/paper/armorystock/proc/gen_list(list/current_list)
	info += "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>"
	info += "<tr>"
	info += "<th><center>Name</center></th>"
	info += "<th><center>Count</center></th>"
	info += "</tr>"

	for(var/obj/pathcheck as anything in current_list)
		info += "<tr>"
		var/count = current_list[pathcheck]
		// Custom name support
		var/name = initial(pathcheck.name)
		info += "<td><center>[name]</center></td>"
		info += "<td><center>[count]</center></td>"
		info += "</tr>"
	info += "</table>"
