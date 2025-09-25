/obj/structure/window/maint_panel
	name = "maintenance panel"
	desc = "A maintenance panel. It covers important things hidden inside the wall."
	icon = 'modular_outpost/icons/obj/maintenance_panel.dmi'
	icon_state = "window"
	basestate = "window"
	maxhealth = 60
	glasstype = /obj/item/stack/material/steel
	maximal_heat = 1800 // steel
	force_threshold = 7
	shardtype = null

/obj/structure/window/maint_panel/apply_silicate(var/amount)
	return // can't fix it like that

/obj/structure/window/maint_panel/updateSilicate()
	silicate = 0
	return // can't fix it like that

/obj/structure/window/maint_panel/attack_ghost(mob/observer/dead/user as mob)
	return // Too powerful for ghosts

/obj/structure/window/maint_panel/is_fulltile()
	return FALSE // NEVER

/obj/structure/window/maint_panel/take_damage(var/damage = 0,  var/sound_effect = 1)
	var/initialhealth = health
	health = max(0, health - damage)
	if(health <= 0)
		shatter()
		return

	if(sound_effect)
		playsound(src, 'sound/effects/Glasshit.ogg', 100, 1)
	if(health < maxhealth / 4 && initialhealth >= maxhealth / 4)
		visible_message("\the [src] looks like it's taking damage!" )
		update_icon()
	else if(health < maxhealth / 2 && initialhealth >= maxhealth / 2)
		visible_message("\the [src] looks seriously damaged!" )
		update_icon()
	else if(health < maxhealth * 3/4 && initialhealth >= maxhealth * 3/4)
		visible_message("\the [src] is about to break free!" )
		update_icon()

/obj/structure/window/maint_panel/shatter(var/display_message = 1)
	playsound(src, 'sound/effects/metalscrape3.ogg', 70, 1)
	if(display_message)
		visible_message("\the [src] thunks free of the wall!")
	new glasstype(loc)
	qdel(src)



/datum/material/steel
	created_window = /obj/structure/window/maint_panel
	window_options = list("One Direction" = 1)

// Construction
/datum/material/steel/build_windows(var/mob/living/user, var/obj/item/stack/used_stack)
	if(!user || !used_stack || !created_window)
		return 0

	if(!user.IsAdvancedToolUser())
		to_chat(user, span_warning("This task is too complex for your clumsy hands."))
		return 1

	var/turf/T = user.loc
	if(!istype(T))
		to_chat(user, span_warning("You must be standing on open flooring to build a maintenance panel."))
		return 1

	if(!used_stack || !user || (used_stack.loc != user && !isrobot(user)) || user.stat || user.loc != T)
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

	if(used_stack.get_amount() < sheets_needed)
		to_chat(user, span_warning("You need at least [sheets_needed] sheets to build this."))
		return 1
	if(build_dir == SOUTHWEST)
		to_chat(user, span_warning("A maintenance panel cannot be built like that!"))
		return 1

	// Build the structure and update sheet count etc.
	used_stack.use(sheets_needed)
	new created_window(T, build_dir, 1)
	return 1
