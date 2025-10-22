/obj/structure/fence/eshui_sign
	name = "ESHUI Secure Facility"
	desc = "WARNING, restricted area. It is unlawful to enter this area without the permission of the installation commander. No trespassing beyond this point. This perimeter is patrolled by drones. Use of deadly force is authorized."
	icon = 'modular_outpost/icons/obj/fence.dmi'
	icon_state = "secure_eshui"

/obj/structure/fence/eshui_sign/attackby(obj/item/W, mob/user)
	attack_hand(user) // Ignore wirecutters

/obj/structure/fence/eshui_sign/electric
	electric = TRUE


/obj/structure/fence/eshui_sign_high_sec
	name = "No Entry"
	desc = "WARNING, high security restricted area. No entry without prior orders. A command officer must be present at all times while in this area."
	icon = 'modular_outpost/icons/obj/fence.dmi'
	icon_state = "secure_eshui_high"

/obj/structure/fence/eshui_sign_high_sec/attackby(obj/item/W, mob/user)
	attack_hand(user) // Ignore wirecutters

/obj/structure/fence/eshui_sign_high_sec/electric
	electric = TRUE
