/obj/item/packageWrap/borg
	name = "packaging dispenser"
	desc = "Wraps various items so they can be tagged and shipped through disposals."
	amount = 999

// Unwrapping
/obj/item/smallDelivery/attack_robot(mob/living/user)
	if(user.stat || !Adjacent(user))
		return
	attack_self(user)

/obj/structure/bigDelivery/attack_robot(mob/living/user)
	if(user.stat || !Adjacent(user))
		return
	unwrap()
