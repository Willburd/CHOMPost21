/datum/goal/cargo
	category = GOAL_CARGO

/datum/goal/cargo/New()
	. = ..()
	RegisterSignal(SSdcs,COMSIG_GLOB_SUPPLY_SHUTTLE_SELL_ITEM,PROC_REF(handle_cargo_sale))

/datum/goal/cargo/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_SUPPLY_SHUTTLE_SELL_ITEM)
	. = ..()

/datum/goal/cargo/proc/handle_cargo_sale(datum/source, atom/movable/sold_item, sold_successfully, datum/exported_crate/export_data, area/shuttle_subarea)
	SIGNAL_HANDLER
	return


// Sell sheets
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/cargo/sell_sheets
	name = "Sell Refined Materials"
	goal_text = null
	var/mat_to_sell = MAT_STEEL
	var/sheet_required = 0
	var/sheets_sold = 0

/datum/goal/cargo/sell_sheets/New()
	. = ..()

	// Decide the sheet to sell
	mat_to_sell = pick(list(
						MAT_STEEL,
						MAT_BRONZE,
						MAT_COPPER,
						MAT_DIAMOND,
						MAT_GOLD,
						MAT_LEAD,
						MAT_IRON,
						MAT_PLATINUM,
						MAT_PHORON,
						MAT_DURASTEEL,
						MAT_PLASTEEL,
						MAT_MORPHIUM,
						MAT_METALHYDROGEN,
						MAT_VALHOLLIDE,
						MAT_SUPERMATTER
						))
	switch(mat_to_sell)
		if(MAT_SUPERMATTER, MAT_VALHOLLIDE, MAT_METALHYDROGEN, MAT_MORPHIUM)
			sheet_required = rand(25,50)
		else
			sheet_required = rand(150,300)

	var/datum/material/mat_datum = get_material_by_name(mat_to_sell)
	goal_text = "Export a total of [sheet_required] [mat_datum.name] [mat_datum.sheet_plural_name]."

/datum/goal/cargo/sell_sheets/check_completion(has_completed)
	. = ..(sheets_sold >= sheet_required)

/datum/goal/cargo/sell_sheets/handle_cargo_sale(datum/source, atom/movable/sold_item, sold_successfully, datum/exported_crate/export_data, area/shuttle_subarea)
	if(!sold_successfully)
		return
	if(!istype(sold_item,/obj/structure/closet/crate))
		return
	for(var/obj/item/stack/material/sheet_stack in sold_item)
		if(sheet_stack.name != mat_to_sell)
			continue
		sheets_sold += sheet_stack.amount


// Sell chemicals
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/cargo/sell_chemicals
	name = "Export Chemical Tanks"
	goal_text = null
	var/chosen_reagent = null

/datum/goal/cargo/sell_chemicals/New()
	. = ..()
	goal_count = rand(10,15)
	chosen_reagent = pick(list(
							REAGENT_ID_BICARIDINE,
							REAGENT_ID_ANTITOXIN,
							REAGENT_ID_KELOTANE,
							REAGENT_ID_DERMALINE,
							REAGENT_ID_TRICORDRAZINE,
							REAGENT_ID_ADRANOL,
							REAGENT_ID_INAPROVALINE,
							REAGENT_ID_DEXALIN,
							REAGENT_ID_TRAMADOL,
							REAGENT_ID_ALKYSINE,
							REAGENT_ID_IMIDAZOLINE,
							REAGENT_ID_SPACEACILLIN,
							REAGENT_ID_CARTHATOLINE,
							REAGENT_ID_HYRONALIN,
							REAGENT_ID_RYETALYN,
							REAGENT_ID_PERIDAXON,
							REAGENT_ID_LUBE,
							REAGENT_ID_CLEANER,
							REAGENT_ID_PAINT,
							REAGENT_ID_SACID,
							REAGENT_ID_PACID
							))
	var/datum/reagent/chem = SSchemistry.chemical_reagents[chosen_reagent]
	goal_text = "Export [goal_count * CARGOTANKER_VOLUME]u of [chem.name]."

/datum/goal/cargo/sell_chemicals/check_completion(has_completed)
	. = ..(current_count >= goal_count * CARGOTANKER_VOLUME)

/datum/goal/cargo/sell_chemicals/handle_cargo_sale(datum/source, atom/movable/sold_item, sold_successfully, datum/exported_crate/export_data, area/shuttle_subarea)
	if(!sold_successfully)
		return
	if(!istype(sold_item,/obj/vehicle/train/trolley_tank))
		return
	current_count += sold_item.reagents.get_reagent_amount(chosen_reagent)


// Drill Rock
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/cargo/mine_rock
	name = "Mining Productivity"
	goal_text = null

/datum/goal/cargo/mine_rock/New()
	goal_count = rand(1500,2500)
	goal_text = "Drill through at least [goal_count] rock walls, keeping our miners in shape!"

/datum/goal/cargo/mine_rock/check_completion(has_completed)
	current_count = GLOB.rocks_drilled_roundstat
	. = ..(current_count >= goal_count)
