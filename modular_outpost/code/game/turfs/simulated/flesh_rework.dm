////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FLOOR
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/turf/simulated/floor/flesh
	name = "flesh"
	desc = "This slick flesh ripples and squishes under your touch"
	icon_state = "flesh_floor"
	icon = 'modular_outpost/icons/turf/stomach.dmi'
	temperature = TERRAFORMER_BODY_TEMP
	initial_flooring = /datum/decl/flooring/flesh
	var/can_heal = FALSE // If this turf can transform back into a wall if part of the terraformer
	var/break_tile_to_plating = TRUE
	explosion_resistance = 1

/turf/simulated/floor/flesh/Initialize(mapload)
	. = ..()
	if(prob(30))
		// alt puddles
		flooring_override = pickweight(list("flesh_floor_puddle0","flesh_floor_puddle1","flesh_floor_puddle2","flesh_floor_puddle3"))
	update_icon()

/turf/simulated/floor/flesh/proc/heal_into_wall()
	wash(CLEAN_ALL)
	var/old_plating_state = break_tile_to_plating
	ChangeTurf(/turf/simulated/flesh, preserve_outdoors = TRUE)
	var/turf/simulated/flesh/new_wall = src
	playsound(new_wall, 'sound/effects/squelch1.ogg', 100, 1)
	flick("doorc1", new_wall)
	new_wall.update_icon(1)
	new_wall.check_underside_turf(old_plating_state)

/turf/simulated/floor/flesh/rcd_act(mob/living/user, obj/item/rcd/the_rcd, passed_mode)
	return

/turf/simulated/floor/flesh/ex_act(severity)
	if(severity == 1)
		destroy_meat()
	if(severity == 2 && prob(30))
		destroy_meat()
	if(severity == 3 && prob(7))
		destroy_meat()

/turf/simulated/floor/flesh/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(temperature < (T0C + 200))
		return
	if(prob(5)) // burninate
		destroy_meat()

/turf/simulated/floor/flesh/proc/destroy_meat()
	var/area/AR = get_area(src)
	if(istype(AR, /area/muriki/processor)) // In terraformer... not allowed
		return
	if(istype(AR?.base_turf,/turf/simulated/floor/flesh))
		return
	if(break_tile_to_plating)
		ChangeTurf(/turf/simulated/floor/plating, preserve_outdoors = TRUE)
		return
	ChangeTurf(AR.base_turf, preserve_outdoors = TRUE)

/turf/simulated/floor/flesh/attackby(obj/item/W, mob/user)
	if(..())
		return
	if(!is_sharp(W) && !is_hot(W))
		return
	// In terraformer... not allowed
	var/area/AR = get_area(src)
	if(istype(AR, /area/muriki/processor) || istype(AR, /area/specialty) || istype(AR?.base_turf,/turf/simulated/floor/flesh))
		to_chat(user, span_warning("The meat heals too quickly to dig it away!"))
		return
	// Cut it out
	visible_message("\the [user] begins to cut away the meat with \a [W]!")
	if(do_after(user, W.toolspeed * 6 SECONDS, target = src))
		visible_message("\the [user] tears the meat away!")
		destroy_meat()

/turf/simulated/floor/flesh/proc/check_underside_turf(old_plating_state)
	break_tile_to_plating = old_plating_state
	var/area/AR = get_area(src)
	if(!AR)
		return
	if(istype(AR, /area/muriki/processor) || istype(AR, /area/specialty) || (AR.base_turf in typesof(/turf/simulated/floor/flesh, /turf/simulated/floor/outdoors, /turf/simulated/mineral, /turf/simulated/floor/water)))
		break_tile_to_plating = FALSE // Use baseturfs instead
		return

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// WALL
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/turf/simulated/flesh
	name = "flesh wall"
	desc = "The fleshy surface of this wall squishes nicely under your touch but looks and feels extremly strong"
	icon = 'modular_outpost/icons/turf/stomach.dmi'
	icon_state = "flesh"
	opacity = 1
	density = TRUE
	blocks_air = 1
	var/health = 100
	explosion_resistance = 1
	var/break_tile_to_plating = TRUE

/turf/simulated/flesh/Initialize(mapload)
	. = ..()
	update_icon(1)

/turf/simulated/flesh/update_icon(var/update_neighbors)
	cut_overlays()
	icon = 'modular_outpost/icons/turf/stomach.dmi'
	icon_state = "flesh"
	for(var/direction in GLOB.cardinal)
		var/turf/T = get_step(src,direction)
		if(istype(T) && !T.density)
			var/place_dir = turn(direction, 180)
			var/offset = 32
			if(!GLOB.flesh_overlay_cache["flesh_side_[place_dir]"])
				GLOB.flesh_overlay_cache["flesh_side_[place_dir]"] = image('modular_outpost/icons/turf/stomach.dmi', "flesh_side", dir = place_dir)
				var/image/cache = null
				switch(direction)
					if(NORTH)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_y = offset
					if(SOUTH)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_y = -offset
					if(EAST)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_x = offset
					if(WEST)
						cache = GLOB.flesh_overlay_cache["flesh_side_[place_dir]"]
						cache.pixel_x = -offset
				// Outpost 21 edit end
			add_overlay(GLOB.flesh_overlay_cache["flesh_side_[place_dir]"])

	if(update_neighbors)
		adjacent_icon_update()

/turf/simulated/flesh/proc/adjacent_icon_update()
	for(var/direction in GLOB.alldirs)
		if(istype(get_step(src, direction), /turf/simulated/flesh))
			var/turf/simulated/flesh/F = get_step(src, direction)
			F.update_icon()

/turf/simulated/flesh/attackby(obj/item/W, mob/user)
	if(..())
		return
	if(!is_sharp(W) && !is_hot(W))
		return
	// Cut it out
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	user.do_attack_animation(src)
	playsound(src, 'sound/effects/meatslap.ogg', 90, 1)
	beat_the_meat(W.force)

/turf/simulated/flesh/rcd_act(mob/living/user, obj/item/rcd/the_rcd, passed_mode)
	return

/turf/simulated/flesh/bullet_act(obj/item/projectile/P, def_zone)
	. = ..()
	if(P.nodamage || P.taser_effect)
		return
	beat_the_meat(P.damage * 0.6)

/turf/simulated/flesh/ex_act(severity)
	if(severity == 1)
		beat_the_meat(120)
	if(severity == 2 && prob(60))
		beat_the_meat(rand(50,120))
	if(severity == 3 && prob(30))
		beat_the_meat(rand(10,50))

/turf/simulated/flesh/adjacent_fire_act(turf/simulated/floor/adj_turf, datum/gas_mixture/adj_air, adj_temp, adj_volume)
	if(adj_temp < (T0C + 200))
		return
	if(prob(15)) // burninate
		beat_the_meat(adj_temp / 10)

/turf/simulated/flesh/proc/beat_the_meat(damage)
	health -= damage
	if((health <= 0 && prob(20)) || (damage > 10 && prob(damage / 2)))
		new /obj/effect/gibspawner/small_gore(src)
	if(health > 0)
		return
	var/old_plating_state = break_tile_to_plating
	ChangeTurf(/turf/simulated/floor/flesh, preserve_outdoors = TRUE)
	var/turf/simulated/floor/flesh/new_meat = src
	SSterraformer.meat_broken(new_meat)
	check_underside_turf(old_plating_state)

/turf/simulated/flesh/proc/check_underside_turf(old_plating_state)
	break_tile_to_plating = old_plating_state
	var/area/AR = get_area(src)
	if(!AR)
		return
	if(istype(AR, /area/muriki/processor) || istype(AR, /area/specialty) || (AR.base_turf in typesof(/turf/simulated/floor/flesh, /turf/simulated/floor/outdoors, /turf/simulated/mineral, /turf/simulated/floor/water)))
		break_tile_to_plating = FALSE // Use baseturfs instead
		return

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// BONE BARRIERS
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/turf/simulated/flesh/indestructable
	name = "bone wall"
	desc = "Flesh filled with bones. They look very durable."
	icon_state = "bonewall"
	var/bone_iconstate = 1
	explosion_resistance = 100

/turf/simulated/flesh/indestructable/Initialize(mapload)
	. = ..()
	icon_state = /turf/simulated/flesh::icon_state
	bone_iconstate = pick(1,2,3)

/turf/simulated/flesh/indestructable/attackby(obj/item/W, mob/user)
	return

/turf/simulated/flesh/indestructable/ex_act(severity)
	return

/turf/simulated/flesh/indestructable/beat_the_meat(damage)
	return

/turf/simulated/flesh/indestructable/update_icon(var/update_neighbors)
	. = ..()
	var/image/bone_overlay = image('modular_outpost/icons/turf/stomach.dmi', "bone_[bone_iconstate]")
	add_overlay(bone_overlay)

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Arteries
////////////////////////////////////////////////////////////////////////////////////////////////////////////

GLOBAL_LIST_EMPTY(terraformer_arteries)

/turf/simulated/flesh/artery
	name = "artery"
	desc = "A large blood filled artery of a massive organism."
	var/junction_id = ""
	icon_state = "fleshartery"
	description_info = "It can be cut into with a sharp object, and repaired with bandages or something hot to cauterize it back together."
	var/heals_at_time // Prevent bleeding all shift once cut
	var/blockage = FALSE
	var/static/list/blockage_items = list(
		/obj/item/kinetic_crusher,
		/obj/item/material/twohanded/fireaxe,
		/obj/item/stack/material/plasteel,
		/obj/item/tank/oxygen,
		/obj/item/tank/phoron,
		/obj/item/clothing/head/helmet/space/syndicate,
		/obj/item/clothing/suit/space/syndicate,
		/obj/item/clothing/head/helmet/space/skrell,
		/obj/item/clothing/suit/space/skrell,
		/obj/item/mop/advanced,
		/obj/item/reagent_containers/glass/beaker/large,
		/obj/item/reagent_containers/glass/beaker/bluespace,
		/obj/item/bluespace_harpoon,
		/obj/item/tool/crowbar/brace_jack,
		/obj/item/clothing/glasses/graviton,
		/obj/item/perfect_tele,
		/obj/item/rig/robotics,
		/obj/item/rig/hazard,
		/obj/item/rig/industrial,
		/obj/item/inducer,
		/obj/item/rcd/advanced,
		/obj/item/stock_parts/capacitor/omni,
		/obj/item/stock_parts/manipulator/omni,
		/obj/item/stock_parts/micro_laser/omni,
		/obj/item/stock_parts/scanning_module/omni,
		/obj/item/stock_parts/subspace/amplifier,
		/obj/item/stock_parts/subspace/analyzer,
		/obj/item/stock_parts/subspace/ansible,
		/obj/item/smes_coil/super_capacity/hyper,
		/obj/item/smes_coil/super_io/hyper,
	)
	var/list/valid_treatments = list(
		/obj/item/stack/medical/crude_pack,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/stack/medical/advanced,
		/obj/item/surgical/cautery
	)

/turf/simulated/flesh/artery/Initialize(mapload)
	. = ..()
	icon_state = /turf/simulated/flesh::icon_state
	GLOB.terraformer_arteries += src
	junction_id = "JNC-[rand(1000,9999)]:[pick(list("A","B","D","M","L","R","W","X","P","LB","CL","RM"))]"

/turf/simulated/flesh/artery/Destroy()
	GLOB.terraformer_arteries -= src
	STOP_PROCESSING(SSobj, src)
	. = ..()

/turf/simulated/flesh/artery/examine(mob/user)
	. = ..()
	. += span_info("It is tattooed with \"[junction_id]\".")

/turf/simulated/flesh/artery/attackby(obj/item/W, mob/user)
	if(is_sharp(W) && density) // Cutting
		user.visible_message("\The [user] begins cutting into \the [src]!")
		if(do_after(user, W.toolspeed * 5 SECONDS, target = src))
			user.visible_message("\The [user] slices open \the [src]!")
			cut_open()
		return

	if((is_type_in_list(W,valid_treatments) || is_hot(W)) && !density) // Closing
		user.visible_message("\The [user] begins sealing \the [src]!")
		if(do_after(user, W.toolspeed * 5 SECONDS, target = src))
			user.visible_message("\The [user] seals up \the [src]!")
			seal_up()
		return

/turf/simulated/flesh/artery/ex_act(severity)
	if(severity == 1)
		cut_open()
		return
	if(severity == 2 && prob(10))
		cut_open()
		return

/turf/simulated/flesh/artery/beat_the_meat(damage)
	if(density && damage > 30 && prob(20))
		cut_open()

/turf/simulated/flesh/artery/update_icon(var/update_neighbors)
	. = ..()
	var/image/artery_overlay = image('modular_outpost/icons/turf/stomach.dmi', "artery_[density]") // TODO - future artery art types
	add_overlay(artery_overlay)

/turf/simulated/flesh/artery/proc/cause_blockage()
	if(!density)
		return
	blockage = TRUE
	addtimer(CALLBACK(src, PROC_REF(hemorage)), rand(30,60) MINUTES, TIMER_DELETE_ME)

/turf/simulated/flesh/artery/proc/hemorage()
	if(!density || !blockage) // Burst if we ignore treating this blockage
		return
	blockage = FALSE
	cut_open()
	SSterraformer.hemorage_triggered()

/turf/simulated/flesh/artery/proc/cut_open()
	if(!density)
		return
	density = FALSE
	update_icon()
	START_PROCESSING(SSobj, src)
	// Spawn blockage item now that we are cured
	if(blockage)
		blockage = FALSE
		var/path_spawn = pick(blockage_items)
		new path_spawn(src)
		addtimer(CALLBACK(src, PROC_REF(blockage_cleared_alert)), rand(30,35) SECONDS, TIMER_DELETE_ME)
	heals_at_time = world.time + rand(40,60) SECONDS
	gore_pump()

/turf/simulated/flesh/artery/proc/seal_up()
	if(density)
		return
	wash(CLEAN_ALL)
	density = TRUE
	update_icon()
	STOP_PROCESSING(SSobj, src)
	heals_at_time = 0

// Bleeding mode
/turf/simulated/flesh/artery/process()
	gore_pump()
	if(world.time > heals_at_time)
		seal_up()

/turf/simulated/flesh/artery/proc/gore_pump()
	playsound(src, 'sound/effects/squelch1.ogg', 100, 1)
	new /obj/effect/gibspawner/small_gore(src)

/turf/simulated/flesh/artery/proc/blockage_cleared_alert()
	var/str = "Flow corrected in junction \"[junction_id]\" the blockage has been cleared."
	if(!density)
		str += " Flow rate is low, was the junction left open?"
		SSterraformer.hemorage_triggered() // If they want to be lazy then so be it

	GLOB.global_announcer.autosay(str, "Terraformer System Monitor", CHANNEL_COMMAND)
	GLOB.global_announcer.autosay(str, "Terraformer System Monitor", CHANNEL_MEDICAL)
	GLOB.global_announcer.autosay(str, "Terraformer System Monitor", CHANNEL_ENGINEERING)
