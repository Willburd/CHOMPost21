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
	var/datum/tgui_module/appearance_changer/body_designer/designer_gui
	var/obj/item/disk/body_record/disk = null
	var/selected_record = FALSE

	// Resleeving database this machine interacts with. Blank for default database
	// Needs a matching /datum/transcore_db with key defined in code
	var/db_key
	var/datum/transcore_db/our_db // These persist all round and are never destroyed, just keep a hard ref

/obj/machinery/computer/transhuman/designer/Initialize()
	. = ..()
	our_db = SStranscore.db_by_key(db_key)
	designer_gui = new(src, make_fake_owner())
	designer_gui.linked_body_design_console = WEAKREF(src)

/obj/machinery/computer/transhuman/designer/Destroy()
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
	designer_gui.tgui_interact(user)

/obj/machinery/computer/transhuman/designer/attack_hand(mob/user as mob)
	add_fingerprint(user)
	if(inoperable())
		return
	designer_gui.tgui_interact(user)

/obj/machinery/computer/transhuman/designer/proc/make_fake_owner()
	// checks for monkey to tell if on the menu
	var/mob/living/carbon/human/H = new(get_turf(src))
	H.set_species(SPECIES_MONKEY)
	H.species.produceCopy(H.species.traits.Copy(),H,null,FALSE)
	return H

/obj/machinery/computer/transhuman/designer/proc/create_body(var/datum/transhuman/body_record/current_project)
	//Get the DNA and generate a new mob
	var/datum/dna2/record/R = current_project.mydna
	var/mob/living/carbon/human/H = new /mob/living/carbon/human(src, R.dna.species)
	//Fix the external organs
	for(var/part in current_project.limb_data)
		var/status = current_project.limb_data[part]
		if(status == null) continue //Species doesn't have limb? Child of amputated limb?
		var/obj/item/organ/external/O = H.organs_by_name[part]
		if(!O) continue //Not an organ. Perhaps another amputation removed it already.
		if(status == 1) //Normal limbs
			continue
		else if(status == 0) //Missing limbs
			O.remove_rejuv()
		else if(status) //Anything else is a manufacturer
			O.remove_rejuv() //Don't robotize them, leave them removed so robotics can attach a part.
	for(var/part in current_project.organ_data)
		var/status = current_project.organ_data[part]
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
	//Set the name or generate one
	H.real_name = R.dna.real_name
	//Apply DNA
	H.dna = R.dna.Clone()
	H.original_player = current_project.ckey
	//Apply legs
	H.digitigrade = R.dna.digitigrade // ensure clone mob has digitigrade var set appropriately
	if(H.dna.digitigrade <> R.dna.digitigrade)
		H.dna.digitigrade = R.dna.digitigrade // ensure cloned DNA is set appropriately from record??? for some reason it doesn't get set right despite the override to datum/dna/Clone()
	//Update appearance, remake icons
	H.UpdateAppearance()
	H.sync_dna_traits(FALSE) // Traitgenes edit - Sync traits to genetics if needed
	H.sync_organ_dna()
	H.regenerate_icons()
	// Traitgenes edit begin - Moved breathing equipment to AFTER the genes set it
	H.flavor_texts = current_project.mydna.flavor.Copy()
	H.resize(current_project.sizemult, FALSE)
	H.appearance_flags = current_project.aflags
	H.weight = current_project.weight
	if(current_project.speciesname)
		H.custom_species = current_project.speciesname
	return H

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
