/obj/item/reagent_containers/food/snacks/monkeycube/pet
	var/pet_path = null

/obj/item/reagent_containers/food/snacks/monkeycube/pet/wrapped
	desc = "Still wrapped in some paper."
	icon_state = "monkeycubewrap"
	flags = 0
	wrapped = 1

/obj/item/reagent_containers/food/snacks/monkeycube/pet/Expand()
	src.visible_message("<b>\The [src]</b> expands!")
	if(pet_path)
		new pet_path(get_turf(src))
	qdel(src)
	return 1
