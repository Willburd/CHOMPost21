/obj/item/soap
	var/start_icon
	var/start_state

/obj/item/soap/Initialize(mapload)
	. = ..()
	start_icon = icon
	start_state = icon_state

/obj/item/soap/update_icon()
	cut_overlays()
	if(!bites)
		return
	// Create soap bite blending
	icon = 'icons/system/blank_32x32.dmi'
	icon_state = ""
	var/icon/soap_icon = icon(start_icon, start_state)
	var/icon/soap_bites = icon('modular_outpost/icons/obj/soap.dmi', "bite_[bites]")
	soap_icon.Blend(soap_bites,ICON_SUBTRACT)
	add_overlay(image(soap_icon))
