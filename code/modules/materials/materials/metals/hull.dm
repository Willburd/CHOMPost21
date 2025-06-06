/datum/material/steel/hull
	name = MAT_STEELHULL
	stack_type = /obj/item/stack/material/steel/hull
	integrity = 250
	explosion_resistance = 10
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	icon_colour = "#666677"
	flags = MATERIAL_UNMELTABLE | MATERIAL_NO_SYNTH
	composite_material = list(MAT_STEEL = SHEET_MATERIAL_AMOUNT)
	supply_conversion_value = 0.25 // Outpost 21 edit - Added supply sell price. This was missing...

/datum/material/steel/hull/place_sheet(var/turf/target) //Deconstructed into normal steel sheets.
	new /obj/item/stack/material/steel(target)

/datum/material/plasteel/hull
	name = MAT_PLASTEELHULL
	stack_type = /obj/item/stack/material/plasteel/hull
	integrity = 600
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	icon_colour = "#777788"
	explosion_resistance = 40
	flags = MATERIAL_UNMELTABLE | MATERIAL_NO_SYNTH
	composite_material = list(MAT_PLASTEEL = SHEET_MATERIAL_AMOUNT)

/datum/material/plasteel/hull/place_sheet(var/turf/target) //Deconstructed into normal plasteel sheets.
	new /obj/item/stack/material/plasteel(target)

/datum/material/durasteel/hull //The 'Hardball' of starship hulls.
	name = MAT_DURASTEELHULL
	stack_type = /obj/item/stack/material/durasteel/hull
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	icon_colour = "#45829a"
	explosion_resistance = 90
	reflectivity = 0.9
	flags = MATERIAL_UNMELTABLE | MATERIAL_NO_SYNTH
	composite_material = list(MAT_DURASTEEL = SHEET_MATERIAL_AMOUNT)

/datum/material/durasteel/hull/place_sheet(var/turf/target) //Deconstructed into normal durasteel sheets.
	new /obj/item/stack/material/durasteel(target)

/datum/material/titanium/hull
	name = MAT_TITANIUMHULL
	stack_type = /obj/item/stack/material/titanium/hull
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	flags = MATERIAL_UNMELTABLE | MATERIAL_NO_SYNTH
	composite_material = list(MAT_TITANIUM = SHEET_MATERIAL_AMOUNT)

/datum/material/titanium/hull/place_sheet(var/turf/target) //Deconstructed into normal titanium sheets.
	new /obj/item/stack/material/titanium(target)

/datum/material/morphium/hull
	name = MAT_MORPHIUMHULL
	stack_type = /obj/item/stack/material/morphium/hull
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	flags = MATERIAL_UNMELTABLE | MATERIAL_NO_SYNTH
	composite_material = list(MAT_MORPHIUM = SHEET_MATERIAL_AMOUNT)

/datum/material/morphium/hull/place_sheet(var/turf/target)
	new /obj/item/stack/material/morphium(target)

/datum/material/plastitanium/hull
	name = MAT_PLASTITANIUMHULL
	stack_type = /obj/item/stack/material/plastitanium/hull
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	icon_colour = "#585658"
	explosion_resistance = 50
	flags = MATERIAL_NO_SYNTH
	composite_material = list(MAT_PLASTITANIUM = SHEET_MATERIAL_AMOUNT)

/datum/material/plastitanium/hull/place_sheet(var/turf/target) //Deconstructed into normal plasteel sheets.
	new /obj/item/stack/material/plastitanium(target)

/datum/material/gold/hull
	name = MAT_GOLDHULL
	stack_type = /obj/item/stack/material/gold/hull
	icon_base = "hull"
	table_icon_base = "stone"
	icon_reinf = "reinf_mesh"
	explosion_resistance = 50
	flags = MATERIAL_NO_SYNTH
	composite_material = list(MAT_GOLD = SHEET_MATERIAL_AMOUNT)

/datum/material/gold/hull/place_sheet(var/turf/target) //Deconstructed into normal gold sheets.
	new /obj/item/stack/material/gold(target)
