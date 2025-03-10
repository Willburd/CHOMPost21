/obj/machinery/autolathe/armory
	name = "ammolathe"
	desc = "An autolathe that produces ammunition using metal and glass."
	hacked = 1
	var/stun_only = FALSE // Outpost 21 edit - stunonly range autolathe varient

/obj/machinery/autolathe/armory/tgui_static_data(mob/user)
	var/list/data = ..()

	var/list/categories = list()
	var/list/recipes = list()
	for(var/datum/category_group/autolathe/A in autolathe_recipes.categories)
		categories += A.name
		for(var/datum/category_item/autolathe/arms/M in A.items)
			if(M.hidden && !hacked)
				continue
			if(M.man_rating > man_rating)
				continue
			if((M.lethal && stun_only) || hacked) // Outpost 21 edit - stunonly range autolathe varient
				continue
			recipes.Add(list(list(
				"category" = A.name,
				"name" = M.name,
				"ref" = REF(M),
				"requirements" = M.resources,
				"hidden" = M.hidden,
				"coeff_applies" = !M.no_scale,
				"is_stack" = M.is_stack,
			)))
	data["recipes"] = recipes
	data["categories"] = categories

	return data

// Outpost 21 edit begin - stunonly range autolathe varient
/obj/machinery/autolathe/armory/stun_only
	name = "training ammolathe"
	desc = "An autolathe that produces training ammunition using metal and glass."
	stun_only = TRUE
// Outpost 21 edit end
