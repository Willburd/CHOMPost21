//Outpost map defs
#define Z_LEVEL_OUTPOST_DEEPDARK					1
#define Z_LEVEL_OUTPOST_BASEMENT					2
#define Z_LEVEL_OUTPOST_SURFACE						3
#define Z_LEVEL_OUTPOST_UPPER						4
#define Z_LEVEL_OUTPOST_CENTCOM						5
#define Z_LEVEL_OUTPOST_MISC 						6
#define Z_LEVEL_OUTPOST_ASTEROID 					7
//efine Z_LEVEL_OUTPOST_PROSPECTOR 					8
//efine Z_LEVEL_OUTPOST_SURVEY	 					9
#define Z_LEVEL_OUTPOST_VR		 					8
#define Z_LEVEL_OUTPOST_CONFINEMENTBEAM				9
//Ensure these stay updated with map and z-level changes - Ignus

/obj/effect/landmark/map_data/muriki
    height = 4

// Overmap represetation of muriki
/obj/effect/overmap/visitable/sector/muriki
	name = "Muriki"
	desc = "What a terrible place to call home."
	scanner_desc = @{"[i]Registration[/i]: ES Outpost 21-00
[i]Class[/i]: Planetary Installation
[i]Transponder[/i]: Transmitting (CIV), ESHUI IFF
[b]Notice[/b]: ESHUI Terraforming Outpost, authorized personnel only"}

	base = TRUE
	icon_state = "globe"
	color = "#7be313"
	initial_generic_waypoints = list("outpost_landing_pad","outpost_engineering_pad")
	initial_restricted_waypoints = list( "Mining Trawler" = list("outpost_trawler_pad"), "Security Carrier" = list("outpost_security_hangar"), "Medical Rescue" = list("outpost_medical_hangar"))
	//Despite not being in the multi-z complex, these levels are part of the overmap sector
	extra_z_levels = list()

/obj/effect/overmap/visitable/sector/muriki/Crossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = FALSE)

/obj/effect/overmap/visitable/sector/muriki/Uncrossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = TRUE)

/obj/effect/overmap/visitable/sector/muriki/announce_atc(var/atom/movable/AM, var/going = FALSE)
	var/message = "Sensor contact for vessel '[AM.name]' has [going ? "left" : "entered"] ATC control area."
	//For landables, we need to see if their shuttle is cloaked
	if(istype(AM, /obj/effect/overmap/visitable/ship/landable))
		var/obj/effect/overmap/visitable/ship/landable/SL = AM //Phew
		var/datum/shuttle/autodock/multi/shuttle = SSshuttles.shuttles[SL.shuttle]
		if(!istype(shuttle) || !shuttle.cloaked) //Not a multishuttle (the only kind that can cloak) or not cloaked
			atc.msg(message)

	//For ships, it's safe to assume they're big enough to not be sneaky
	else if(istype(AM, /obj/effect/overmap/visitable/ship))
		atc.msg(message)

/obj/effect/overmap/visitable/sector/muriki/get_space_zlevels()
	return list() //None!



/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard
	initial_generic_waypoints = list("orbitalyard_civ","orbitalyard_north","orbitalyard_south","orbitalyard_east","orbitalyard_west")
	initial_restricted_waypoints = list("Mining Trawler" = list("trawler_yard"))
	name = "Orbital Reclamation Yard"
	scanner_desc = @{"[i]Registration[/i]: ES Orbital 21-03
[i]Class[/i]: Installation
[i]Transponder[/i]: Transmitting (CIV), ESHUI IFF
[b]Notice[/b]: ESHUI Base, authorized personnel only"}
	map_z = list(Z_LEVEL_OUTPOST_ASTEROID)
	extra_z_levels = list()

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/Crossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = FALSE)

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/Uncrossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = TRUE)

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/announce_atc(var/atom/movable/AM, var/going = FALSE)
	var/message = "Sensor contact for vessel '[AM.name]' has [going ? "left" : "entered"] ATC control area."
	//For landables, we need to see if their shuttle is cloaked
	if(istype(AM, /obj/effect/overmap/visitable/ship/landable))
		var/obj/effect/overmap/visitable/ship/landable/SL = AM //Phew
		var/datum/shuttle/autodock/multi/shuttle = SSshuttles.shuttles[SL.shuttle]
		if(!istype(shuttle) || !shuttle.cloaked) //Not a multishuttle (the only kind that can cloak) or not cloaked
			atc.msg(message)

	//For ships, it's safe to assume they're big enough to not be sneaky
	else if(istype(AM, /obj/effect/overmap/visitable/ship))
		atc.msg(message)

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/get_space_zlevels()
	return list(Z_LEVEL_OUTPOST_ASTEROID)



/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam
	initial_generic_waypoints = list("confinementbeam_civ")
	name = "Confinement Beam Platform"
	scanner_desc = @{"[i]Registration[/i]: ES Orbital 21-04
[i]Class[/i]: Confinement Beam
[i]Transponder[/i]: Transmitting (ENG), ESHUI IFF
[b]Notice[/b]: ESHUI Base, authorized personnel only"}
	map_z = list(Z_LEVEL_OUTPOST_CONFINEMENTBEAM)
	extra_z_levels = list()
	initial_restricted_waypoints = list( "Mining Trawler" = list("confinementbeam_trawler"), "Security Carrier" = list("confinementbeam_security", "aisat_security"), "Medical Rescue" = list("confinementbeam_medical"))

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/Crossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = FALSE)

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/Uncrossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = TRUE)

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/announce_atc(var/atom/movable/AM, var/going = FALSE)
	var/message = "Sensor contact for vessel '[AM.name]' has [going ? "left" : "entered"] ATC control area."
	//For landables, we need to see if their shuttle is cloaked
	if(istype(AM, /obj/effect/overmap/visitable/ship/landable))
		var/obj/effect/overmap/visitable/ship/landable/SL = AM //Phew
		var/datum/shuttle/autodock/multi/shuttle = SSshuttles.shuttles[SL.shuttle]
		if(!istype(shuttle) || !shuttle.cloaked) //Not a multishuttle (the only kind that can cloak) or not cloaked
			atc.msg(message)

	//For ships, it's safe to assume they're big enough to not be sneaky
	else if(istype(AM, /obj/effect/overmap/visitable/ship))
		atc.msg(message)

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/get_space_zlevels()
	return list(Z_LEVEL_OUTPOST_CONFINEMENTBEAM)
