/obj/effect/overmap/visitable/ship/landable/trawler
	name = "Mining Trawler"
	desc = "A hefty beast for making the station rich. Supposedly in compliance."
	vessel_mass = 3500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Mining Trawler"
	known = TRUE // we own this lol

/obj/machinery/computer/shuttle_control/explore/trawler
	name = "short jump console"
	shuttle_tag = "Mining Trawler"
	req_one_access = list(access_mining)


/obj/effect/overmap/visitable/ship/landable/medical
	name = "Medical Rescue"
	desc = "A modified search and rescue spacecraft. No man left behind."
	vessel_mass = 2500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Medical Rescue"
	known = TRUE // we own this lol

/obj/machinery/computer/shuttle_control/explore/medical
	name = "short jump console"
	shuttle_tag = "Medical Rescue"
	req_one_access = list(access_medical)


/obj/effect/overmap/visitable/ship/landable/security
	name = "Security Carrier"
	desc = "A modified search and \"rescue\" spacecraft. No one can hide."
	vessel_mass = 2500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Security Carrier"
	known = TRUE // we own this lol

/obj/machinery/computer/shuttle_control/explore/security
	name = "short jump console"
	shuttle_tag = "Security Carrier"
	req_one_access = list(access_security)
