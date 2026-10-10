/obj/structure/candybowl/command
	name = "bridge candy bowl"

/obj/structure/candybowl/command/Initialize(mapload)
	. = ..()
	candy += list(
		/obj/item/reagent_containers/food/snacks/chocolatepiece/white,
		/obj/item/reagent_containers/food/snacks/donut,
		/obj/item/reagent_containers/food/snacks/donut/plain,
		/obj/item/reagent_containers/food/snacks/donut/beige,
		/obj/item/reagent_containers/food/snacks/donut/blue,
		/obj/item/reagent_containers/food/snacks/donut/choc,
		/obj/item/reagent_containers/food/snacks/donut/olive,
		/obj/item/reagent_containers/food/snacks/donut/pink
	)
