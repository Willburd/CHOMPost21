// -----------------------------
//          Santa bag
// -----------------------------
/obj/item/storage/bag/santabag
	name = "\improper Santa's gift bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space in Christmas! Wow, it's pretty big!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "giftbag0"
	item_state_slots = list(slot_r_hand_str = "giftbag", slot_l_hand_str = "giftbag")

	w_class = ITEMSIZE_LARGE
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_NORMAL * 100 // can store a ton of shit!
	can_hold = list() // any
	cant_hold = list(/obj/item/disk/nuclear)

/obj/item/storage/bag/santabag/update_icon()
	if(contents.len < 10)
		icon_state = "giftbag0"
	else if(contents.len < 25)
		icon_state = "giftbag1"
	else
		icon_state = "giftbag2"
