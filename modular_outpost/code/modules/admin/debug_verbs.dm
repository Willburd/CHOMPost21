ADMIN_VERB(lock_weather, R_EVENT, "Lock Weather", "Locks or unlocks the current weather from proceeding to the next forcast.", ADMIN_CATEGORY_EVENTS)
	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to toggle the weather lock on?", "Toggle Lock Weather", SSplanets.planets)
	if(istype(planet))
		planet.weather_holder.locked = !planet.weather_holder.locked
		to_chat(usr, span_vdanger("The weather on [planet] is now [planet.weather_holder.locked ? "LOCKED" : "unlocked"], the weather is currently [planet.weather_holder.current_weather]."))

ADMIN_VERB(lock_planet_light, R_EVENT, "Lock Planet Lightlevel", "Locks a planet to a specific light level and color.", ADMIN_CATEGORY_EVENTS)
	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to toggle the weather lock on?", "Toggle Lock Weather", SSplanets.planets)
	if(istype(planet))
		if(!isnull(planet.locked_light_color))
			planet.locked_light_intensity = 0
			planet.locked_light_color = null
			planet.update_sun()
			to_chat(usr, span_vdanger("The light on [planet] is now unlocked."))
			return
		var/new_color = tgui_color_picker(usr, "New light color.", "Light Color")
		var/new_intensity = tgui_input_number(usr, "The new light intensity.", "Light Intensity", 1, 1, 0)
		if(!new_color)
			return
		planet.locked_light_color = new_color
		planet.locked_light_intensity = new_intensity
		planet.update_sun()

ADMIN_VERB(change_weather_temp, R_EVENT, "Change Weather Temperature", "Sets the temperature of the current weather.", ADMIN_CATEGORY_EVENTS)
	var/datum/planet/planet = tgui_input_list(usr, "Which planet do you want to change the temperature on?", "Change Weather Temperature", SSplanets.planets)
	var/set_temp = tgui_input_number(usr,"The new temperature in kelvin.", "New Temperature", 215, 999999, 1)
	if(set_temp && istype(planet))
		planet.weather_holder.temperature = max(1,set_temp)
		SSplanets.updateTemp(planet)

ADMIN_VERB(door_access_debug, R_DEBUG, "Debug All Door Access", "Reveals ALL door accesses for quick identification of problems. DANGER SLOW AND CANNOT BE UNDONE!", ADMIN_CATEGORY_DEBUG_INVESTIGATE)
	for(var/obj/machinery/door/airlock/A in world)
		create_access_overlay_view_object(get_turf(A), A, usr)

	for(var/obj/machinery/door/window/brigdoor/A in world)
		create_access_overlay_view_object(get_turf(A), A, usr)

/proc/create_access_overlay_view_object(turf/root_turf, obj/thing, mob/user)
	var/image/client_only/door_info = new('icons/system/blank_32x32.dmi', root_turf, "", OBFUSCATION_LAYER, SOUTH)
	door_info.place_from_root(root_turf)
	door_info.append_client(user.client)
	door_info.plane = PLANE_PLAYER_HUD
	door_info.layer = CRIT_LAYER

	var/offset = 0
	var/image/img
	if(length(thing.req_one_access))
		img = image(icon = 'modular_outpost/icons/effects/access_debug.dmi', icon_state = "start", pixel_y = offset)
		door_info.add_overlay(img)
		offset -= 7

		for(var/entry in thing.req_one_access)
			img = image(icon = 'modular_outpost/icons/effects/access_debug.dmi', icon_state = "[entry]", pixel_y = offset)
			door_info.add_overlay(img)
			offset -= 7

	if(length(thing.req_access))
		img = image(icon = 'modular_outpost/icons/effects/access_debug.dmi', icon_state = "divider", pixel_y = offset)
		door_info.add_overlay(img)
		offset -= 7

		for(var/entry in thing.req_access)
			img = image(icon = 'modular_outpost/icons/effects/access_debug.dmi', icon_state = "[entry]", pixel_y = offset)
			door_info.add_overlay(img)
			offset -= 7
