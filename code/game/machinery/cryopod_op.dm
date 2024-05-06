
/obj/machinery/cryopod/robot/door/dorms/outpost
	name = "Residential District Elevator"
	desc = "A small elevator that goes down to the deeper section of the colony."
	icon = 'icons/obj/Cryogenic2_op.dmi'
	icon_state = "lift_closed"
	base_icon_state = "lift_closed"
	occupied_icon_state = "lift_open"
	on_store_message = "has departed for the residential district."
	on_store_name = "Residential Oversight"
	on_enter_occupant_message = "The elevator door closes slowly, ready to bring you down to the residential district."
	on_store_visible_message_1 = "makes a ding as it moves"
	on_store_visible_message_2 = "to the residential district."

	time_till_despawn = 60 //1 second, lets make this fast
