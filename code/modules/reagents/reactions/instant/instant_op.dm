/decl/chemical_reaction/instant/hemocyanin
	name = "Hemocyanin"
	id = "hemocyanin"
	result = "hemocyanin"
	required_reagents = list("nitrogen" = 5, "hydrogen" = 3, "carbon" = 10, "copper" = 1, "phoron" = 0.2)
	catalysts = list("phoron" = 1)
	result_amount = 20

/decl/chemical_reaction/instant/artificial_sustenance
	name = "Artificial Sustenance"
	id = "a_sustenance"
	result = "a_sustenance"
	required_reagents = list("nutriment" = 1, "mutagen" = 1, "phoron" = 1)
	result_amount = 1

/decl/chemical_reaction/instant/sulphuricacid
	name = "Sulphuric acid"
	id = "sacid"
	result = "sacid"
	required_reagents = list("hydrogen" = 2,"sulfur" = 1,"oxygen" = 4)
	result_amount = 5

/decl/chemical_reaction/instant/silicon
	name = "Silicon"
	id = "reduce_silicate"
	result = "silicon"
	required_reagents = list("silicate" = 1, "sacid" = 1,"sulfur" = 1)
	result_amount = 1

/decl/chemical_reaction/instant/riotsmoke
	name = "Riotgas"
	id = "riotsmoke"
	result = null
	required_reagents = list("titanium_diox" = 1, "chlorine" = 4, "phosphorus" = 1)
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
	name = "Titanium"
	id = "reduce_titanium"
	result = "titanium"
	required_reagents = list("titanium_diox" = 1, "chlorine" = 4, "sodium" = 1)
	result_amount = 1

/decl/chemical_reaction/instant/titanium_oxidation
	name = "Titanium dioxide"
	id = "oxidize_titanium"
	result = "titanium_diox"
	required_reagents = list("titanium" = 1, "oxygen" = 2)
	result_amount = 1

/* Metallic paints */
/decl/chemical_reaction/instant/metal_paint
	name = "Metallic white paint"
	id = "metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/metal_paint/send_data()
	return "#b2d1da"

/decl/chemical_reaction/instant/red_metal_paint
	name = "Metallic red paint"
	id = "red_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_red" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/red_metal_paint/send_data()
	return "#ff7a7a"

/decl/chemical_reaction/instant/orange_metal_paint
	name = "Metallic orange paint"
	id = "orange_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_orange" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/orange_metal_paint/send_data()
	return "#ffd690"

/decl/chemical_reaction/instant/yellow_metal_paint
	name = "Metallic yellow paint"
	id = "yellow_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_yellow" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/yellow_metal_paint/send_data()
	return "#ffffab"

/decl/chemical_reaction/instant/green_metal_paint
	name = "Metallic green paint"
	id = "green_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_green" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/green_metal_paint/send_data()
	return "#69d76b"

/decl/chemical_reaction/instant/blue_metal_paint
	name = "Metallic blue paint"
	id = "blue_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_blue" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/blue_metal_paint/send_data()
	return "#81aff5"

/decl/chemical_reaction/instant/purple_metal_paint
	name = "Metallic purple paint"
	id = "purple_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_purple" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/purple_metal_paint/send_data()
	return "#e77acc"

/decl/chemical_reaction/instant/brown_metal_paint
	name = "Metallic brown paint"
	id = "brown_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "marker_ink_brown" = 1)
	result_amount = 5

/decl/chemical_reaction/instant/brown_metal_paint/send_data()
	return "#827655"

/decl/chemical_reaction/instant/orange_juice_metal_paint
	name = "Metallic orange juice paint"
	id = "orange_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "orangejuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/orange_juice_metal_paint/send_data()
	return "#e2a254"

/decl/chemical_reaction/instant/tomato_juice_metal_paint
	name = "Metallic tomato juice paint"
	id = "tomato_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "tomatojuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/tomato_juice_metal_paint/send_data()
	return "#934e49"

/decl/chemical_reaction/instant/lime_juice_metal_paint
	name = "Metallic lime juice paint"
	id = "lime_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "limejuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/lime_juice_metal_paint/send_data()
	return "#556c51"

/decl/chemical_reaction/instant/carrot_juice_metal_paint
	name = "Metallic carrot juice paint"
	id = "carrot_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "carrotjuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/carrot_juice_metal_paint/send_data()
	return "#a06a4b"

/decl/chemical_reaction/instant/berry_juice_metal_paint
	name = "Metallic berry juice paint"
	id = "berry_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "berryjuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/berry_juice_metal_paint/send_data()
	return "#ae5892"

/decl/chemical_reaction/instant/grape_juice_metal_paint
	name = "Metallic grape juice paint"
	id = "grape_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "grapejuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/grape_juice_metal_paint/send_data()
	return "#925e5e"

/decl/chemical_reaction/instant/poisonberry_juice_metal_paint
	name = "Metallic poison berry juice paint"
	id = "poisonberry_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "poisonberryjuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/poisonberry_juice_metal_paint/send_data()
	return "#683c4d"

/decl/chemical_reaction/instant/watermelon_juice_metal_paint
	name = "Metallic watermelon juice paint"
	id = "watermelon_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "watermelonjuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/watermelon_juice_metal_paint/send_data()
	return "#a47a7a"

/decl/chemical_reaction/instant/lemon_juice_metal_paint
	name = "Metallic lemon juice paint"
	id = "lemon_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "lemonjuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/lemon_juice_metal_paint/send_data()
	return "#8f8f5c"

/decl/chemical_reaction/instant/banana_juice_metal_paint
	name = "Metallic banana juice paint"
	id = "banana_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "banana" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/banana_juice_metal_paint/send_data()
	return "#9c9129"

/decl/chemical_reaction/instant/potato_juice_metal_paint
	name = "Metallic potato juice paint"
	id = "potato_juice_metal_paint"
	result = "paint"
	required_reagents = list("titanium_diox" = 1, "water" = 3, "potatojuice" = 5)
	result_amount = 5

/decl/chemical_reaction/instant/potato_juice_metal_paint/send_data()
	return "#2e2a21"
