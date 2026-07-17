
/datum/supply_pack/med/bloodpack
	contains = list(/obj/item/storage/box/bloodpacks_full = 3) // Actual blood packs

/datum/supply_pack/med/bloodpack_empty
	name = "Empty BloodPack crate"
	desc = "Three boxes of empty bloodbags."
	contains = list(/obj/item/storage/box/bloodpacks = 3)
	cost = 10
	containertype = /obj/structure/closet/crate/medical/blood
	containername = "BloodPack crate"

/datum/supply_pack/med/iv_medpacks
	name = "Medication IV Bags crate"
	desc = "Three boxes of IV medication bags."
	contains = list(/obj/item/storage/box/iv_medpacks = 3)
	cost = 10
	containertype = /obj/structure/closet/crate/medical/blood
	containername = "Medication IV Bags crate"
