/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 */

/*
 * First Aid Kits
 */

/obj/item/storage/firstaid/vox
	name = "vox-safe medical kit"
	desc = "Contains medical treatments that are safe for vox crewmembers."
	icon = 'modular_outpost/icons/obj/storage.dmi'
	item_icons = list(slot_l_hand_str = 'modular_outpost/icons/mob/items/lefthand_storage.dmi', slot_r_hand_str = 'modular_outpost/icons/mob/items/righthand_storage.dmi')
	icon_state = "voxkit"
	item_state_slots = list(slot_r_hand_str = "firstaid-vox", slot_l_hand_str = "firstaid-vox")
	starts_with = list(
		/obj/item/reagent_containers/syringe/voxkit,
		/obj/item/reagent_containers/hypospray/autoinjector/hemocyanin,
		/obj/item/reagent_containers/hypospray/autoinjector/hemocyanin,
		/obj/item/reagent_containers/hypospray/autoinjector/biginjector/clotting,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/healthanalyzer
	)

/obj/item/storage/pill_bottle/paroxetine
	name = "pill bottle (Paroxetine)"
	desc = "Stabilizes the mind greatly, but has a chance of adverse effects. Medicate cautiously."
	starts_with = list(/obj/item/reagent_containers/pill/paroxetine = 14)
	wrapper_color = COLOR_PURPLE

/obj/item/storage/pill_bottle/lithium
	name = "pill bottle (Lithium)"
	desc = "Used in the treatment of schizophrenia, Alzheimer's disease, and dementia. Medicate cautiously."
	starts_with = list(/obj/item/reagent_containers/pill/lithium = 14)
	wrapper_color = COLOR_BABY_BLUE

/obj/item/reagent_containers/syringe/voxkit
	name = "Syringe (phoron stim)"
	desc = "\[WARNING\] Contains raw phoron. Intended only for vox crewmembers."

/obj/item/reagent_containers/syringe/voxkit/Initialize()
	. = ..()
	reagents.add_reagent("phoron", 15)
	//mode = SYRINGE_INJECT //VOREStation Edit - Starts capped
	//update_icon()
