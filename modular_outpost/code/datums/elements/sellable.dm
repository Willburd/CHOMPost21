// Selling slimes
/datum/element/sellable/slime_extract/calculate_sell_value(obj/source)
	var/obj/item/slime_extract/slime_stuff = source
	return FLOOR(slime_stuff.supply_conversion_value,1)


// Selling food
/datum/element/sellable/food_snack
	sale_info = "This can be sold on the cargo shuttle if packed in a freezer crate."

/datum/element/sellable/food_snack/sell_error(obj/source)
	if(!istype(source.loc, /obj/structure/closet/crate/freezer))
		return "Error: Product was improperly packaged. Send contents in freezer crate to preserve contents for transport. Payment rendered null under terms of agreement."
	var/obj/item/reagent_containers/food/food_stuff = source
	if(istype(food_stuff,/obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = food_stuff
		if(S.bitecount > 0)
			return "Error: Product was partially consumed, and is unfit for sale. Payment rendered null under terms of agreement."
	return null

/datum/element/sellable/food_snack/calculate_sell_value(obj/source)
	var/obj/item/reagent_containers/food/food_stuff = source
	return FLOOR(food_stuff.price_tag,1) // Converts old price system into supply point cost


// Selling TTVs
/datum/element/sellable/transfer_valve/calculate_sell_value(obj/source)
	var/obj/item/transfer_valve/TTV = source

	if(!TTV.tank_one || !TTV.tank_two)
		return 0

	var/datum/gas_mixture/faketank = new()
	QDEL_IN(faketank,5)

	// Highest pressure must be in tank 1!
	var/obj/item/tank/tone = TTV.tank_one
	var/obj/item/tank/ttwo = TTV.tank_two
	if(tone.air_contents.return_pressure() < ttwo.air_contents.return_pressure())
		tone = TTV.tank_two
		ttwo = TTV.tank_one
	faketank.volume = tone.air_contents.volume + ttwo.air_contents.volume
	faketank.copy_from(tone.air_contents)
	var/faketank_integrity = tone.integrity

	// Perform the explosion
	faketank.merge(ttwo.air_contents)
	faketank.react()
	var/pressure = faketank.return_pressure()
	if(pressure <= TANK_FRAGMENT_PRESSURE)
		return 0
	if(faketank_integrity > 7)
		return 0

	faketank.react()
	faketank.react()
	faketank.react()
	pressure = faketank.return_pressure()

	var/strength = (pressure-TANK_FRAGMENT_PRESSURE)/TANK_FRAGMENT_SCALE
	var/mult = ((faketank.volume/140)**(1/2)) * (faketank.total_moles**(2/3))/((29*0.64) **(2/3)) //Don't ask me what this is, see tanks.dm

	var/dev = round((mult*strength)*0.15)
	var/heavy = round((mult*strength)*0.35)
	var/light = round((mult*strength)*0.80)

	return FLOOR(round(dev + (heavy/2) + (light/3),1),1)

/datum/element/sellable/transfer_valve/sell(obj/source, var/datum/exported_crate/EC, var/in_crate)
	. = ..()
	if(. && EC.contents[EC.contents.len]["value"] > 0)
		SSsupply.warheads_sold++
		SSsupply.warheads_value += EC.contents[EC.contents.len]["value"]


// Mech selling
/datum/element/sellable/mecha
	needs_crate = FALSE
	sale_info = "This can be sold on the cargo shuttle. It's condition and parts would greatly affects its price."

/datum/element/sellable/food_snack/sell_error(obj/source)
	var/check_val = calculate_sell_value(source)
	if(!check_val)
		var/obj/mecha/exo = source
		if((exo.health / exo.maxhealth) < 0.5)
			return "Error: The unit is too damaged to sell, and will be used as scrap. Payment rendered null under terms of agreement."
		return "Error: The unit in its current condition has no resale value at all, and will be used as scrap. Payment rendered null under terms of agreement."
	return null

/datum/element/sellable/mecha/calculate_sell_value(obj/source)
	var/obj/mecha/exo = source
	var/amount = exo.health / 10
	amount += exo.max_temperature / 1000

	// generic bonuses
	for(var/slot in exo.internal_components)
		var/obj/item/mecha_parts/component/MC = exo.internal_components[slot]
		amount += MC.integrity
		amount += MC.emp_resistance * 10

	// special bonuses
	if(exo.internal_components[MECH_ACTUATOR])
		var/obj/item/mecha_parts/component/actuator/MC = exo.internal_components[MECH_ACTUATOR]
		amount += MC.integrity
		amount += 20 * MC.strafing_multiplier

	if(exo.internal_components[MECH_ARMOR])
		var/obj/item/mecha_parts/component/armor/MC = exo.internal_components[MECH_ARMOR]
		amount += MC.deflect_chance
		for(var/dam in MC.damage_absorption)
			amount += MC.damage_absorption[dam] * 10

	if(exo.internal_components[MECH_ELECTRIC])
		var/obj/item/mecha_parts/component/electrical/MC = exo.internal_components[MECH_ELECTRIC]
		amount += MC.integrity
		amount -= 100 * MC.charge_cost_mod

	// Don't bother somehow...
	if(amount < 0)
		return 0

	// Special mech multipliers
	if(istype(exo,/obj/mecha/combat/phazon))
		amount *= 3
	else if(istype(exo,/obj/mecha/combat/fighter)) // More niche
		amount *= 1.15
	else if(istype(exo,/obj/mecha/medical))
		amount *= 1.25
	else if(istype(exo,/obj/mecha/combat))
		amount *= 1.5
	else if(istype(exo,/obj/mecha/micro)) // Teeny weenies!
		amount *= 0.85
	else
		amount *= 1

	// Final health scaler
	amount *= (exo.health / exo.maxhealth)
	if(amount < 100)
		return 0
	return FLOOR(amount,10)


// Selling GUNZ
/datum/element/sellable/gun/calculate_sell_value(obj/source)
	var/amount = 10
	var/obj/item/gun/G = source
	var/obj/item/projectile/P = initial(G.projectile_type)

	if(istype(G,/obj/item/gun/projectile))
		var/obj/item/gun/projectile/PG = G
		amount += initial(PG.recoil) * 2 // We can assume bigger bang
		amount += initial(PG.max_shells) * 1.5 // More shots more bang

	if(istype(G,/obj/item/gun/energy))
		var/obj/item/gun/energy/EG = G
		amount += initial(EG.charge_cost) / 100 // We can assume bigger bang

	if(P)
		// Default bullet breakdown
		amount += initial(P.damage) / 2
		amount += initial(P.stun)
		amount += initial(P.weaken)
		amount += initial(P.paralyze)
		amount += initial(P.irradiate) / 2
		amount += initial(P.agony) / 2
		// Stop trying to sell donksofts
		if(initial(P.nodamage))
			amount /= 20

	return FLOOR(amount,5)





// Refinery chemical tanks (WIP)
/datum/element/sellable/trolley_tank
	sale_info = "This can be sold on the cargo shuttle if filled with a single reagent."
	needs_crate = FALSE

/datum/element/sellable/trolley_tank/sell_error(obj/source)
	var/obj/vehicle/train/trolley_tank/tank = source
	if(!tank.reagents || tank.reagents.reagent_list.len == 0)
		return "Error: Product was not filled with any reagents to sell. Payment rendered null under terms of agreement."
	var/min_tank = (CARGOTANKER_VOLUME - 100)
	if(tank.reagents.total_volume < min_tank)
		return "Error: Product was improperly packaged. Send full tanks only (minimum [min_tank] units). Payment rendered null under terms of agreement."
	if(tank.reagents.reagent_list.len > 1)
		return "Error: Product was improperly refined. Send purified mixtures only (too many reagents in tank). Payment rendered null under terms of agreement."
	return null

/datum/element/sellable/trolley_tank/calculate_sell_value(obj/source)
	var/obj/vehicle/train/trolley_tank/tank = source

	// Update export values
	var/datum/reagent/R = tank.reagents.reagent_list[1]
	var/reagent_value = FLOOR(R.volume * R.supply_conversion_value, 1)

	return reagent_value

/datum/element/sellable/trolley_tank/calculate_sell_quantity(obj/source)
	var/obj/vehicle/train/trolley_tank/tank = source
	if(!tank.reagents || tank.reagents.reagent_list.len == 0)
		return "0u "
	var/datum/reagent/R = tank.reagents.reagent_list[1]
	return "[R.name] [tank.reagents.total_volume]u "

/datum/element/sellable/trolley_tank/sell(obj/source, var/datum/exported_crate/EC, var/in_crate)
	. = ..()
	var/obj/vehicle/train/trolley_tank/tank = source
	if(. && tank.reagents?.reagent_list?.len)
		// Update end round data, has nothing to do with actual cargo sales
		var/datum/reagent/R = tank.reagents.reagent_list[1]
		var/reagent_value = FLOOR(R.volume * R.supply_conversion_value, 1)
		if(R.industrial_use)
			if(isnull(GLOB.refined_chems_sold[R.industrial_use]))
				var/list/data = list()
				data["units"] = FLOOR(R.volume, 1)
				data["value"] = reagent_value
				GLOB.refined_chems_sold[R.industrial_use] = data
			else
				GLOB.refined_chems_sold[R.industrial_use]["units"] += FLOOR(R.volume, 1)
				GLOB.refined_chems_sold[R.industrial_use]["value"] += reagent_value
