/obj/item/retail_scanner
	name = "retail scanner"
	desc = "Assess the cargo sale value of items."
	icon = 'icons/obj/device.dmi'
	icon_state = "retail_idle"
	flags = NOBLUDGEON
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_SMALL
	origin_tech = list(TECH_DATA = 1)

// Always face the user when put on a table
/obj/item/retail_scanner/afterattack(atom/movable/AM, mob/user, proximity)
	if(!proximity)	return
	if(istype(AM, /obj/structure/table))
		src.pixel_y = 3 // Shift it up slightly to look better on table
		src.dir = get_dir(src, user)
	else
		flick("retail_scan", src)
		scan_item_price(AM,user)

// Reset dir when picked back up
/obj/item/retail_scanner/pickup(mob/user)
	src.dir = SOUTH
	src.pixel_y = 0

/obj/item/retail_scanner/proc/scan_item_price(var/atom/movable/AM,mob/user)
	to_chat(user,span_boldnotice("\The [src] assesses the supply point value of \the [AM]..."))
	playsound(src, 'sound/machines/beep.ogg', 50, 1)

	// Some things cannot be sold
	if(isliving(AM) || isstructure(AM) || isturf(AM) || istype(AM,/obj/effect))
		to_chat(user,span_danger("-Cannot be sold."))
		return 0

	// Raw item value
	var/value = 0
	if(isitem(AM))
		value = SSsupply.get_item_sale_value(AM)

	// Assess reagents
	var/reagent_value = 0
	if(!istype(AM,/obj/item/reagent_containers/food)) // Ignore food reagents
		if(!isnull(AM.reagents))
			if(AM.reagents.reagent_list.len > 0)
				for(var/datum/reagent/R in AM.reagents.reagent_list)
					reagent_value += SSsupply.get_reagent_sale_value(R)

	// Handle output
	if(value == 0 && reagent_value == 0)
		to_chat(user,span_danger("-It's worth nothing."))
	else
		if(value > 0)
			var/price = SSsupply.points_to_cash(value)
			to_chat(user,span_notice("-It's worth [value] points, or [price] [price > 1 ? "thalers" : "thaler"]"))
		if(reagent_value > 0)
			var/price = SSsupply.points_to_cash(reagent_value)
			to_chat(user,span_notice("-It's chemical contents are worth [reagent_value] points, or [price] [price > 1 ? "thalers" : "thaler"]"))
			to_chat(user,span_warning("-This product must be transported in a full cargo tug tanker with minimal cross contamination."))

	// Supply notes
	if(istype(AM,/obj/item/organ) || istype(AM,/obj/item/reagent_containers/glass/bottle/vaccine) || istype(AM,/obj/item/reagent_containers/food))
		to_chat(user,span_warning("-This product must be sold in a freezer"))
	else if(value > 0)
		to_chat(user,span_warning("-This product must be sold in a crate"))
