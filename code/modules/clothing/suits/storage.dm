/obj/item/clothing/suit/storage
	name = DEVELOPER_WARNING_NAME
	var/obj/item/storage/internal/pockets

/obj/item/clothing/suit/storage/Initialize(mapload)
	. = ..()
	pockets = new/obj/item/storage/internal(src)
	pockets.max_w_class = ITEMSIZE_SMALL		//fit only pocket sized items
	pockets.max_storage_space = ITEMSIZE_COST_SMALL * 2

/obj/item/clothing/suit/storage/Destroy()
	QDEL_NULL(pockets)
	return ..()

/obj/item/clothing/suit/storage/attack_hand(mob/user as mob)
	if (pockets.handle_attack_hand(user))
		..(user)

/obj/item/clothing/suit/storage/MouseDrop(obj/over_object as obj)
	if (pockets.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/suit/storage/attackby(obj/item/W as obj, mob/user as mob)
	..()
	pockets.attackby(W, user)

/obj/item/clothing/suit/storage/emp_act(severity)
	pockets.emp_act(severity)
	..()

//Jackets with buttons, used for labcoats, IA jackets, First Responder jackets, and brown jackets.
/obj/item/clothing/suit/storage/toggle
	name = DEVELOPER_WARNING_NAME
	flags_inv = HIDEHOLSTER
	var/open = 0	//0 is closed, 1 is open, -1 means it won't be able to toggle

/obj/item/clothing/suit/storage/toggle/verb/toggle()
	set name = "Toggle Coat Buttons"
	set category = "Object"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return 0

	if(open == 1) //Will check whether icon state is currently set to the "open" or "closed" state and switch it around with a message to the user
		open = 0
		icon_state = initial(icon_state)
		flags_inv = HIDETIE|HIDEHOLSTER
		to_chat(usr, "You button up the coat.")
	else if(open == 0)
		open = 1
		icon_state = "[icon_state]_open"
		flags_inv = HIDEHOLSTER
		to_chat(usr, "You unbutton the coat.")
	else //in case some goofy admin switches icon states around without switching the icon_open or icon_closed
		to_chat(usr, "You attempt to button-up the velcro on your [src], before promptly realising how silly you are.")
		return
	update_clothing_icon()	//so our overlays update


/obj/item/clothing/suit/storage/hooded/toggle
	name = DEVELOPER_WARNING_NAME
	flags_inv = HIDEHOLSTER
	var/open = 0	//0 is closed, 1 is open, -1 means it won't be able to toggle

/obj/item/clothing/suit/storage/hooded/toggle/verb/toggle()
	set name = "Toggle Coat Buttons"
	set category = "Object"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return 0

	if(open == 1) //Will check whether icon state is currently set to the "open" or "closed" state and switch it around with a message to the user
		open = 0
		update_icon()
		flags_inv = HIDETIE|HIDEHOLSTER
		to_chat(usr, "You button up the coat.")
	else if(open == 0)
		open = 1
		update_icon()
		flags_inv = HIDEHOLSTER
		to_chat(usr, "You unbutton the coat.")
	else //in case some goofy admin switches icon states around without switching the icon_open or icon_closed
		to_chat(usr, "You attempt to button-up the velcro on your [src], before promptly realising how silly you are.")
		return
	if(istype(hood,/obj/item/clothing/head/hood/toggleable)) //checks if a hood (which you should use) is attached
		var/obj/item/clothing/head/hood/toggleable/T = hood
		T.open = open //copy the jacket's open state to the hood
		T.update_icon(usr) //usr as an arg to fix a weird runtime
		T.update_clothing_icon()
	update_clothing_icon() //so our overlays update

/obj/item/clothing/suit/storage/hooded/toggle/update_icon()
	. = ..()
	icon_state = "[toggleicon][open ? "_open" : ""][hood_up ? "_t" : ""]"

//New Vest 4 pocket storage and badge toggles, until suit accessories are a thing.
/obj/item/clothing/suit/storage/vest/heavy/Initialize(mapload)
	. = ..()
	pockets = new/obj/item/storage/internal(src)
	pockets.max_w_class = ITEMSIZE_SMALL
	pockets.max_storage_space = ITEMSIZE_COST_SMALL * 4

/obj/item/clothing/suit/storage/vest
	var/icon_badge
	var/icon_nobadge

/obj/item/clothing/suit/storage/vest/verb/toggle()
	set name ="Adjust Badge"
	set category = "Object"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return 0

	if(icon_state == icon_badge)
		icon_state = icon_nobadge
		to_chat(usr, "You conceal \the [src]'s badge.")
	else if(icon_state == icon_nobadge)
		icon_state = icon_badge
		to_chat(usr, "You reveal \the [src]'s badge.")
	else
		to_chat(usr, "\The [src] does not have a badge.")
		return
	update_clothing_icon()
