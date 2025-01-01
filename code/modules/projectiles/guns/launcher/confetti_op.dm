/obj/item/gun/launcher/confetti_cannon/pie
	name = "Pie Cannon"
	desc = "Pies for everyone!"
	chambered = new /obj/item/reagent_containers/food
	var/list/pies = list()

/obj/item/gun/launcher/confetti_cannon/pie/examine(mob/user)
	. = ..()
	if(get_dist(user, src) <= 2)
		. += span_blue("It's loaded with [pies.len] rounds.")

/obj/item/gun/launcher/confetti_cannon/pie/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/reagent_containers/food))
		if(pies.len < max_confetti)
			user.drop_item()
			to_chat(usr, span_blue("You put \the [I] in the [src]."))
			I.forceMove(src)
			pies.Add(I)
		else
			to_chat(usr, span_red("[src] cannot hold more rounds."))

/obj/item/gun/launcher/confetti_cannon/pie/pump(mob/M as mob)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
	if(!chambered)
		if(pies.len)
			chambered = pies[1]
			pies.Remove(chambered)
			to_chat(usr, span_blue("You load a new round."))
		else
			to_chat(usr, span_red("The [src] is out of rounds!"))
	else
		to_chat(usr, span_red("The [src] is already loaded!"))

/obj/item/gun/launcher/confetti_cannon/pie/consume_next_projectile()
	if(chambered)
		playsound(src, 'sound/items/confetti.ogg', 75, 1)
	return chambered


/obj/item/gun/launcher/confetti_cannon/pie/super
	name = "Super Pie Cannon"
	desc = "Pies for EVERYONE! It bakes more, so you'll never run out!"
	var/charge_counter = 0

/obj/item/gun/launcher/confetti_cannon/pie/super/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	while(pies.len < max_confetti)
		var/obj/item/reagent_containers/food/snacks/pie/I = new(src)
		pies.Add(I)

/obj/item/gun/launcher/confetti_cannon/pie/super/Destroy(force, ...)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/gun/launcher/confetti_cannon/pie/super/process()
	if(pies.len < max_confetti)
		charge_counter += 0.05
		if(charge_counter > 1)
			charge_counter = 0
			var/obj/item/reagent_containers/food/snacks/pie/I = new(src)
			pies.Add(I)
			playsound(src, 'sound/machines/ding.ogg', 50, 1)
			visible_message("ding")
