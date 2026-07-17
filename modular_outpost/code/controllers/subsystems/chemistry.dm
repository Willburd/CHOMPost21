/datum/controller/subsystem/chemistry/proc/randomize_chemical_market_prices()
	var/major_varience = rand(2,5)
	var/moderate_varience = rand(3,7)
	for(var/id in chemical_reagents)
		var/datum/reagent/R = chemical_reagents[id]
		if(R.supply_conversion_value)
			var/varience = 1
			if(prob(2))
				if(moderate_varience > 0)
					varience = rand(1, 3)
					moderate_varience--
			else if(prob(1))
				if(major_varience > 0)
					varience = rand(2, 3)
					major_varience--
			R.supply_conversion_value *= varience // randomized market on round start
