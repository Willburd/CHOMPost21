/// Spin the bottle, Now with less menuing!
/obj/item/reagent_containers/food/drinks/bottle/click_alt(mob/user)
	..()
	spin_bottle()
	return CLICK_ACTION_SUCCESS
