/*
General Explination:
The research datum is the "folder" where all the research information is stored in a R&D console. It's also a holder for all the
various procs used to manipulate it. It has four variables and seven procs:

Variables:
- possible_tech is a list of all the /datum/tech that can potentially be researched by the player. The RefreshResearch() proc
(explained later) only goes through those when refreshing what you know. Generally, possible_tech contains ALL of the existing tech
but it is possible to add tech to the game that DON'T start in it (example: Xeno tech). Generally speaking, you don't want to mess
with these since they should be the default version of the datums. They're actually stored in a list rather then using typesof to
refer to them since it makes it a bit easier to search through them for specific information.
- know_tech is the companion list to possible_tech. It's the tech you can actually research and improve. Until it's added to this
list, it can't be improved. All the tech in this list are visible to the player.
- possible_designs is functionally identical to possbile_tech except it's for /datum/design.
- known_designs is functionally identical to known_tech except it's for /datum/design

Procs:
- TechHasReqs: Used by other procs (specifically RefreshResearch) to see whether all of a tech's requirements are currently in
known_tech and at a high enough level.
- DesignHasReqs: Same as TechHasReqs but for /datum/design and known_design.
- AddTech2Known: Adds a /datum/tech to known_tech. It checks to see whether it already has that tech (if so, it just replaces it). If
it doesn't have it, it adds it. Note: It does NOT check possible_tech at all. So if you want to add something strange to it (like
a player made tech?) you can.
- AddDesign2Known: Same as AddTech2Known except for /datum/design and known_designs.
- RefreshResearch: This is the workhorse of the R&D system. It updates the /datum/research holder and adds any unlocked tech paths
and designs you have reached the requirements for. It only checks through possible_tech and possible_designs, however, so it won't
accidentally add "secret" tech to it.
- UpdateTech is used as part of the actual researching process. It takes an ID and finds techs with that same ID in known_tech. When
it finds it, it checks to see whether it can improve it at all. If the known_tech's level is less then or equal to
the inputted level, it increases the known tech's level to the inputted level -1 or know tech's level +1 (whichever is higher).

The tech datums are the actual "tech trees" that you improve through researching. Each one has five variables:
- Name:		Pretty obvious. This is often viewable to the players.
- Desc:		Pretty obvious. Also player viewable.
- ID:		This is the unique ID of the tech that is used by the various procs to find and/or maniuplate it.
- Level:	This is the current level of the tech. All techs start at 1 and have a max of 20. Devices and some techs require a certain
level in specific techs before you can produce them.
- Req_tech:	This is a list of the techs required to unlock this tech path. If left blank, it'll automatically be loaded into the
research holder datum.

*/
/***************************************************************
**						Master Types						  **
**	Includes all the helper procs and basic tech processing.  **
***************************************************************/
GLOBAL_LIST_INIT(design_datums, list())

/datum/research								//Holder for all the existing, archived, and known tech. Individual to console.
	var/list/known_tech = list()			//List of locally known tech. Datum/tech go here.
	var/list/possible_designs = list()		//List of all designs.
	var/list/known_designs = list()			//List of available designs.

/datum/research/New()		//Insert techs into possible_tech here. Known_tech automatically updated.
	if(!LAZYLEN(GLOB.design_datums))
		for(var/T in subtypesof(/datum/design))
			GLOB.design_datums += new T
	possible_designs = GLOB.design_datums

	if(!LAZYLEN(known_tech))
		for(var/T in subtypesof(/datum/tech))
			known_tech += new T
	RefreshResearch()

/datum/research/techonly
/datum/research/techonly/New()
	. = ..()
	possible_designs = list()
	known_designs = list()

/datum/research/techonly/RefreshResearch()
	. = ..()
	known_designs = list() // Just in case

//Checks to see if design has all the required pre-reqs.
//Input: datum/design; Output: 0/1 (false/true)
/datum/research/proc/DesignHasReqs(var/datum/design/D)
	if(!LAZYLEN(D.req_tech))
		return TRUE

	var/list/k_tech = list()
	for(var/datum/tech/known in known_tech)
		k_tech[known.id] = known.level

	for(var/req in D.req_tech)
		if(isnull(k_tech[req]) || k_tech[req] < D.req_tech[req])
			return 0

	return TRUE

//Adds a tech to known_tech list. Checks to make sure there aren't duplicates and updates existing tech's levels if needed.
//Input: datum/tech; Output: Null
/datum/research/proc/AddTech2Known(var/datum/tech/T)
	for(var/datum/tech/known in known_tech)
		if(T.id == known.id)
			if(T.level > known.level)
				known.level = T.level
			return
	return

/datum/research/proc/AddDesign2Known(var/datum/design/D)
	LAZYDISTINCTADD(known_designs, D)

//Refreshes known_tech and known_designs list
//Input/Output: n/a
/datum/research/proc/RefreshResearch()
	for(var/datum/design/PD in possible_designs)
		if(DesignHasReqs(PD))
			AddDesign2Known(PD)
	for(var/datum/tech/T in known_tech)
		T.level = between(0, T.level, 20)
	return

//Refreshes the levels of a given tech.
//Input: Tech's ID and Level; Output: null
/datum/research/proc/UpdateTech(var/ID, var/level)
	for(var/datum/tech/KT in known_tech)
		if(KT.id == ID && KT.level <= level)
			// Outpost 21 edit begin - Randomize tech levels to avoid metagaming
			var/R = 0
			if(prob(20) || level >= 6)
				R = 1 // Original mechanics, give the full tech!
			else
				R = rand(0.5,1) // Weighted toward higher end
			var/final_level = round(level * R)
			// Outpost 21 edit end
			KT.level = max(KT.level + 1, final_level - 1)
	return

// A simple helper proc to find the name of a tech with a given ID.
/proc/CallTechName(var/ID)
	for(var/datum/tech/check_tech as anything in subtypesof(/datum/tech))
		if(initial(check_tech.id) == ID)
			return  initial(check_tech.name)

/***************************************************************
**						Technology Datums					  **
**	Includes all the various technoliges and what they make.  **
***************************************************************/

/datum/tech //Datum of individual technologies.
	var/name = "name"					//Name of the technology.
	var/desc = "description"			//General description of what it does and what it makes.
	var/id = "id"						//An easily referenced ID. Must be alphanumeric, lower-case, and no symbols.
	var/level = 1						//A simple number scale of the research level. Level 0 = Secret tech.

/datum/tech/materials
	name = "Materials Research"
	desc = "Development of new and improved materials."
	id = TECH_MATERIAL

/datum/tech/engineering
	name = "Engineering Research"
	desc = "Development of new and improved engineering parts."
	id = TECH_ENGINEERING

/datum/tech/phorontech
	name = "Phoron Research"
	desc = "Research into the mysterious substance colloqually known as 'phoron'."
	id = TECH_PHORON

/datum/tech/powerstorage
	name = "Power Manipulation Technology"
	desc = "The various technologies behind the storage and generation of electicity."
	id = TECH_POWER

/datum/tech/bluespace
	name = "'Blue-space' Research"
	desc = "Research into the sub-reality known as 'blue-space'"
	id = TECH_BLUESPACE

/datum/tech/biotech
	name = "Biological Technology"
	desc = "Research into the deeper mysteries of life and organic substances."
	id = TECH_BIO

/datum/tech/combat
	name = "Combat Systems Research"
	desc = "The development of offensive and defensive systems."
	id = TECH_COMBAT

/datum/tech/magnets
	name = "Electromagnetic Spectrum Research"
	desc = "Research into the electromagnetic spectrum. No clue how they actually work, though."
	id = TECH_MAGNET

/datum/tech/programming
	name = "Data Theory Research"
	desc = "The development of new computer and artificial intelligence and data storage systems."
	id = TECH_DATA

/datum/tech/syndicate
	name = "Transgressive Technologies Research"
	desc = "The study of technologies that sit on the very boundaries of legality and ethics."
	id = TECH_ILLEGAL
	level = 0

/datum/tech/arcane
	name = "Anomalous Research"
	desc = "Study of phenomena that disobey the fundamental laws of this universe."
	id = TECH_ARCANE
	level = 0

/datum/tech/precursor
	name = "Precursor Research"
	desc = "The applied study of Precursor Technology, for modern applications."
	id = TECH_PRECURSOR
	level = 0

/obj/item/disk/tech_disk
	name = "technology disk"
	desc = "A disk for storing technology data for further research."
	icon = 'icons/obj/discs_vr.dmi' //VOREStation Edit
	icon_state = "data-blue" //VOREStation Edit
	item_state = "card-id"
	randpixel = 5
	w_class = ITEMSIZE_SMALL
	matter = list(MAT_STEEL = 30, MAT_GLASS = 10)
	var/datum/tech/stored

/obj/item/disk/tech_disk/Initialize(mapload)
	. = ..()
	randpixel_xy()

/obj/item/disk/design_disk
	name = "component design disk"
	desc = "A disk for storing device design data for construction in lathes."
	icon = 'icons/obj/discs_vr.dmi' //VOREStation Edit
	icon_state = "data-purple" //VOREStation Edit
	item_state = "card-id"
	randpixel = 5
	w_class = ITEMSIZE_SMALL
	matter = list(MAT_STEEL = 30, MAT_GLASS = 10)
	var/datum/design/blueprint

/obj/item/disk/design_disk/Initialize(mapload)
	. = ..()
	randpixel_xy()
