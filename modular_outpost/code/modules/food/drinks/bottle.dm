/// Spin the bottle, Now with less menuing!
/obj/item/reagent_containers/food/drinks/bottle/click_alt(mob/user)
	..()
	spin_bottle()
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/food/drinks/bottle/afterattack(obj/target, mob/user, proximity)
	if(proximity && is_open_container() && user.a_intent == I_HURT)
		if(standard_splash_mob(user,target))
			return
		if(reagents && reagents.total_volume)
			balloon_alert(user, "splashed the solution onto [target]")
			reagents.splash(target, reagents.total_volume)
			return
	..()
