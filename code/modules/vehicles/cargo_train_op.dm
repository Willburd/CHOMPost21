/obj/vehicle/train/trolly_tank
	name = "cargo train tanker"
	desc = "A large, tank made for transporting liquids."
	icon = 'icons/obj/vehicles_op.dmi'	//VOREStation Edit
	icon_state = "cargo_tank"
	anchored = FALSE
	flags = OPENCONTAINER

	var/obj/item/weapon/reagent_containers/glass/stored_container = null

/obj/vehicle/train/trolly_tank/Initialize()
	. = ..()
	create_reagents(5000)

/obj/vehicle/train/trolly_tank/insert_cell(var/obj/item/weapon/cell/C, var/mob/living/carbon/human/H)
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

	var/obj/item/W = M.get_active_hand()
	if(istype(W,/obj/item/weapon/reagent_containers/glass))
		M.drop_from_inventory(W,src)
		stored_container = W
		visible_message("\The [M] loads \the [W] into \the [src].")

/obj/vehicle/train/trolly_tank/proc/load_container(var/obj/item/W)
	if(istype(W,/obj/item/weapon/reagent_containers/glass))
		stored_container.forceMove(src)
		stored_container = W

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
	. += "The meter shows [FLOOR((reagents.total_volume / reagents.maximum_volume) * 100,1)]% full."
