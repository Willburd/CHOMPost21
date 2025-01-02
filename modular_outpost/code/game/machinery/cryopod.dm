/obj/machinery/cryopod
	// The corresponding spawn point type that user despawning here will return at next round.
	// Note: We use a type instead of name so that its validity is checked at compile time.
	var/spawnpoint_type = /datum/spawnpoint/cryo

/obj/machinery/cryopod/robot/door/dorms/outpost
	name = "Residential District Elevator"
	desc = "A small elevator that goes down to a deeper section of the colony."
	icon = 'modular_outpost/icons/obj/Cryogenic2.dmi'
	icon_state = "lift_closed"
	base_icon_state = "lift_closed"
	occupied_icon_state = "lift_open"
	on_store_message = "has departed for the residential district."
	on_store_name = "Residential Oversight"
	on_enter_occupant_message = "The elevator door closes slowly, ready to bring you down to the residential district."
	on_store_visible_message_1 = "makes a ding as it moves"
	on_store_visible_message_2 = "to the residential district."

	spawnpoint_type = /datum/spawnpoint/elevator // Custom for outpost

	time_till_despawn = 60 //1 second, lets make this fast

/obj/machinery/cryopod/proc/log_special_item(var/atom/movable/item,var/mob/to_despawn)
	ASSERT(item && to_despawn)

	var/loaded_from_key
	var/char_name = to_despawn.name
	var/item_name = item.name

	// Best effort key aquisition
	if(ishuman(to_despawn))
		var/mob/living/carbon/human/H = to_despawn
		if(H.original_player)
			loaded_from_key = H.original_player

	if(!loaded_from_key && to_despawn.mind && to_despawn.mind.loaded_from_ckey)
		loaded_from_key = to_despawn.mind.loaded_from_ckey

	else
		loaded_from_key = "INVALID"

	// Log to harrass them later
	log_game("CRYO [loaded_from_key]/([to_despawn.name]) cryo'd with [item_name] ([item.type])")
	qdel(item)

	if(control_computer && control_computer.allow_items)
		control_computer.frozen_items += "[item_name] ([char_name])"
