#define AGE_MOD_MAX 10 //CHOMPedit: Define for age_mod sanity check as a define to allow for easy tweaking.

/obj/machinery/portable_atmospherics/hydroponics
	name = "hydroponics tray"
	desc = "A tray usually full of fluid for growing plants."
	icon = 'icons/obj/hydroponics_machines_vr.dmi' //VOREStation Edit
	icon_state = "hydrotray3"
	density = TRUE
	anchored = TRUE
	unacidable = TRUE
	flags = OPENCONTAINER
	volume = 100

	var/mechanical = 1         // Set to 0 to stop it from drawing the alert lights.
	var/base_name = "tray"

	// Plant maintenance vars.
	var/waterlevel = 100       // Water (max 100)
	var/nutrilevel = 10        // Nutrient (max 10)
	var/pestlevel = 0          // Pests (max 10)
	var/weedlevel = 0          // Weeds (max 10)

	// Tray state vars.
	var/dead = 0               // Is it dead?
	var/harvest = 0            // Is it ready to harvest?
	var/age = 0                // Current plant age
	var/sampled = 0            // Have we taken a sample?

	// Harvest/mutation mods.
	var/yield_mod = 0          // Modifier to yield
	var/mutation_mod = 0       // Modifier to mutation chance
	var/toxins = 0             // Toxicity in the tray?
	var/mutation_level = 0     // When it hits 100, the plant mutates.
	var/tray_light = 1         // Supplied lighting.
	var/age_mod = 0            //CHOMPedit: Variable for chems which speed up plant growth. On average, every 3 age mod reduces growing time by 2.5 minutes.

	// Mechanical concerns.
	var/health = 0             // Plant health.
	var/lastproduce = 0        // Last time tray was harvested
	var/lastcycle = 0          // Cycle timing/tracking var.
	var/cycledelay = 150       // Delay per cycle.
	var/closed_system          // If set, the tray will attempt to take atmos from a pipe.
	var/force_update           // Set this to bypass the cycle time check.
	var/obj/temp_chem_holder   // Something to hold reagents during process_reagents()
	var/labelled
	var/frozen = 0				//Is the plant frozen? -1 is used to define trays that can't be frozen. 0 is unfrozen and 1 is frozen.

	// Seed details/line data.
	var/datum/seed/seed = null // The currently planted seed

	var/image/ov_lowhealth
	var/image/ov_lowwater
	var/image/ov_lownutri
	var/image/ov_harvest
	var/image/ov_frozen
	var/image/ov_alert3

	// Reagent information for process(), consider moving this to a controller along
	// with cycle information under 'mechanical concerns' at some point.
	var/static/list/toxic_reagents = list(
		REAGENT_ID_ANTITOXIN =     -2,
		REAGENT_ID_TOXIN =           2,
		REAGENT_ID_FLUORINE =        2.5,
		REAGENT_ID_CHLORINE =        1.5,
		REAGENT_ID_SACID =           1.5,
		REAGENT_ID_PACID =           3,
		REAGENT_ID_PLANTBGONE =      3,
		REAGENT_ID_CRYOXADONE =     -3,
		REAGENT_ID_RADIUM =          2
		)
	var/static/list/nutrient_reagents = list(
		REAGENT_ID_MILK =            0.1,
		REAGENT_ID_BEER =            0.25,
		REAGENT_ID_PHOSPHORUS =      0.1,
		REAGENT_ID_SUGAR =           0.1,
		REAGENT_ID_SODAWATER =       0.1,
		REAGENT_ID_AMMONIA =         1,
		REAGENT_ID_DIETHYLAMINE =    2,
		REAGENT_ID_NUTRIMENT =       1,
		REAGENT_ID_ADMINORDRAZINE =  1,
		REAGENT_ID_EZNUTRIENT =      1,
		REAGENT_ID_ROBUSTHARVEST =   1,
		REAGENT_ID_LEFT4ZED =        1
		)
	var/static/list/weedkiller_reagents = list(
		REAGENT_ID_FLUORINE =       -4,
		REAGENT_ID_CHLORINE =       -3,
		REAGENT_ID_PHOSPHORUS =     -2,
		REAGENT_ID_SUGAR =           2,
		REAGENT_ID_SACID =          -2,
		REAGENT_ID_PACID =          -4,
		REAGENT_ID_PLANTBGONE =     -8,
		REAGENT_ID_ADMINORDRAZINE = -5
		)
	var/static/list/pestkiller_reagents = list(
		REAGENT_ID_SUGAR =           2,
		REAGENT_ID_DIETHYLAMINE =   -2,
		REAGENT_ID_ADMINORDRAZINE = -5
		)
	var/static/list/water_reagents = list(
		REAGENT_ID_WATER =           1,
		REAGENT_ID_ADMINORDRAZINE =  1,
		REAGENT_ID_MILK =            0.9,
		REAGENT_ID_BEER =            0.7,
		REAGENT_ID_FLUORINE =       -0.5,
		REAGENT_ID_CHLORINE =       -0.5,
		REAGENT_ID_PHOSPHORUS =     -0.5,
		REAGENT_ID_WATER =           1,
		REAGENT_ID_SODAWATER =       1,
		)

	// Beneficial reagents also have values for modifying health, yield_mod and mut_mod (in that order).
	var/static/list/beneficial_reagents = list(
		REAGENT_ID_BEER =           list( -0.05, 0,   0  ),
		REAGENT_ID_FLUORINE =       list( -2,    0,   0  ),
		REAGENT_ID_CHLORINE =       list( -1,    0,   0  ),
		REAGENT_ID_PHOSPHORUS =     list( -0.75, 0,   0  ),
		REAGENT_ID_SODAWATER =      list(  0.1,  0,   0  ),
		REAGENT_ID_SACID =          list( -1,    0,   0  ),
		REAGENT_ID_PACID =          list( -2,    0,   0  ),
		REAGENT_ID_PLANTBGONE =     list( -2,    0,   0.2),
		REAGENT_ID_CRYOXADONE =     list(  3,    0,   0  ),
		REAGENT_ID_AMMONIA =        list(  0.5,  0,   0  ),
		REAGENT_ID_DIETHYLAMINE =   list(  1,    0,   0  ),
		REAGENT_ID_NUTRIMENT =      list(  0.5,  0.1, 0  ),
		REAGENT_ID_RADIUM =         list( -1.5,  0,   0.2),
		REAGENT_ID_ADMINORDRAZINE = list(  1,    1,   1  ),
		REAGENT_ID_ROBUSTHARVEST =  list(  0,    0.2, 0  ),
		REAGENT_ID_LEFT4ZED =       list(  0,    0,   0.2)
		)

	// Mutagen list specifies minimum value for the mutation to take place, rather
	// than a bound as the lists above specify.
	var/static/list/mutagenic_reagents = list(
		REAGENT_ID_RADIUM =  8,
		REAGENT_ID_MUTAGEN = 15
		)

	//CHOMPedit: Reagents which double plant growth speed.
	var/static/list/age_reagents = list(
	REAGENT_ID_PITCHERNECTAR =  1
	)
	//CHOMPedit end

/obj/machinery/portable_atmospherics/hydroponics/AltClick(var/mob/living/user)
	if(!istype(user))
		return
	if(mechanical && !user.incapacitated() && Adjacent(user))
		close_lid(user)
		return 1
	return ..()

/obj/machinery/portable_atmospherics/hydroponics/attack_ghost(var/mob/observer/dead/user)

	if(!(harvest && seed && seed.has_mob_product))
		return

	var/datum/ghosttrap/plant/G = get_ghost_trap("living plant")
	if(!G.assess_candidate(user))
		return
	var/response = tgui_alert(user, "Are you sure you want to harvest this [seed.display_name]?", "Living plant request", list("Yes", "No"))
	if(response == "Yes")
		harvest()
	return

/obj/machinery/portable_atmospherics/hydroponics/attack_generic(var/mob/user)

	// Why did I ever think this was a good idea. TODO: move this onto the nymph mob.
	if(istype(user,/mob/living/carbon/alien/diona))
		var/mob/living/carbon/alien/diona/nymph = user

		if(nymph.stat == DEAD || nymph.paralysis || nymph.weakened || nymph.stunned || nymph.restrained())
			return

		if(weedlevel > 0)
			nymph.reagents.add_reagent(REAGENT_ID_GLUCOSE, weedlevel)
			weedlevel = 0
			nymph.visible_message(span_notice(span_bold("[nymph]") + " begins rooting through [src], ripping out weeds and eating them noisily."),span_notice("You begin rooting through [src], ripping out weeds and eating them noisily."))
		else if(nymph.nutrition > 100 && nutrilevel < 10)
			nymph.nutrition -= ((10-nutrilevel)*5)
			nutrilevel = 10
			nymph.visible_message(span_notice(span_bold("[nymph]") + " secretes a trickle of green liquid, refilling [src]."),span_notice("You secrete a trickle of green liquid, refilling [src]."))
		else
			nymph.visible_message(span_notice(span_bold("[nymph]") + " rolls around in [src] for a bit."),span_notice("You roll around in [src] for a bit."))
		return

/obj/machinery/portable_atmospherics/hydroponics/Initialize(mapload)
	..()
	if(!ov_lowhealth)	 //VOREStation Add
		setup_overlays() //VOREStation Add
	temp_chem_holder = new()
	temp_chem_holder.create_reagents(10)
	create_reagents(200)
	if(mechanical)
		connect()
	update_icon()
	return INITIALIZE_HINT_LATELOAD

// Give the seeds time to initialize itself
/obj/machinery/portable_atmospherics/hydroponics/LateInitialize()
	. = ..()
	var/obj/item/seeds/S = locate() in loc
	if(S)
		plant_seeds(S)

/obj/machinery/portable_atmospherics/hydroponics/proc/plant_seeds(var/obj/item/seeds/S)
	lastproduce = 0
	seed = S.seed //Grab the seed datum.
	dead = 0
	age = 1
	//Snowflakey, maybe move this to the seed datum
	health = (istype(S, /obj/item/seeds/cutting) ? round(seed.get_trait(TRAIT_ENDURANCE)/rand(2,5)) : seed.get_trait(TRAIT_ENDURANCE))
	lastcycle = world.time

	qdel(S)

	GLOB.seed_planted_shift_roundstat++

	check_health()
	update_icon()

/obj/machinery/portable_atmospherics/hydroponics/bullet_act(var/obj/item/projectile/Proj)

	//Don't act on seeds like dionaea that shouldn't change.
	if(seed && seed.get_trait(TRAIT_IMMUTABLE) > 0)
		return

	// Override for somatoray projectiles.
	// Change the mutchance var to buff or nerf somatorays, it will be multiplied by the tier of the laser.
	var/mutchance = 15
	if(istype(Proj ,/obj/item/projectile/energy/floramut))
		var/obj/item/projectile/energy/floramut/GM = Proj
		mutchance *= GM.lasermod
		if(prob(mutchance))
			if(istype(Proj, /obj/item/projectile/energy/floramut/gene))
				var/obj/item/projectile/energy/floramut/gene/G = Proj
				if(seed)
					seed = seed.diverge_mutate_gene(G.gene, get_turf(loc))	//get_turf just in case it's not in a turf.
			else
				mutate(1)
				return
	else if(istype(Proj ,/obj/item/projectile/energy/florayield))
		var/obj/item/projectile/energy/floramut/GY = Proj
		mutchance *= GY.lasermod
		if(prob(mutchance))
			yield_mod = min(10,yield_mod+rand(1,2))
			return
	else if(istype(Proj, /obj/item/projectile/energy/floraprune))
		var/obj/item/projectile/energy/floraprune/GP = Proj
		mutchance *= GP.lasermod
		if(prob(mutchance) && seed)
			var/c = safepick(seed.chems)
			if(length(seed.chems) > 1 && c)
				var/turf/T = get_turf(loc)
				seed = seed.diverge()
				T.visible_message(span_infoplain(span_bold("\The [seed.display_name]") + " quivers!"))
				seed.chems -= c
			return

	..()

/obj/machinery/portable_atmospherics/hydroponics/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return TRUE
	return FALSE

/obj/machinery/portable_atmospherics/hydroponics/proc/check_health()
	if(seed && !dead && health <= 0)
		die()
	check_level_sanity()
	update_icon()

/obj/machinery/portable_atmospherics/hydroponics/proc/die()
	dead = 1
	mutation_level = 0
	harvest = 0
	weedlevel += 1 * HYDRO_SPEED_MULTIPLIER
	pestlevel = 0

//Process reagents being input into the tray.
/obj/machinery/portable_atmospherics/hydroponics/proc/process_reagents()

	if(!reagents) return

	if(reagents.total_volume <= 0)
		return

	reagents.trans_to_obj(temp_chem_holder, min(reagents.total_volume,rand(1,3)))

	for(var/datum/reagent/R in temp_chem_holder.reagents.reagent_list)

		var/reagent_total = temp_chem_holder.reagents.get_reagent_amount(R.id)

		if(seed && !dead)
			// Beneficial reagents have a few impacts along with health buffs.
			if(seed.beneficial_reagents && seed.beneficial_reagents[R.id])
				health += seed.beneficial_reagents[R.id][1]       * reagent_total
				yield_mod += seed.beneficial_reagents[R.id][2]    * reagent_total
				mutation_mod += seed.beneficial_reagents[R.id][3] * reagent_total

			else if(beneficial_reagents[R.id])
				health += beneficial_reagents[R.id][1]       * reagent_total
				yield_mod += beneficial_reagents[R.id][2]    * reagent_total
				mutation_mod += beneficial_reagents[R.id][3] * reagent_total

			// Mutagen is distinct from the previous types and mostly has a chance of proccing a mutation.
			if(seed.mutagenic_reagents && seed.mutagenic_reagents[R.id])
				mutation_level += reagent_total*seed.mutagenic_reagents[R.id]+mutation_mod

			else if(mutagenic_reagents[R.id])
				mutation_level += reagent_total*mutagenic_reagents[R.id]+mutation_mod

			// Toxic reagents can possibly differ between plants.
			if(seed.toxic_reagents && seed.toxic_reagents[R.id])
				toxins += seed.toxic_reagents[R.id] * reagent_total

			else if(toxic_reagents[R.id])
				toxins += toxic_reagents[R.id] * reagent_total

			//CHOMPedit: Agents which speed up plant growth
			if(age_reagents[R.id])
				age_mod += age_reagents[R.id]  * reagent_total
			//CHOMPedit end

		//Handle some general level adjustments. These values are independent of plants existing.
		if(weedkiller_reagents[R.id])
			weedlevel -= weedkiller_reagents[R.id] * reagent_total
		if(pestkiller_reagents[R.id])
			pestlevel += pestkiller_reagents[R.id] * reagent_total

		// Handle nutrient refilling.
		if(nutrient_reagents[R.id])
			nutrilevel += nutrient_reagents[R.id]  * reagent_total

		// Handle water and water refilling.
		var/water_added = 0
		if(water_reagents[R.id])
			var/water_input = water_reagents[R.id] * reagent_total
			water_added += water_input
			waterlevel += water_input

		// Water dilutes toxin level.
		if(water_added > 0)
			toxins -= round(water_added/4)

	temp_chem_holder.reagents.clear_reagents()
	check_health()

//Harvests the product of a plant.
/obj/machinery/portable_atmospherics/hydroponics/proc/harvest(var/mob/user)

	//Harvest the product of the plant,
	if(!seed || !harvest)
		return

	if(closed_system)
		if(user)
			to_chat(user, span_filter_notice("You can't harvest from the plant while the lid is shut."))
		return

	if(user)
		seed.harvest(user,yield_mod)
	else
		seed.harvest(get_turf(src),yield_mod)
	// Reset values.
	harvest = 0
	lastproduce = age
	SShaunting.influence(HAUNTING_COMFORT) // Outpost 21 edit - IT DA SPOOKY STATION! - Botanist comfort gardening

	if(!seed.get_trait(TRAIT_HARVEST_REPEAT))
		yield_mod = 0
		seed = null
		dead = 0
		age = 0
		sampled = 0
		mutation_mod = 0
		age_mod = 0 //CHOMPedit

	check_health()
	return

//Clears out a dead plant.
/obj/machinery/portable_atmospherics/hydroponics/proc/remove_dead(var/mob/user)
	if(!user || !dead) return

	if(closed_system)
		to_chat(user, span_filter_notice("You can't remove the dead plant while the lid is shut."))
		return

	seed = null
	dead = 0
	sampled = 0
	age = 0
	yield_mod = 0
	mutation_mod = 0
	age_mod = 0 //CHOMPedit

	to_chat(user, span_filter_notice("You remove the dead plant."))
	lastproduce = 0
	check_health()
	return

// If a weed growth is sufficient, this proc is called.
/obj/machinery/portable_atmospherics/hydroponics/proc/weed_invasion()
	var/previous_plant

	//Remove the seed if something is already planted.
	if(seed)
		previous_plant = seed.display_name
		seed = null
	seed = SSplants.seeds[pick(list(PLANT_REISHI,PLANT_NETTLE,PLANT_AMANITA,PLANT_MUSHROOMS,PLANT_PLUMPHELMET,PLANT_TOWERCAP,PLANT_HAREBELLS,PLANT_WEEDS))]
	if(!seed) return //Weed does not exist, someone fucked up.

	dead = 0
	age = 0
	age_mod = 0 //CHOMPedit
	health = seed.get_trait(TRAIT_ENDURANCE)
	lastcycle = world.time
	harvest = 0
	weedlevel = 0
	pestlevel = 0
	sampled = 0
	update_icon()
	visible_message(span_notice("\The [previous_plant ? previous_plant : initial(name)] has been overtaken by [seed.display_name]."))

	return

/obj/machinery/portable_atmospherics/hydroponics/proc/mutate(var/severity)

	// No seed, no mutations.
	if(!seed)
		return

	// Check if we should even bother working on the current seed datum.
	if(seed.mutants && seed.mutants.len && severity > 1)
		mutate_species()
		return

	// We need to make sure we're not modifying one of the global seed datums.
	// If it's not in the global list, then no products of the line have been
	// harvested yet and it's safe to assume it's restricted to this tray.
	if(!isnull(SSplants.seeds[seed.name]))
		seed = seed.diverge()
		seed.mutate(severity,get_turf(src))

	return

/obj/machinery/portable_atmospherics/hydroponics/verb/remove_label()

	set name = "Remove Label"
	set category = "Object"
	set src in view(1)

	if(usr.incapacitated())
		return
	if(ishuman(usr) || isrobot(usr))
		if(labelled)
			to_chat(usr, span_filter_notice("You remove the label."))
			labelled = null
			update_icon()
		else
			to_chat(usr, span_filter_notice("There is no label to remove."))
	return

/obj/machinery/portable_atmospherics/hydroponics/verb/setlight()
	set name = "Set Light"
	set category = "Object"
	set src in view(1)

	if(usr.incapacitated())
		return
	if(ishuman(usr) || isrobot(usr))
		var/new_light = tgui_input_list(usr, "Specify a light level.", "Light Level", list(0,1,2,3,4,5,6,7,8,9,10))
		if(new_light)
			tray_light = new_light
			to_chat(usr, span_filter_notice("You set the tray to a light level of [tray_light] lumens."))
	return

/obj/machinery/portable_atmospherics/hydroponics/proc/check_level_sanity()
	//Make sure various values are sane.
	if(seed)
		health =     max(0,min(seed.get_trait(TRAIT_ENDURANCE),health))
	else
		health = 0
		dead = 0

	mutation_level = max(0,min(mutation_level,100))
	nutrilevel =     max(0,min(nutrilevel,10))
	waterlevel =     max(0,min(waterlevel,100))
	pestlevel =      max(0,min(pestlevel,10))
	weedlevel =      max(0,min(weedlevel,10))
	toxins =         max(0,min(toxins,10))
	age_mod =        max(0,min(age_mod,AGE_MOD_MAX)) //CHOMPedit: age_mod sanity check

/obj/machinery/portable_atmospherics/hydroponics/proc/mutate_species()

	var/previous_plant = seed.display_name
	var/newseed = seed.get_mutant_variant()
	if(newseed in SSplants.seeds)
		seed = SSplants.seeds[newseed]
	else
		return

	dead = 0
	mutate(1)
	age = 0
	health = seed.get_trait(TRAIT_ENDURANCE)
	lastcycle = world.time
	harvest = 0
	weedlevel = 0

	update_icon()
	visible_message(span_danger("The " + span_notice("[previous_plant]") + " has suddenly mutated into " + span_notice("[seed.display_name]") + "!"))

	return

/obj/machinery/portable_atmospherics/hydroponics/attackby(var/obj/item/O as obj, var/mob/user as mob)

	if(O.is_open_container())
		return 0

	if(O.has_tool_quality(TOOL_WIRECUTTER) || istype(O, /obj/item/surgical/scalpel))

		if(!seed)
			to_chat(user, span_filter_notice("There is nothing to take a sample from in \the [src]."))
			return

		if(sampled)
			to_chat(user, span_filter_notice("You have already sampled from this plant."))
			return

		if(dead)
			to_chat(user, span_filter_notice("The plant is dead."))
			return

		// Create a sample.
		seed.harvest(user,yield_mod,1)
		health -= (rand(3,5)*10)

		if(prob(30))
			sampled = 1

		// Bookkeeping.
		check_health()
		force_update = 1
		process()

		return

	else if(istype(O, /obj/item/reagent_containers/syringe))

		var/obj/item/reagent_containers/syringe/S = O

		if (S.mode == 1)
			if(seed)
				return ..()
			else
				to_chat(user, span_filter_notice("There's no plant to inject."))
				return 1
		else
			if(seed)
				//Leaving this in in case we want to extract from plants later.
				to_chat(user, span_filter_notice("You can't get any extract out of this plant."))
			else
				to_chat(user, span_filter_notice("There's nothing to draw something from."))
			return 1

	else if (istype(O, /obj/item/seeds))

		if(!seed)

			var/obj/item/seeds/S = O
			user.remove_from_mob(O)

			if(!S.seed)
				to_chat(user, span_filter_notice("The packet seems to be empty. You throw it away."))
				qdel(O)
				return

			to_chat(user, span_filter_notice("You plant the [S.seed.seed_name] [S.seed.seed_noun]."))
			plant_seeds(S)

		else
			to_chat(user, span_danger("\The [src] already has seeds in it!"))

	else if (istype(O, /obj/item/material/minihoe))  // The minihoe

		if(weedlevel > 0)
			user.visible_message(span_danger("[user] starts uprooting the weeds."), span_danger("You remove the weeds from the [src]."))
			weedlevel = 0
			update_icon()
		else
			to_chat(user, span_danger("This plot is completely devoid of weeds. It doesn't need uprooting."))

	else if (istype(O, /obj/item/storage/bag/plants))

		attack_hand(user)

		var/obj/item/storage/bag/plants/S = O
		for (var/obj/item/reagent_containers/food/snacks/grown/G in locate(user.x,user.y,user.z))
			if(!S.can_be_inserted(G))
				return
			S.handle_item_insertion(G, 1)

	else if ( istype(O, /obj/item/plantspray) )

		var/obj/item/plantspray/spray = O
		user.remove_from_mob(O)
		toxins += spray.toxicity
		pestlevel -= spray.pest_kill_str
		weedlevel -= spray.weed_kill_str
		to_chat(user, span_filter_notice("You spray [src] with [O]."))
		playsound(src, 'sound/effects/spray3.ogg', 50, 1, -6)
		qdel(O)
		check_health()

	else if(mechanical && O.has_tool_quality(TOOL_WRENCH))

		//If there's a connector here, the portable_atmospherics setup can handle it.
		if(locate(/obj/machinery/atmospherics/portables_connector/) in loc)
			return ..()

		playsound(src, O.usesound, 50, 1)
		anchored = !anchored
		to_chat(user, span_filter_notice("You [anchored ? "wrench" : "unwrench"] \the [src]."))

	else if(istype(O,/obj/item/multitool))
		if(!anchored)
			to_chat(user, span_warning("Anchor it first!"))
			return
		if(frozen == -1)
			to_chat(user, span_warning("You see no way to use \the [O] on [src]."))
			return
		to_chat(user, span_notice("You [frozen ? "disable" : "enable"] the cryogenic freezing."))
		frozen = !frozen
		update_icon()
		return

	else if(O.force && seed)
		user.setClickCooldown(user.get_attack_speed(O))
		user.visible_message(span_danger("\The [seed.display_name] has been attacked by [user] with \the [O]!"))
		if(!dead)
			health -= O.force
			check_health()

	return

/obj/machinery/portable_atmospherics/hydroponics/attack_tk(mob/user)
	if(dead)
		remove_dead(user)
	else if(harvest)
		harvest(user)

/obj/machinery/portable_atmospherics/hydroponics/attack_hand(mob/user)

	if(istype(user,/mob/living/silicon))
		return
	if(frozen == 1)
		to_chat(user, span_warning("Disable the cryogenic freezing first!"))
	if(harvest)
		harvest(user)
	else if(dead)
		remove_dead(user)

/obj/machinery/portable_atmospherics/hydroponics/examine(mob/user)
	. = ..()

	if(seed)
		. += span_notice("[seed.display_name] are growing here.")
	else
		. += "It is empty."

	if(!Adjacent(user))
		return .

	. += "Water: [round(waterlevel,0.1)]/100"
	. += "Nutrient: [round(nutrilevel,0.1)]/10"

	if(seed)
		if(weedlevel >= 5)
			. += "It is " + span_danger("infested with weeds") + "!"
		if(pestlevel >= 5)
			. += "It is " + span_danger("infested with tiny worms") + "!"
		if(dead)
			. += "It has " + span_danger("a dead plant") + "!"
		else if(health <= (seed.get_trait(TRAIT_ENDURANCE)/ 2))
			. += "It has " + span_danger("an unhealthy plant") + "!"
	if(frozen == 1)
		. += span_notice("It is cryogenically frozen.")
	if(mechanical)
		var/turf/T = loc
		var/datum/gas_mixture/environment

		var/environment_type
		if(closed_system && (connected_port || holding) && air_contents)
			environment = air_contents
			environment_type = "connected"
		else
			if(istype(T))
				environment = T.return_air()
			if(!environment) //We're in a crate or nullspace, bail out.
				return
			environment_type = "surrounding"

		var/light_string
		if(closed_system && mechanical)
			light_string = "that the internal lights are set to [tray_light] lumens"
		else
			var/light_available = T.get_lumcount() * 5
			light_string = "a light level of [light_available] lumens"

		. += "The tray's sensor suite is reporting [light_string] and a temperature of [environment.temperature]K at [environment.return_pressure()] kPa in the [environment_type] environment."

/obj/machinery/portable_atmospherics/hydroponics/verb/close_lid_verb()
	set name = "Toggle Tray Lid"
	set category = "Object"
	set src in view(1)
	if(usr.incapacitated())
		return

	if(ishuman(usr) || isrobot(usr))
		close_lid(usr)
	return

/obj/machinery/portable_atmospherics/hydroponics/proc/close_lid(var/mob/living/user)
	closed_system = !closed_system
	to_chat(user, span_filter_notice("You [closed_system ? "close" : "open"] the tray's lid."))
	update_icon()

#undef AGE_MOD_MAX //CHOMPedit
