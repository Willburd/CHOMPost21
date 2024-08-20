/turf/simulated/floor/gas_crack
	icon = 'icons/turf/flooring/asteroid.dmi'
	desc = "Rough sand with a huge crack. It seems to be nothing in particular."
	name = "cracked sand"
	icon_state = "asteroid_cracked"
	initial_flooring = /decl/flooring/rock
	oxygen = 0
	nitrogen = 0

	// Fracking results for fluid pump
	var/static/list/ore_types = list(
		// "hematite" = list("silicate","iron","carbon"), // rusty rocks, but i don't include it here because it makes uranium impossible due to emp pulse reaction, it's easy to get iron anyway
		"uranium" = list("uranium","radium","calcium","phosphorus"),
		"copper" = list("gold","copper","lead"), // Commonly
		"gold" = list("gold","copper","lead"), // Found
		"tin" = list("gold","copper","lead"), // Together
		"silver" = list("silver","lead","copper"), // lead loves this one too
		"diamond" = list("titanium_diox","phosphorus","sulfur","carbon"), // Ignius process
		"phoron" = list("phoron","radium","phosphorus","sulfur"), // Ignius heavymetals?
		"platinum" = list("platinum","copper"), // Don't have much to group it with
		"mhydrogen" = list("silicate","hydrogen"),
		"sand" = list("silicate","silicon","lithium","phosphorus","calcium","sodiumchloride","carbon"), // Catch all sedimentry
		"carbon" = list("silicate","carbon","sodiumchloride"), // Salty coal
		"bauxite" = list("titanium_diox","aluminum","sodiumchloride"), // ore's general components and neighbours
		"rutile" = list("titanium_diox","silicate","silicon","sodiumchloride") // ore's general components and neighbours
		)

/turf/simulated/floor/gas_crack/pump_reagents(var/datum/reagents/R, var/volume)
	// pick random turfs in range, then use their deep ores to get some extra reagents
	var/i = 0
	while(i++ < 4) // Do this a few times
		var/turf/simulated/mineral/M = pick(orange(3,src))
		if(!M)
			return
		for(var/metal in ore_types)
			if(!M.resources[metal])
				return
			var/list/ore_list = ore_types[metal]
			if(!ore_list || !ore_list.len)
				return
			if(prob(60))
				var/reagent_id = pick(ore_list)
				R.add_reagent(reagent_id, round(volume, 0.1))


/turf/simulated/floor/gas_crack/oxygen
	desc = "Rough sand with a huge crack. A strong breeze blows through it."
	oxygen = 2500

/turf/simulated/floor/gas_crack/oxygen/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("oxygen", round(volume / 2, 0.1))


/turf/simulated/floor/gas_crack/nitrogen
	desc = "Rough sand with a huge crack. A strong breeze blows through it."
	nitrogen = 2500

/turf/simulated/floor/gas_crack/nitrogen/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("nitrogen", round(volume / 2, 0.1))


/turf/simulated/floor/gas_crack/carbon
	desc = "Rough sand with a huge crack. A strong breeze blows through it."
	carbon_dioxide = 2500

/turf/simulated/floor/gas_crack/carbon/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("carbon", round(volume / 2, 0.1))


/turf/simulated/floor/gas_crack/nitro
	desc = "Rough sand with a huge crack. A strange smell wafts from beneath it."
	nitrous_oxide = 2500

/turf/simulated/floor/gas_crack/nitro/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("oxygen", round(volume / 3, 0.1))
	R.add_reagent("nitrogen", round(volume / 3, 0.1))


/turf/simulated/floor/gas_crack/phoron
	desc = "Rough sand with a huge crack. A terrible smell wafts from beneath it."
	phoron = 2500

/turf/simulated/floor/gas_crack/phoron/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("phoron", round(volume / 3, 0.1))


/turf/simulated/floor/gas_crack/methane
	desc = "Rough sand with a huge crack. A terrible smell wafts from beneath it."
	methane = 2500

/turf/simulated/floor/gas_crack/methane/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("sulfur", round(volume / 2, 0.1))
	R.add_reagent("Phosphorus", round(volume / 2, 0.1))


/turf/simulated/floor/gas_crack/air
	desc = "Rough sand with a huge crack. A fresh breeze blows through it."
	oxygen = 2500
	nitrogen = 2500

/turf/simulated/floor/gas_crack/air/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("oxygen", round(volume / 2, 0.1))
	R.add_reagent("nitrogen", round(volume / 2, 0.1))


/turf/simulated/floor/gas_crack/terrible
	desc = "Rough sand with a huge crack. A dangerous smell wafts from beneath it."
	methane = 2500
	phoron = 2500

/turf/simulated/floor/gas_crack/terrible/pump_reagents(var/datum/reagents/R, var/volume)
	. = ..()
	R.add_reagent("sulfur", round(volume / 2, 0.1))
	R.add_reagent("Phosphorus", round(volume / 2, 0.1))
	R.add_reagent("phoron", round(volume / 3, 0.1))
