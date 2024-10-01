/obj/item/storage/box/monkeycubes/pets
	icon = 'modular_outpost/icons/obj/food.dmi'
	icon_state = "petcubebox"
	starts_with = null // Don't add monkeys
	var/pet_list = list("Ian" = /mob/living/simple_mob/animal/passive/dog/corgi/Ian)

/obj/item/storage/box/monkeycubes/pets/A
	name = "pet cube box (series A)"
	desc = "Drymate brand pet cubes, formulated for E-Shui Outpost 21. Just add water!"
	pet_list = list("Ian" = /mob/living/simple_mob/animal/passive/dog/corgi/Ian,
					"Bones" = /mob/living/simple_mob/animal/passive/cat/bones,
					"Poppy" = /mob/living/simple_mob/animal/passive/opossum/poppy,
					"Jillilah" = /mob/living/simple_mob/vore/alienanimals/jil/jillilah,
					"Noodle" = /mob/living/simple_mob/animal/passive/snake/python/noodle,
					"Grins" = /mob/living/simple_mob/animal/synx/ai/pet/grins,
					"Kendrick" = /mob/living/simple_mob/slime/xenobio/rainbow/kendrick)

/obj/item/storage/box/monkeycubes/pets/B
	name = "pet cube box (series B)"
	desc = "Drymate brand pet cubes, formulated for E-Shui Outpost 21. Just add water!"
	pet_list = list("Clucky" = /mob/living/simple_mob/animal/passive/chicken/clucky,
					"Cooper" = /mob/living/simple_mob/animal/passive/mouse/mining,
					"Poly" = /mob/living/simple_mob/animal/passive/bird/parrot/poly,
					"Runtime" = /mob/living/simple_mob/animal/passive/cat/runtime,
					"Tom" = /mob/living/simple_mob/animal/passive/mouse/brown/Tom,
					"Jilly-bean" = /mob/living/simple_mob/vore/alienanimals/jil/bean,
					"Miros" = /mob/living/simple_mob/vore/alienanimals/catslug/custom/spaceslug)

/obj/item/storage/box/monkeycubes/pets/Initialize()
	. = ..()
	// spawn each pet in the box
	var/first = TRUE
	for(var/pet in pet_list)
		if(first)
			desc += " Contains: "
			first = FALSE
		else
			desc += ", "
		var/obj/item/reagent_containers/food/snacks/monkeycube/pet/wrapped/C = new(src)
		C.name ="[pet] pet cube"
		C.pet_path = pet_list[pet]
		desc += "[pet]"
