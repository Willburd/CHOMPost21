/image/client_only/haunting_sparkle
	plane = PLANE_FULLSCREEN
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = (RESET_COLOR|PIXEL_SCALE|KEEP_APART)

/image/client_only/haunting_sparkle/New(icon, loc, icon_state, layer, dir)
	. = ..()
	QDEL_IN(src, 1 SECONDS)
