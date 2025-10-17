/obj/structure/window/maintenance_panel
	name = "maintenance panel"
	desc = "A maintenance panel. It covers important things hidden inside the wall."
	description_info = "Can be cut through or repaired with a welder. Can be deconstructed with a wrench once detached."
	icon = 'modular_outpost/icons/obj/maintenance_panel.dmi'
	icon_state = "panel"
	basestate = "panel"
	maxhealth = 350
	glasstype = /obj/item/stack/tile/maintenance_panel
	maximal_heat = /datum/material/steel::melting_point
	force_threshold = 7
	shardtype = null
	opacity = 1 // Difficult to see past

/obj/structure/window/maintenance_panel/apply_silicate(var/amount)
	return // can't fix it like that

/obj/structure/window/maintenance_panel/updateSilicate()
	silicate = 0
	return // can't fix it like that

/obj/structure/window/maintenance_panel/attack_ghost(mob/observer/dead/user as mob)
	return // Too powerful for ghosts

/obj/structure/window/maintenance_panel/is_fulltile()
	return FALSE // NEVER

/obj/structure/window/maintenance_panel/attackby(obj/item/W, mob/user)
	if(W.has_tool_quality(TOOL_SCREWDRIVER))
		return // Cannot be screwed down
	if(istype(W, /obj/item/stack/cable_coil))
		return // Cannot be electrochromed
	if(W.has_tool_quality(TOOL_WELDER) && (user.a_intent != I_HELP || health == maxhealth)) // If at max health or not on help
		var/obj/item/weldingtool/WT = W.get_welder()
		if(WT.remove_fuel(1 ,user))
			to_chat(user, span_warning("You begin to [!anchored ? "weld" : "cut"] the [src] [!anchored ? "to" : "off"] the wall."))
			playsound(src, W.usesound, 75, 1)
			if(do_after(user, 2 SECONDS, target = src))
				anchored = !anchored
				update_nearby_tiles(need_rebuild=1)
				update_nearby_icons()
				update_verbs()
				to_chat(user, span_info("You [anchored ? "weld" : "cut"] the [src] [anchored ? "to" : "off"] the wall."))
		return
	. = ..()


/obj/structure/window/maintenance_panel/take_damage(var/damage = 0,  var/sound_effect = 1)
	var/initialhealth = health
	health = max(0, health - damage)
	if(health <= 0)
		shatter()
		return

	if(sound_effect)
		playsound(src, 'sound/effects/Glasshit.ogg', 100, 1)
	if(health < maxhealth / 4 && initialhealth >= maxhealth / 4)
		visible_message("\the [src] is about to break free!" )
		update_icon()
	else if(health < maxhealth / 2 && initialhealth >= maxhealth / 2)
		visible_message("\the [src] looks seriously damaged!" )
		update_icon()
	else if(health < maxhealth * 3/4 && initialhealth >= maxhealth * 3/4)
		visible_message("\the [src] looks like it's taking damage!" )
		update_icon()

/obj/structure/window/maintenance_panel/shatter(var/display_message = 1)
	playsound(src, pick(list('sound/effects/metalscrape1.ogg','sound/effects/metalscrape2.ogg','sound/effects/metalscrape3.ogg')), 70, 1)
	if(display_message)
		visible_message("\the [src] thunks free of the wall!")
	new glasstype(loc)
	qdel(src)

/obj/structure/window/maintenance_panel/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature <= maximal_heat)
		return
	var/burndamage = log(RAND_F(0.9, 1.1) * (exposed_temperature - maximal_heat))
	if(burndamage)
		take_damage(burndamage)

/obj/structure/window/maintenance_panel/examine(mob/user)
	. = ..()
	if(!anchored)
		. += span_warning("It's hanging freely, and hasn't been welded in place!")

// Maintenance panel sheets
/obj/item/stack/tile/maintenance_panel
	name = "maintenance panel"
	desc = "A maintenance panel"
	icon_state = "techtile_grid"
	force = 6.0
	matter = list(DEFAULT_WALL_MATERIAL = SHEET_MATERIAL_AMOUNT / 4)
	throwforce = 15.0
	throw_speed = 5
	throw_range = 20
	can_weld = TRUE

/obj/item/stack/tile/maintenance_panel/attack_self(var/mob/user)
	var/turf/T = user.loc
	if(!user || (loc != user && !isrobot(user)) || user.stat || user.loc != T)
		return 0

	if(!user.IsAdvancedToolUser())
		to_chat(user, span_warning("This task is too complex for your clumsy hands."))
		return 1

	// Get data for building windows here.
	var/list/possible_directions = GLOB.cardinal.Copy()
	var/window_count = 0
	for (var/obj/structure/window/check_window in user.loc)
		window_count++
		possible_directions  -= check_window.dir
	for (var/obj/structure/windoor_assembly/check_assembly in user.loc)
		window_count++
		possible_directions -= check_assembly.dir
	for (var/obj/machinery/door/window/check_windoor in user.loc)
		window_count++
		possible_directions -= check_windoor.dir

	// Get the closest available dir to the user's current facing.
	var/build_dir = SOUTHWEST //Default to southwest for fulltile windows.
	var/failed_to_build
	if(window_count >= 4)
		failed_to_build = 1
	else
		if(possible_directions.len)
			for(var/direction in list(user.dir, turn(user.dir,90), turn(user.dir,270), turn(user.dir,180)))
				if(direction in possible_directions)
					build_dir = direction
					break
		else
			failed_to_build = 1
	if(failed_to_build)
		to_chat(user, span_warning("There is no room in this location."))
		return 1

	var/sheets_needed = 1
	if(get_amount() < sheets_needed)
		to_chat(user, span_warning("You need at least [sheets_needed] sheets to build this."))
		return 1
	if(build_dir == SOUTHWEST)
		to_chat(user, span_warning("A maintenance panel cannot be built like that!"))
		return 1

	// Build the structure and update sheet count etc.
	use(sheets_needed)
	new /obj/structure/window/maintenance_panel(T, build_dir, 1)
	return 1

// Spawner
/obj/fiftyspawner/maintenance_panel
	name = "stack of maintenance panels"
	type_to_spawn = /obj/item/stack/tile/maintenance_panel
