#define INVENTORY_POUCH_SPACE ITEMSIZE_COST_SMALL*4 // Gotta copy this from \\code\game\objects\items\weapons\storage\pouches.dm because of fuck
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

/obj/item/storage/pouch/ifak
	name = "Individual First Aid Kit"
	desc = "Remember: this is YOURS, for when YOU get hit."
	icon = 'modular_outpost/icons/obj/storage.dmi'
	icon_state = "medical_ifak"
	max_storage_space = INVENTORY_POUCH_SPACE*2 //Just to make sure it can hold everything, and give it a nice niche.
	starts_with = list(
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/ointment,
		/obj/item/reagent_containers/hypospray/autoinjector/biginjector/clotting,
		/obj/item/stack/medical/splint,
		/obj/item/storage/pill_bottle/assorted
	)
	can_hold = list(
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/storage/quickdraw/syringe_case,
		/obj/item/storage/pill_bottle,
		/obj/item/reagent_containers/hypospray/,
		/obj/item/stack/medical,
		/obj/item/stack/medical/splint,
		/obj/item/stack/nanopaste,
		/obj/item/clothing/mask/chewable/candy/lolli,

	) //much more limited than the medical case
	remove_delay = 0 //Very fast access for your 'uh oh' moments.



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

/obj/item/storage/pill_bottle/tercozolam
	name = "pill bottle (Tercozolam)"
	desc = "Used in the treatment of schizophrenia, and periodic delerium."
	starts_with = list(/obj/item/reagent_containers/pill/tercozolam = 14)
	wrapper_color = COLOR_GREEN_GRAY

/obj/item/reagent_containers/syringe/voxkit
	name = "Syringe (phoron stim)"
	desc = "\[WARNING\] Contains raw phoron. Intended only for vox crewmembers."

/obj/item/reagent_containers/syringe/voxkit/Initialize(mapload)
	. = ..()
	reagents.add_reagent("phoron", 15)
	//mode = SYRINGE_INJECT //VOREStation Edit - Starts capped
	//update_icon()


#undef INVENTORY_POUCH_SPACE //Then we banish the heathenous shitcode
