/obj/machinery/vending/cargo_resale
	name = "Cargo Vendor"
	desc = "A vending machine loaded by the station's cargo department. So many prices and values!"
	description_fluff = "Contact your nearest cargo technician to inquire about lost or stolen belongings. You might get a good price for them."
	// icon = 'icons/obj/vending_op.dmi'
	icon_state = "engi" // Outpost todo - custom vendi
	products = list()
	contraband = list()
	prices = list()
	refillable = FALSE // special handling
	var/cargo_locked = TRUE
	var/vending_account = "Cargo" // Which department bankaccount this goes to

	var/unlock_access = list(access_cargo)
	forced_icon_path = /obj/item/spacecash/c20

/obj/machinery/vending/cargo_resale/do_not_use
	// This exists exclusively so that we have icons for the cargo vendor above. Due to startup tgui icon init only getting the icons of the initial vendable products.
	products = list(/obj/item/spacecash/c1,/obj/item/spacecash/c5,/obj/item/spacecash/c10,/obj/item/spacecash/c20,/obj/item/spacecash/c50,/obj/item/spacecash/c100,/obj/item/spacecash/c200,/obj/item/spacecash/c500,/obj/item/spacecash/c1000)

/obj/machinery/vending/cargo_resale/Destroy()
	// Drop inventory before clearing it
	for(var/datum/stored_item/vending_product/R in product_records)
		for(var/obj/I in R.instances)
			I.forceMove(loc)
		R.instances = list()
	return ..()

/obj/machinery/vending/cargo_resale/proc/cargo_vendor_unlocking(var/obj/item/card/id/C, mob/user as mob)
	// Handle unlocking machine if cargo
	if(!(unlock_access[1] in C.access)) //doesn't have this access
		return FALSE
	cargo_locked = !cargo_locked
	visible_message(span_info("\The [user] [cargo_locked ? "locks" : "unlocks"] \the [src]'s restocking controls."))
	SStgui.update_uis(src)
	return TRUE

/obj/machinery/vending/cargo_resale/proc/stock_cargo_vendor(obj/item/W as obj, mob/user as mob)
	if(panel_open)
		// check if already has
		for(var/datum/stored_item/vending_product/R in product_records)
			if(istype(W, R.item_path) && (W.name == R.item_name))
				stock(W, R, user)
				return TRUE

		// Basic unvendables
		if(W.my_augment)
			to_chat(user,span_notice("\The [src] cannot vend an attached implant."))
			return FALSE
		if(istype(W,/obj/item/stack) || istype(W,/obj/item/holder) || istype(W,/obj/item/grab) || istype(W,/obj/item/card/id))
			to_chat(user,span_notice("\The [src] cannot vend this."))
			return FALSE
		// Per item sanity filter. I hate everything about this.
		if(istype(W,/obj/item/vac_attachment) \
		|| istype(W,/obj/item/shockpaddles/linked) \
		|| istype(W,/obj/item/radio/bluespacehandset/linked) \
		|| istype(W,/obj/item/cmo_disk_holder) \
		|| istype(W,/obj/item/rig) \
		|| istype(W,/obj/item/telecube) \
		|| istype(W,/obj/item/reagent_containers/glass/bottle/adminordrazine) \
		|| istype(W,/obj/item/gun/energy/sizegun/admin) \
		|| istype(W,/obj/item/melee/cursedblade) \
		|| istype(W,/obj/item/radio/bluespacehandset/linked) \
		|| istype(W,/obj/item/paicard) \
		|| istype(W,/obj/item/radio/bluespacehandset/linked) \
		|| istype(W,/obj/item/organ) \
		|| istype(W,/obj/item/soulstone) \
		|| istype(W,/obj/item/aicard) \
		|| istype(W,/obj/item/mmi) \
		|| istype(W,/obj/item/spacecash) \
		|| istype(W,/obj/item/spacecasinocash))
			to_chat(user,span_notice("\The [src] should not vend this."))
			return FALSE

		// Add new entry if safe
		var/datum/stored_item/vending_product/product = new/datum/stored_item/vending_product(src, W.type, W.name, price = 0)
		product.instances = list() // So we don't reinit and get a free item upon calling stock()
		product_records.Add(product)
		stock(W, product, user)
		return TRUE

	return FALSE

/obj/machinery/vending/cargo_resale/proc/set_cargo_price(var/datum/stored_item/vending_product/R, mob/user as mob)
	if(!Adjacent(user))
		return
	var/amount = tgui_input_number(user, "Assign vending price for [R.item_name], it is currently [R.item_name ? R.item_name : "free"].", "Set Vending Price")
	if(!R || !Adjacent(user))
		return
	if(amount < 0)
		amount = 0
	R.price = amount
	SStgui.update_uis(src)

/obj/machinery/vending/cargo_resale/examine(mob/user, infix, suffix)
	. = ..()
	. += "The slot for restocking and inserting a [vending_account] department ID is [cargo_locked ? "locked behind a small screwed on panel" : "unlocked"]."

// Remove empty products from machine on final vend
/obj/machinery/vending/delayed_vend(datum/stored_item/vending_product/R, mob/user)
	. = ..()
	if(R && R.instances.len <= 0)
		product_records.Remove(R)
		SStgui.update_uis(src)

/**
 *  Add money for current purchase to the vendor account.
 *
 *  Called after the money has already been taken from the customer.
 */
/obj/machinery/vending/cargo_resale/credit_purchase(var/target as text)
	var/datum/money_account/cargo_dept_account = department_accounts[vending_account]
	cargo_dept_account.money += currently_vending.price

	var/datum/transaction/T = new()
	T.target_name = target
	T.purpose = "Purchase of [currently_vending.item_name]"
	T.amount = "[currently_vending.price]"
	T.source_terminal = name
	T.date = current_date_string
	T.time = stationtime2text()
	cargo_dept_account.transaction_log.Add(T)




/obj/machinery/vending/cargo_resale/bar
	name = "Kitchen Vendor"
	desc = "A vending machine loaded by the station's kitchen and bar. So many drinks and meals!"
	// icon = 'icons/obj/vending_op.dmi'
	icon_state = "nutri" // Outpost todo - custom vendi
	vending_account = "Civilian" // Which department bankaccount this goes to
	unlock_access = list(access_kitchen,access_bar)

/obj/machinery/vending/cargo_resale/medi
	name = "Medicare Vendor"
	desc = "A vending machine loaded by the station's medical department. So many chemicals and treatments!"
	// icon = 'icons/obj/vending_op.dmi'
	icon_state = "med" // Outpost todo - custom vendi
	vending_account = "Medical" // Which department bankaccount this goes to
	unlock_access = list(access_medical)

/obj/machinery/vending/cargo_resale/sci
	name = "Technology Vendor"
	desc = "A vending machine loaded by the station's research department. So many doodads and whatzits!"
	// icon = 'icons/obj/vending_op.dmi'
	icon_state = "nutri" // Outpost todo - custom vendi
	vending_account = "Research" // Which department bankaccount this goes to
	unlock_access = list(access_research)
