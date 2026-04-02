#define DESTRUCTIVE_DEVICES list(/obj/machinery/rnd/destructive_analyzer, /obj/item/dogborg/sleeper)

/// Advanced
/datum/experiment/scanning/points/adv_mat_study_superconductive
	name = "Super-semiconductor Material Study"
	description = "Destructively analyze a raw super-semiconductor material to learn about it's electrical properties."
	required_points = 1
	allowed_experimentors = DESTRUCTIVE_DEVICES
	traits = EXPERIMENT_TRAIT_DESTRUCTIVE
	exp_tag = EXPERIMENT_TAG_PHYSICAL
	required_atoms = list(
		/obj/item/stack/material/mhydrogen = 1,
		/obj/item/slime_extract/yellow = 1
	)

/datum/experiment/scanning/points/adv_mat_study_superconductive/serialize_progress_stage(atom/target, list/seen_instances)
	return EXPERIMENT_PROG_INT("Destroy a metallic hydrogen sheet, or a yellow slime core.", \
		traits & EXPERIMENT_TRAIT_DESTRUCTIVE ? scanned[target] : seen_instances.len, required_atoms[target])


// Hypers
/datum/experiment/scanning/points/adv_mat_study_extradimensional
	name = "Exotic-Space Material Study"
	description = "Destructively analyze a material with an exotic dimension property to learn about it's structural composition."
	required_points = 1
	allowed_experimentors = DESTRUCTIVE_DEVICES
	traits = EXPERIMENT_TRAIT_DESTRUCTIVE
	exp_tag = EXPERIMENT_TAG_PHYSICAL
	required_atoms = list(
		/obj/item/stack/material/valhollide = 1,
		/obj/item/slime_extract/ruby = 1
	)

/datum/experiment/scanning/points/adv_mat_study_extradimensional/serialize_progress_stage(atom/target, list/seen_instances)
	return EXPERIMENT_PROG_INT("Destroy a valhollide gem or a ruby slime core.", \
		traits & EXPERIMENT_TRAIT_DESTRUCTIVE ? scanned[target] : seen_instances.len, required_atoms[target])

// Omniparts
/datum/experiment/scanning/points/precursor_components_study
	name = "Precursor Components Study"
	description = "Destructively analyze precursor machine parts and exotic-space materials to uncover their secrets."
	required_points = 2
	allowed_experimentors = DESTRUCTIVE_DEVICES
	traits = EXPERIMENT_TRAIT_DESTRUCTIVE
	exp_tag = EXPERIMENT_TAG_PHYSICAL
	required_atoms = list(
		/obj/item/stock_parts/capacitor/omni = 1,
		/obj/item/stock_parts/scanning_module/omni = 1,
		/obj/item/stock_parts/manipulator/omni = 1,
		/obj/item/stock_parts/micro_laser/omni = 1,
		/obj/item/stock_parts/matter_bin/omni = 1,
		/obj/item/stack/material/supermatter = 1,
		/obj/item/prop/deconstructable/gigacell = 2
	)

// Bluespace tech
/datum/experiment/scanning/points/bluespace_containing_items
	name = "Bluespace Pocket Folding"
	description = "Some objects naturally contain pockets of unstable folded bluespace. Destructively analyze these rare naturally created objects to understand their properties."
	required_points = 2
	allowed_experimentors = DESTRUCTIVE_DEVICES
	traits = EXPERIMENT_TRAIT_DESTRUCTIVE
	exp_tag = EXPERIMENT_TAG_PHYSICAL
	required_atoms = list(
		/obj/item/reagent_containers/food/snacks/grown = 1,
		/obj/item/slime_extract/bluespace = 1,
		/obj/item/anobattery = 1,
		/obj/item/assembly/signaler/anomaly/bluespace = 1,
		/obj/item/organ/internal/malignant/tumor/bluespace = 1,
	)

/datum/experiment/scanning/points/bluespace_containing_items/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	if(istype(target, /obj/item/reagent_containers/food/snacks/grown))
		var/obj/item/reagent_containers/food/snacks/grown/to_check = target
		if(!to_check.seed?.get_trait(TRAIT_TELEPORTING))
			return FALSE
	if(istype(target, /obj/item/anobattery))
		var/obj/item/anobattery/to_check = target
		if(to_check.battery_effect?.effect_type != EFFECT_TELEPORT)
			return FALSE
	return TRUE

#undef DESTRUCTIVE_DEVICES
