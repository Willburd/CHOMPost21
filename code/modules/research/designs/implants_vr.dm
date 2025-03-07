/* Outpost 21 edit - Backup implants removed
/datum/design/item/implant/backup
	name = "Backup implant"
	id = "implant_backup"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 2, TECH_DATA = 4, TECH_ENGINEERING = 2, TECH_ILLEGAL = 5) // Outpost 21 edit - This is illegal
	materials = list(MAT_STEEL = 2000, MAT_GLASS = 2000)
	build_path = /obj/item/implantcase/backup
	sort_string = "MFAVA"
	department = LATHE_ALL | LATHE_MEDICAL // CHOMPAdd
*/

/datum/design/item/implant/sizecontrol
	name = "Size control implant"
	id = "implant_size"
	req_tech = list(TECH_MATERIAL = 3, TECH_BIO = 4, TECH_DATA = 4, TECH_ENGINEERING = 3)
	materials = list(MAT_STEEL = 4000, MAT_GLASS = 4000)
	build_path = /obj/item/implanter/sizecontrol
	sort_string = "MFAVB"
	department = LATHE_ALL | LATHE_MEDICAL | LATHE_PUBLIC // CHOMPAdd
