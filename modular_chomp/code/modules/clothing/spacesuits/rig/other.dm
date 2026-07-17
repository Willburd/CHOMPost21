// Outpost 21 edit begin - Actual design
/obj/item/rig/ert/janitor
	name = "ERT-J suit control module"
	desc = "A suit worn by the janitorial division of an Emergency Response Team. Has purple highlights. Armoured and space ready."
	suit_type = "ERT janitor"
	icon = 'icons/obj/rig_modules_vr.dmi'
	icon_state = "ihs_rig"
	req_access = null

	initial_modules = list(
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/cleaner_launcher,
		)

/obj/item/rig/ert/assetprotection
	armor = list(melee = 80, bullet = 70, laser = 60, energy = 15, bomb = 80, bio = 100, rad = 60)
// Outpost 21 edit end
