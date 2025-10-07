/obj/item/ammo_magazine/ammo_box/CtrlClick(mob/user)
	if(isliving(user) && Adjacent(user) && shake_ammo(user))
		return
	..()

/obj/item/ammo_magazine/ammo_box/verb/jumblize_ammo()
	set category = "Object"
	set name = "Jumble Ammo"
	set src in usr

	if(isliving(usr) && Adjacent(usr))
		shake_ammo(usr)

/obj/item/ammo_magazine/ammo_box/proc/shake_ammo(mob/user)
	if(stored_ammo.len)
		stored_ammo = shuffle(stored_ammo)
		user.visible_message("\The [user] shakes \the [src].", span_notice("You shake \the [src], jumbling up the contents."))
		return TRUE
	to_chat(user,span_notice("\The [src] is empty!"))
	return FALSE

/obj/item/ammo_magazine/ammo_box/examine(mob/user)
	. = ..()
	. += to_chat(user, span_notice("Control-click to randomize the order of the contents."))

// For mapper stuff
/obj/item/ammo_magazine/ammo_box/empty_shotty
	name = "12g ammo box"
	desc = "A box with space for 8 shotgun rounds"
	icon_state = "slug"
	caliber = "12g"
	ammo_type = null
	max_ammo = 8
