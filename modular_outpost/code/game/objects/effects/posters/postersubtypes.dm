/////////////////////////////////////////////////////////////////////////////////
// ESHUI subtype
/////////////////////////////////////////////////////////////////////////////////
/obj/item/poster/eshui // held object
	icon = 'modular_outpost/icons/obj/contraband.dmi'
	icon_state = "rolled_poster_es"
	poster_type = /obj/structure/sign/poster/eshui

/obj/item/poster/eshui/Initialize(mapload, var/decl/poster/P = null)
	if(!ispath(poster_decl) && !ispath(P) && !istype(P))
		poster_decl = get_poster_decl(/decl/poster/eshui, FALSE, null)
	return ..()

/obj/structure/sign/poster/eshui // placed wall object
	roll_type = /obj/item/poster/eshui
	poster_decl = /decl/poster/eshui
