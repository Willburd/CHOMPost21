// Export power by PTL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/engineering/export_power
	name = "Export PTL Power"

/datum/goal/engineering/export_power/New()
	. = ..()
	goal_count = rand(15,35)
	goal_text = "Export [goal_count]GW of power via the power transmission laser."
	goal_count = goal_count GIGAWATTS

/datum/goal/engineering/export_power/check_completion(has_completed)
	current_count = SSsupply.watts_sold
	. = ..()


// Heal Terraformer
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/cargo/heal_terraformer_export_chems
	name = "Refine Chemicals For Terraformer"
	enabled = FALSE // Admin starts this as it is an event
	var/chosen_reagent = null

/datum/goal/cargo/heal_terraformer_export_chems/New()
	. = ..()
	goal_count = rand(8,15) * CARGOTANKER_VOLUME
	chosen_reagent = pick(list(
							REAGENT_ID_BICARIDINE,
							REAGENT_ID_DERMALINE,
							REAGENT_ID_TRICORDRAZINE,
							REAGENT_ID_SPACEACILLIN
							))
	var/datum/reagent/chem = SSchemistry.chemical_reagents[chosen_reagent]
	goal_text = "Export [goal_count]u of [chem.name]."

/datum/goal/cargo/heal_terraformer_export_chems/handle_cargo_sale(datum/source, atom/movable/sold_item, sold_successfully, datum/exported_crate/export_data, area/shuttle_subarea)
	if(!sold_successfully)
		return
	if(!istype(sold_item,/obj/vehicle/train/trolley_tank))
		return
	current_count += sold_item.reagents.get_reagent_amount(chosen_reagent)
