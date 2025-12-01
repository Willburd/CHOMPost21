//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TRACKING IMPLANT PAD
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/data/pda/app/prisoner_manager
	name = "Prisoner Locator"
	icon = "compass"
	template = "pda_prisoner_implant"
	category = "Security"

/datum/data/pda/app/prisoner_manager/update_ui(mob/user as mob, list/data)
	var/list/secData = list()

	var/list/implantData = list()
	for(var/obj/item/implant/tracking/B in GLOB.all_tracking_implants)
		if(!B.implanted)
			continue
		var/turf/bl = get_turf(B)
		if(bl)
			var/area/A = get_area(bl)
			if(B.malfunction)
				implantData[++implantData.len] = list("host" = B.imp_in, "x" = rand(1,300), "y" = rand(1,300), "z" = rand(1,300), "area" = "Unknown")
				continue
			if(!(bl.z in using_map.station_levels) || istype(bl, /turf/space))
				implantData[++implantData.len] = list("host" = B.imp_in, "x" = "?", "y" = "?", "z" = "?", "area" = "Unknown")
				continue
			implantData[++implantData.len] = list("host" = B.imp_in, "x" = bl.x, "y" = bl.y, "z" = bl.z, "area" = A.name)

	secData["prisoner_implants"] = implantData.len ? implantData : null
	data["security"] = secData



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TESH PETTER
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
GLOBAL_LIST_EMPTY(pda_teshpet_scores)
/datum/data/pda/app/tesh_pet
	name = "Tesh Petter"
	icon = "heart"
	template = "pda_tesh_pet"
	category = "Clown"

/datum/data/pda/app/tesh_pet/update_ui(mob/user as mob, list/data)
	var/list/petData = list()
	petData["scores"] = GLOB.pda_teshpet_scores.Copy()
	data["teshpet_data"] = petData

/datum/data/pda/app/tesh_pet/tgui_act(action, params, ui, state)
	if(..())
		return TRUE

	var/obj/item/card/id/ID = pda.id
	if(!ID?.registered_name)
		return FALSE
	var/found_name = ID.registered_name

	switch(action)
		if("Pet")
			GLOB.pda_teshpet_scores[found_name] += 1
		if("Kill")
			GLOB.pda_teshpet_scores[found_name] = 0

	return TRUE
