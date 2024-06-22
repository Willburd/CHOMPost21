/obj/structure/closet/crate/MouseDrop_T(mob/target, mob/user)
	// Adds climbing from drag, You can't put yourself in crates with a drag anyway... Nore anyone else actually.
	var/mob/living/H = user
	if(istype(H) && can_climb(H) && target == user)
		do_climb(target)
	else
		return ..()
