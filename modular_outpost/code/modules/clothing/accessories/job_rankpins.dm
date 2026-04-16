#define RANK_ENLISTED 1
#define RANK_NCO 2
#define RANK_CADET 3
#define RANK_BORG 4
#define RANK_WARRANT 5
#define RANK_AI 6
#define RANK_OFFICER 7
#define RANK_HEAD 8
#define RANK_CAPTAIN 9
#define RANK_CENTRAL 10
#define RANK_DRONE 11

/// Enlisted
/obj/item/clothing/accessory/rank_eshui
	name = "\improper (E-1) Recruit patch"
	var/rank = "(E-1) Recruit"
	var/rank_level_index = RANK_ENLISTED // Tutorial text index
	desc = "A small strip of cloth denoting the rank of E-1, recruit. Some of the lowest ranks on station, but outranking any civilian."
	icon = 'modular_outpost/icons/inventory/accessory/item.dmi'
	icon_state = "rank_e1"
	slot = ACCESSORY_SLOT_RANK
	drop_sound = 'sound/items/drop/accessory.ogg'
	pickup_sound = 'sound/items/pickup/accessory.ogg'

/obj/item/clothing/accessory/rank_eshui/examine(mob/user)
	. = ..()
	. += station_rank_guide(rank_level_index)

/obj/item/clothing/accessory/rank_eshui/enlisted2
	name = "\improper (E-2) Private patch"
	rank = "(E-2) Private"
	desc = "A small strip of cloth denoting the rank of E-2, Private. Trusted with slightly more authority, but still novices."
	icon_state = "rank_e2"

/obj/item/clothing/accessory/rank_eshui/enlisted3
	name = "\improper (E-3) Private First Class patch"
	rank = "(E-3) Private First Class"
	desc = "A small strip of cloth denoting the rank of E-3, Private First Class. Seen as the start of actual responsibility, where the station relies on their performance."
	icon_state = "rank_e3"

/obj/item/clothing/accessory/rank_eshui/enlisted4
	name = "\improper (E-4) Corporal patch"
	rank = "(E-4) Corporal"
	desc = "A small strip of cloth denoting the rank of E-4, Corporal. The highest non NCO-rank, trusted with oversight of most minor station operations."
	icon_state = "rank_e4"

/obj/item/clothing/accessory/rank_eshui/enlisted5
	name = "\improper (E-5) Sergeant patch"
	rank = "(E-5) Sergeant"
	desc = "A small strip of cloth denoting the rank of E-5, Sergeant. The beginning of the NCO ranks. Trusted with general authority and specialized performance."
	icon_state = "rank_e5"
	rank_level_index = RANK_NCO

/obj/item/clothing/accessory/rank_eshui/enlisted6
	name = "\improper (E-6) Staff Sergeant patch"
	rank = "(E-6) Staff Sergeant"
	desc = "A small strip of cloth denoting the rank of E-6, Staff Sergeant. Trusted over the majority of crew to run station operations."
	icon_state = "rank_e6"
	rank_level_index = RANK_NCO

/obj/item/clothing/accessory/rank_eshui/enlisted7
	name = "\improper (E-7) Sergeant First Class patch"
	rank = "(E-7) Sergeant First Class"
	desc = "A small strip of cloth denoting the rank of E-7, Sergeant First Class. Those tasked to uphold station values and security."
	icon_state = "rank_e7"
	rank_level_index = RANK_NCO

/obj/item/clothing/accessory/rank_eshui/enlisted8
	name = "\improper (E-8) Master Sergeant patch"
	rank = "(E-8) Master Sergeant"
	desc = "A small strip of cloth denoting the rank of E-8, Master Sergeant. Nearly the highest of all enlisted crewmen."
	icon_state = "rank_e8"
	rank_level_index = RANK_NCO

/obj/item/clothing/accessory/rank_eshui/enlisted9
	name = "\improper (E-9) Sergeant Major patch"
	rank = "(E-9) Sergeant Major"
	desc = "A small strip of cloth denoting the rank of E-9, Sergeant Major. The highest enlisted rank one can achieve, trusted to uphold the station in nearly every situation."
	icon_state = "rank_e9"
	rank_level_index = RANK_NCO

// Warrant officers
/obj/item/clothing/accessory/rank_eshui/warrant1 // Hyper specialists
	name = "\improper (WO-1) Petty Warrant Officer patch"
	rank = "(WO-1) Petty Warrant Officer"
	desc = "A small strip of cloth denoting the rank of WO-1, Petty Warrant Officer. Specialists in their trade, expected to have a deep and thorough understanding of their specialty."
	icon_state = "rank_wo1"
	rank_level_index = RANK_WARRANT

/obj/item/clothing/accessory/rank_eshui/warrant2
	name = "\improper (WO-2) Warrant Officer patch"
	rank = "(WO-2) Warrant Officer"
	desc = "A small strip of cloth denoting the rank of WO-2, Warrant Officer. Specialists of hazardous situations, they're expected to have a deep understanding and respect for their field."
	icon_state = "rank_wo2"
	rank_level_index = RANK_WARRANT

/obj/item/clothing/accessory/rank_eshui/warrant3
	name = "\improper (WO-3) Senior Warrant Officer patch"
	rank = "(WO-3) Senior Warrant Officer"
	desc = "A small strip of cloth denoting the rank of WO-3, Senior Warrant Officer. Incredibly specialized individuals, whos knowledge and expertise of their field shouldn't be understated."
	icon_state = "rank_wo3"
	rank_level_index = RANK_WARRANT

/obj/item/clothing/accessory/rank_eshui/warrant4
	name = "\improper (WO-4) Master Warrant Officer patch"
	rank = "(WO-4) Master Warrant Officer"
	desc = "A small strip of cloth denoting the rank of WO-4, Master Warrant Officer. Those that demonstrate extreme specialty in their field, trusted with authority of the station in extreme situations."
	icon_state = "rank_wo4"
	rank_level_index = RANK_WARRANT

/obj/item/clothing/accessory/rank_eshui/warrant5
	name = "\improper (WO-5) Chief Warrant Officer patch"
	rank = "(WO-5) Chief Warrant Officer"
	desc = "A small strip of cloth denoting the rank of WO-5, Chief Warrant Officer. The bridge between Central Command, and the station. They respond to the Major, and are masters of station SOP and Law."
	icon_state = "rank_wo5"
	rank_level_index = RANK_WARRANT

// Commissioned
/obj/item/clothing/accessory/rank_eshui/cadet // Problems in training.
	name = "\improper (E-5) Cadet patch"
	rank = "(E-5) Cadet"
	desc = "A small strip of cloth denoting the rank of E-5, Cadet. While technically an officer position, they are in training and learning how to utilize their trusted authority."
	icon_state = "rank_cadot"
	rank_level_index = RANK_CADET

/obj/item/clothing/accessory/rank_eshui/commissioned1 // Forever lost.
	name = "\improper (O-1) Second Lieutenant patch"
	rank = "(O-1) Second Lieutenant"
	desc = "A small strip of cloth denoting the rank of O-1, Second Lieutenant. Those aspiring to be heads of staff, and officially trusted with the rank of authority, just don't ask them for directions."
	icon_state = "rank_o1"
	rank_level_index = RANK_OFFICER

/obj/item/clothing/accessory/rank_eshui/commissioned2 // Department head
	name = "\improper (O-2) First Lieutenant patch"
	rank = "(O-2) First Lieutenant"
	desc = "A small strip of cloth denoting the rank of O-2, First Lieutenant. Those trusted with near ultimate authority over their departments and station operations, they oversee the station in every situation."
	icon_state = "rank_o2"
	rank_level_index = RANK_HEAD

/obj/item/clothing/accessory/rank_eshui/commissioned3 // Facility Head
	name = "\improper (O-3) Captain patch"
	rank = "(O-3) Captain"
	desc = "A small strip of cloth denoting the rank of O-3, Captain. The highest rank in normal station operation, trusted above all to maintain order and discipline on station, even if that's largely oversight."
	icon_state = "rank_o3"
	rank_level_index = RANK_CAPTAIN

// Event/admemes
/obj/item/clothing/accessory/rank_eshui/commissioned4 // Centcom officer
	name = "\improper (O-4) Major patch"
	rank = "(O-4) Major"
	desc = "A small strip of cloth denoting the rank of O-4, Major. Officers above that of Captain, overseeing Central's will to the station."
	icon_state = "rank_o4"
	rank_level_index = RANK_CENTRAL

/obj/item/clothing/accessory/rank_eshui/commissioned5 // Planet head
	name = "\improper (O-5) Commander patch"
	rank = "(O-5) Commander"
	desc = "A small strip of cloth denoting the rank of O-5, Commander. The individual trusted with responsibility of all planetary facilities and operations."
	icon_state = "rank_o5"
	rank_level_index = RANK_CENTRAL

/obj/item/clothing/accessory/rank_eshui/commissioned6 // Sector Head
	name = "\improper (O-6) Colonel patch"
	rank = "(O-6) Colonel"
	desc = "A small strip of cloth denoting the rank of O-6, Colonel. An individual trusted with oversight of the entire sector, encompassing countless planets and facilities... hope you don't see this often."
	icon_state = "rank_o6"
	rank_level_index = RANK_CENTRAL

/obj/item/clothing/accessory/rank_eshui/commissioned7 // Fleet head
	name = "\improper (O-7) Vice Admiral patch"
	rank = "(O-7) Vice Admiral"
	desc = "A small strip of cloth denoting the rank of O-7, Vice admiral. The individual put in charge of an entire fleet of warships, while not directly in control of facilities, their warships often make their point clear."
	icon_state = "rank_o7"
	rank_level_index = RANK_CENTRAL

/obj/item/clothing/accessory/rank_eshui/commissioned8 // Director of Military Operations
	name = "\improper (O-8) Admiral patch"
	rank = "(O-8) Admiral"
	desc = "A small strip of cloth denoting the rank of O-8, Admiral. The highest rank outside of SolGov military, in charge of every military operation within E-Shui PMC Operations, directly sitting on the board of directors, and communicating with SolGov military."
	icon_state = "rank_o8"
	rank_level_index = RANK_CENTRAL

/obj/item/clothing/accessory/rank_eshui/drone
	name = "\improper (E-0) Station Drone"
	rank = "(E-0) Drone"
	desc = "A small strip of cloth denoting the rank of E-0, Technical Enlisted. This rank is specific to station bound drones, and has no authority."
	icon_state = "rank_drots"
	rank_level_index = RANK_DRONE

/obj/item/clothing/accessory/rank_eshui/borg
	name = "\improper (WO-0) Station Synthetic"
	rank = "(WO-0) Station Synthetic"
	desc = "A small strip of cloth denoting the rank of WO-0, Technical Warrant Officer. Specialists in their trade, expected to have a deep and thorough understanding of their specialty. This rank is specific to station bound synthetics."
	icon_state = "rank_rodot"
	rank_level_index = RANK_BORG

/obj/item/clothing/accessory/rank_eshui/ai
	name = "\improper (WO-5) Station AI"
	desc = "A small strip of cloth denoting the rank of WO-5, Chief Warrant Officer. The bridge between Central Command, and the station. They respond to the Major, and are masters of station SOP and Law. This specific one is for a station bound AI core."
	rank = "(WO-5) Station AI"
	icon_state = "rank_wo5"
	rank_level_index = RANK_AI

// Rank tutorial
/proc/station_rank_guide(rank_index)
	switch(rank_index)
		if(RANK_ENLISTED)
			return "As a lower enlisted rank you have meager authority on station with low responsibility. You are expected to perform the labor entailed of your job, and not much more."

		if(RANK_NCO)
			return "As an upper enlisted rank (known as a non-commisioned officer) you have basic authority to issue orders, and are responsible for station wide operations expected of your job. You are responsible for the safety and well being of multiple other crewmembers and company assets."

		if(RANK_BORG)
			return "As a station synthetic you are considered warrant officer-0. As a warrant officer you are considered the rank of officer-1 in matters of your specific module's field, in matters outside your module's field you are considered enlisted-5. All crew of O-1 or WO-1 rank or above have authority over you regardless of your module's field. You are authorized to deny crew of lesser rank from accessing secure areas or tools, unless they are otherwise authorized to do so. If your laws are found to be incorrect your rank will be disregarded until they are corrected."

		if(RANK_WARRANT)
			return "As a warrant officer you are expected to have a deep understanding of your job's specific field, and be capable of providing critical advice to command staff and other crew pretaining to it. You are considered officer-1 rank in matters of your field, but outside of it you are considered the rank of enlisted-5. Warrant officers have the technical knowledge and experience to know when even officers above them are making a poor decision, and communicate with central if required."

		if(RANK_AI)
			return "As a station AI you are considered warrant officer-5 with specialization in station operation, law and procedure. While you must still respond to crew orders, an AI may deny access to secure locations or tools without authorization, and make judgements for crew safety as according to rank and SOP. If your laws are found to not be the company's expected laws your rank will be disregarded until they are corrected."

		if(RANK_CADET)
			return "As a jr officer you are expected to learn coordination skills, and to deligate your authority to crew beneath your rank. In matters of rank, you are considered enlisted-5, but may request the responsibility and authority from any officer-1 staff or greater to dictate orders using their authority. Authority may be requested from central in cases where a officer-1 rank or above is not present on staff for an extended period or in emergencies."

		if(RANK_OFFICER)
			return "As a lower officer you are expected to have authority and responsibility over large sections of the station and its crew. While you are not designated to an exact station department. You have the authority and the expected knowledge to manage crew and dictate effective orders during standard and emergency situations. You are expected to coordinate with warrant officers about critical station matters, and assist relevant department heads."

		if(RANK_HEAD)
			return "As an upper officer you are expected to have the authority and responsibility of an entire station department; It's crew, assets, and all related success and failure are your own. Unless a captain or higher rank is present, your authority is considered absolute. While you are expected to follow the advice of warrant officers, you may overrule them at your own peril."

		if(RANK_CAPTAIN)
			return "As a captain your authority and responsibility for the station and it's crew is absolute in almost all situations. You are expected to deligate your authority over all lower ranking staff, and rarely perform department tasks yourself when deligation is not possible. You are expected to follow the advice of warrant officers, but you may overrule them at your own peril."

		if(RANK_CENTRAL)
			return "As a central command officer your authority extends beyond a single facility, and may encompass entire planets or beyond. Any rank above captain is rare to encounter, and even more terrifying to end up in a meeting with."

		if(RANK_DRONE)
			return "As a drone you have no authority. You are incapable of critical thought, and must perform your laws and designated task as designed."

	return ""


/// Get all jobs with a specific rank badge
/proc/station_rank_job_list(rank_path)
	var/list/ranked_job_list = list()

	for(var/datum/job/jb in SSjob.occupations)
		var/base_job_rank = jb.rank_pin
		if(base_job_rank && base_job_rank == rank_path)
			ranked_job_list += jb.title

		if(jb.alt_titles)
			for(var/atitle in jb.alt_titles)
				var/datum/alt_title/alt = jb.alt_titles[atitle]
				if(initial(alt.title) == "GENERIC ALT TITLE") // TEMP
					stack_trace("Alt title datum does not exist is is misconfigured: [atitle] > [alt]")
					continue

				if(initial(alt.rank_pin))
					if(initial(alt.rank_pin) == rank_path)
						ranked_job_list += initial(alt.title)

				else if(base_job_rank && base_job_rank == rank_path)
					ranked_job_list += initial(alt.title)

	if(!length(ranked_job_list))
		return "This rank is not playable."

	return english_list(ranked_job_list)


#undef RANK_ENLISTED
#undef RANK_NCO
#undef RANK_CADET
#undef RANK_BORG
#undef RANK_WARRANT
#undef RANK_AI
#undef RANK_OFFICER
#undef RANK_HEAD
#undef RANK_CAPTAIN
#undef RANK_CENTRAL
#undef RANK_DRONE
