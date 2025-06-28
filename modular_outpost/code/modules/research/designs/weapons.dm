/datum/design/item/weapon/gun/launcher/confetti_cannon/pie
	name = "pie cannon"
	desc = "Stuff it with pie and shoot! You'll be a hit at every party."
	id = "pie_cannon"
	req_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	materials = list(MAT_STEEL = 3000, MAT_GLASS = 3000)
	build_path = /obj/item/gun/launcher/confetti_cannon/pie
	sort_string = "MAAVDE"
	department = LATHE_ALL | LATHE_SERVICE

/datum/design/item/weapon/grenade/dephasing
	name = "Dephasing Grenade"
	desc = "Causes localized instability in bluespace, dephasing things into real space if they are near enough to it."
	id = "grenade_phase"
	req_tech = list(TECH_BLUESPACE = 5, TECH_COMBAT = 3)
	materials = list(MAT_STEEL = 1000)
	build_path = /obj/item/grenade/dephasing
	sort_string = "MAABEE"
	department = LATHE_SECURITY
