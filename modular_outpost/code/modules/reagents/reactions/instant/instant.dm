/decl/chemical_reaction/instant/hemocyanin
	name = REAGENT_HEMOCYANIN
	id = REAGENT_ID_HEMOCYANIN
	result = REAGENT_ID_HEMOCYANIN
	required_reagents = list(REAGENT_ID_NITROGEN = 5, REAGENT_ID_HYDROGEN = 3, REAGENT_ID_CARBON = 10, REAGENT_ID_COPPER = 1, REAGENT_ID_PHORON = 0.2)
	catalysts = list(REAGENT_ID_PHORON = 1)
	result_amount = 20

/decl/chemical_reaction/instant/artificial_sustenance
	name = REAGENT_ASUSTENANCE
	id = REAGENT_ID_ASUSTENANCE
	result = REAGENT_ID_ASUSTENANCE
	required_reagents = list(REAGENT_ID_NUTRIMENT = 1, REAGENT_ID_MUTAGEN = 1, REAGENT_ID_PHORON = 1)
	result_amount = 1

/decl/chemical_reaction/instant/sulphuricacid
	name = REAGENT_SACID
	id = REAGENT_ID_SACID
	result = REAGENT_ID_SACID
	required_reagents = list(REAGENT_ID_HYDROGEN = 2,REAGENT_ID_SULFUR = 1,REAGENT_ID_OXYGEN = 4)
	result_amount = 5

/decl/chemical_reaction/instant/silicon
	name = REAGENT_SILICON
	id = "reduce_silicate"
	result = REAGENT_ID_SILICON
	required_reagents = list(REAGENT_ID_SILICATE = 1, REAGENT_ID_SACID = 1,REAGENT_ID_SULFUR = 1)
	result_amount = 1

/decl/chemical_reaction/instant/riotsmoke
	name = "Riotgas"
	id = "riotsmoke"
	result = null
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_CHLORINE = 4, REAGENT_ID_PHOSPHORUS= 1)
	result_amount = 0.4

/decl/chemical_reaction/instant/riotsmoke/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/smoke_spread/bad/S = new /datum/effect/effect/system/smoke_spread/bad
	S.attach(location)
	S.set_up(holder, created_volume, 0, location)
	playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
	spawn(0)
		S.start()
	if(!isliving(holder.my_atom)) //No more powergaming by creating a tiny amount of this
		holder.clear_reagents()
	return

/decl/chemical_reaction/instant/titanium_refine
	name = REAGENT_TITANIUM
	id = "reduce_titanium"
	result = REAGENT_ID_TITANIUM
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_CHLORINE = 4, REAGENT_ID_SODIUM = 1)
	result_amount = 1

/decl/chemical_reaction/instant/titanium_oxidation
	name = REAGENT_TITANIUMDIOX
	id = "oxidize_titanium"
	result = REAGENT_ID_TITANIUMDIOX
	required_reagents = list(REAGENT_ID_TITANIUM = 1, REAGENT_ID_OXYGEN = 2)
	result_amount = 1

/* Metallic paints */
/decl/chemical_reaction/instant/metal_paint
	name = "Metallic white paint"
	id = "metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINK = 1)
	result_amount = 5

/decl/chemical_reaction/instant/metal_paint/send_data()
	return "#b2d1da"

/decl/chemical_reaction/instant/red_metal_paint
	name = "Metallic red paint"
	id = "red_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKRED = 1)
	result_amount = 5

/decl/chemical_reaction/instant/red_metal_paint/send_data()
	return "#ff7a7a"

/decl/chemical_reaction/instant/orange_metal_paint
	name = "Metallic orange paint"
	id = "orange_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKORANGE = 1)
	result_amount = 5

/decl/chemical_reaction/instant/orange_metal_paint/send_data()
	return "#ffd690"

/decl/chemical_reaction/instant/yellow_metal_paint
	name = "Metallic yellow paint"
	id = "yellow_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKYELLOW = 1)
	result_amount = 5

/decl/chemical_reaction/instant/yellow_metal_paint/send_data()
	return "#ffffab"

/decl/chemical_reaction/instant/green_metal_paint
	name = "Metallic green paint"
	id = "green_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKGREEN = 1)
	result_amount = 5

/decl/chemical_reaction/instant/green_metal_paint/send_data()
	return "#69d76b"

/decl/chemical_reaction/instant/blue_metal_paint
	name = "Metallic blue paint"
	id = "blue_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKBLUE = 1)
	result_amount = 5

/decl/chemical_reaction/instant/blue_metal_paint/send_data()
	return "#81aff5"

/decl/chemical_reaction/instant/purple_metal_paint
	name = "Metallic purple paint"
	id = "purple_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKPURPLE = 1)
	result_amount = 5

/decl/chemical_reaction/instant/purple_metal_paint/send_data()
	return "#e77acc"

/decl/chemical_reaction/instant/brown_metal_paint
	name = "Metallic brown paint"
	id = "brown_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_MARKERINKBROWN = 1)
	result_amount = 5

/decl/chemical_reaction/instant/brown_metal_paint/send_data()
	return "#827655"

/decl/chemical_reaction/instant/orange_juice_metal_paint
	name = "Metallic orange juice paint"
	id = "orange_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_ORANGEJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/orange_juice_metal_paint/send_data()
	return "#e2a254"

/decl/chemical_reaction/instant/tomato_juice_metal_paint
	name = "Metallic tomato juice paint"
	id = "tomato_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_TOMATOJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/tomato_juice_metal_paint/send_data()
	return "#934e49"

/decl/chemical_reaction/instant/lime_juice_metal_paint
	name = "Metallic lime juice paint"
	id = "lime_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_LIMEJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/lime_juice_metal_paint/send_data()
	return "#556c51"

/decl/chemical_reaction/instant/carrot_juice_metal_paint
	name = "Metallic carrot juice paint"
	id = "carrot_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_CARROTJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/carrot_juice_metal_paint/send_data()
	return "#a06a4b"

/decl/chemical_reaction/instant/berry_juice_metal_paint
	name = "Metallic berry juice paint"
	id = "berry_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_BERRYJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/berry_juice_metal_paint/send_data()
	return "#ae5892"

/decl/chemical_reaction/instant/grape_juice_metal_paint
	name = "Metallic grape juice paint"
	id = "grape_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_GRAPEJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/grape_juice_metal_paint/send_data()
	return "#925e5e"

/decl/chemical_reaction/instant/poisonberry_juice_metal_paint
	name = "Metallic poison berry juice paint"
	id = "poisonberry_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_POISONBERRYJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/poisonberry_juice_metal_paint/send_data()
	return "#683c4d"

/decl/chemical_reaction/instant/watermelon_juice_metal_paint
	name = "Metallic watermelon juice paint"
	id = "watermelon_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_WATERMELONJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/watermelon_juice_metal_paint/send_data()
	return "#a47a7a"

/decl/chemical_reaction/instant/lemon_juice_metal_paint
	name = "Metallic lemon juice paint"
	id = "lemon_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_LEMONJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/lemon_juice_metal_paint/send_data()
	return "#8f8f5c"

/decl/chemical_reaction/instant/banana_juice_metal_paint
	name = "Metallic banana juice paint"
	id = "banana_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_BANANA = 5)
	result_amount = 5

/decl/chemical_reaction/instant/banana_juice_metal_paint/send_data()
	return "#9c9129"

/decl/chemical_reaction/instant/potato_juice_metal_paint
	name = "Metallic potato juice paint"
	id = "potato_juice_metal_paint"
	result = REAGENT_ID_PAINT
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_WATER = 3, REAGENT_ID_POTATOJUICE = 5)
	result_amount = 5

/decl/chemical_reaction/instant/potato_juice_metal_paint/send_data()
	return "#2e2a21"
