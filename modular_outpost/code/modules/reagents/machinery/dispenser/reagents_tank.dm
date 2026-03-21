/*
 * Tanks
 */

//SOUP
/obj/structure/reagent_dispensers/souppot
	name = "soup cart"
	desc = "A large pot mounted to a trolley with a hand operated grinder. Dare you try the kitchen's latest sins?"
	icon = 'modular_outpost/icons/obj/chemical_tanks.dmi'
	icon_state = "soup"
	amount_per_transfer_from_this = 10
	open_top = TRUE
	flags = OPENCONTAINER
	var/inuse = FALSE
	var/list/holdingitems = list()

	var/static/list/base_reagents = list( // Base soups
		REAGENT_ID_TOMATOSOUP,
		REAGENT_ID_CHICKENNOODLESOUP,
		REAGENT_ID_CHICKENSOUP,
		REAGENT_ID_MUSHROOMSOUP,
	)
	var/static/list/soup_reagents = list( // Added ingredients
		REAGENT_ID_TOMATOJUICE,
		REAGENT_ID_BANANA,
		REAGENT_ID_BLACKPEPPER,
		REAGENT_ID_CHEESE,
		REAGENT_ID_CHERRYJELLY,
		REAGENT_ID_CORNOIL,
		REAGENT_ID_CREAM,
		REAGENT_ID_SODIUMCHLORIDE,
		REAGENT_ID_EGG,
		REAGENT_ID_MILK,
		REAGENT_ID_PEANUTOIL,
		REAGENT_ID_TURNIPJUICE,
		REAGENT_ID_SOYSAUCE,
		REAGENT_ID_SOYMILK,
		REAGENT_ID_BEERBATTER,
		REAGENT_ID_BEER,
		REAGENT_ID_RICE,
		REAGENT_ID_SUGAR,
		REAGENT_ID_PINEAPPLEJUICE,
	)
	var/static/list/rotten_reagents = list( // Goobies
		REAGENT_ID_TOXIN,
		REAGENT_ID_MOLD,
		REAGENT_ID_FUNGI,
		REAGENT_ID_AMATOXIN,
		REAGENT_ID_VIRUSFOOD,
		REAGENT_ID_BEPIS,
		REAGENT_ID_BEER,
		REAGENT_ID_COFFEE,
		REAGENT_ID_SEXONTHEBEACH,
		REAGENT_ID_VOXDELIGHT,
		REAGENT_ID_AMMONIA,
		REAGENT_ID_PHOSPHORUS,
		REAGENT_ID_SPIDEREGG
	)

/obj/structure/reagent_dispensers/souppot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)

/obj/structure/reagent_dispensers/souppot/on_reagent_change(changetype)
	. = ..()
	update_icon()

/obj/structure/reagent_dispensers/souppot/update_icon()
	. = ..()
	cut_overlays()
	// GOOBY!
	if(reagents && reagents.total_volume >= 1)
		var/percent = (reagents.total_volume / reagents.maximum_volume) * 100
		switch(percent)
			if(1 to 10)			percent = 1
			if(10 to 20)		percent = 2
			if(20 to 30) 		percent = 3
			if(30 to 40) 		percent = 4
			if(40 to 50) 		percent = 5
			if(50 to 60)		percent = 6
			if(60 to 70)		percent = 7
			if(70 to 80)		percent = 8
			if(80 to 90)		percent = 9
			if(90 to INFINITY)	percent = 10
		var/image/filling = image(icon, loc, "soup_[percent]",dir = dir)
		filling.color = reagents.get_color()
		add_overlay(filling)
	if(!(flags & OPENCONTAINER))
		var/image/cap = image(icon, loc, "soup_cap",dir = dir)
		add_overlay(cap)

/obj/structure/reagent_dispensers/souppot/click_alt(mob/user)
	. = ..()
	update_icon()

/obj/structure/reagent_dispensers/souppot/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()
	if(.)
		return

	if(inuse)
		return FALSE

	// Too full
	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("\The [src] is too full to grind anything else."))
		return FALSE

	// Don't grind these
	if (istype(O,/obj/item/reagent_containers/glass) || \
		istype(O,/obj/item/reagent_containers/food/drinks/glass2) || \
		istype(O,/obj/item/reagent_containers/food/drinks/shaker))
		return FALSE

	// Needs to be sheet, ore, or grindable reagent containing things
	if(!GLOB.sheet_reagents[O.type] && !GLOB.ore_reagents[O.type] && (!O.reagents || !O.reagents.total_volume))
		to_chat(user, span_notice("\The [O] is not suitable for blending."))
		return FALSE

	// Perform grinding
	inuse = TRUE
	spawn(50)
		inuse = FALSE

	playsound(src, 'sound/machines/blender.ogg', 50, 1)
	user.drop_from_inventory(O,src)
	holdingitems.Add(O)
	grind_items_to_reagents(holdingitems,reagents)

	return TRUE

// About half filled
/obj/structure/reagent_dispensers/souppot/half/Initialize(mapload)
	. = ..()
	var/max_vol = reagents.maximum_volume / 2
	reagents.add_reagent(pick(base_reagents),rand(max_vol / 8, max_vol / 2))
	// add components
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))

// Should be mostly full
/obj/structure/reagent_dispensers/souppot/full/Initialize(mapload)
	. = ..()
	var/max_vol = reagents.maximum_volume
	reagents.add_reagent(pick(base_reagents),rand(max_vol / 4, max_vol / 2))
	// add components
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))

// Around half but lots of random junk
/obj/structure/reagent_dispensers/souppot/rotten/Initialize(mapload)
	. = ..()
	var/max_vol = reagents.maximum_volume * 0.65
	reagents.add_reagent(pick(base_reagents),rand(max_vol / 8, max_vol / 4))
	reagents.add_reagent(pick(base_reagents),rand(max_vol / 8, max_vol / 4))
	// add components
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(soup_reagents),rand(max_vol / 12, max_vol / 6))
	// goops
	reagents.add_reagent(pick(rotten_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(rotten_reagents),rand(max_vol / 12, max_vol / 6))
	reagents.add_reagent(pick(rotten_reagents),rand(max_vol / 12, max_vol / 6))



/obj/structure/reagent_dispensers/medical_waste_tank
	name = "biological waste tank"
	desc = "A large tank for safely storing liquid biological waste like blood, decaying food, virology medium or expired medication."
	icon_state = "mwaste"
	icon = 'modular_outpost/icons/obj/chemical_tanks.dmi'
	// start open for dumping
	open_top = TRUE
	flags = OPENCONTAINER

/obj/structure/reagent_dispensers/medical_waste_tank/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)
