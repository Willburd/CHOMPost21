/obj/item/storage/box/bloodpacks
	name = "blood packs bags"
	desc = "This box contains blood packs."
	icon_state = "sterile"

/obj/item/storage/box/bloodpacks/Initialize(mapload)
	. = ..()
	new /obj/item/reagent_containers/blood/empty(src)
	new /obj/item/reagent_containers/blood/empty(src)
	new /obj/item/reagent_containers/blood/empty(src)
	new /obj/item/reagent_containers/blood/empty(src)
	new /obj/item/reagent_containers/blood/empty(src)
	new /obj/item/reagent_containers/blood/empty(src)
	new /obj/item/reagent_containers/blood/empty(src)

// Outpost 21 edit begin - Actual blood packs
/obj/item/storage/box/bloodpacks_full
	name = "blood bags"
	desc = "This box contains loaded blood packs."
	icon_state = "sterile"

/obj/item/storage/box/bloodpacks_full/Initialize(mapload)
	. = ..()
	new /obj/item/reagent_containers/blood/APlus(src)
	new /obj/item/reagent_containers/blood/AMinus(src)
	new /obj/item/reagent_containers/blood/BPlus(src)
	new /obj/item/reagent_containers/blood/BMinus(src)
	new /obj/item/reagent_containers/blood/OPlus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/synthblood(src)
// Outpost 21 edit end

/obj/item/reagent_containers/blood
	name = "IV pack"
	var/base_name = " "
	desc = "Holds liquids used for transfusion."
	var/base_desc = " "
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "empty"
	item_state = "bloodpack_empty"
	drop_sound = 'sound/items/drop/food.ogg'
	pickup_sound = 'sound/items/pickup/food.ogg'
	volume = 200
	var/label_text = ""

	var/blood_type = null
	var/reag_id = REAGENT_ID_BLOOD

/obj/item/reagent_containers/blood/Initialize(mapload)
	. = ..()
	base_name = name
	base_desc = desc
	if(blood_type != null)
		label_text = "[blood_type]"
		update_iv_label()
		reagents.add_reagent(reag_id, 200, list("donor"=null,"viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null,"changeling"=FALSE)) // Outpost 21 edit - changling blood effects
		update_icon()

/obj/item/reagent_containers/blood/on_reagent_change()
	update_icon()

/obj/item/reagent_containers/blood/update_icon()
	var/percent = round((reagents.total_volume / volume) * 100)
	if(percent >= 0 && percent <= 9)
		icon_state = "empty"
		item_state = "bloodpack_empty"
	else if(percent >= 10 && percent <= 50)
		icon_state = "half"
		item_state = "bloodpack_half"
	else if(percent >= 51 && percent < INFINITY)
		icon_state = "full"
		item_state = "bloodpack_full"

/obj/item/reagent_containers/blood/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/pen) || istype(W, /obj/item/flashlight/pen))
		var/tmp_label = sanitizeSafe(tgui_input_text(user, "Enter a label for [name]", "Label", label_text, MAX_NAME_LEN), MAX_NAME_LEN)
		if(length(tmp_label) > 50)
			to_chat(user, span_notice("The label can be at most 50 characters long."))
		else if(length(tmp_label) > 10)
			to_chat(user, span_notice("You set the label."))
			label_text = tmp_label
			update_iv_label()
		else
			to_chat(user, span_notice("You set the label to \"[tmp_label]\"."))
			label_text = tmp_label
			update_iv_label()

/obj/item/reagent_containers/blood/proc/update_iv_label()
	if(label_text == "")
		name = base_name
	else if(length(label_text) > 10)
		var/short_label_text = copytext(label_text, 1, 11)
		name = "[base_name] ([short_label_text]...)"
	else
		name = "[base_name] ([label_text])"
	desc = "[base_desc] It is labeled \"[label_text]\"."

/obj/item/reagent_containers/blood/APlus
	blood_type = "A+"

/obj/item/reagent_containers/blood/AMinus
	blood_type = "A-"

/obj/item/reagent_containers/blood/BPlus
	blood_type = "B+"

/obj/item/reagent_containers/blood/BMinus
	blood_type = "B-"

/obj/item/reagent_containers/blood/OPlus
	blood_type = "O+"

/obj/item/reagent_containers/blood/OMinus
	blood_type = "O-"

/obj/item/reagent_containers/blood/synthplas
	blood_type = "O-"
	reag_id = REAGENT_ID_SYNTHBLOOD_DILUTE

/obj/item/reagent_containers/blood/synthblood
	blood_type = "O-"
	reag_id = REAGENT_ID_SYNTHBLOOD

/obj/item/reagent_containers/blood/empty
	name = "Empty BloodPack"
	desc = "Seems pretty useless... Maybe if there were a way to fill it?"
	icon_state = "empty"
	item_state = "bloodpack_empty"

/obj/item/reagent_containers/blood/random_bloodsucker
	name = "Ration BloodPack"
	desc = "A standard issue BloodPack Ration given to crew that require blood to be sustained!"

/obj/item/reagent_containers/blood/random_bloodsucker/Initialize(mapload)
	blood_type = pick("A+", "A-", "B+", "B-", "O-", "O+", "AB+", "AB-")
	. = ..()
