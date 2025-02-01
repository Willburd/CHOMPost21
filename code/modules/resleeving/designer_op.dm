// Little define makes it cleaner to read the tripple color values out of mobs.
#define MENU_MAIN "Main"
#define MENU_BODYRECORDS "Body Records"
#define MENU_STOCKRECORDS "Stock Records"
#define MENU_SPECIFICRECORD "Specific Record"
#define MENU_OOCNOTES "OOC Notes"

/obj/machinery/computer/transhuman/designer
	name = "body design console"
	catalogue_data = list(/datum/category_item/catalogue/technology/resleeving)
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "med_key"
	icon_screen = "explosive"
	light_color = "#315ab4"
	circuit = /obj/item/circuitboard/body_designer
	req_access = list(access_medical) // Used for loading people's designs
	VAR_PRIVATE/temp = ""
	VAR_PRIVATE/menu = MENU_MAIN //Which menu screen to display
	VAR_PRIVATE/datum/transhuman/body_record/active_br = null
	//Mob preview
	VAR_PRIVATE/map_name
	VAR_PRIVATE/obj/screen/south_preview = null
	VAR_PRIVATE/obj/screen/east_preview = null
	VAR_PRIVATE/obj/screen/west_preview = null
	VAR_PRIVATE/obj/screen/north_preview = null
	// Mannequins are somewhat expensive to create, so cache it
	VAR_PRIVATE/mob/living/carbon/human/dummy/mannequin/mannequin = null
	VAR_PRIVATE/obj/item/disk/body_record/disk = null

	// Resleeving database this machine interacts with. Blank for default database
	// Needs a matching /datum/transcore_db with key defined in code
	VAR_PRIVATE/db_key
	VAR_PRIVATE/datum/transcore_db/our_db // These persist all round and are never destroyed, just keep a hard ref

/obj/machinery/computer/transhuman/designer/Initialize()
	. = ..()
	map_name = "transhuman_designer_[REF(src)]_map"

	south_preview = new
	south_preview.name = ""
	south_preview.assigned_map = map_name
	south_preview.del_on_map_removal = FALSE
	south_preview.screen_loc = "[map_name]:2,1"

	east_preview = new
	east_preview.name = ""
	east_preview.assigned_map = map_name
	east_preview.del_on_map_removal = FALSE
	east_preview.screen_loc = "[map_name]:4,1"

	west_preview = new
	west_preview.name = ""
	west_preview.assigned_map = map_name
	west_preview.del_on_map_removal = FALSE
	west_preview.screen_loc = "[map_name]:0,1"

	north_preview = new
	north_preview.name = ""
	north_preview.assigned_map = map_name
	north_preview.del_on_map_removal = FALSE
	north_preview.screen_loc = "[map_name]:6,1"

	our_db = SStranscore.db_by_key(db_key)

/obj/machinery/computer/transhuman/designer/Destroy()
	replace_br(null)
	qdel_null(mannequin)
	if(disk)
		disk.forceMove(get_turf(src))
		disk = null
	. = ..()

/obj/machinery/computer/transhuman/designer/dismantle()
	if(disk)
		disk.forceMove(get_turf(src))
		disk = null
	. = ..()

/obj/machinery/computer/transhuman/designer/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/disk/body_record))
		user.unEquip(W)
		disk = W
		disk.forceMove(src)
		to_chat(user, span_notice("You insert \the [W] into \the [src]."))
		SStgui.update_uis(src)
	else
		. = ..()

/obj/machinery/computer/transhuman/designer/attack_ai(mob/user as mob)
	if(inoperable())
		return
	tgui_interact(user)

/obj/machinery/computer/transhuman/designer/attack_hand(mob/user as mob)
	add_fingerprint(user)
	if(inoperable())
		return
	tgui_interact(user)

/obj/machinery/computer/transhuman/designer/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		if(user.client)
			user.client.register_map_obj(south_preview)
			user.client.register_map_obj(east_preview)
			user.client.register_map_obj(west_preview)
			user.client.register_map_obj(north_preview)
		ui = new(user, src, "BodyDesigner", name)
		ui.open()

/obj/machinery/computer/transhuman/designer/tgui_static_data(mob/user)
	var/list/data = ..()
	data["mapRef"] = map_name
	return data

/obj/machinery/computer/transhuman/designer/tgui_data(mob/user)
	var/list/data = list()

	if(menu == MENU_BODYRECORDS)
		var/bodyrecords_list_ui[0]
		for(var/N in our_db.body_scans)
			var/datum/transhuman/body_record/BR = our_db.body_scans[N]
			bodyrecords_list_ui[++bodyrecords_list_ui.len] = list("name" = N, "recref" = "\ref[BR]")
		if(bodyrecords_list_ui.len)
			data["bodyrecords"] = bodyrecords_list_ui

	if(menu == MENU_STOCKRECORDS)
		var/stock_bodyrecords_list_ui[0]
		for (var/N in GLOB.all_species)
			var/datum/species/S = GLOB.all_species[N]
			if((S.spawn_flags & (SPECIES_IS_WHITELISTED|SPECIES_CAN_JOIN)) != SPECIES_CAN_JOIN) continue
			stock_bodyrecords_list_ui += N
		if(stock_bodyrecords_list_ui.len)
			data["stock_bodyrecords"] = stock_bodyrecords_list_ui

	if(active_br)
		data["menu"] = menu
		data["activeBodyRecord"] = list(
			"real_name" = active_br.mydna.name,
			"speciesname" = active_br.speciesname ? active_br.speciesname : active_br.mydna.dna.species,
			"gender" = active_br.bodygender,
			"synthetic" = active_br.synthetic ? "Yes" : "No",
			"locked" = active_br.locked,
			"booc" = active_br.body_oocnotes
		)

	data["menu"] = menu
	data["temp"] = temp
	data["disk"] = disk ? 1 : 0
	data["diskStored"] = disk && disk.stored ? 1 : 0

	return data

/obj/machinery/computer/transhuman/designer/tgui_act(action, params, datum/tgui/ui)
	if(..())
		return FALSE

	switch(action)
		if("debug_load_my_body")
			send_mob_images(new /datum/transhuman/body_record(ui.user, FALSE, FALSE))
			menu = MENU_SPECIFICRECORD
			return TRUE

		if("view_brec")
			var/datum/transhuman/body_record/BR = locate(params["view_brec"])
			if(BR && istype(BR.mydna))
				if(allowed(ui.user) || BR.ckey == ui.user.ckey)
					send_mob_images(new /datum/transhuman/body_record(BR)) // Load a COPY!
					menu = MENU_SPECIFICRECORD
				else
					replace_br(null)
					temp = "Access denied: Body records are confidential."
			else
				replace_br(null)
				temp = "ERROR: Record missing."
			return TRUE

		if("view_stock_brec")
			var/datum/species/S = GLOB.all_species[params["view_stock_brec"]]
			if(S && (S.spawn_flags & (SPECIES_IS_WHITELISTED|SPECIES_CAN_JOIN)) == SPECIES_CAN_JOIN)
				// Generate body record from species!
				mannequin = new(null, S.name)
				mannequin.real_name = "Stock [S.name] Body"
				mannequin.name = mannequin.real_name
				mannequin.dna.real_name = mannequin.real_name
				mannequin.dna.base_species = mannequin.species.base_species
				send_mob_images(new /datum/transhuman/body_record(mannequin, FALSE, FALSE))
				active_br.speciesname = "Custom Sleeve" // Custom name
				menu = MENU_SPECIFICRECORD
			else
				replace_br(null)
				temp = "ERROR: Stock Record missing."
			return TRUE

		if("boocnotes")
			menu = MENU_OOCNOTES
			return TRUE

		if("loadfromdisk")
			if(disk && disk.stored)
				send_mob_images(new /datum/transhuman/body_record(disk.stored)) // Loads a COPY!
				menu = MENU_SPECIFICRECORD
			return TRUE

		if("savetodisk")
			if(active_br.locked)
				var/answer = tgui_alert(ui.user,"This body record will be written to a disk and allow any mind to inhabit it. This is against the current body owner's configured OOC preferences for body impersonation. Please confirm that you have permission to do this, and are sure! Admins will be notified.","Mind Compatability",list("No","Yes"))
				if(!answer)
					return
				if(answer == "No")
					to_chat(ui.user, span_warning("ERROR: This body record is restricted."))
					return
				else
					message_admins("[ui.user] wrote an unlocked version of [active_br.mydna.name]'s bodyrecord to a disk. Their preferences do not allow body impersonation, but may be allowed with OOC consent.")
					active_br.locked = FALSE // unlock it, even though it's only temp, so you don't get the warning every time
			if(disk && active_br)
				// Create it from the mob
				if(disk.stored)
					qdel_null(disk.stored)
				disk.stored = new /datum/transhuman/body_record(mannequin, FALSE, FALSE) // Saves a COPY!
				disk.stored.locked = FALSE // remove lock
				disk.name = "[initial(disk.name)] ([active_br.mydna.name])"
			return TRUE

		if("ejectdisk")
			disk.forceMove(get_turf(src))
			disk = null
			return TRUE

		if("menu")
			menu = params["menu"]
			temp = ""
			replace_br(null)
			return TRUE

		if("edit_body")
			if(active_br && mannequin)
				var/datum/tgui_module/appearance_changer/body_designer/V = new(src, mannequin)
				V.tgui_interact(ui.user)
			return FALSE

		if("edit_tag")
			// TODO - Anything not handled by appearance_changer
			return TRUE

	return FALSE

/obj/machinery/computer/transhuman/designer/proc/replace_br(var/datum/transhuman/body_record/new_br)
	PRIVATE_PROC(TRUE)
	if(active_br)
		qdel_null(active_br)
	active_br = new_br

/obj/machinery/computer/transhuman/designer/proc/get_active_record()
	return active_br

/obj/machinery/computer/transhuman/designer/proc/get_mannequin()
	if(!mannequin) // Regen if missing somehow
		send_mob_images(null)
	return mannequin

//
// Code below is for generating preview icons based on a body_record
//

/obj/machinery/computer/transhuman/designer/proc/send_mob_images(var/datum/transhuman/body_record/update_br)
	if(!mannequin)
		mannequin = new ()
	if(update_br)
		replace_br(update_br)
	mannequin.delete_inventory(TRUE)
	update_mob_from_record(mannequin)
	mannequin.ImmediateOverlayUpdate()

	var/mutable_appearance/MA = new(mannequin)
	south_preview.appearance = MA
	south_preview.dir = SOUTH
	south_preview.screen_loc = "[map_name]:2,1"
	south_preview.name = ""
	east_preview.appearance = MA
	east_preview.dir = EAST
	east_preview.screen_loc = "[map_name]:4,1"
	east_preview.name = ""
	west_preview.appearance = MA
	west_preview.dir = WEST
	west_preview.screen_loc = "[map_name]:0,1"
	west_preview.name = ""
	north_preview.appearance = MA
	north_preview.dir = NORTH
	north_preview.screen_loc = "[map_name]:6,1"
	north_preview.name = ""

/obj/machinery/computer/transhuman/designer/proc/update_mob_from_record(var/mob/living/carbon/human/H)
	PRIVATE_PROC(TRUE)
	ASSERT(!QDELETED(H))
	ASSERT(!QDELETED(active_br))

	// MAJOR TODO - Validate if this is needed or if another proc exists for regenning the species after call

	//Get the DNA and generate a new mob
	var/datum/dna2/record/R = active_br.mydna
	H.set_species(R.dna.species) // This needs to happen before anything else becuase it sets some variables.

	// Update the external organs
	for(var/part in active_br.limb_data)
		var/status = active_br.limb_data[part]
		if(status == null) continue //Species doesn't have limb? Child of amputated limb?

		var/obj/item/organ/external/O = H.organs_by_name[part]
		if(!O) continue //Not an organ. Perhaps another amputation removed it already.

		if(status == 1) //Normal limbs
			continue
		else if(status == 0) //Missing limbs
			O.remove_rejuv()
		else if(status) //Anything else is a manufacturer
			if(active_br.synthetic)
				O.robotize(status)
			else
				O.remove_rejuv()

	// Then the internal organs.  I think only O_EYES acutally counts, but lets do all just in case
	for(var/part in active_br.organ_data)
		var/status = active_br.organ_data[part]
		if(status == null) continue //Species doesn't have organ? Child of missing part?

		var/obj/item/organ/I = H.internal_organs_by_name[part]
		if(!I) continue//Not an organ. Perhaps external conversion changed it already?

		if(status == 0) //Normal organ
			continue
		else if(status == 1) //Assisted organ
			I.mechassist()
		else if(status == 2) //Mechanical organ
			I.robotize()
		else if(status == 3) //Digital organ
			I.digitize()

	// Apply DNA
	H.dna = R.dna.Clone()
	H.UpdateAppearance() // Update all appearance stuff from the DNA record
	// H.sync_dna_traits(FALSE) // Traitgenes edit - Sync traits to genetics if needed // Currently not implemented
	H.sync_organ_dna() // Do this because sprites depend on DNA-gender of organs (chest etc)
	H.resize(active_br.sizemult, FALSE)

	// Emissiive...
	if(H.ear_style)
		H.ear_style.em_block = FALSE
	if(H.tail_style)
		H.tail_style.em_block = FALSE
	if(H.wing_style)
		H.wing_style.em_block = FALSE

	for(var/key in R.flavor)
		H.flavor_texts[key]	= R.flavor[key]
	H.weight = active_br.weight
	// stupid dupe vars
	H.b_type = active_br.mydna.dna.b_type
	H.blood_color = active_br.mydna.dna.blood_color

	// And as for clothing...
	// We don't actually dress them! This is a medical machine, handle the nakedness DOCTOR!

	H.regenerate_icons()
	return 0 // Success!


// Disk for manually moving body records between the designer and sleever console etc.
/obj/item/disk/body_record
	name = "Body Design Disk"
	desc = "It has a small label: \n\
	\"Portable Body Record Storage Disk. \n\
	Insert into resleeving control console\""
	icon = 'icons/obj/discs_vr.dmi'
	icon_state = "data-green"
	item_state = "card-id"
	w_class = ITEMSIZE_SMALL
	var/datum/transhuman/body_record/stored = null

/*
 *	Diskette Box
 */

/obj/item/storage/box/body_record_disk
	name = "body record disk box"
	desc = "A box of body record disks, apparently."
	icon_state = "disk_kit"

/obj/item/storage/box/body_record_disk/New()
	..()
	for(var/i = 0 to 7)
		new /obj/item/disk/body_record(src)

#undef MENU_MAIN
#undef MENU_BODYRECORDS
#undef MENU_STOCKRECORDS
#undef MENU_SPECIFICRECORD
#undef MENU_OOCNOTES
