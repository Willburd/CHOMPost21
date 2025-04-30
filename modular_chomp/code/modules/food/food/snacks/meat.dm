/obj/item/reagent_containers/food/snacks/deathclawmeat
	name = "Death claw Meat"
	desc = "A slice from a deathclaw"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 6, REAGENT_ID_DEATHBLOOD = 6)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/deathclawmeat/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 6)
	reagents.add_reagent(REAGENT_ID_RADIUM, 6) // REAGENT_ID_DEATHBLOOD // Outpost 21 edit - Removing badly designed chems

/obj/item/reagent_containers/food/snacks/dragonmeat
	name = "Dragon Meat"
	desc = "A slice from a mighty dragon"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 6, REAGENT_ID_LIQUIDFIRE = 6)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/dragonmeat/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 6)
	//reagents.add_reagent(REAGENT_ID_LIQUIDFIRE, 6) // Outpost 21 edit - Removing badly designed chems

/obj/item/reagent_containers/food/snacks/phorondragonmeat
	name = "Phoron Dragon Meat"
	desc = "A slice from a mighty dragon"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 6, REAGENT_ID_NEOLIQUIDFIRE = 6, REAGENT_ID_PHORON = 3)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/phorondragonmeat/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 6)
	// reagents.add_reagent(REAGENT_ID_NEOLIQUIDFIRE, 6) // Outpost 21 edit - Removing badly designed chems
	reagents.add_reagent(REAGENT_ID_PHORON, 3)

/obj/item/reagent_containers/food/snacks/metroidmeat
	name = "Metroid Slice"
	desc = "A slice from a metroid"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_LIQUIDLIFE = 3)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/metroidmeat/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 3)
	// reagents.add_reagent(REAGENT_ID_LIQUIDLIFE, 3) // Outpost 21 edit - Removing badly designed chems

/obj/item/reagent_containers/food/snacks/meat/raymeat
	name = "Solar Ray Meat"
	desc = "You aren't sure how ediable this is"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_CAPSAICIN = 8, REAGENT_ID_CONDENSEDCAPSAICIN = 8)


/obj/item/reagent_containers/food/snacks/meat/eelmeat
	name = "Eel Meat"
	desc = "A slice from an eel"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_SHOCKCHEM = 1)


/obj/item/reagent_containers/food/snacks/meat/gravityshell
	name = "Gravity Shell Meat"
	desc = "A slice from a gravity shell"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 24)


//ant meats
/obj/item/reagent_containers/food/snacks/copperant
	name = "Bronze Ant Slice"
	desc = "A slice from a ant"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_SHOCKCHEM = 3)
	bitesize = 1

/obj/item/reagent_containers/food/snacks/copperant/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 3)
	reagents.add_reagent(REAGENT_ID_SHOCKCHEM, 3)

/obj/item/reagent_containers/food/snacks/painiteant
	name = "Painite Ant Slice"
	desc = "A slice from a ant"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_DERMALINE = 3) // REAGENT_ID_NEOLIQUIDFIRE Outpost 21 edit - Removing badly designed chems
	bitesize = 1

/obj/item/reagent_containers/food/snacks/painiteant/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 3)
	reagents.add_reagent(REAGENT_ID_DERMALINE,  3) // REAGENT_ID_NEOLIQUIDFIRE Outpost 21 edit - Removing badly designed chems


/obj/item/reagent_containers/food/snacks/bronzeant
	name = "Bronze Ant Slice"
	desc = "A slice from a ant"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_KELOTANE = 3) // REAGENT_ID_LIQUIDFIRE Outpost 21 edit - Removing badly designed chems
	bitesize = 1

/obj/item/reagent_containers/food/snacks/bronzeant/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 3)
	reagents.add_reagent(REAGENT_ID_KELOTANE, 3) // REAGENT_ID_LIQUIDFIRE Outpost 21 edit - Removing badly designed chems

/obj/item/reagent_containers/food/snacks/quartzant
	name = "Bronze Ant Slice"
	desc = "A slice from a ant"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_TOXIN = 3) // REAGENT_ID_DEATHBLOOD Outpost 21 edit - Removing badly designed chems
	bitesize = 1

/obj/item/reagent_containers/food/snacks/quartzant/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 3)
	reagents.add_reagent(REAGENT_ID_TOXIN, 3) // REAGENT_ID_DEATHBLOOD Outpost 21 edit - Removing badly designed chems

/obj/item/reagent_containers/food/snacks/agateant
	name = "Bronze Ant Slice"
	desc = "A slice from a ant"
	icon_state = "meat"
	center_of_mass_x = 17 //CHOMPEdit
	center_of_mass_y= 16 //CHOMPEdit
	nutriment_amt = 3
	nutriment_desc = list(REAGENT_ID_PROTEIN = 3, REAGENT_ID_TRICORDRAZINE = 3) // REAGENT_ID_LIQUIDLIFE Outpost 21 edit - Removing badly designed chems
	bitesize = 1

/obj/item/reagent_containers/food/snacks/agateant/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 3)
	reagents.add_reagent(REAGENT_ID_TRICORDRAZINE, 3) // REAGENT_ID_LIQUIDLIFE Outpost 21 edit - Removing badly designed chems
