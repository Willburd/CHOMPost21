/obj/item/reagent_containers/glass/mortar_pestle
	name = "mortar and pestle"
	desc = "A specially formed bowl of ancient design. It is possible to crush or juice items placed in it using a pestle; however the process, unlike modern methods, is slow and physically exhausting."
	description_info = "Place grindable items inside to turn into reagents! Not everything can be grinded by hand."
	icon = 'modular_outpost/icons/obj/chemical.dmi'
	icon_state = "mortar_pestle"
	volume = 60
	flags = OPENCONTAINER
	drop_sound = 'sound/items/drop/generic1.ogg'
	pickup_sound = 'sound/items/pickup/generic1.ogg'
	var/list/grinding = list()
	var/static/list/grind_legal = list(
		/obj/item/ore,
		/obj/item/seeds,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/food/snacks,
		/obj/item/stack/material/wood,
		/obj/item/stack/material/stick,
		/obj/item/stack/material/log,
		/obj/item/stack/material/resin,
		/obj/item/stack/material/plastic,
		/obj/item/stack/material/algae,
		/obj/item/stack/material/graphite,
		/obj/item/stack/material/leather,
		/obj/item/stack/material/snow,
		/obj/item/stack/material/wax,
		/obj/item/stack/material/fur,
		/obj/item/stack/material/cloth,
		/obj/item/stack/material/fiber,
		/obj/item/stack/material/phoron,
		/obj/item/stack/material/cardboard,
		/obj/item/stack/material/sandstone,
		/obj/item/stack/material/glass,
		/obj/item/stack/material/supermatter
	)
	special_handling = TRUE

/obj/item/reagent_containers/glass/mortar_pestle/verb/remove_grindables()
	set name = "Remove Grindables"
	set category = "Object"
	set src in range(0)

	for(var/obj/thing in grinding)
		grinding -= thing
		thing.forceMove(get_turf(src))

/obj/item/reagent_containers/glass/mortar_pestle/attack_self(mob/user, modifiers)
	. = ..(user)
	if(.)
		return TRUE
	grind_action()

/obj/item/reagent_containers/glass/mortar_pestle/examine(mob/user)
	. = ..()
	if(length(grinding))
		. += "It has unground items in it."

/obj/item/reagent_containers/glass/mortar_pestle/verb/grind_action()
	set name = "Grind Contents"
	set category = "Object"
	set src in range(0)

	if(!length(grinding))
		to_chat(usr, span_warning("There is nothing in \the [src]!"))
		return
	if(reagents.total_volume == reagents.maximum_volume)
		to_chat(usr, span_warning("\The [src] is too full to grind more into!"))
		return

	usr.visible_message("\The [usr] starts grinding...")
	var/grind_time = 0
	for(var/item in grinding)
		if(istype(item,/obj/item/stack/material))
			var/obj/item/stack/material/MM = item
			grind_time += MM.amount
			continue
		grind_time += 2
	if(grind_time < 2)
		grind_time = 2

	if(do_after(usr, length(grinding) SECONDS, target = src))
		if(length(grinding))
			grind_items_to_reagents(grinding, reagents)
	usr.visible_message("\The [usr] finishes grinding.")

/obj/item/reagent_containers/glass/mortar_pestle/attackby(obj/item/W, mob/user)
	// Handle these with parent
	if(istype(W,/obj/item/reagent_containers/glass) || istype(W,/obj/item/reagent_containers/hypospray/autoinjector) || istype(W,/obj/item/reagent_containers/syringe))
		return ..()
	// A very restricted grinding tool
	if(length(grinding) >= 10)
		to_chat(usr, span_warning("\The [src] is too full to put \the [W] in!"))
		return TRUE
	if(is_type_in_list(W,grind_legal))
		user.visible_message("\The [user] puts \the [W] into \the [src].")
		user.drop_from_inventory(W,src)
		grinding += W
		return TRUE
	// Forbid the rest
	to_chat(user, span_warning("\The [W] is too hard to grind with \the [src]."))
