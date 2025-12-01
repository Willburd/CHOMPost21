#define CUSTOM_BORGSPRITE(x) "Custom - " + (x)

// All whitelisted dogborg sprites go here.

/datum/robot_sprite/fluff
	is_whitelisted = TRUE

// A

// D

/datum/robot_sprite/fluff/darklord92
	name = CUSTOM_BORGSPRITE("Tangent")
	module_type = "Standard"

	sprite_icon = 'modular_outpost/icons/mob/robot/fluff_wide.dmi'
	sprite_icon_state = "darklord92-tangent"
	sprite_hud_icon_state = "k9"

	has_eye_light_sprites = TRUE
	has_vore_belly_sprites = FALSE
	has_rest_sprites = TRUE
	rest_sprite_options = list("Default")
	has_dead_sprite = TRUE
	has_dead_sprite_overlay = TRUE
	pixel_x = -16
	icon_x = 64
	icon_y = 32

	whitelist_ckey = "darklord92"
	whitelist_charname = "Tangent"

/datum/robot_sprite/fluff/darklord92/hauler
	name = CUSTOM_BORGSPRITE("T-Hauler")
	module_type = "Miner"
	sprite_icon_state = "darklord92-hauler"
	whitelist_charname = "Tangent"

// J

/datum/robot_sprite/fluff/jademanique
	name = CUSTOM_BORGSPRITE("B.A.U-Kingside")
	module_type = "Security"

	sprite_icon = 'icons/mob/robot/fluff_wide.dmi'
	sprite_icon_state = "jademanique-kingside"
	sprite_hud_icon_state = "k9"

	has_eye_light_sprites = TRUE
	has_vore_belly_sprites = TRUE
	has_rest_sprites = TRUE
	rest_sprite_options = list("Default", "Sit", "Bellyup")
	has_dead_sprite = TRUE
	has_dead_sprite_overlay = TRUE
	pixel_x = -16
	icon_x = 64
	icon_y = 32

	whitelist_ckey = "jademanique"
	whitelist_charname = "B.A.U-Kingside"

// L

/// S

/// T

#undef CUSTOM_BORGSPRITE
