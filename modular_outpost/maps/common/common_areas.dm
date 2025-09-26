// put all map-specific areas here for ease of use and not cluttering a thousand other maps - Ignus
/area/muriki // area/outpost was already in use, so we're using the planet's name.
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "deck1"
	sound_env = STANDARD_STATION

// Misc
/area/mine/explored/muriki_wilds
	name = "\improper muriki Wilderness Outer Perimeter"

/area/mine/unexplored/muriki_wilds
	name = "\improper muriki Wilderness Inner Perimeter"

/area/muriki/lowerelev
	name = "\improper Arrivals Elevator Shaft"
	icon_state = "dark128"
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/open
	sound_env = TUNNEL_ENCLOSED
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS
	color_grading = COLORTINT_DARK

/area/muriki/lowerevac
	name = "\improper Evac Elevator Shaft"
	icon_state = "dark128"
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/open
	sound_env = TUNNEL_ENCLOSED
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS
	color_grading = COLORTINT_DARK



//Station! Y'know, the important stuff.
//
// Atmospherics ---------------------------------------------------------------------
//
/area/engineering/atmoshall
	name = "\improper Atmospherics Hallway"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "atmos"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM
	lightswitch = 1

/area/muriki/atmos/voxdump
	name = "\improper Hazardous Gas Filtration Substation"
	icon_state = "yelblacir"
	ambience = AMBIENCE_ATMOS
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/maintenance/substation/atmos
	name = "Atmospherics Substation"

//Processor. Our station is cool enough to have a giant vore eldrich horror for a terraforming station.
/area/muriki/processor
	name = "\improper Core Terraformer Processing"
	base_turf = /turf/simulated/open
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_GHOST_SIGHT
	sound_env = SPACE
	ambience = AMBIENCE_MEATZONE
	music = 'sound/ambience/approaching_planet.ogg'
	requires_power = FALSE
	color_grading = COLORTINT_MEAT

/area/muriki/processor/euth
	name = "\improper Processor Euthanization"
	icon_state = "nuke_storage"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	music = 'sound/ambience/ambimine.ogg'
	requires_power = TRUE
	color_grading = COLORTINT_UNDERDARK

//Hallways... I guess?
/area/muriki/processor/hall
	name = "\improper Core Processor Cavities"
	icon_state = "anohallway"

/area/muriki/processor/hall/entrance
	name = "\improper Core Processor Access"
	icon_state = "anohallway"
	requires_power = TRUE
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/muriki/processor/hall/airmix
	name = "\improper Terraformer Alveolar duct"

/area/muriki/processor/hall/waterway_upper
	name = "\improper Terraformer Upper Jejunum"

/area/muriki/processor/hall/waterway_low
	name = "\improper Terraformer Lower Jejunum"

/area/muriki/processor/hall/waterway_other
	name = "\improper Terraformer Ileum"

//Glands
/area/muriki/processor/gland
	name = "\improper Terraformer Gaseous Glands"
	icon_state = "green"

/area/muriki/processor/gland/space
	name = "\improper Terraformer Inhallation Gland"

/area/muriki/processor/gland/airmix
	name = "\improper Terraformer Primary Enzyme Cavity" //Technically a pool, but it makes more sense here.

/area/muriki/processor/gland/nitrogen
	name = "\improper Terraformer Common Nitrogen Duct"

/area/muriki/processor/gland/co2
	name = "\improper Terraformer Carbon Dioxide Bladder"

/area/muriki/processor/gland/phoron
	name = "\improper Terraformer Phoronic Sack"

//Pools.. don't swim in these.
/area/muriki/processor/pools
	name = "\improper Terraformer Enzomatic Pools"
	icon_state = "yellow"

/area/muriki/processor/pools/pylorus
	name = "\improper Terraformer Pyloric Pool"

/area/muriki/processor/pools/antrum
	name = "\improper Terraformer Antrum Pool"

/area/muriki/processor/pools/crop
	name = "\improper Terraformer Crop"

/area/muriki/processor/pools/cropbig
	name = "\improper Terraformer Greater Crop"

/area/muriki/processor/pools/gizzard //Note to medical: Don't even bother rescuing anyone in here.
	name = "\improper Terraformer Gizzard"

/area/muriki/processor/pools/eastfund
	name = "\improper Terraformer Eastern Fundic Pool"

/area/muriki/processor/pools/westfund
	name = "\improper Terraformer Western Fundic Pool"

/area/muriki/processor/depths
	name = "\improper Core Terraformer Depths"
	base_turf = /turf/simulated/floor/flesh

//
//Bathrooms. Each department's has a unique ending name, for humor, and navigation.
//
/area/muriki/bathroom
	name = "\improper Bathroom. Don't use."
	icon_state = "cyablatri"
	sound_env = SMALL_ENCLOSED
	flags = RAD_SHIELDED | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT | AREA_FIRE_SUPRESSION
	use_emergency_overlay = TRUE
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_CHILL

/area/muriki/bathroom/atmospherics
	name = "\improper Atmospherics Latrine"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/muriki/bathroom/bar
	name = "\improper Bar Head"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

/area/muriki/bathroom/bridge
	name = "\improper Privy"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/muriki/bathroom/captain
	name = "\improper Oval Office"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/muriki/bathroom/cargo
	name = "\improper Main Cargo Bog"
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	base_turf = /turf/simulated/open

/area/muriki/bathroom/cargopub
	name = "\improper Cargo Public Restroom"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/muriki/bathroom/cargolower
	name = "\improper Lower Cargo Bog"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/muriki/bathroom/chapel
	name = "\improper Chapel Pilgrimage"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

/area/muriki/bathroom/courthouse
	name = "\improper Dreadbox"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/muriki/bathroom/dorm
	name = "\improper Pool Restroom"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/engineering
	name = "\improper Engineering Latrine"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/muriki/bathroom/engsingle
	name = "\improper Engineering Lobby Latrine"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/muriki/bathroom/engrefinery
	name = "\improper Moonshiner"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_DARK

/area/muriki/bathroom/kitchen
	name = "\improper Kitchen Comode"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	base_turf = /turf/simulated/open

/area/muriki/bathroom/medical
	name = "\improper Medical Depository"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/open

/area/muriki/bathroom/medupper
	name = "\improper Recovery Depository"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/open

/area/muriki/bathroom/sanitorium
	name = "\improper Sanitorium"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/muriki/bathroom/sciupper
	name = "\improper Research Lavatory"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	base_turf = /turf/simulated/open

/area/muriki/bathroom/scilower
	name = "\improper Science Lavoratory"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/muriki/bathroom/security
	name = "\improper Security Thunderbox"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
	base_turf = /turf/simulated/open

/area/muriki/bathroom/securitypub
	name = "\improper Arrivals Restroom"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/muriki/bathroom/vox
	name = "\improper Vomit Closet"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/bathroom/virology
	name = "\improper Biohazard Dump"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/open

/area/muriki/bathroom/casino
	name = "\improper Casino Royal Flush"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/phoronics
	name = "\improper Pressure Release Chamber"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	base_turf = /turf/simulated/open

/area/muriki/bathroom/confinement_beam
	name = "\improper Orbital Bombardment Chamber"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	base_turf = /turf/space

/area/muriki/bathroom/ai_download
	name = "\improper AI Download Chamber"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/muriki/bathroom/bunker_buster
	name = "\improper Bunker Buster"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

//
// Medical ---------------------------------------------------------
//

/area/maintenance/medbay_roof
	name = "\improper Medical Roof Maintenance"
	base_turf = /turf/simulated/open
	sound_env = SMALL_ENCLOSED

/area/maintenance/cargobay_roof
	name = "\improper Disposal Pressure Management"
	base_turf = /turf/simulated/open
	sound_env = SMALL_ENCLOSED

//
// Cargo ---------------------------------------------------------
//
/area/quartermaster/breakroom
	name = "\improper Cargo Break Room"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "orawhicir"
	sound_env = SMALL_SOFTFLOOR
	color_grading = COLORTINT_WARM

/area/maintenance/substation/mining
	name = "Mining Substation"
	base_turf = /turf/simulated/open

/area/quartermaster/mining
	name = "\improper Mining Department"
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

/area/quartermaster/mining/prep
	name = "\improper Mining Equipment Storage"
	base_turf = /turf/simulated/open

/area/quartermaster/mining/expl
	name = "\improper Exploration Equipment"
	base_turf = /turf/simulated/open

/area/quartermaster/mining/secpi
	name = "\improper Exploration Security"
	icon_state = "security_equip_storage"
	base_turf = /turf/simulated/open

/area/quartermaster/mining/processing
	name = "\improper Ore Processing"
	ambience = AMBIENCE_ENGINEERING
	base_turf = /turf/simulated/open

/area/quartermaster/mining/ore_silo
	name = "\improper Ore Silo"
	ambience = AMBIENCE_MAINTENANCE
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/quartermaster/mining/firstaid
	name = "\improper Mining First Aid"
	icon_state = "medbay2"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/open
	flags = AREA_FIRE_SUPRESSION
	lightswitch = 1

/area/quartermaster/cargupbreak
	name = "\improper Cargo Upper Break Room"
	base_turf = /turf/simulated/open
	icon_state = "orawhicir"
	color_grading = COLORTINT_DIM

/area/quartermaster/cargrecycle
	name = "\improper Cargo Recycling"
	base_turf = /turf/simulated/open
	icon_state = "orawhicir"
	ambience = AMBIENCE_ENGINEERING

/area/muriki/septic
	name = "\improper Septic Tank"
	base_turf = /turf/simulated/open/muriki
	icon_state = "green"
	color_grading = COLORTINT_DARK

/area/muriki/yard
	name = "\improper The Yard"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "yelwhicir"

/area/muriki/station/trawler_dock
	name = "\improper Mining trawler Landing Pad"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "orablasqu"

/area/maintenance/cargoupper
	name = "Cargo Roof Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "green"

/area/maintenance/cargomid
	name = "Cargo Disposal Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "orawhicir"

//
// Civilian ---------------------------------------------------------
//
/area/muriki/arriveelev
	name = "\improper Arrivals Elevators"
	icon_state = "shuttle"
	ambience = AMBIENCE_GENERIC
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS
	flags = AREA_FIRE_SUPRESSION
	lightswitch = 0

/area/muriki/arriveproc
	name = "\improper Arrivals Processing"
	icon_state = "blublacir"
	ambience = AMBIENCE_GENERIC
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/muriki/arrivejani
	name = "\improper Arrivals Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	holomap_color = HOLOMAP_AREACOLOR_JANITOR
	color_grading = COLORTINT_DIM

/area/muriki/janiextra
	name = "\improper Overflow Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	holomap_color = HOLOMAP_AREACOLOR_JANITOR
	color_grading = COLORTINT_DIM

/area/muriki/janiupstairs
	name = "\improper Hydroponics Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	holomap_color = HOLOMAP_AREACOLOR_JANITOR
	color_grading = COLORTINT_DIM

/area/muriki/cybstorage
	name = "\improper Cyborg Storage"
	icon_state = "shuttle"
	ambience = AMBIENCE_GENERIC
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS
	lightswitch = 0

/area/muriki/crew/
	name = "\improper Crew Area"
	icon_state = "cyawhicir"
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	ambience = AMBIENCE_GENERIC

/area/muriki/crew/arcade
	name = "\improper Arcade"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "cyawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/casino
	name = "\improper Casino and Smoke Lounge"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "cyawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/casinostore
	name = "\improper Casino Storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "orawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/barback
	name = "\improper Bartender Backroom"
	icon_state = "cyawhicir"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/arcade/lasertag
	name = "\improper Laser Tag Arena"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "purwhitri"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/arcade/lasertagstore
	name = "\improper Laser Tag Storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "purwhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_DIM

/area/muriki/crew/sauna1
	name = "\improper Sauna Room One"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "bluewnew"
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_COZY

/area/muriki/crew/sauna2
	name = "\improper Sauna Room Two"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "bluewnew"
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_COZY

/area/muriki/crew/poollocker
	name = "\improper Pool Showers"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "locker"
	sound_env = MEDIUM_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/judge
	name = "\improper Judge's Office"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "bluenew"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/glass
	name = "\improper Dorm Dayroom"
	icon_state = "recreation_area"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/dormaid
	name = "\improper Dorm First Aid Station"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_FIRE_SUPRESSION

/area/muriki/crew/baraid
	name = "\improper Public First Aid Station"
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_FIRE_SUPRESSION

/area/muriki/crew/engyaid
	name = "\improper Public Cargo First Aid Station"
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_FIRE_SUPRESSION

/area/chapel/chapel_music
	name = "\improper Music Room"
	icon_state = "yellow"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/muriki/crew/vr_train
	name = "\improper Virtual Reality Training"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "blublatri"
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = RAD_SHIELDED
	color_grading = COLORTINT_DIM

/area/muriki/crew/civmail
	name = "\improper Civilian Mail Room"
	icon_state = "orablasqu"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_DIM

/area/library_office
	name = "\improper Librarian Office"
	icon_state = "library"
	base_turf = /turf/simulated/open
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_WARM

/area/maintenance/substation/arrivals
	name = "Arrivals Substation"
	base_turf = /turf/simulated/open

/area/muriki/crew/bunker
	name = "\improper Emergency Bunker Access"
	base_turf = /turf/simulated/open
	icon_state = "cyawhicir"
	flags = RAD_SHIELDED|BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT|AREA_FIRE_SUPRESSION
	color_grading = COLORTINT_DIM

/area/hallway/muriki/bunkerhall
	name = "\improper Bunker Access Hallway"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "cyawhicir"
	color_grading = COLORTINT_DIM

/area/muriki/crew/bunker_deep
	name = "\improper Emergency Bunker"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "cyawhicir"
	flags = RAD_SHIELDED|BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT|AREA_FIRE_SUPRESSION
	color_grading = COLORTINT_DARK
	haunted = TRUE

/area/muriki/crew/bunker_deep/eng
	name = "\improper Bunker Engineering"

/area/muriki/crew/bunker_deep/med
	name = "\improper Bunker Medical"

/area/muriki/crew/bunker_deep/comm
	name = "\improper Bunker Command"

/area/muriki/crew/bunker_deep/main
	name = "\improper Bunker Vault"

/area/maintenance/roof_tube_access
	name = "Civilian Roof Access"
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

//Hallways-------
/area/muriki/crewstairwell
	name = "\improper Civilian Stairwell"
	icon_state = "bluenew"
	music = 'sound/ambience/signal.ogg'
	sound_env = TUNNEL_ENCLOSED
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	use_emergency_overlay = TRUE

/area/hallway
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/hallway/muriki/dorm
	name = "\improper Dorm Hallway"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "bluewnew"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	color_grading = COLORTINT_DIM

/area/hallway/muriki/civup
	name = "\improper Civilian Upper Hallway"
	icon_state = "bluenew"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/hallway/security/main
	name = "\improper Security Main Hallway"
	icon_state = "blue"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/hallway/security/armor
	name = "\improper Security Armory Hallway"
	icon_state = "red2"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/hallway/security/upper
	name = "\improper Security Upper Hallway"
	icon_state = "blue"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/secmail
	name = "\improper Security Mail Room"
	icon_state = "orablasqu"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	color_grading = COLORTINT_DIM

//Hydro-------
/area/hydroponics
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/muriki/crew/kitchenfreezer
	name = "\improper Kitchen Freezer"
	icon_state = "bluewnew"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_COLD

/area/hydroponics/publicgarden
	name = "\improper Public Garden"
	icon_state = "cafe_garden"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/hydroponics/apiary
	name = "\improper Hydroponics Aipiary"
	icon_state = "hydro"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	color_grading = COLORTINT_WARM

/area/hydroponics/hallway
	name = "\improper Hydroponics Hallway"
	icon_state = "center"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/hydroponics/gibber //Watch your step~
	name = "\improper Hydroponics Gibber Deposit"
	icon_state = "red2"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	color_grading = COLORTINT_CHILL

//
// Engineering -----------------------------------------------------
//
/area/engineering
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/engineering/trammaint
	name = "\improper Tram Maintenance Room"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "engineering"
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM
	lightswitch = 1

/area/engineering/hardsuitstore
	name = "\improper Engineering Hardsuit Storage"
	icon_state = "eva"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/enginestorage
	name = "\improper Engine Storage"
	icon_state = "primarystorage"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM

/area/engineering/refinery
	ambience = AMBIENCE_MAINTENANCE
	color_grading = COLORTINT_DIM

/area/engineering/refinery/main
	name = "\improper Chemical Refinery"
	icon_state = "primarystorage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/refinery/aid_station
	name = "\improper Refinery Medical Station"
	icon_state = "medbay2"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_FIRE_SUPRESSION

/area/engineering/refinery/tankstorage
	name = "\improper Chemical Refinery Tank Storage"
	icon_state = "eva"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	lightswitch = 1

/area/engineering/refinery/backup_gen
	name = "\improper Chemical Refinery Generator"
	icon_state = "darkred"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/refinery/observation
	name = "\improper Chemical Refinery Observation Room"
	icon_state = "darkred"
	base_turf = /turf/simulated/open
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/refinery/lab
	name = "\improper Chemical Refinery Lab"
	icon_state = "primarystorage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ATMOS
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/refinery/tugstorage
	name = "\improper Chemical Refinery Tug Storage"
	icon_state = "auxstorage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	lightswitch = 1

/area/engineering/refinery/pump_station
	name = "\improper Chemical Refinery Pump Station"
	icon_state = "maint_pumpstation"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/auxstore
	name = "\improper Engineering Aux Storage"
	icon_state = "auxstorage"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/corepower
	name = "\improper Engine Generator"
	icon_state = "engine"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/eva
	name = "\improper Engineering Exterior Access"
	icon_state = "eva"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/gravgen
	name = "\improper Elevator Gravity Assist"
	icon_state = "maint_pumpstation"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	outdoors = FALSE
	lightswitch = 1

/area/engineering/coreproctunnel
	name = "\improper Core Processor Atmo Tunnel"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "darkred"
	sound_env = TUNNEL_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	music = 'sound/ambience/ambimine.ogg'
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	use_emergency_overlay = FALSE
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	color_grading = COLORTINT_UNDERDARK

/area/engineering/atmos/tank_storage
	name = "\improper Atmospherics Secure Storage"
	color_grading = COLORTINT_DARK

//them dat der bluespezz warpy magic
/area/teleporter/engineering
	name = "\improper Engineering Teleporter"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DARK

/area/teleporter/bridge
	name = "\improper Bridge Teleporter"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

//AI sat
/area/ai_sat
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	sound_env = TUNNEL_ENCLOSED
	ambience = AMBIENCE_HIGHSEC
	use_emergency_overlay = TRUE
	base_turf = /turf/simulated/mineral/floor/vacuum

/area/ai_sat/core_external
	name = "\improper AI Satellite External Core"

/area/ai_sat/docking_wing
	name = "\improper AI Satellite Docking Wing"

/area/ai_sat/fore_airlock
	name = "\improper AI Satellite Fore Airlock"
	sound_env = SMALL_ENCLOSED

/area/ai_sat/solar_airlock
	name = "\improper AI Satellite Solar Airlock"
	sound_env = SMALL_ENCLOSED

/area/ai_sat/storage
	name = "\improper AI Satellite Secure Storage"
	color_grading = COLORTINT_DIM

/area/ai_sat/access_shaft
	name = "\improper AI Satellite Access Shaft"

/area/ai_sat/observation
	name = "\improper AI Satellite Observation Deck"
	sound_env = SMALL_ENCLOSED

/area/ai_sat/atmos
	name = "\improper AI Satellite Atmospherics"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE
	color_grading = COLORTINT_DARK

/area/ai_sat/power_control
	name = "\improper AI Satellite Power Control"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	base_turf = /turf/space
	color_grading = COLORTINT_DARK

//
// Elevator -------------------------------------------------------
// mapping areas
/area/muriki/elevator
	use_emergency_overlay = TRUE

/area/muriki/elevator/secbase
	name = "Security Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/secmain
	name = "Security First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/secupper
	name = "Security Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/medibasement
	name = "Medbay Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/medical
	name = "Medbay First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/mediupper
	name = "Medbay Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/civbase
	name = "Civilian Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/civmain
	name = "Civilian First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/civupper
	name = "Civilian Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/scibase
	name = "Science Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/scimain
	name = "Science First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open
/area/muriki/elevator/sciupper
	name = "Science Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/open

// finalized elevator areas, lift itself makes these once init
/area/turbolift
	delay_time = 2 SECONDS
	forced_ambience = list('modular_outpost/sound/music/elevator2.ogg')
	dynamic_lighting = FALSE //Temporary fix for elevator lighting
	flags = RAD_SHIELDED
	requires_power = FALSE
	use_emergency_overlay = TRUE

//SECURITY
/area/turbolift/secbase
	name = "Security Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Security Basement"
	lift_floor_name = "Brig."
	lift_announce_str = "Arriving at Security Basement."
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/turbolift/secmain
	name = "Security First Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Security Main"
	lift_floor_name = "Primary Security."
	lift_announce_str = "Arriving at Security Primary."
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/turbolift/secupper
	name = "Security Second Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Security High Level"
	lift_floor_name = "AI, Telecoms, Evac shuttle."
	lift_announce_str = "Arriving at Security Upper Floor."
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

//MEDICAL
/area/turbolift/medibasement
	name = "Medbay Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Medical Basement"
	lift_floor_name = "Vox Treatment, Morgue, Surgery Training, Cavern Access."
	lift_announce_str = "Arriving at Medical Basement."
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/turbolift/medical
	name = "Medbay First Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Medbay"
	lift_floor_name = "Lobby, Surgery, Primary Treatment, Psychology."
	lift_announce_str = "Arriving at Medbay Primary."
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/turbolift/mediupper
	name = "Medbay Second Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Medical Recovery"
	lift_floor_name = "Resleeving, CMO, Checkup, Recovery ward, Hangar."
	lift_announce_str = "Arriving at Medical Loft."
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

//Civilian
/area/turbolift/civbase
	name = "Civilian Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Basement"
	lift_floor_name = "Cafe, Pool, Dorms, Arcade, Cavern Access."
	lift_announce_str = "Arriving at Basement."
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/turbolift/civmain
	name = "Civilian First Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "First Floor"
	lift_floor_name = "Bar, Bridge, Evac Hallway."
	lift_announce_str = "Arriving at First Floor."
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/turbolift/civupper
	name = "Civilian Second Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Second Floor"
	lift_floor_name = "Chapel, Library, Garden."
	lift_announce_str = "Arriving at Second Floor."
	holomap_color = HOLOMAP_AREACOLOR_CIV

//Science
/area/turbolift/scibase
	name = "Science Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Research Basement"
	lift_floor_name = "Xenobio, Particle lab, Xenoarch, Cavern Access"
	lift_announce_str = "Arriving at Basement."
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/turbolift/scimain
	name = "Science First Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Research First Floor"
	lift_floor_name = "RnD, Telesci, Laboratory."
	lift_announce_str = "Arriving at First Floor."
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/turbolift/sciupper
	name = "Science Second Floor"
	base_turf = /turf/simulated/open
	lift_floor_label = "Research Second Floor"
	lift_floor_name = "Xenoflora, Chemistry, Phoronics, RD."
	lift_announce_str = "Arriving at Second Floor."
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

//
//----------------- Exterior / hazard areas / mine ---------------------------------
//
/area/muriki/grounds //Non dangerous variant, for inside the fence
	name = "\improper Facility Grounds"
	icon_state = "dark"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	outdoors = TRUE

/area/muriki/grounds/graveyard
	name = "\improper Facility Graveyard"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "outside1"

/area/muriki/grounds/terraform
	name = "\improper Facility Terraformer Base"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "outside2"

/area/muriki/grounds/engi
	name = "\improper Facility Near Engineering"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "orablatri"

/area/muriki/grounds/waste
	name = "\improper Facility Near Waste Management"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "orablatri"

/area/muriki/grounds/sec
	name = "\improper Facility Near Security"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "redblatri"

/area/muriki/grounds/sec/garage_entrance
	name = "\improper Security Garage Entrance"
	icon_state = "cyablatri"
	base_turf = /turf/simulated/open/muriki

/area/muriki/grounds/med
	name = "\improper Facility Near Medical"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "cyablatri"

/area/muriki/grounds/shutt
	name = "\improper Facility Shuttle Pads"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "deck1"

/area/muriki/grounds/civ
	name = "\improper Facility Near Civilian Structure"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "bluwhitri"

/area/muriki/grounds/sci
	name = "\improper Facility Near Science"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "purblatri"

/area/muriki/grounds/tramborder
	name = "\improper Tram Line Edge"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "redwhicir"

/area/muriki/grounds/tramborder/garage
	name = "\improper Medical Garage Entrance"
	base_turf = /turf/simulated/open/muriki
	icon_state = "purblatri"

/area/muriki/grounds/tramlineeast
	name = "\improper Eastern Tram Line"
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki
	icon_state = "redblasqu"

/area/muriki/grounds/tramlinewest
	name = "\improper Western Tram Line"
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki
	icon_state = "redblatri"

//Mine variants for mob spawns.
/area/mine/explored/muriki/surface
	name = "\improper Facility Grounds"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	music = 'sound/ambience/ambiatm1.ogg'

/area/mine/unexplored/muriki/surface
	name = "\improper Facility Grounds"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/mine/explored/muriki/cave
	name = "\improper Facility Tunnels"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = TUNNEL_ENCLOSED
	flags = AREA_BLOCK_GHOST_SIGHT | AREA_FLAG_IS_NOT_PERSISTENT
	color_grading = COLORTINT_DARK

/area/mine/unexplored/muriki/cave
	name = "\improper Muriki Caverns"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = TUNNEL_ENCLOSED
	flags = AREA_BLOCK_GHOST_SIGHT | AREA_FLAG_IS_NOT_PERSISTENT
	color_grading = COLORTINT_DARK

//Subdivided areas because holy crap zas hates our map.
//Basement. Dept.
/area/mine/explored/muriki
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
/area/mine/unexplored/muriki
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/mine/explored/muriki/cave/eng
	name = "\improper Facility Engineering Tunnels"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "orange"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
/area/mine/unexplored/muriki/cave/eng
	name = "\improper Muriki Caverns Near Engineering"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "orange"

/area/mine/explored/muriki/cave/cargo
	name = "\improper Muriki Cargo Isle Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "yellow"
/area/mine/unexplored/muriki/cave/cargo
	name = "\improper Muriki Caverns Near Cargo"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "yellow"

/area/mine/explored/muriki/cave/waste
	name = "\improper Muriki Waste Processing Caves"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "green"
/area/mine/unexplored/muriki/cave/waste
	name = "\improper Muriki Caverns Near Waste"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "green"

/area/mine/explored/muriki/cave/sec
	name = "\improper Muriki Security Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "darkred"
/area/mine/unexplored/muriki/cave/sec
	name = "\improper Muriki Caverns Near Security"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "darkred"

/area/mine/explored/muriki/cave/med
	name = "\improper Muriki Medical Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "bluenew"

/area/mine/unexplored/muriki/cave/med
	name = "\improper Muriki Caverns Near Medical"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "bluenew"

/area/mine/explored/muriki/cave/sci
	name = "\improper Muriki Research Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "purple"
/area/mine/unexplored/muriki/cave/sci
	name = "\improper Muriki Caverns Near Research"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "purple"

/area/mine/explored/muriki/cave/civ
	name = "\improper Muriki Civilian Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dark128"
/area/mine/unexplored/muriki/cave/civ
	name = "\improper Muriki Caverns Near Civilian"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dark128"

//cavern access
/area/mine/explored/muriki/cave/sci/west_access
	name = "\improper Research Cavern Access West"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "purple"
/area/mine/explored/muriki/cave/sci/east_access
	name = "\improper Research Cavern Access East"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "purple"
/area/maintenance/research/north
	name = "\improper North Research Maintenance"
	icon_state = "pmaint"
/area/maintenance/research/closet
	name = "\improper Research Maintenance Closet"
	icon_state = "pmaint"

/area/mine/explored/muriki/cave/med/east_access
	name = "\improper Medical Cavern Access West"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "bluenew"
	color_grading = COLORTINT_DIM
/area/mine/explored/muriki/cave/med/resleever_exit
	name = "\improper Medical Automatic Resleeving Access"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "bluenew"
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DIM

/area/mine/explored/muriki/cave/civ/south_access
	name = "\improper Civilian Cavern Access South"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dark128"
/area/mine/explored/muriki/cave/civ/east_access
	name = "\improper Civilian Cavern Access East"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dark128"

/area/maintenance/civ/closet
	name = "\improper Civilian Maintenance Closet"
	sound_env = TUNNEL_ENCLOSED
	color_grading = COLORTINT_DIM

/area/maintenance/civ/bunker
	name = "\improper Bunker Maintenance"
	sound_env = TUNNEL_ENCLOSED
	color_grading = COLORTINT_DIM

/area/maintenance/civ/north
	name = "\improper North Civilian Maintenance"
	sound_env = TUNNEL_ENCLOSED

/area/maintenance/civ/east
	name = "\improper East Civilian Maintenance"
	sound_env = TUNNEL_ENCLOSED

//fillers
/area/mine/unexplored/muriki/cave/terra
	name = "\improper Muriki Caverns Near Terraformer"
	icon_state = "cave"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/west
	name = "\improper Muriki Western Caverns"
	icon_state = "west"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/south
	name = "\improper Muriki Southern Caverns"
	icon_state = "south"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/east
	name = "\improper Muriki Eastern Caverns"
	icon_state = "east"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/north
	name = "\improper Muriki Northern Caverns"
	icon_state = "north"
	sound_env = TUNNEL_ENCLOSED

//below the mountain
/area/mine/explored/muriki/mountainbase
	name = "\improper Facility Mountain Caves"
	icon_state = "center"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE

/area/mine/unexplored/muriki/mountainbase
	name = "\improper Muriki Eastern Mountain Caverns"
	icon_state = "east"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE

/area/mine/unexplored/muriki/mountainbasenorth
	name = "\improper Muriki Northern Mountain Caverns"
	icon_state = "north"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE

//------second floor------
/area/mine/unexplored/muriki/mountainnorth
	name = "\improper Muriki Northern Mountain Caverns"
	icon_state = "north"
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE
/area/mine/unexplored/muriki/mountaineast
	name = "\improper Muriki Eastern Mountain Caverns"
	icon_state = "east"
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE
/area/mine/explored/muriki/mountainnorth
	name = "\improper North Facility Mountainside"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "north"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	outdoors = TRUE
/area/mine/explored/muriki/mountaineast
	name = "\improper Eastern Facility Mountainside"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	icon_state = "east"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	outdoors = TRUE
/area/mine/explored/muriki/valley
	name = "\improper Valley Edge"
	icon_state = "center"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	outdoors = TRUE
/area/mine/unexplored/muriki/valleyeast
	name = "\improper Muriki Lower Valley"
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki
	icon_state = "east"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	outdoors = TRUE
/area/mine/unexplored/muriki/valleywest
	name = "\improper Muriki Lower Valley"
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki
	icon_state = "west"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	outdoors = TRUE

//-------third floor--------
/area/mine/explored/muriki/mountaintopnorth
	name = "\improper North Facility Mountaintop"
	icon_state = "north"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/explored/muriki/mountaintopeast
	name = "\improper Eastern Facility Mountaintop"
	icon_state = "east"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/unexplored/muriki/mountaintopnorth
	name = "\improper Muriki Northern Mountaintop Caverns"
	icon_state = "north"
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE
/area/mine/unexplored/muriki/mountaintopeast
	name = "\improper Muriki Eastern Mountaintop Caverns"
	icon_state = "east"
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE
/area/muriki/crystal
	name = "\improper Muriki Crystal Den"
	icon_state = "bluwhicir"
	sound_env = TUNNEL_ENCLOSED
	outdoors = FALSE
/area/mine/unexplored/muriki/mountaintop_pathway // special, outdoors but not skyline
	name = "\improper Muriki Eastern Mountaintop Path"
	icon_state = "dark"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	outdoors = FALSE
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki
	outdoors = TRUE

//Skyline
/area/muriki/skyline
	name = "\improper Facility Airspace"
	icon_state = "dark"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'
	outdoors = TRUE
	dynamic_lighting = FALSE // Disable sky light
	base_turf = /turf/simulated/open/muriki

/area/muriki/skyline/east
	name = "\improper Eastern Facility Airspace"
	icon_state = "east"

/area/muriki/skyline/west
	name = "\improper Western Facility Airspace"
	icon_state = "west"

/area/muriki/skyline/north
	name = "\improper Northern Facility Airspace"
	icon_state = "north"

/area/muriki/skyline/south
	name = "\improper Southern Facility Airspace"
	icon_state = "south"

/area/muriki/skyline/cent
	name = "\improper Central Facility Airspace"
	icon_state = "center"

//Other areas in the caves
/area/mine/explored/muriki/tuggrave
	name = "\improper Tug Graveyard"
	base_turf = /turf/simulated/open/muriki
	sound_env = TUNNEL_ENCLOSED
	flags = AREA_BLOCK_GHOST_SIGHT|AREA_FLAG_IS_NOT_PERSISTENT
	icon_state = "dk_yellow"
	color_grading = COLORTINT_UNDERDARK

/area/mine/explored/muriki/liminaltoobs
	name = "\improper Disposal Return Maintenance"
	base_turf = /turf/simulated/open/muriki
	sound_env = TUNNEL_ENCLOSED
	flags = AREA_BLOCK_GHOST_SIGHT|AREA_FLAG_IS_NOT_PERSISTENT
	icon_state = "dk_yellow"
	color_grading = COLORTINT_DARK

//Moon riiiiver
/area/mine/explored/muriki/river
	name = "\improper Muriki River"
	icon_state = "blue2"
	base_turf = /turf/simulated/floor/water/acidic/deep/turfpack/muriki
	sound_env = SOUND_ENVIRONMENT_SEWER_PIPE
	flags = AREA_BLOCK_GHOST_SIGHT|AREA_FLAG_IS_NOT_PERSISTENT
	music = 'sound/ambience/ruins/ruins3.ogg'
	color_grading = COLORTINT_DIM

/area/mine/explored/muriki/river/mouth
	name = "\improper River Mouth"

/area/mine/explored/muriki/river/north
	name = "\improper River North"

/area/mine/explored/muriki/river/south
	name = "\improper River South"

/area/mine/explored/muriki/river/east
	name = "\improper River East"

/area/mine/explored/muriki/river/hole
	name = "\improper River Cave-in"
	base_turf = /turf/simulated/open/muriki

/area/mine/explored/muriki/river/end
	name = "\improper River Falls"

//
// Maintenance ------------------------------------------------------------
//
/area/maintenance
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_GHOST_SIGHT
	color_grading = COLORTINT_DARK

/area/maintenance/basement
	name = "Maintenance"
	icon_state = "amaint"
	ambience = list('sound/ambience/maintenance/maintenance1.ogg','sound/ambience/maintenance/maintenance2.ogg')
	flags = RAD_SHIELDED

/area/maintenance/main
	name = "Maintenance"
	icon_state = "amaint"
	ambience = list('sound/ambience/maintenance/maintenance1.ogg','sound/ambience/maintenance/maintenance2.ogg')
	flags = RAD_SHIELDED

/area/maintenance/upper
	name = "Maintenance"
	icon_state = "amaint"
	ambience = list('sound/ambience/maintenance/maintenance1.ogg','sound/ambience/maintenance/maintenance2.ogg')
	flags = RAD_SHIELDED

/area/maintenance/medicelev
	name = "\improper Medical Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_medbay"

/area/maintenance/medicelevbasement
	name = "\improper Medical Elevator Maintenance Foundation"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "maint_medbay"

/area/maintenance/secelev
	name = "\improper Security Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_security_port"

/area/maintenance/secelevbasement
	name = "\improper Security Elevator Maintenance Foundation"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "pmaint"

/area/maintenance/scielev
	name = "\improper Research Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_research_shuttle"

/area/maintenance/scielev
	name = "\improper Research Phoronics Maintenance"
	icon_state = "maint_research_shuttle"

/area/maintenance/scielevbasement
	name = "\improper Research Elevator Maintenance Foundation"
	icon_state = "pmaint"

/area/maintenance/research/geneticshole
	name = "\improper Research Genetics Hole"
	icon_state = "pmaint"
	base_turf = /turf/simulated/open

/area/maintenance/crewelev
	name = "\improper Civilian Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_security_port"

/area/maintenance/crewelevbasement
	name = "\improper Civilian Elevator Maintenance Foundation"
	icon_state = "pmaint"

/area/maintenance/wastedisposal
	name = "\improper Waste Disposal Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "maint_research_shuttle"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	use_emergency_overlay = TRUE

/area/maintenance/damaged_resleeverA
	name = "\improper Collapsed Structure"
	base_turf = /turf/simulated/open
	icon_state = "maint_research_shuttle"
	flags = RAD_SHIELDED | AREA_BLOCK_SUIT_SENSORS | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT
	requires_power = FALSE
	haunted = TRUE
	color_grading = COLORTINT_OMEN

/area/maintenance/damaged_resleeverB
	name = "\improper Damaged Structure"
	base_turf = /turf/simulated/open
	icon_state = "maint_research_shuttle"
	flags = RAD_SHIELDED | AREA_BLOCK_SUIT_SENSORS | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT
	requires_power = FALSE
	haunted = TRUE
	color_grading = COLORTINT_OMEN

/area/maintenance/wastedisposalnear
	name = "\improper Near Waste Disposal Maintenance"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "maint_medbay"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/maintenance/wastenear
	name = "\improper Near Waste Maintenance"
	icon_state = "blue"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/sec
	name = "\improper Near Security Maintenance"
	icon_state = "blue"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/med
	name = "\improper Near Medical Maintenance"
	icon_state = "bluenew"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/sci
	name = "\improper Near Science Maintenance"
	icon_state = "purple"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/civ
	name = "\improper Civilian Pool Maintenance"
	icon_state = "maintcentral"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/eng
	name = "\improper Near Engineering Maintenance"
	icon_state = "maint_engineering"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/bridge
	name = "\improper Bridge Maintenance"
	icon_state = "bluenew"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/kennel
	name = "\improper Kennels Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "blue"

/area/maintenance/gravgen
	name = "\improper Gravity Generator Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "blue"
	color_grading = COLORTINT_DIM

/area/maintenance/oldbridge
	name = "\improper Abandoned Bridge"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon = 'icons/turf/areas.dmi'
	icon_state = "bridge"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT
	broken_light_chance = 85
	haunted = TRUE
	color_grading = COLORTINT_DIM

//Cavern maintenance
/area/maintenance/cave
	name = "\improper Facility Lower Maintenance"
	icon_state = "dark128"
	color_grading = COLORTINT_DIM

/area/maintenance/spine
	name = "\improper Maintenance Spine"
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "orawhisqu"

/area/maintenance/spine/civ
	name = "\improper Maintenance Spine Civilian"

/area/maintenance/spine/eng
	name = "\improper Maintenance Spine Engineering"

/area/maintenance/spine/waste
	name = "\improper Maintenance Spine Waste"

/area/maintenance/tug
	name = "\improper Maintenance Tug Tunnel"
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "deckmaint1"
	use_emergency_overlay = TRUE

//
// Collapsed underdark entrances ------------------------------------------------------------
//
/area/mine/unexplored/muriki/cave/underdark_pit
	name = "\improper Collapsed Cavern"
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "deckmaint1"
	base_turf = /turf/simulated/open/muriki
	sound_env = SOUND_ENVIRONMENT_SEWER_PIPE
	flags = AREA_BLOCK_GHOST_SIGHT | AREA_FLAG_IS_NOT_PERSISTENT
	color_grading = COLORTINT_UNDERDARK

/area/mine/unexplored/muriki/cave/underdark_pit/south_west_waste
	name = "\improper South West Collapsed Cavern"

/area/mine/unexplored/muriki/cave/underdark_pit/south_civ
	name = "\improper Southern Collapsed Cavern"

/area/mine/unexplored/muriki/cave/underdark_pit/east_civ
	name = "\improper Eastern Collapsed Cavern"

/area/mine/unexplored/muriki/cave/underdark_pit/medical_access
	name = "\improper Medical Emergency Cavern Access"

/area/mine/unexplored/muriki/cave/underdark_pit/central_eng
	name = "\improper Engineering Collapsed Cavern"

/area/mine/unexplored/muriki/cave/underdark_pit/east_sci
	name = "\improper North Eastern Collapsed Cavern"

/area/mine/unexplored/muriki/cave/underdark_pit/west_terraformer
	name = "\improper North West Collapsed Cavern"

/area/mine/unexplored/muriki/cave/shelter
	name = "\improper Cavern Shelter"
	icon_state = "deckmaint1"
	base_turf = /turf/simulated/open/muriki
	sound_env = SOUND_ENVIRONMENT_BATHROOM
	flags = AREA_BLOCK_GHOST_SIGHT | AREA_FLAG_IS_NOT_PERSISTENT
	color_grading = COLORTINT_DIM

/area/mine/unexplored/muriki/cave/shelter/north_west_far
	name = "\improper Far North Western Cavern Shelter"

/area/mine/unexplored/muriki/cave/shelter/north_west
	name = "\improper North Western Cavern Shelter"

/area/mine/unexplored/muriki/cave/shelter/north
	name = "\improper Northern Cavern Shelter"

/area/mine/unexplored/muriki/cave/shelter/north_east
	name = "\improper North Eastern Cavern Shelter"

/area/mine/unexplored/muriki/cave/shelter/east
	name = "\improper Eastern Cavern Shelter"

//
// Medical ------------------------------------------------------------
//
/area/medical
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/medical/stairwell
	name = "\improper Medical Stairwell"
	icon_state = "bluenew"
	music = 'sound/ambience/signal.ogg'
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/maintenance/substation/virology
	name = "Virology Substation"
	base_turf = /turf/simulated/open

/area/medical/laundry
	name = "\improper Medical Laundry Room"
	icon_state = "locker"
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/mail
	name = "\improper Medical Mailing Room"
	icon_state = "quartdelivery"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/medical/chem_storage
	name = "\improper Medical Chemical Storage"
	icon_state = "locker"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_ENCLOSED
	color_grading = COLORTINT_CHILL

/area/medical/locker
	name = "\improper Medical Locker Room"
	icon_state = "locker"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/recovlaund
	name = "\improper Medical Recovery Laundry"
	icon_state = "locker"
	flags = RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/evastore
	name = "\improper Medical Hazop And Hardsuit Storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "locker"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/sleevecheck
	name = "\improper Medical Resleeving Verification"
	icon_state = "medbay3"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/checkup
	name = "\improper Medical Examination Room"
	icon_state = "medbay3"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgtrain
	name = "\improper Medical Surgery Training Theater"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "medbay4"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/hallway/secondary/secmedbridge
	name = "\improper Medical Security Transfer Bridge"
	icon_state = "blue-red2"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

//vox treatment: In compliance with....

/area/medical/voxlab
	name = "\improper Vox Treatment Lab"
	icon_state = "purple"
	sound_env = SMALL_ENCLOSED
	flags = AREA_FORBID_EVENTS|AREA_FIRE_SUPRESSION
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	ambience = list(AMBIENCE_OTHERWORLDLY, AMBIENCE_OUTPOST)
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/airgap
	name = "\improper Vox Treatment Airgap"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/airlock
	name = "\improper Vox Treatment Airlock"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/lobby
	name = "\improper Vox Treatment Lobby"
	icon_state = "decontamination"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/main
	name = "\improper Vox Treatment Lab"
	icon_state = "medbay_triage"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/storage
	name = "\improper Vox Treatment Storage"
	icon_state = "storage"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/surgery
	name = "\improper Vox Surgery"
	icon_state = "surgery"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/chem
	name = "\improper Vox Chemistry Lab"
	icon_state = "chem"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/recov
	name = "\improper Vox Recovery"
	icon_state = "Sleep"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/breakroom
	name = "\improper Vox Lab Breakroom"
	icon_state = "bar"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	color_grading = COLORTINT_WARM

/area/medical/hangar
	name = "\improper Medevac Shuttle Hangar"
	icon_state = "medical"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	color_grading = COLORTINT_DARK

/area/medical/tankstore
	name = "\improper Nurse Bradley's Office"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	color_grading = COLORTINT_DIM

/area/medical/autosleever
	name = "\improper Automated Resleever"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/medical/virology/prep
	name = "\improper Virology Preperation"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/virology/quarantine_airlock
	name = "\improper Virology Quarantine Airlock"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/virology/quarantine_quarantine
	name = "\improper Virology Quarantine"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

//
// Rooftops-----------------------------------------------------------------------
//
/area/muriki/rooftop
	name = "\improper Rooftop"
	icon = 'icons/turf/areas.dmi'
	icon_state = "away"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'
	base_turf = /turf/simulated/open
	outdoors = TRUE

/area/muriki/rooftop/engineering
	name = "\improper Engineering Roof"
	icon_state = "away4"

/area/muriki/rooftop/cargo
	name = "\improper Cargo Roof"
	icon_state = "away"

/area/muriki/rooftop/disposal
	name = "\improper Waste Management Roof"
	icon_state = "away"

/area/muriki/rooftop/medical
	name = "\improper Medical Roof"
	icon_state = "away1"

/area/muriki/rooftop/security
	name = "\improper Security Roof"
	icon_state = "away3"

/area/muriki/rooftop/science
	name = "\improper Science Roof"
	icon_state = "away2"

/area/muriki/rooftop/civilian
	name = "\improper Civilian Roof"
	icon_state = "away"

//
//Backup Generators
//
/area/muriki/rooftop/medgen
	name = "\improper Medical Backup Generator"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	icon_state = "blue"
	outdoors = FALSE
	color_grading = COLORTINT_DIM

/area/muriki/rooftop/scigen
	name = "\improper Research Backup Generator"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	icon_state = "blue"
	outdoors = FALSE
	color_grading = COLORTINT_DIM

/area/muriki/rooftop/civgen
	name = "\improper Civilian Backup Generator"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	icon_state = "blue"
	outdoors = FALSE
	color_grading = COLORTINT_DIM

/area/muriki/rooftop/secgen
	name = "\improper Security Backup Generator"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	icon_state = "blue"
	outdoors = FALSE
	color_grading = COLORTINT_DIM

/area/muriki/rooftop/comgen
	name = "\improper Command Backup Generator"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "blue"
	outdoors = FALSE
	color_grading = COLORTINT_DIM

/area/muriki/rooftop/cargen
	name = "\improper Cargo Backup Generator"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open
	icon_state = "blue"
	outdoors = FALSE
	color_grading = COLORTINT_DIM

//
// Security-----------------------------------------------------------------------
//
/area/security
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/security/brig/low
	name = "\improper Security Low Security Brig"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
	color_grading = COLORTINT_DIM

/area/security/brig/lowobservation
	name = "\improper Security Sparring Ring"
	base_turf = /turf/simulated/open
	icon_state = "security_sub"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/observation
	name = "\improper Security Brig Observation"
	base_turf = /turf/simulated/open
	icon_state = "security_sub"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/drunk
	name = "\improper Security Drunktank"
	base_turf = /turf/simulated/open
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/isolate
	name = "\improper Security Solitary Confinement"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
	color_grading = COLORTINT_DIM

/area/security/tankstore
	name = "\improper Security Heavy Armor Storage"
	icon_state = "security_sub"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
	flags = RAD_SHIELDED|BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT
	color_grading = COLORTINT_DIM

/area/security/mechent
	name = "\improper Security Mech Entrance"
	icon_state = "security_sub"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/kennels
	name = "\improper Security Kennels"
	icon_state = "red2"
	flags = AREA_FLAG_IS_NOT_PERSISTENT // Lets avoid the bowls stacking for the otties
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/eva
	name = "\improper Security External Access"
	icon_state = "red2"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/stairwell
	name = "\improper Security Stairwell"
	icon_state = "red2"
	sound_env = TUNNEL_ENCLOSED
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/hangar
	name = "\improper Security hangar"
	icon_state = "red2"
	sound_env = LARGE_ENCLOSED
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/surgery
	name = "\improper Security Operating Theatre"
	icon_state = "surgery"
	flags = AREA_FLAG_IS_NOT_PERSISTENT //This WOULD become a filth pit
	lightswitch = 1

/area/security/brig_hole
	name = "\improper Security Hole"
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

//
// Science-----------------------------------------------------------------------
//
/area/rnd
	name = "\improper Research"
	icon = 'icons/turf/areas.dmi'
	icon_state = "purple"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	use_emergency_overlay = TRUE

/area/constructionsite/science2
	name = "\improper Research Construction Site"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "construction"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	use_emergency_overlay = TRUE

/area/rnd/chemistry
	name = "\improper Research Backup Chemistry"
	icon_state = "chem"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/breakroom
	name = "\improper Research Breakroom"
	icon_state = "locker"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_WARM

/area/rnd/lockers
	name = "\improper Research Locker Room"
	icon_state = "locker"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/entry
	name = "\improper Research Entryway Decontamination"
	icon_state = "decontamination"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	flags = AREA_FIRE_SUPRESSION

/area/rnd/entry_aux
	name = "\improper Research Auxiliary Decontamination"
	icon_state = "decontamination"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/stairwell
	name = "\improper Science Stairwell"
	icon_state = "purple"
	base_turf = /turf/simulated/open
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	lightswitch = 1

/area/rnd/otherlab
	name = "\improper RnD Auxillary Laboratory"
	icon_state = "outpost_research"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_DIM

/area/rnd/telesci
	name = "\improper Research Telescience"
	icon_state = "teleporter"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	flags = AREA_FIRE_SUPRESSION

/area/rnd/xenobiology/xenoflora2
	name = "\improper Xenoflora Hazard Lab"
	icon_state = "xeno_f_lab"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology/xenobioh
	name = "\improper Hazardous Xenobiology Lab"
	icon_state = "xeno_f_lab"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	flags = BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT

/area/rnd/xenobiology/xenobiohstore
	name = "\improper Hazardous Xenobiology Storage"
	icon_state = "research_storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	flags = BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT

/area/rnd/xenobiology/burn
	name = "\improper Xenobiology Threat Supression"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "red2"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	flags = AREA_FIRE_SUPRESSION

/area/rnd/research/atmosia
	name = "\improper Sphenoidal Atmospherics"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM

/area/rnd/research/analysis
	name = "\improper Research Sample Analysis"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/anomaly
	name = "\improper Anomalous Materials Lab"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/medical
	name = "\improper Xenolab First aid"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_FIRE_SUPRESSION
	lightswitch = 1

/area/rnd/research/isolation_a
	name = "\improper Research Isolation 1"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/isolation_b
	name = "\improper Research Isolation 2"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/isolation_c
	name = "\improper Research Isolation 3"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/longtermstorage
	name = "\improper Xenolab Long-Term Storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_DARK

/area/rnd/research/anomaly_storage
	name = "\improper Xenolab Anomalous Storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/anomaly_analysis
	name = "\improper Xenolab Anomaly Analysis"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/exp_prep
	name = "\improper Xenolab Expedition Preperation"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_DIM

/area/rnd/research/xenobio_storage
	name = "\improper Xenolab Storage"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_DIM

/area/rnd/research/mailing
	name = "\improper Research Mailing"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	color_grading = COLORTINT_DIM

/area/rnd/research/oldrd
	name = "\improper Synthetic Surgery"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM

/area/rnd/research/laundry
	name = "\improper Xenolab Laundry"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/breakroom
	name = "\improper Research Break Room"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_WARM

/area/rnd/research/medical_roof
	name = "\improper Research First aid"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_FIRE_SUPRESSION
	lightswitch = 1

/area/rnd/research/roof_eva
	name = "\improper Research Roof Access"
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

/area/rnd/research/xenoflora_storage
	name = "\improper Xenoflora Storage"
	base_turf = /turf/simulated/open

/area/rnd/research/phoronics
	name = "\improper Phoronics"
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "magblacir"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	lightswitch = 1

/area/rnd/research/phoronics/burn
	name = "\improper Phoronics Burn Chamber"
	icon_state = "redblacir"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_DIM

/area/rnd/research/phoronics/clean
	name = "\improper Phoronics Cleaning Closet"
	icon_state = "purwhitri"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/phoronics/breakroom
	name = "\improper Phoronics Break Room"
	icon_state = "purwhicir"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_WARM

/area/rnd/research/phoronics/gasstore
	name = "\improper Phoronics Gas Storage"
	icon_state = "magblasqu"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	color_grading = COLORTINT_DIM

/area/rnd/research/phoronics/extrastore
	name = "\improper Phoronics Overflow Storage"
	icon_state = "magwhicir"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/phoronics/bombrange
	name = "\improper Phoronics Bomb Testing Range"
	icon_state = "redwhitri"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	use_emergency_overlay = FALSE

/area/rnd/research/phoronics/med
	name = "\improper Phoronics Medical Station"
	icon_state = "blublacir"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_FIRE_SUPRESSION

/area/maintenance/substation/phoronics
	name = "Phoronics Substation"
	base_turf = /turf/simulated/open

//----------------
/area/rnd/hallway
	name = "\improper Research hallway"
	icon_state = "hallC"
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	base_turf = /turf/simulated/open
	lightswitch = 1

/area/rnd/hallway/main
	name = "\improper Primary Research hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/basementstairs
	name = "\improper Primary Research Server Access"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/upper
	name = "\improper Upper Research hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/lowmain
	name = "\improper Lower Main Research hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/xeno
	name = "\improper Xenoarch hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/hazard
	name = "\improper Hazardous Research hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/staircase
	name = "\improper Research Stairwell"
	icon_state = "purple"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/phoronicsbridge
	name = "\improper Phoronics Access Bridge"
	icon_state = "magblasqu"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/phoronicsmainhall
	name = "\improper Phoronics Main Hallway"
	icon_state = "magblatri"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/muriki/research/isolation_hall
	name = "Research Isolation Hall"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	use_emergency_overlay = TRUE

/area/muriki/research/showers
	name = "\improper Research Showers"
	base_turf = /turf/simulated/open
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

//
//-----------------------------------------------------------------------
//Asteroid yard

/area/offworld/asteroidyard/station
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/asteroidyard/external
	name = "\improper Reclamation Yard Exterior"
	icon_state = "red2"
	has_gravity = 0
	ambience = AMBIENCE_OUTPOST21_SPACE
	base_turf = /turf/space
	flags = AREA_BLOCK_GHOST_SIGHT
	ambience = AMBIENCE_SPACE

/area/offworld/asteroidyard/external/get_gravity()
	return FALSE

/area/offworld/asteroidyard/external/yardzone
	icon_state = "construction"

/area/offworld/asteroidyard/station/halls
	name = "\improper Reclamation Yard Hallway"
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/halls_storage
	name = "\improper Reclamation Yard Hallway"
	icon_state = "green"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/halls_bar
	name = "\improper Reclamation Yard Hallway"
	icon_state = "orange"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/access_shaft
	name = "\improper Reclamation Yard Access Shaft"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/washing
	name = "\improper Reclamation Yard Cleaning Room"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/dockingbay
	name = "\improper Reclamation Yard Hanger"
	icon_state = "decontamination"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/cave
	name = "\improper Reclamation Yard Caverns"
	icon_state = "construction"
	sound_env = ASTEROID
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_DIM

/area/offworld/asteroidyard/station/storage
	name = "\improper Reclamation Yard Primary Storage"
	icon_state = "locker"
	sound_env = ASTEROID
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	color_grading = COLORTINT_DIM

/area/offworld/asteroidyard/station/storage_aux
	name = "\improper Reclamation Yard Material Storage"
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	color_grading = COLORTINT_DIM

/area/offworld/asteroidyard/station/bar
	name = "\improper Reclamation Yard Bar"
	icon_state = "green"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_WARM

/area/offworld/asteroidyard/station/medbox
	name = "\improper Reclamation Medical Station"
	icon_state = "medbay2"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/offworld/asteroidyard/station/spelunker
	name = "\improper Reclamation Spelunker"
	icon_state = "toilet"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_DARK

/area/offworld/asteroidyard/station/engineering
	name = "\improper Reclamation Yard Engineering"
	icon_state = "orange"
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/asteroidyard/station/solarControl
	name = "\improper Reclamation Yard Solar Control"
	icon_state = "orange"
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/asteroidyard/station/observation
	name = "\improper Reclamation Yard Observation"
	icon_state = "blue"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/telecomms
	name = "\improper Reclamation Yard Telecomms"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/offworld/asteroidyard/station/teleport
	name = "\improper Reclamation Yard Teleporter"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	color_grading = COLORTINT_DIM

//
//-----------------------------------------------------------------------
//Confinement beam
/area/offworld/confinementbeam/station
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/space

/area/offworld/confinementbeam/station/access_shaft
	name = "\improper Confinement Beam Access Shaft"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/confinementbeam/station/dockingbay
	name = "\improper Confinement Beam Docking Arm"
	icon_state = "decontamination"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/exterior
	name = "\improper Confinement Beam Exterior"
	icon_state = "red2"
	sound_env = SPACE
	ambience = AMBIENCE_OUTPOST21_SPACE
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	flags = AREA_BLOCK_GHOST_SIGHT
	has_gravity = FALSE
	dynamic_lighting = FALSE // Respect space

/area/offworld/confinementbeam/exterior/get_gravity()
	return FALSE

/area/offworld/confinementbeam/station/storage
	name = "\improper Confinement Beam Primary Storage"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/port_equipment
	name = "\improper Confinement Beam Engine Equipment Port"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/starboard_equipment
	name = "\improper Confinement Beam Engine Equipment Starboard"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/port_airlock
	name = "\improper Confinement Beam Port Airlock"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/starboard_airlock
	name = "\improper Confinement Beam Starboard Airlock"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/trawler_airlock
	name = "\improper Confinement Beam Trawler Airlock"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/solar_control
	name = "\improper Confinement Beam Solar Control"
	icon_state = "dark128"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/hallway
	name = "\improper Confinement Beam Crew Conduit Aft"
	icon_state = "blue"
	sound_env = SOUND_ENVIRONMENT_HALLWAY
	ambience = AMBIENCE_MAINTENANCE
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/hallway_alt
	name = "\improper Confinement Beam Crew Conduit Fore"
	icon_state = "blue"
	sound_env = SOUND_ENVIRONMENT_HALLWAY
	ambience = AMBIENCE_MAINTENANCE
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/backup_power
	name = "\improper Confinement Beam Auxilary Power"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/medical_treatment
	name = "\improper Confinement Beam Medical Station"
	icon_state = "green"
	sound_env = SOUND_ENVIRONMENT_STONEROOM
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/offworld/confinementbeam/station/atmos
	name = "\improper Confinement Beam Atmospherics"
	icon_state = "blue"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ATMOS
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/power_distribution
	name = "\improper Confinement Beam Power Distribution"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/beam_emitter
	name = "\improper Confinement Beam Emitter Control"
	icon_state = "shuttle2"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/port_observation
	name = "\improper Confinement Beam Port Observation"
	icon_state = "blue"
	sound_env = SMALL_SOFTFLOOR
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/confinementbeam/station/starboard_observation
	name = "\improper Confinement Beam Starboard Observation"
	icon_state = "blue"
	sound_env = SMALL_SOFTFLOOR
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
// Tramline --------------------------------------------------
//
/area/shuttle/tram
	name = "\improper Station Tram"
	icon = 'icons/turf/areas.dmi'
	icon_state = "shuttlegrn"
	base_turf = /turf/simulated/floor/plating
	use_emergency_overlay = TRUE

/area/muriki/tramstation
	name = "\improper Tram Station"
	icon_state = "dark128"
	sound_env = LARGE_ENCLOSED
	ambience = list(AMBIENCE_ARRIVALS, AMBIENCE_HANGAR)
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	use_emergency_overlay = TRUE

/area/muriki/tramstation/shed
	name = "\improper Tram Station - Shed"
	icon_state = "dark128"
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DARK

/area/muriki/tramstation/waste
	name = "\improper Tram Station - Waste"
	icon_state = "dark128"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DARK

/area/muriki/tramstation/cargeng
	name = "\improper Tram Station - Cargo Engineering"
	icon_state = "dark128"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DIM

/area/muriki/tramstation/civ
	name = "\improper Tram Station - Civilian"
	icon_state = "dark128"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	use_emergency_overlay = TRUE


// Bad guys
/area/shuttle/mercenary
	name = "\improper Mercenary Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/floor/plating

/area/shuttle/skipjack
	name = "\improper Vox Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/floor/plating



//
// Foundation blocks ---------------------------------------------------------------------
//

/area/submap/outpost21/foundation_block
	name = "\improper Foundation Block"
	icon_state = "red2"
	flags = AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT | RAD_SHIELDED
	sound_env = SOUND_ENVIRONMENT_HANGAR
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_DARK

/area/submap/outpost21/foundation_block/waste
	name = "\improper Foundation Block W"
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/submap/outpost21/foundation_block/eng
	name = "\improper Foundation Block E"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/submap/outpost21/foundation_block/carg
	name = "\improper Foundation Block C"
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/submap/outpost21/foundation_block/med
	name = "\improper Foundation Block M"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/submap/outpost21/foundation_block/sec
	name = "\improper Foundation Block S"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/submap/outpost21/foundation_block/research
	name = "\improper Foundation Block R"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/submap/outpost21/foundation_block/bridge
	name = "\improper Foundation Block B"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

//
// Vehicle interiors ---------------------------------------------------------------------
//
/area/vehicle_interior
	sound_env = SMALL_ENCLOSED
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED
	requires_power = FALSE
	color_grading = COLORTINT_DIM


/area/vehicle_interior/heavyarmor_carrier_A
	name = "\improper Carrier A"

/area/vehicle_interior/heavyarmor_carrier_B
	name = "\improper Carrier A"


/area/vehicle_interior/heavyarmor_tank_A
	name = "\improper Tank A"

/area/vehicle_interior/heavyarmor_tank_B
	name = "\improper Tank B"

/area/vehicle_interior/heavyarmor_tank_C
	name = "\improper Tank C"


/area/vehicle_interior/heavyarmor_medic_recovery
	name = "\improper Medic Recovery Vehicle"


//
// Specialtiy -------------------------------------------------------------------------------
//

/area/specialty/redspace
	name = "\improper Unknown"
	base_turf = /turf/simulated/floor/flesh
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_BLOCK_SUIT_SENSORS | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT | AREA_BLOCK_PHASE_SHIFT
	sound_env = SPACE
	ambience = AMBIENCE_MEATZONE
	music = 'sound/ambience/approaching_planet.ogg'
	requires_power = FALSE
	broken_light_chance = 75
	haunted = TRUE
	color_grading = COLORTINT_MEAT

/area/specialty/thedarkplace // halucination punishment zone
	name = "\improper Unknown"
	base_turf = /turf/simulated/floor/weird_things/dark
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_BLOCK_SUIT_SENSORS | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_GHOST_SIGHT | AREA_BLOCK_PHASE_SHIFT
	sound_env = SPACE
	ambience = AMBIENCE_FOREBODING
	music = 'sound/ambience/ambisin1.ogg'
	haunted = TRUE
	color_grading = COLORTINT_OMEN

/area/vr/lighting // virtual reality, but cooler
	dynamic_lighting = 1 // literally the only change, I just wanted neat lights for the hazard course.

/area/vr/requirespower // virtual reality, but for doors that are pried open, and lights that are dead
	dynamic_lighting = 1
	requires_power = TRUE

/area/vr/spacesim // acts like space with lights
	dynamic_lighting = 1
	always_unpowered = TRUE
	requires_power = FALSE
	has_gravity = FALSE

/area/vr/spacesim/get_gravity()
	return 0

/area/specialty/hell
	name = "\improper Unknown"
	base_turf = /turf/simulated/floor/lava
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_TRACKING | AREA_FORBID_EVENTS | AREA_BLOCK_PHASE_SHIFT
	sound_env = SPACE
	ambience = AMBIENCE_MEATZONE
	music = 'sound/ambience/approaching_planet.ogg'
	requires_power = FALSE
	dynamic_lighting = 0
	color_grading = COLORTINT_OMEN
