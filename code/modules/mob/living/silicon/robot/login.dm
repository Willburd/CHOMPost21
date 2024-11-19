/mob/living/silicon/robot/Login()
	..()
	regenerate_icons()
	update_hud()

	show_laws(0)

	// Override the DreamSeeker macro with the borg version!
	client.set_hotkeys_macro("borgmacro", "borghotkeymode")

	repick_laws()

	// Forces synths to select an icon relevant to their module
	// pick_module() // Outpost 21 edit - Don't do this on login or tgui breaks on laggy servers

	plane_holder.set_vis(VIS_AUGMENTED, TRUE)
