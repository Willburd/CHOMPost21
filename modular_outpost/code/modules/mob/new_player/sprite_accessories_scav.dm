/***********************************
	SOURCE REPO: https://github.com/ScavStation/ScavStation Credit to the yinglet station!
	Ported to work with polaris code by Willbird.
	Yinglets are (C) valsalia  ( https://www.valsalia.com/ )
	Related files:
	icons/mob/scav/tail.dmi
	icons/mob/scav/hair.dmi
	icons/mob/scav/markings.dmi
***********************************/

/datum/sprite_accessory/tail/yinglet_tail
	icon = 'modular_outpost/icons/mob/scav/tail.dmi'
	name = "Yinglet Tail"
	icon_state = "tail_yinglet_s"
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY

/datum/sprite_accessory/tail/yinglet_tail_female
	icon = 'modular_outpost/icons/mob/scav/tail.dmi'
	name = "Yinglet Tail Female"
	icon_state = "tail_yinglet_s"
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY
	extra_overlay = "tail_yinglet_female"

/datum/sprite_accessory/tail/yinglet_tail_male
	icon = 'modular_outpost/icons/mob/scav/tail.dmi'
	name = "Yinglet Tail Male"
	icon_state = "tail_yinglet_s"
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY
	extra_overlay = "tail_yinglet_hairymale"


/datum/sprite_accessory/marking/yinglet_longtooth
	icon = 'modular_outpost/icons/mob/scav/markings.dmi'
	name = "Yinglet Long Shelltooth"
	icon_state = "longtooth"
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY
	body_parts = list(BP_HEAD)

/datum/sprite_accessory/marking/yinglet_shelltooth
	icon = 'modular_outpost/icons/mob/scav/markings.dmi'
	name = "Yinglet Shelltooth"
	icon_state = "shelltooth"
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY
	body_parts = list(BP_HEAD)

/datum/sprite_accessory/ears/yinglet_short_ears
	icon = 'modular_outpost/icons/mob/scav/markings.dmi'
	name = "Yinglet Short Ears"
	icon_state = "shortears"
	desc = ""
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY

/datum/sprite_accessory/ears/yinglet_long_ears
	icon = 'modular_outpost/icons/mob/scav/markings.dmi'
	name = "Yinglet Long Ears"
	icon_state = "longears"
	desc = ""
	do_colouration = 1
	color_blend_mode = ICON_MULTIPLY


/datum/sprite_accessory/marking/yinglet_front_belly
	icon = 'modular_outpost/icons/mob/scav/markings.dmi'
	name = "Yinglet Belly Fluff"
	icon_state = "frontfluff"
	color_blend_mode = ICON_MULTIPLY
	body_parts = list(BP_TORSO)

/datum/sprite_accessory/marking/yinglet_front_chest
	icon = 'modular_outpost/icons/mob/scav/markings.dmi'
	name = "Yinglet Chest Fluff"
	icon_state = "torsofront"
	color_blend_mode = ICON_MULTIPLY
	body_parts = list(BP_TORSO)


/* Unported stuff, We already have things that match these. These were made for the yinglet species icon, and likely will not fit anyway.
// this doesnt function do to how the tail code works
// /decl/sprite_accessory/marking/yinglet/recolour_under_tail
//	name = "Tail Underfluff Colour"
//	icon_state = "underfluff"

/decl/sprite_accessory/hair/yinglet
	name = "Ying Messy"
	icon_state = "hair_messy"
	species_allowed = list(SPECIES_YINGLET)
	icon = 'icons/mob/scav/hair.dmi'
	blend = ICON_MULTIPLY

/decl/sprite_accessory/hair/yinglet/afro
	name = "Ying Afro"
	icon_state = "hair_afro"

/decl/sprite_accessory/hair/yinglet/familyman
	name = "Ying Family Man"
	icon_state = "hair_familyman"

/decl/sprite_accessory/hair/yinglet/spiky
	name = "Ying Spiky"
	icon_state = "hair_spiky"

/decl/sprite_accessory/hair/yinglet/ponytail
	name = "Ying Ponytail"
	icon_state = "hair_ponytail"
	flags = HAIR_TIEABLE

/decl/sprite_accessory/hair/yinglet/long
	name = "Ying Long Hair"
	icon_state = "hair_long"
	flags = HAIR_TIEABLE

/decl/sprite_accessory/hair/yinglet/longmessy
	name = "Ying Long Messy Hair"
	icon_state = "hair_longmessy"
	flags = HAIR_TIEABLE

/decl/sprite_accessory/hair/yinglet/updo
	name = "Ying Updo"
	icon_state = "hair_updo"
	flags = HAIR_TIEABLE

/decl/sprite_accessory/hair/yinglet/bald
	name = "Ying Bald"
	icon_state = "hair_bald"
	flags = VERY_SHORT | HAIR_BALD

/datum/category_item/underwear/bottom/yinglet_wraps
	name = "Yinglet Wraps"
	underwear_name = "wraps"
	icon_state = "ying_wraps"
	has_color = TRUE

/datum/category_item/underwear/top/yinglet_wraps
	name = "Yinglet Chestwrap"
	underwear_name = "chestwrap"
	icon_state = "ying_chestwrap"
	has_color = TRUE
*/
