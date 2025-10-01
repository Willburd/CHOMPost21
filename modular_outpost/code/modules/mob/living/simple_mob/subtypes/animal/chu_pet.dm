/mob/living/simple_mob/vore/alienanimals/chu/chips
	name = "chips"
	real_name = "chips"
	desc = "Xenobiology's unfortunate research test subject and \"pet\"..."
	tt_desc = "Chitter"
	player_msg = "You sure feel happy today!"

	faction = FACTION_STATION
	glow_color = "#d9d023"

	maxHealth = 110
	health = 110

	vore_bump_chance = 2
	vore_default_mode = DM_HOLD
	vore_active = TRUE
	vore_standing_too = FALSE
	vore_pounce_chance = 0

	say_list_type = /datum/say_list/chu/pet
	ai_holder_type = /datum/ai_holder/simple_mob/passive

	isOriginal = FALSE
	overlay_colors = list(
		"Body" = "#d4c3a7",
		"Eyes" = "#3bbdf0",
		"Blood" = "#e1960c"
	)

/mob/living/simple_mob/vore/alienanimals/chu/chips/update_icon()
	. = ..()
	var/mutable_appearance/I = mutable_appearance(icon, "[icon_state]-petbow")
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	add_overlay(I)

/datum/say_list/chu/pet
	speak = list("giggle","hiss","hiss","hiss","twitches","friend...","ehehe...","feldam...","hiss...")
