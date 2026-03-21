
/datum/category_item/autolathe/arms
	var/lethal = TRUE // assume it

// Missing 5.56 ammos
/datum/category_item/autolathe/arms/m16_556
	name = "M16 magazine (5.56x45mm standard)"
	path = /obj/item/ammo_magazine/m16
	hidden = 1

/datum/category_item/autolathe/arms/m16_556_ap
	name = "M16 magazine (5.56x45mm armor-piercing)"
	path = /obj/item/ammo_magazine/m16/ap
	hidden = 1

/datum/category_item/autolathe/arms/m16_556_hp
	name = "M16 magazine (5.56x45mm hollow-point)"
	path = /obj/item/ammo_magazine/m16/hp
	hidden = 1

/datum/category_item/autolathe/arms/m16_556_rubber
	name = "M16 magazine (5.56x45mm less-lethal)"
	path = /obj/item/ammo_magazine/m16/rubber
	lethal = FALSE

/datum/category_item/autolathe/arms/mauser_792
	name = "drum mag (7.92x57mm Mauser)"
	path = /obj/item/ammo_magazine/mg42
	hidden = 1

////////////////////////////////////////////////////////////////////////////////////
// Overrides
////////////////////////////////////////////////////////////////////////////////////
/datum/category_item/autolathe/arms/shotgun_blanks
	lethal = FALSE

/datum/category_item/autolathe/arms/shotgun_beanbag
	lethal = FALSE

/datum/category_item/autolathe/arms/shotgun_flash
	lethal = FALSE

/datum/category_item/autolathe/arms/shotgun_clip_beanbag
	lethal = FALSE

/datum/category_item/autolathe/arms/foamdart
	lethal = FALSE

/datum/category_item/autolathe/arms/foambox
	lethal = FALSE

/datum/category_item/autolathe/arms/speedloader_38r
	lethal = FALSE

/datum/category_item/autolathe/arms/speedloader_45r
	lethal = FALSE

/datum/category_item/autolathe/arms/b10mm/practice
	lethal = FALSE

/datum/category_item/autolathe/arms/b10mm/rubber
	lethal = FALSE

/datum/category_item/autolathe/arms/b44/rubber
	lethal = FALSE

/datum/category_item/autolathe/arms/b45/practice
	lethal = FALSE

/datum/category_item/autolathe/arms/b45/rubber
	lethal = FALSE

/datum/category_item/autolathe/arms/b545/practice
	lethal = FALSE

/datum/category_item/autolathe/arms/b545/large/practice
	lethal = FALSE

/datum/category_item/autolathe/arms/b9mm/practice
	lethal = FALSE

/datum/category_item/autolathe/arms/b9mm/rubber
	lethal = FALSE

/datum/category_item/autolathe/arms/shotgun_drum_empty
	lethal = FALSE

/datum/category_item/autolathe/arms/pistol_45p
	lethal = FALSE

/datum/category_item/autolathe/arms/pistol_45r
	lethal = FALSE

/datum/category_item/autolathe/arms/pistol_45f
	lethal = FALSE

/datum/category_item/autolathe/arms/pistol_9mmr
	lethal = FALSE

/datum/category_item/autolathe/arms/pistol_9mmp
	lethal = FALSE

/datum/category_item/autolathe/arms/pistol_9mmf
	lethal = FALSE

/datum/category_item/autolathe/arms/smg_9mmr
	lethal = FALSE

/datum/category_item/autolathe/arms/smg_9mmp
	lethal = FALSE

/datum/category_item/autolathe/arms/smg_9mmf
	lethal = FALSE

/datum/category_item/autolathe/arms/rifle_545p
	lethal = FALSE
