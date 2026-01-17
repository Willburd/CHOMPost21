/datum/job
	var/rank_pin = /obj/item/clothing/accessory/rank_eshui
/datum/alt_title
	var/rank_pin = null // Override for above
/datum/job/stowaway
	rank_pin = null // no rank

// Lowest rank, no duty
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui
/datum/job/offduty_cargo
	rank_pin = RANK_PIN_PATH
/datum/job/offduty_civilian
	rank_pin = RANK_PIN_PATH
/datum/job/offduty_engineering
	rank_pin = RANK_PIN_PATH
/datum/job/offduty_exploration
	rank_pin = RANK_PIN_PATH
/datum/job/offduty_medical
	rank_pin = RANK_PIN_PATH
/datum/job/offduty_science
	rank_pin = RANK_PIN_PATH
/datum/job/offduty_security
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// No rank
#define RANK_PIN_PATH 0
/datum/alt_title/visitor
	rank_pin = RANK_PIN_PATH
/datum/alt_title/outpost_resident
	rank_pin = RANK_PIN_PATH
/datum/alt_title/spacer
	rank_pin = RANK_PIN_PATH
/datum/job/entrepreneur
	rank_pin = RANK_PIN_PATH
/datum/job/entertainer
	rank_pin = RANK_PIN_PATH
/datum/alt_title/engineering_contractor
	rank_pin = RANK_PIN_PATH
/datum/alt_title/medical_contractor
	rank_pin = RANK_PIN_PATH
/datum/alt_title/security_contractor
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enlisted 1
////////////////////////////////////////////////////////////////////////////////////////////////////////
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui
/datum/job/assistant
	rank_pin = RANK_PIN_PATH
/datum/job/intern
	rank_pin = RANK_PIN_PATH
/datum/job/janitor
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 2
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted2
/datum/job/librarian
	rank_pin = RANK_PIN_PATH
/datum/job/chef
	rank_pin = RANK_PIN_PATH
/datum/job/hydro
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 3
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted3
/datum/job/cargo_tech
	rank_pin = RANK_PIN_PATH
/datum/job/mining
	rank_pin = RANK_PIN_PATH
/datum/job/bartender
	rank_pin = RANK_PIN_PATH
/datum/alt_title/electrician
	rank_pin = RANK_PIN_PATH
/datum/alt_title/salvage_tech
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 4
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted4
/datum/job/scientist
	rank_pin = RANK_PIN_PATH
/datum/alt_title/orderly
	rank_pin = RANK_PIN_PATH
/datum/alt_title/chem_tech
	rank_pin = RANK_PIN_PATH
/datum/alt_title/maint_tech
	rank_pin = RANK_PIN_PATH
/datum/alt_title/computer_tech
	rank_pin = RANK_PIN_PATH
/datum/alt_title/ship_breaker
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 5
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted5
/datum/job/engineer
	rank_pin = RANK_PIN_PATH
/datum/alt_title/junior_brigphys
	rank_pin = RANK_PIN_PATH
/datum/alt_title/nurse
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH

// Cadet
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/cadet
/datum/alt_title/co_petty_officer
	rank_pin = RANK_PIN_PATH
/datum/alt_title/co_cadet
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 6
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted6
/datum/alt_title/junior_officer
	rank_pin = RANK_PIN_PATH
/datum/alt_title/medical_practitioner
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 7
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted7
/datum/job/officer
	rank_pin = RANK_PIN_PATH
/datum/job/brigphysician
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 8
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted8
/datum/job/doctor
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Enlisted 9
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/enlisted9
/datum/job/warden
	rank_pin = RANK_PIN_PATH
/datum/job/emergency_responder
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


////////////////////////////////////////////////////////////////////////////////////////////////////////
// Warrent 1
////////////////////////////////////////////////////////////////////////////////////////////////////////
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/warrant1
/datum/job/geneticist
	rank_pin = RANK_PIN_PATH
/datum/job/chemist
	rank_pin = RANK_PIN_PATH
/datum/job/xenobiologist
	rank_pin = RANK_PIN_PATH
/datum/job/xenobotanist
	rank_pin = RANK_PIN_PATH
/datum/alt_title/xenoarch
	rank_pin = RANK_PIN_PATH
/datum/alt_title/xenoanthropologist
	rank_pin = RANK_PIN_PATH
/datum/alt_title/anomalist
	rank_pin = RANK_PIN_PATH
/datum/alt_title/engine_tech
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Warrant 2
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/warrant2
/datum/alt_title/phoron_research
	rank_pin = RANK_PIN_PATH
/datum/alt_title/gas_physicist
	rank_pin = RANK_PIN_PATH
/datum/job/roboticist
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Warrant 3
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/warrant3
/datum/alt_title/detective
	rank_pin = RANK_PIN_PATH
/datum/alt_title/investigator
	rank_pin = RANK_PIN_PATH
/datum/alt_title/forensic_tech
	rank_pin = RANK_PIN_PATH
/datum/alt_title/virologist
	rank_pin = RANK_PIN_PATH
/datum/job/atmos
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Warrent 4
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/warrant4
/datum/alt_title/xenoanatomyspecialist
	rank_pin = RANK_PIN_PATH
/datum/alt_title/surgeon
	rank_pin = RANK_PIN_PATH
/datum/job/psychiatrist
	rank_pin = RANK_PIN_PATH
/datum/job/paramedic
	rank_pin = RANK_PIN_PATH
/datum/job/chaplain
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Warrent 5
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/warrant5
/datum/job/lawyer
	rank_pin = RANK_PIN_PATH
/datum/alt_title/co_warrant_officer
	rank_pin = RANK_PIN_PATH
/datum/job/hop
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


////////////////////////////////////////////////////////////////////////////////////////////////////////
// Officer 1
////////////////////////////////////////////////////////////////////////////////////////////////////////
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/commissioned1
/datum/job/command_officer
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Officer 2
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/commissioned2
/datum/job/qm
	rank_pin = RANK_PIN_PATH
/datum/job/rd
	rank_pin = RANK_PIN_PATH
/datum/job/cmo
	rank_pin = RANK_PIN_PATH
/datum/job/chief_engineer
	rank_pin = RANK_PIN_PATH
/datum/job/hos
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Officer 3
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/commissioned3
/datum/job/captain
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH


// Officer 4
#define RANK_PIN_PATH /obj/item/clothing/accessory/rank_eshui/commissioned4
/datum/job/centcom_officer
	rank_pin = RANK_PIN_PATH
#undef RANK_PIN_PATH
