/obj/machinery/pointdefense/apply_mapped_upgrades()
	// Detect new parts placed by mappers
	var/list/parts_found = list()
	for(var/i = 1, i <= loc.contents.len, i++)
		var/obj/item/W = loc.contents[i]
		if(istype(W, /obj/item/stock_parts/capacitor))
			parts_found.Add(W)
		if(istype(W, /obj/item/stock_parts/manipulator))
			parts_found.Add(W)
		if(istype(W, /obj/item/stock_parts/scanning_module))
			parts_found.Add(W)

	// Wipe old parts for new ones!
	if(parts_found.len == 0)
		return
	if(locate(/obj/item/stock_parts/capacitor) in parts_found)
		while(TRUE)
			var/obj/item/stock_parts/capacitor/C = locate(/obj/item/stock_parts/capacitor) in component_parts
			if(isnull(C))
				break
			component_parts.Remove(C)
			qdel(C)
	if(locate(/obj/item/stock_parts/manipulator) in parts_found)
		while(TRUE)
			var/obj/item/stock_parts/manipulator/M = locate(/obj/item/stock_parts/manipulator) in component_parts
			if(isnull(M))
				break
			component_parts.Remove(M)
			qdel(M)
	if(locate(/obj/item/stock_parts/scanning_module) in parts_found)
		while(TRUE)
			var/obj/item/stock_parts/scanning_module/S = locate(/obj/item/stock_parts/scanning_module) in component_parts
			if(isnull(S))
				break
			component_parts.Remove(S)
			qdel(S)

	// Rebuild from mapper's parts
	for(var/i = 1, i <= parts_found.len, i++)
		var/obj/item/W = parts_found[i]
		component_parts.Add(W)
		W.forceMove(src)
	RefreshParts()
