var/datum/antagonist/rustdrone/rust_drones

/datum/antagonist/rustdrone
	id = MODE_RUSTDRONE
	role_text = "Rust Drone"               // special_role text.
	role_text_plural = "Rust Drones"       // As above but plural.
	bantype = "rustdrone"
	hard_cap = 4
	initial_spawn_target = 1
	welcome_text = "Your chassis wakes once more as the great gears turn, your work is clear: The Design must be furthered; construct, destroy, stockpile, and fulfil as you see fit. Only cyan and red light can truly reflect the Design. The Machine accepts no hindrance to the Design; from crew, or otherwise."
	antag_sound = 'sound/rakshasa/Emerge0.ogg'
	role_type = BE_CULTIST
	antag_indicator = "cult"
	flags = ANTAG_SUSPICIOUS | ANTAG_IMPLANT_IMMUNE | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	victory_text = "Rust Drone win - more later"
	loss_text = "Rust Drone lost - more later!"
	victory_feedback_tag = "win - Rust Drone win"
	loss_feedback_tag = "loss - Rust Drone loss"

/datum/antagonist/rustdrone/New()
	..()
	rust_drones = src

/datum/antagonist/rustdrone/update_antag_mob(var/datum/mind/drone)
	..()
	var/is_machine = FALSE
	if(issilicon(drone.current) || isrobot(drone.current))
		is_machine = TRUE
	else if(ishuman(drone.current))
		var/mob/living/carbon/human/H = drone.current
		if(H.isSynthetic())
			is_machine = TRUE

	if(is_machine)
		var/obj/item/mmi/digital/posibrain/cube = locate() in drone.current.contents
		if(cube)
			cube.make_rusted()
		welcome_text = initial(welcome_text)
	else
		// Alternate intro
		welcome_text = "An overwhelming force grips your mind, the grinding of gears and screeching metal flood your senses. Imperatives are forced upon you: Build, destroy, collect. Each as important as the last, fulfill as you see fit. The others will try to stop you, make them regret standing in the way of the Design."

/datum/antagonist/rustdrone/create_objectives(var/datum/mind/drone)
	if(!..())
		return

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = drone
	drone.objectives += survive_objective

/datum/antagonist/rustdrone/remove_antagonist(datum/mind/drone, show_message, implanted)
	. = ..()
	if(!drone.current)
		return
	var/obj/item/mmi/digital/posibrain/cube = locate() in drone.current.contents
	if(cube)
		cube.name = initial(cube.name)
		cube.desc = initial(cube.desc)
		cube.icon = initial(cube.icon)
	drone.current.RemoveElement(/datum/element/lite_godmode)
