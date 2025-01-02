/obj/vehicle/train/trolly_tank
	name = "cargo train tanker"
	desc = "A large, tank made for transporting liquids."
	icon = 'modular_outpost/icons/obj/vehicles.dmi'
	icon_state = "cargo_tank"
	anchored = FALSE
	flags = OPENCONTAINER

	var/obj/item/reagent_containers/glass/stored_container = null
	paint_color = "#efdd16"

	// Support hoses
	var/obj/item/hose_connector/input/active/InputSocketA
	var/obj/item/hose_connector/input/active/InputSocketB
	var/obj/item/hose_connector/input/active/InputSocketC
	var/obj/item/hose_connector/output/active/OutputSocket

/obj/vehicle/train/trolly_tank/Initialize()
	. = ..()
	create_reagents(5000)
	update_icon()
	InputSocketA = new(src)
	InputSocketB = new(src)
	InputSocketC = new(src)
	OutputSocket = new(src)

/obj/vehicle/train/trolly_tank/Destroy()
	QDEL_NULL(InputSocketA)
	QDEL_NULL(InputSocketB)
	QDEL_NULL(InputSocketC)
	QDEL_NULL(OutputSocket)
	. = ..()

/obj/vehicle/train/trolly_tank/insert_cell(var/obj/item/cell/C, var/mob/living/carbon/human/H)
	return

/obj/vehicle/train/trolly_tank/Bump(atom/Obstacle)
	if(!lead)
		return //so people can't knock others over by pushing a trolley around
	..()

/obj/vehicle/train/trolly_tank/load(var/atom/movable/C, var/mob/living/user)
	return FALSE // Cannot load anything onto this

/obj/vehicle/train/trolly_tank/RunOver(var/mob/living/M)
	..()
	attack_log += text("\[[time_stamp()]\] [span_red("ran over [M.name] ([M.ckey])")]")

/obj/vehicle/train/trolly_tank/attackby(obj/item/W, mob/user)

	if(istype(W, /obj/item/multitool))
		var/new_paint = input(usr, "Please select paint color.", "Paint Color", paint_color) as color|null
		if(new_paint)
			paint_color = new_paint
			update_icon()
			return

	if(istype(W, /obj/item/pen))
		var/t = tgui_input_text(user, "What would you like the label to be?", text("[]", src.name), null, MAX_NAME_LEN)
		if (user.get_active_hand() != W)
			return
		if((!in_range(src, user) && src.loc != user))
			return
		t = sanitizeSafe(t, MAX_NAME_LEN)
		if(t)
			src.name = "[initial(name)] - '[t]'"
		else
			src.name = initial(name)
		return

	. = ..()

/obj/vehicle/train/trolly_tank/update_car(var/train_length, var/active_engines)
	src.train_length = train_length
	src.active_engines = active_engines

	if(!lead && !tow)
		anchored = FALSE
	else
		anchored = TRUE

/obj/vehicle/train/trolly_tank/attack_hand(mob/user)
	if(stored_container)
		unload_container()
		return
	. = ..()
/obj/vehicle/train/trolly_tank/verb/load_container_verb()
	set name = "Load Container"
	set category = "Object"
	set src in oview(1)

	var/mob/M = usr
	if(!M || M.incapacitated())
		return

	if(stored_container)
		return

	var/obj/item/W = M.get_active_hand()
	if(istype(W,/obj/item/reagent_containers/glass))
		stored_container = W
		M.drop_from_inventory(stored_container,src)
		visible_message("\The [M] loads \the [stored_container] into \the [src].")

/obj/vehicle/train/trolly_tank/proc/load_container(var/mob/user,var/obj/item/W)
	if(stored_container)
		return
	if(istype(W,/obj/item/reagent_containers/glass))
		if(W.loc == user)
			stored_container = W
			user.drop_from_inventory(stored_container,src)
			visible_message("\The [user] loads \the [stored_container] into \the [src].")

/obj/vehicle/train/trolly_tank/AltClick(mob/user)
	fill_container()

/obj/vehicle/train/trolly_tank/verb/unload_container()
	set name = "Unload Container"
	set category = "Object"
	set src in oview(1)

	if(stored_container)
		visible_message("\The [usr] removes \the [stored_container] from \the [src].")
		stored_container.forceMove(loc) // drop it outside even if user fails to pick it up
		stored_container.attack_hand(usr) // Attempt pickup
		stored_container = null
		return

/obj/vehicle/train/trolly_tank/verb/fill_container()
	set name = "Fill Loaded Container"
	set category = "Object"
	set src in oview(1)

	if(!stored_container)
		to_chat(usr,"No container loaded.")
		return
	if(reagents.total_volume <= 0)
		to_chat(usr,"\The [src] is empty.")
		return
	if(stored_container.reagents.total_volume >= stored_container.reagents.maximum_volume)
		to_chat(usr,"\The [stored_container] is full.")
		return
	playsound(src, 'sound/machines/reagent_dispense.ogg', 25, 1)
	to_chat(usr,"You drain \the [src] into the loaded [stored_container].")
	reagents.trans_to_holder( stored_container.reagents, stored_container.reagents.maximum_volume)

/obj/vehicle/train/trolly_tank/examine(mob/user, infix, suffix)
	. = ..()
	. += "The meter shows [reagents.total_volume]u / [reagents.maximum_volume]u."

/obj/vehicle/train/trolly_tank/update_icon()
	. = ..()
	cut_overlays()
	if(reagents && reagents.total_volume > 0)
		var/percent = (reagents.total_volume / reagents.maximum_volume) * 100
		switch(percent)
			if(0 to 10)			percent = 10
			if(10 to 20) 		percent = 20
			if(20 to 30) 		percent = 30
			if(30 to 40) 		percent = 40
			if(40 to 50)		percent = 50
			if(50 to 60)		percent = 60
			if(60 to 70)		percent = 70
			if(70 to 80)		percent = 80
			if(80 to 90)		percent = 90
			if(90 to INFINITY)	percent = 100
		var/image/chems = image(icon, icon_state = "[icon_state]_r_[percent]", dir = NORTH)
		chems.color = reagents.get_color()
		add_overlay(chems)
	var/image/Bodypaint = image(icon, icon_state = "[icon_state]_c", dir = NORTH)
	Bodypaint.color = paint_color
	add_overlay(Bodypaint)

/obj/vehicle/train/trolly_tank/on_reagent_change(changetype)
	update_icon()
