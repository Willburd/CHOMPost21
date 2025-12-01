/datum/data/pda/app/uav_control
	name = "UAV control"
	icon = "quidditch"
	template = "pda_uav"
	category = "Utilities"

	var/datum/weakref/our_uav = null
	var/adhoc_range = 50 //How far we can operate
	var/signal_test_counter = 0 //How long until next signal strength check
	var/signal_strength = 0 //Our last signal strength report (cached for a few seconds)
	var/list/viewers //Who's viewing a UAV through us

/datum/data/pda/app/uav_control/update_ui(mob/user as mob, list/data)
	var/list/uav_data = list()
	uav_data["current_uav"] = null
	var/obj/item/uav/linked_uav = our_uav?.resolve()
	if(linked_uav)
		if(QDELETED(linked_uav))
			to_chat(user,span_danger("The screen cuts out as it loses connection."))
			clear_current()
		else if(signal_test_counter-- <= 0)
			signal_strength = get_signal_to(linked_uav)
			if(!signal_strength)
				to_chat(user,span_warning("The screen freezes for a moment as it loses connection."))
				clear_current()
			else // Don't reset counter until we find a UAV that's actually in range we can stay connected to
				signal_test_counter = 20

		uav_data["current_uav"] = list("status" = linked_uav.get_status_string(), "power" = linked_uav.state == 1 ? 1 : null)
	uav_data["signal_strength"] = signal_strength ? signal_strength >= 2 ? "High" : "Low" : "None"
	uav_data["in_use"] = viewing_uav(user)

	data["uav_data"] = uav_data

/datum/data/pda/app/uav_control/proc/viewing_uav(mob/user)
	return (WEAKREF(user) in viewers)

/datum/data/pda/app/uav_control/proc/clear_current()
	if(!our_uav?.resolve())
		return
	signal_strength = 0
	our_uav = null
	SEND_SIGNAL(src,COMSIG_REMOTE_VIEW_CLEAR)

/datum/data/pda/app/uav_control/proc/get_signal_to(atom/movable/AM)
	if(get_z(tgui_host()) in using_map.get_map_levels(get_z(AM), FALSE))
		if(get_dist(tgui_host(), AM) < adhoc_range) // strong range
			return 2
		if(get_dist(tgui_host(), AM) < adhoc_range + 10) // weak range
			return 1
	return 0 // nope

/datum/data/pda/app/uav_control/look(mob/user)
	var/obj/item/uav/linked_uav = our_uav?.resolve()
	if(issilicon(user)) //Too complicated for me to want to mess with at the moment
		to_chat(user, span_warning("Regulations prevent you from controlling several corporeal forms at the same time!"))
		return
	if(!linked_uav)
		return
	linked_uav.add_master(user)

/datum/data/pda/app/uav_control/unlook(mob/user)
	var/obj/item/uav/linked_uav = our_uav?.resolve()
	if(linked_uav)
		linked_uav.remove_master(user)

/datum/data/pda/app/uav_control/stop()
	SEND_SIGNAL(src,COMSIG_REMOTE_VIEW_CLEAR)

/datum/data/pda/app/uav_control/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	var/obj/item/uav/linked_uav = our_uav?.resolve()
	switch(action)

		if("view_uav")
			if(!linked_uav)
				return FALSE

			if(!linked_uav.state)
				to_chat(ui.user,span_warning("The screen freezes for a moment, before returning to the UAV selection menu. It's not able to connect to that UAV."))
			else
				if(get_dist(ui.user, tgui_host()) > 1 || ui.user.blinded || !pda || !(pda in ui.user.contents))
					return FALSE
				else if(!viewing_uav(ui.user))
					if(!viewers) viewers = list() // List must exist for pass by reference to work
					start_coordinated_remoteview(ui.user, linked_uav, viewers, /datum/remote_view_config/uav_control_pda)
				else
					SEND_SIGNAL(src,COMSIG_REMOTE_VIEW_CLEAR)
			return TRUE

		if("power_uav")
			if(!linked_uav)
				return FALSE
			else if(linked_uav.toggle_power())
				SEND_SIGNAL(src,COMSIG_REMOTE_VIEW_CLEAR)
				return TRUE

	return FALSE

////
////  Settings for remote view
////
/datum/remote_view_config/uav_control_pda
	relay_movement = TRUE
	override_health_hud = TRUE
	var/original_health_hud_icon

/datum/remote_view_config/uav_control_pda/handle_relay_movement( datum/component/remote_view/owner_component, mob/host_mob, direction)
	var/datum/data/pda/app/uav_control/tgui_owner = owner_component.get_coordinator()
	var/obj/item/uav/linked_uav = tgui_owner.our_uav?.resolve()
	if(linked_uav)
		return linked_uav.relaymove(host_mob, direction, tgui_owner.signal_strength)
	return FALSE

/datum/remote_view_config/uav_control_pda/handle_apply_visuals( datum/component/remote_view/owner_component, mob/host_mob)
	var/datum/data/pda/app/uav_control/tgui_owner = owner_component.get_coordinator()
	if(!tgui_owner)
		return
	var/obj/item/uav/linked_uav = tgui_owner.our_uav?.resolve()
	if(get_dist(host_mob, tgui_owner.tgui_host()) > 1 || !linked_uav || !tgui_owner.pda || !(tgui_owner.pda in host_mob.contents))
		host_mob.reset_perspective()
		return
	// Apply hud
	host_mob.overlay_fullscreen("fishbed",/atom/movable/screen/fullscreen/fishbed)
	host_mob.overlay_fullscreen("scanlines",/atom/movable/screen/fullscreen/scanline)
	if(tgui_owner.signal_strength <= 1)
		host_mob.overlay_fullscreen("whitenoise",/atom/movable/screen/fullscreen/noise)
	else
		host_mob.clear_fullscreen("whitenoise", 0)

/datum/remote_view_config/uav_control_pda/handle_remove_visuals( datum/component/remote_view/owner_component, mob/host_mob)
	// Clear hud
	host_mob.clear_fullscreen("fishbed",0)
	host_mob.clear_fullscreen("scanlines",0)
	host_mob.clear_fullscreen("whitenoise",0)

// We are responsible for restoring the health UI's icons on removal
/datum/remote_view_config/uav_control_pda/attached_to_mob( datum/component/remote_view/owner_component, mob/host_mob)
	original_health_hud_icon = host_mob.healths?.icon

/datum/remote_view_config/uav_control_pda/detatch_from_mob( datum/component/remote_view/owner_component, mob/host_mob)
	if(host_mob.healths && original_health_hud_icon)
		host_mob.healths.icon = original_health_hud_icon
		host_mob.healths.appearance = null

// Show the uav health instead of the mob's while it is viewing
/datum/remote_view_config/uav_control_pda/handle_hud_health( datum/component/remote_view/owner_component, mob/host_mob)
	var/datum/data/pda/app/uav_control/tgui_owner = owner_component.get_coordinator()

	var/mutable_appearance/MA = new (host_mob.healths)
	MA.icon = 'icons/mob/screen1_robot_minimalist.dmi'
	MA.cut_overlays()

	var/obj/item/uav/linked_uav = tgui_owner.our_uav?.resolve()
	if(!linked_uav)
		MA.icon_state = "health7"
	else
		switch(linked_uav.health)
			if(100 to INFINITY)
				MA.icon_state = "health0"
			if(80 to 100)
				MA.icon_state = "health1"
			if(60 to 80)
				MA.icon_state = "health2"
			if(40 to 60)
				MA.icon_state = "health3"
			if(20 to 40)
				MA.icon_state = "health4"
			if(0 to 20)
				MA.icon_state = "health5"
			else
				MA.icon_state = "health6"

	host_mob.healths.icon_state = "blank"
	host_mob.healths.appearance = MA
	return COMSIG_COMPONENT_HANDLED_HEALTH_ICON
