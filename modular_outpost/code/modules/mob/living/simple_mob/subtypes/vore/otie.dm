// Gives oties an ID card to use on doors, so they don't destroy security if you walk too fast.
/mob/living/simple_mob/vore/otie/security
	var/obj/item/card/id/idcard

/mob/living/simple_mob/vore/otie/security/New()
	. = ..()
	idcard = new /obj/item/card/id/security(src)
	idcard.access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks) // Minimal access officer
	idcard.age = 0
	idcard.registered_name	= name
	idcard.sex 				= capitalize(gender)

/mob/living/simple_mob/vore/otie/security/GetIdCard()
	// Only use ID card if actually following a friend! Should limit some abuse...
	if(stat == CONSCIOUS && friend)
		return idcard
	return null
