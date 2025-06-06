/*****
medals
*****/
/obj/item/clothing/accessory/medal/solgov/iron/star
	name = "iron star medal"
	desc = "An iron star awarded to members of the SCG for meritorious achievement or service in a combat zone."
	icon_state = "iron_star"

/obj/item/clothing/accessory/medal/solgov/iron/sol
	name = "\improper Sol expeditionary medal"
	desc = "An iron medal awarded to members of the SCG for service outside of the borders of the Sol Central Government."
	icon_state = "iron_sol"

/obj/item/clothing/accessory/medal/solgov/bronze/heart
	name = "bronze heart medal"
	desc = "A bronze heart awarded to members of the SCG for injury or death in the line of duty."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/solgov/bronze/sol
	name = "\improper Sol defensive operations medal"
	desc = "A bronze medal awarded for members of the SCG for service defending the border regions."
	icon_state = "bronze_sol"

/obj/item/clothing/accessory/medal/solgov/silver/sword
	name = "combat action medal"
	desc = "A silver medal awarded to members of the SCG for honorable service while under enemy fire."
	icon_state = "silver_sword"

/obj/item/clothing/accessory/medal/solgov/silver/sol
	name = "\improper Sol valor medal"
	desc = "A silver medal awarded for members of the SCG for acts of exceptional valor."
	icon_state = "silver_sol"

/obj/item/clothing/accessory/medal/solgov/gold/star
	name = "gold star medal"
	desc = "A gold star awarded to members of the SCG for acts of heroism in a combat zone."
	icon_state = "gold_star"

/obj/item/clothing/accessory/medal/solgov/gold/sun
	name = "solar service medal"
	desc = "A gold medal awarded to members of the SCG by the Secretary General for significant contributions to the Sol Central Government."
	icon_state = "gold_sun"

/obj/item/clothing/accessory/medal/solgov/gold/crest
	name = "solar honor medal"
	desc = "A gold medal awarded to members of the Defense Forces by the Secretary General for personal acts of valor and heroism above and beyond the call of duty."
	icon_state = "gold_crest"

/obj/item/clothing/accessory/medal/solgov/gold/sol
	name = "\improper Sol sapientarian medal"
	desc = "A gold medal awarded for members of the SCG for significant contributions to sapient rights."
	icon_state = "gold_sol"

/obj/item/clothing/accessory/medal/solgov/heart
	name = "medical medal"
	desc = "A white heart emblazoned with a red cross awarded to members of the SCG for service as a medical professional in a combat zone."
	icon_state = "white_heart"

/obj/item/clothing/accessory/solgov/torch_patch
	name = "\improper Torch mission patch"
	desc = "A fire resistant shoulder patch, worn by the personnel involved in the Torch Project."
	icon_state = "torchpatch"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_INSIGNIA

/obj/item/clothing/accessory/solgov/ec_patch
	name = "\improper Observatory patch"
	desc = "A laminated shoulder patch, carrying the symbol of the Sol Central Government Expeditionary Corpss Observatory, or SCGEO for short, the eyes and ears of the Expeditionary Corps' missions."
	icon_state = "ecpatch1"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_INSIGNIA

/obj/item/clothing/accessory/solgov/ec_patch/fieldops
	name = "\improper Field Operations patch"
	desc = "A radiation-shielded shoulder patch, carrying the symbol of the Sol Central Government Expeditionary Corps Field Operations, or SCGECFO for short, the hands-on workers of every Expeditionary Corps mission."
	icon_state = "ecpatch2"

/obj/item/clothing/accessory/solgov/cultex_patch
	name = "\improper Cultural Exchange patch"
	desc = "A radiation-shielded shoulder patch, denoting service in the the Sol Central Government Expeditionary Corps Cultural Exchange program."
	icon_state = "ecpatch3"
	slot = ACCESSORY_SLOT_INSIGNIA

/obj/item/clothing/accessory/solgov/fleet_patch
	name = "\improper First Fleet patch"
	desc = "A fancy shoulder patch carrying insignia of First Fleet, the Sol Guard, stationed in Sol."
	icon_state = "fleetpatch1"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_INSIGNIA

/obj/item/clothing/accessory/solgov/fleet_patch/second
	name = "\improper Second Fleet patch"
	desc = "A well-worn shoulder patch carrying insignia of Second Fleet, the Home Guard, tasked with defense of Sol territories."
	icon_state = "fleetpatch2"

/obj/item/clothing/accessory/solgov/fleet_patch/third
	name = "\improper Third Fleet patch"
	desc = "A scuffed shoulder patch carrying insignia of Third Fleet, the Border Guard, guarding borders of Sol territory against Vox and pirates."
	icon_state = "fleetpatch3"

/obj/item/clothing/accessory/solgov/fleet_patch/fourth
	name = "\improper Fourth Fleet patch"
	desc = "A pristine shoulder patch carrying insignia of Fourth Fleet, stationed on Skrell border."
	icon_state = "fleetpatch4"

/obj/item/clothing/accessory/solgov/fleet_patch/fifth
	name = "\improper Fifth Fleet patch"
	desc = "A tactical shoulder patch carrying insignia of Fifth Fleet, the Quick Reaction Force, recently formed and outfited with last tech."
	icon_state = "fleetpatch5"

/******
ribbons
******/
/obj/item/clothing/accessory/ribbon/solgov
	name = "ribbon"
	desc = "A simple military decoration."
	icon_state = "ribbon_marksman"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_MEDAL
	w_class = ITEMSIZE_TINY

/obj/item/clothing/accessory/ribbon/solgov/marksman
	name = "marksmanship ribbon"
	desc = "A military decoration awarded to members of the SCG for good marksmanship scores in training. Common in the days of energy weapons."
	icon_state = "ribbon_marksman"

/obj/item/clothing/accessory/ribbon/solgov/peace
	name = "peacekeeping ribbon"
	desc = "A military decoration awarded to members of the SCG for service during a peacekeeping operation."
	icon_state = "ribbon_peace"

/obj/item/clothing/accessory/ribbon/solgov/frontier
	name = "frontier ribbon"
	desc = "A military decoration awarded to members of the SCG for service along the frontier."
	icon_state = "ribbon_frontier"

/obj/item/clothing/accessory/ribbon/solgov/instructor
	name = "instructor ribbon"
	desc = "A military decoration awarded to members of the SCG for service as an instructor."
	icon_state = "ribbon_instructor"

/*************
specialty pins
*************/
/* //Lost to time.
/obj/item/clothing/accessory/solgov/specialty
	name = "speciality blaze"
	desc = "A color blaze denoting fleet personnel in some special role. This one is silver."
	icon_state = "marinerank_command"
	slot = ACCESSORY_SLOT_INSIGNIA
*/
/obj/item/clothing/accessory/solgov/specialty/janitor
	name = "custodial blazes"
	desc = "Purple blazes denoting a custodial technician."
	icon_state = "fleetspec_janitor"

/obj/item/clothing/accessory/solgov/specialty/brig
	name = "brig blazes"
	desc = "Red blazes denoting a brig officer."
	icon_state = "fleetspec_brig"

/obj/item/clothing/accessory/solgov/specialty/forensic
	name = "forensics blazes"
	desc = "Steel blazes denoting a forensic technician."
	icon_state = "fleetspec_forensic"

/obj/item/clothing/accessory/solgov/specialty/atmos
	name = "atmospherics blazes"
	desc = "Turquoise blazes denoting an atmospheric technician."
	icon_state = "fleetspec_atmos"

/obj/item/clothing/accessory/solgov/specialty/counselor
	name = "counselor blazes"
	desc = "Blue blazes denoting a counselor."
	icon_state = "fleetspec_counselor"

/obj/item/clothing/accessory/solgov/specialty/chemist
	name = "chemistry blazes"
	desc = "Orange blazes denoting a chemist."
	icon_state = "fleetspec_chemist"

/obj/item/clothing/accessory/solgov/specialty/enlisted
	name = "enlisted qualification pin"
	desc = "An iron pin denoting some special qualification."
	icon_state = "fleetpin_enlisted"

/obj/item/clothing/accessory/solgov/specialty/officer
	name = "officer's qualification pin"
	desc = "A golden pin denoting some special qualification."
	icon_state = "fleetpin_officer"

/obj/item/clothing/accessory/solgov/specialty/pilot
	name = "pilot's qualification pin"
	desc = "An iron pin denoting the qualification to fly SCG spacecraft."
	icon_state = "pin_pilot"

/*****
badges
*****/
/obj/item/clothing/accessory/badge/solgov/security
	name = "security forces badge"
	desc = "A silver law enforcement badge. Stamped with the words 'Master at Arms'."
	icon_state = "silverbadge"
	slot_flags = SLOT_TIE
	badge_string = "Sol Central Government"

/obj/item/clothing/accessory/badge/solgov/tags
	name = "dog tags"
	desc = "Plain identification tags made from a durable metal. They are stamped with a variety of informational details."
	gender = PLURAL
	icon_state = "tags"
	badge_string = "Sol Central Government"
	slot_flags = SLOT_MASK | SLOT_TIE

/obj/item/clothing/accessory/badge/solgov/tags/Initialize(mapload)
	. = ..()
	var/mob/living/carbon/human/H
	H = get_holder_of_type(src, /mob/living/carbon/human)
	if(H)
		set_name(H.real_name)
		set_desc(H)

/obj/item/clothing/accessory/badge/solgov/tags/set_desc(var/mob/living/carbon/human/H)
	if(!istype(H))
		return
	var/religion = "Unset"
	desc = "[initial(desc)]\nName: [H.real_name] ([H.get_species()])\nReligion: [religion]\nBlood type: [H.dna ? H.dna.b_type : DEFAULT_BLOOD_TYPE]"

/obj/item/clothing/accessory/badge/solgov/representative
	name = "representative's badge"
	desc = "A leather-backed plastic badge with a variety of information printed on it. Belongs to a representative of the Sol Central Government."
	icon_state = "solbadge"
	slot_flags = SLOT_TIE
	badge_string = "Sol Central Government"

/*******
armbands
*******/
/obj/item/clothing/accessory/armband/solgov/mp
	name = "military police brassard"
	desc = "An armlet, worn by the crew to display which department they're assigned to. This one is black with 'MP' in white."
	icon_state = "mpband"

/obj/item/clothing/accessory/armband/solgov/ma
	name = "master at arms brassard"
	desc = "An armlet, worn by the crew to display which department they're assigned to. This one is white with 'MA' in navy blue."
	icon_state = "maband"

/*****************
armour attachments
*****************/
/obj/item/clothing/accessory/armor/tag
	name = DEVELOPER_WARNING_NAME
/*
/obj/item/clothing/accessory/armor/tag/solgov
	name = "\improper TCG Flag"
	desc = "An emblem depicting the Terran Commonwealth's flag."
	icon_state = "solflag"
	slot = ACCESSORY_SLOT_ARMOR_M

/obj/item/clothing/accessory/armor/tag/solgov/ec
	name = "\improper Expeditionary Corps crest"
	desc = "An emblem depicting the crest of the TCG Expeditionary Corps."
	icon_state = "ecflag"
*/
/obj/item/clothing/accessory/armor/tag/solgov/sec
	name = "\improper POLICE tag"
	desc = "An armor tag with the word POLICE printed in silver lettering on it."
	icon_state = "sectag"

/obj/item/clothing/accessory/armor/tag/solgov/medic
	name = "\improper MEDIC tag"
	desc = "An armor tag with the word MEDIC printed in red lettering on it."
	icon_state = "medictag"

/obj/item/clothing/accessory/armor/tag/solgov/agent
	name = "\improper OCIE AGENT tag"
	desc = "An armor tag with the word OCIE AGENT printed in gold lettering on it."
	icon_state = "agenttag"

/obj/item/clothing/accessory/armor/tag/solgov/com
	name = "\improper TCG tag"
	desc = "An armor tag with the words COMMONWEALTH OF SOL-PROCYON printed in gold lettering on it."
	icon_state = "comtag"

/obj/item/clothing/accessory/armor/tag/solgov/com/sec
	name = "\improper POLICE tag"
	desc = "An armor tag with the words POLICE printed in gold lettering on it."

/obj/item/clothing/accessory/armor/helmcover/blue/sol
	name = "peacekeeper helmet cover"
	desc = "A fabric cover for armored helmets. This one is in TCG peacekeeper colors."

/**************
department tags
**************/
/obj/item/clothing/accessory/solgov/department
	name = "department insignia"
	desc = "Insignia denoting assignment to a department."
	icon_state = "dept_exped"
	on_rolled = list("down" = "none", "rolled" = "dept_exped_sleeves")
	slot = ACCESSORY_SLOT_DEPT
	//removable = FALSE

/obj/item/clothing/accessory/solgov/department/command
	name = "command insignia"
	desc = "Insignia denoting assignment to the command department."
	color = "#e5ea4f"

/obj/item/clothing/accessory/solgov/department/command/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/command/jumper
	icon_state = "dept_exped_jumper"
	color = "#d6bb64"

/obj/item/clothing/accessory/solgov/department/command/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/command/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/engineering
	name = "engineering insignia"
	desc = "Insignia denoting assignment to the engineering department."
	color = "#ff7f00"

/obj/item/clothing/accessory/solgov/department/engineering/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/engineering/jumper
	icon_state = "dept_exped_jumper"

/obj/item/clothing/accessory/solgov/department/engineering/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/engineering/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/security
	name = "security insignia"
	desc = "Insignia denoting assignment to the security department."
	color = "#bf0000"

/obj/item/clothing/accessory/solgov/department/security/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/security/jumper
	icon_state = "dept_exped_jumper"
	color = "#721b1b"

/obj/item/clothing/accessory/solgov/department/security/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/security/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/medical
	name = "medical insignia"
	desc = "Insignia denoting assignment to the medical department."
	color = "#4c9ce4"

/obj/item/clothing/accessory/solgov/department/medical/service
	icon_state = "dept_exped_service"
	color = "#7faad1"

/obj/item/clothing/accessory/solgov/department/medical/jumper
	icon_state = "dept_exped_jumper"
	color = "#7faad1"

/obj/item/clothing/accessory/solgov/department/medical/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/medical/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/supply
	name = "supply insignia"
	desc = "Insignia denoting assignment to the supply department."
	color = "#bb9042"

/obj/item/clothing/accessory/solgov/department/supply/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/supply/jumper
	icon_state = "dept_exped_jumper"
	color = "#7faad1"

/obj/item/clothing/accessory/solgov/department/supply/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/supply/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/service
	name = "service insignia"
	desc = "Insignia denoting assignment to the service department."
	color = "#6eaa2c"

/obj/item/clothing/accessory/solgov/department/service/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/service/jumper
	icon_state = "dept_exped_jumper"
	color = "#7b965d"

/obj/item/clothing/accessory/solgov/department/service/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/service/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/exploration
	name = "exploration insignia"
	desc = "Insignia denoting assignment to the exploration department."
	color = "#68099e"

/obj/item/clothing/accessory/solgov/department/exploration/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/exploration/jumper
	icon_state = "dept_exped_jumper"

/obj/item/clothing/accessory/solgov/department/exploration/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/exploration/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/department/research
	name = "research insignia"
	desc = "Insignia denoting assignment to the research department."
	color = "#68099e"

/obj/item/clothing/accessory/solgov/department/research/service
	icon_state = "dept_exped_service"

/obj/item/clothing/accessory/solgov/department/research/jumper
	icon_state = "dept_exped_jumper"
	color = "#916f8d"

/obj/item/clothing/accessory/solgov/department/research/fleet
	icon_state = "dept_fleet"
	on_rolled = list("rolled" = "dept_fleet_sleeves", "down" = "none")

/obj/item/clothing/accessory/solgov/department/research/army
	icon_state = "dept_army"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/gorka/department
	name = "gorka insignia"
	desc = "Coloured panelling denoting assignment to a specific department."
	icon_state = "gorka_dept"
	on_rolled = list("down" = "none")
	can_remove = FALSE

/obj/item/clothing/accessory/gorka/department/civilian
	name = "civilian insignia"
	desc = "Coloured panelling denoting assignment to no department in particular."
	color = "#bbbbbb"

/obj/item/clothing/accessory/gorka/department/command
	name = "command insignia"
	desc = "Coloured panelling denoting assignment to the command department."
	color = "#3066bf"

/obj/item/clothing/accessory/gorka/department/sec
	name = "security insignia"
	desc = "Coloured panelling denoting assignment to the security department."
	color = "#bf3032"

/obj/item/clothing/accessory/gorka/department/cargo
	name = "cargo insignia"
	desc = "Coloured panelling denoting assignment to the cargo department."
	color = "#815b20"

/obj/item/clothing/accessory/gorka/department/engi
	name = "engineering insignia"
	desc = "Coloured panelling denoting assignment to the engineering department."
	color = "#bf8d30"

/obj/item/clothing/accessory/gorka/department/sci
	name = "research insignia"
	desc = "Coloured panelling denoting assignment to the research department."
	color = "#9b1688"

/obj/item/clothing/accessory/gorka/department/med
	name = "medical insignia"
	desc = "Coloured panelling denoting assignment to the medical department."
	color = "#609ebf"

/obj/item/clothing/accessory/gorka/department/service
	name = "service insignia"
	desc = "Coloured panelling denoting assignment to the service department."
	color = "#90bf60"

/obj/item/clothing/accessory/gorka/department/janitor
	name = "janitorial insignia"
	desc = "Coloured panelling denoting assignment to the janitorial department."
	color = "#bf60b3"

/obj/item/clothing/accessory/gorka/rank
	name = "gorka command trim"
	desc = "Silver trim denoting a higher rank within one's department."
	icon_state = "gorka_rank"
	on_rolled = list("down" = "none")
	can_remove = FALSE

/*********
ranks - ec
*********/

/obj/item/clothing/accessory/solgov/rank
	name = "ranks"
	desc = "Insignia denoting rank of some kind. These appear blank."
	icon_state = "fleetrank"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_RANK
	gender = PLURAL
	//high_visibility = 1

/obj/item/clothing/accessory/solgov/rank/ec
	name = "explorer ranks"
	desc = "Insignia denoting rank of some kind. These appear blank."
	icon_state = "ecrank_e1"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/rank/ec/enlisted
	name = "ranks (E-1 apprentice explorer)"
	desc = "Insignia denoting the rank of Apprentice Explorer."
	icon_state = "ecrank_e1"

/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e3
	name = "ranks (E-3 explorer)"
	desc = "Insignia denoting the rank of Explorer."
	icon_state = "ecrank_e3"

/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e5
	name = "ranks (E-5 senior explorer)"
	desc = "Insignia denoting the rank of Senior Explorer."
	icon_state = "ecrank_e5"

/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e7
	name = "ranks (E-7 chief explorer)"
	desc = "Insignia denoting the rank of Chief Explorer."
	icon_state = "ecrank_e7"

/obj/item/clothing/accessory/solgov/rank/ec/officer
	name = "ranks (O-1 ensign)"
	desc = "Insignia denoting the rank of Ensign."
	icon_state = "ecrank_o1"

/obj/item/clothing/accessory/solgov/rank/ec/officer/o3
	name = "ranks (O-3 lieutenant)"
	desc = "Insignia denoting the rank of Lieutenant."
	icon_state = "ecrank_o3"

/obj/item/clothing/accessory/solgov/rank/ec/officer/o5
	name = "ranks (O-5 commander)"
	desc = "Insignia denoting the rank of Commander."
	icon_state = "ecrank_o5"

/obj/item/clothing/accessory/solgov/rank/ec/officer/o6
	name = "ranks (O-6 captain)"
	desc = "Insignia denoting the rank of Captain."
	icon_state = "ecrank_o6"

/obj/item/clothing/accessory/solgov/rank/ec/officer/o8
	name = "ranks (O-8 admiral)"
	desc = "Insignia denoting the rank of Admiral."
	icon_state = "ecrank_o8"

/************
ranks - fleet
************/
/obj/item/clothing/accessory/solgov/rank/fleet
	name = "naval ranks"
	desc = "Insignia denoting naval rank of some kind. These appear blank."
	icon_state = "fleetrank"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted
	name = "ranks (E-1 crewman recruit)"
	desc = "Insignia denoting the rank of Crewman Recruit."
	icon_state = "fleetrank_enlisted"

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e2
	name = "ranks (E-2 crewman apprentice)"
	desc = "Insignia denoting the rank of Crewman Apprentice."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e3
	name = "ranks (E-3 crewman)"
	desc = "Insignia denoting the rank of Crewman."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e4
	name = "ranks (E-4 petty officer third class)"
	desc = "Insignia denoting the rank of Petty Officer Third Class."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e5
	name = "ranks (E-5 petty officer second class)"
	desc = "Insignia denoting the rank of Petty Officer Second Class."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e6
	name = "ranks (E-6 petty officer first class)"
	desc = "Insignia denoting the rank of Petty Officer First Class."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e7
	name = "ranks (E-7 chief petty officer)"
	desc = "Insignia denoting the rank of Chief Petty Officer."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e8
	name = "ranks (E-8 senior chief petty officer)"
	desc = "Insignia denoting the rank of Senior Chief Petty Officer."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9
	name = "ranks (E-9 master chief petty officer)"
	desc = "Insignia denoting the rank of Master Chief Petty Officer."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9_alt1
	name = "ranks (E-9 command master chief petty officer)"
	desc = "Insignia denoting the rank of Command Master Chief Petty Officer."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9_alt2
	name = "ranks (E-9 fleet master chief petty officer)"
	desc = "Insignia denoting the rank of Fleet Master Chief Petty Officer."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9_alt3
	name = "ranks (E-9 force master chief petty officer)"
	desc = "Insignia denoting the rank of Force Master Chief Petty Officer."

/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9_alt4
	name = "ranks (E-9 master chief petty officer of the Fleet)"
	desc = "Insignia denoting the rank of Master Chief Petty Officer of the Fleet."

/obj/item/clothing/accessory/solgov/rank/fleet/officer
	name = "ranks (O-1 ensign)"
	desc = "Insignia denoting the rank of Ensign."
	icon_state = "fleetrank_officer"

/obj/item/clothing/accessory/solgov/rank/fleet/officer/wo1_monkey
	name = "makeshift ranks (WO-1 warrant officer 1)"
	desc = "Insignia denoting the mythical rank of Warrant Officer. Too bad it's obviously fake."

/obj/item/clothing/accessory/solgov/rank/fleet/officer/o2
	name = "ranks (O-2 sub-lieutenant)"
	desc = "Insignia denoting the rank of Sub-lieutenant."

/obj/item/clothing/accessory/solgov/rank/fleet/officer/o3
	name = "ranks (O-3 lieutenant)"
	desc = "Insignia denoting the rank of Lieutenant."

/obj/item/clothing/accessory/solgov/rank/fleet/officer/o4
	name = "ranks (O-4 lieutenant commander)"
	desc = "Insignia denoting the rank of Lieutenant Commander."

/obj/item/clothing/accessory/solgov/rank/fleet/officer/o5
	name = "ranks (O-5 commander)"
	desc = "Insignia denoting the rank of Commander."

/obj/item/clothing/accessory/solgov/rank/fleet/officer/o6
	name = "ranks (O-6 captain)"
	desc = "Insignia denoting the rank of Captain."
	icon_state = "fleetrank_command"

/obj/item/clothing/accessory/solgov/rank/fleet/flag
	name = "ranks (O-7 commodore)"
	desc = "Insignia denoting the rank of Commodore."
	icon_state = "fleetrank_command"

/obj/item/clothing/accessory/solgov/rank/fleet/flag/o8
	name = "ranks (O-8 rear admiral)"
	desc = "Insignia denoting the rank of Rear Admiral."

/obj/item/clothing/accessory/solgov/rank/fleet/flag/o9
	name = "ranks (O-9 vice admiral)"
	desc = "Insignia denoting the rank of Vice Admiral."

/obj/item/clothing/accessory/solgov/rank/fleet/flag/o10
	name = "ranks (O-10 admiral)"
	desc = "Insignia denoting the rank of Admiral."

/obj/item/clothing/accessory/solgov/rank/fleet/flag/o10_alt
	name = "ranks (O-10 fleet admiral)"
	desc = "Insignia denoting the rank of Fleet Admiral."

/**************
ranks - marines
**************/
/obj/item/clothing/accessory/solgov/rank/marine
	name = "marine ranks"
	desc = "Insignia denoting marine rank of some kind. These appear blank."
	icon_state = "armyrank_enlisted"
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/solgov/rank/marine/enlisted
	name = "ranks (E-1 private)"
	desc = "Insignia denoting the rank of Private."
	icon_state = "armyrank_enlisted"

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e2
	name = "ranks (E-2 private second class)"
	desc = "Insignia denoting the rank of Private Second Class."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e3
	name = "ranks (E-3 private first class)"
	desc = "Insignia denoting the rank of Private First Class."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e4
	name = "ranks (E-4 corporal)"
	desc = "Insignia denoting the rank of Corporal."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e5
	name = "ranks (E-5 sergeant)"
	desc = "Insignia denoting the rank of Sergeant."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e6
	name = "ranks (E-6 staff sergeant)"
	desc = "Insignia denoting the rank of Staff Sergeant."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e7
	name = "ranks (E-7 sergeant first class)"
	desc = "Insignia denoting the rank of Sergeant First Class."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e8
	name = "ranks (E-8 master sergeant)"
	desc = "Insignia denoting the rank of Master Sergeant."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e8_alt
	name = "ranks (E-8 first sergeant)"
	desc = "Insignia denoting the rank of First Sergeant."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e9
	name = "ranks (E-9 sergeant major)"
	desc = "Insignia denoting the rank of Sergeant Major."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e9_alt1
	name = "ranks (E-9 command sergeant major)"
	desc = "Insignia denoting the rank of Command Sergeant Major."

/obj/item/clothing/accessory/solgov/rank/marine/enlisted/e9_alt2
	name = "ranks (E-9 sergeant major of the marine)"
	desc = "Insignia denoting the rank of Sergeant Major of the marine."

/obj/item/clothing/accessory/solgov/rank/marine/officer
	name = "ranks (O-1 second lieutenant)"
	desc = "Insignia denoting the rank of Second Lieutenant."
	icon_state = "armyrank_officer"

/obj/item/clothing/accessory/solgov/rank/marine/officer/o2
	name = "ranks (O-2 first lieutenant)"
	desc = "Insignia denoting the rank of First Lieutenant."

/obj/item/clothing/accessory/solgov/rank/marine/officer/o3
	name = "ranks (O-3 captain)"
	desc = "Insignia denoting the rank of Captain."

/obj/item/clothing/accessory/solgov/rank/marine/officer/o4
	name = "ranks (O-4 major)"
	desc = "Insignia denoting the rank of Major."

/obj/item/clothing/accessory/solgov/rank/marine/officer/o5
	name = "ranks (O-5 lieutenant colonel)"
	desc = "Insignia denoting the rank of Lieutenant Colonel."

/obj/item/clothing/accessory/solgov/rank/marine/officer/o6
	name = "ranks (O-6 colonel)"
	desc = "Insignia denoting the rank of Colonel."

/obj/item/clothing/accessory/solgov/rank/marine/flag
	name = "ranks (O-7 brigadier general)"
	desc = "Insignia denoting the rank of Brigadier General."
	icon_state = "armyrank_command"

/obj/item/clothing/accessory/solgov/rank/marine/flag/o8
	name = "ranks (O-8 major general)"
	desc = "Insignia denoting the rank of Major General."

/obj/item/clothing/accessory/solgov/rank/marine/flag/o9
	name = "ranks (O-9 lieutenant general)"
	desc = "Insignia denoting the rank of lieutenant general."

/obj/item/clothing/accessory/solgov/rank/marine/flag/o10
	name = "ranks (O-10 general)"
	desc = "Insignia denoting the rank of General."

/obj/item/clothing/accessory/solgov/rank/marine/flag/o10_alt
	name = "ranks (O-10 field marshal)"
	desc = "Insignia denoting the rank of Field Marshal."
