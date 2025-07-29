/obj/item/retail_scanner
	name = "cargo scanner"
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

	// Get item value
	var/value = SEND_SIGNAL(AM,COMSIG_ITEM_SCAN_PROFIT)
	if(value == 0)
		to_chat(user,span_danger("-It's worth nothing."))
	else
		var/price = SSsupply.points_to_cash(value)
		to_chat(user,span_notice("-It can be sold for [value] points, or [price] [price > 1 ? "thalers" : "thaler"]"))

	return value
