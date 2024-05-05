//Atmosphere properties
#define MURIKI_ONE_ATMOSPHERE	101.13 //kPa
#define MURIKI_AVG_TEMP	291.15 //kelvin 18C

#define MURIKI_PER_N2		0.72 //percent
#define MURIKI_PER_O2		0.26
#define MURIKI_PER_N2O	0.00 //Currently no capacity to 'start' a turf with this. See turf.dm
#define MURIKI_PER_CO2	0.02
#define MURIKI_PER_PHORON	0.00

//Math only beyond this point
#define MURIKI_MOL_PER_TURF	(MURIKI_ONE_ATMOSPHERE*CELL_VOLUME/(MURIKI_AVG_TEMP*R_IDEAL_GAS_EQUATION))
#define MURIKI_MOL_N2			(MURIKI_MOL_PER_TURF * MURIKI_PER_N2)
#define MURIKI_MOL_O2			(MURIKI_MOL_PER_TURF * MURIKI_PER_O2)
#define MURIKI_MOL_N2O			(MURIKI_MOL_PER_TURF * MURIKI_PER_N2O)
#define MURIKI_MOL_CO2			(MURIKI_MOL_PER_TURF * MURIKI_PER_CO2)
#define MURIKI_MOL_PHORON		(MURIKI_MOL_PER_TURF * MURIKI_PER_PHORON)

//Turfmakers
#define MURIKI_SET_ATMOS	nitrogen=MURIKI_MOL_N2;oxygen=MURIKI_MOL_O2;carbon_dioxide=MURIKI_MOL_CO2;phoron=MURIKI_MOL_PHORON;temperature=MURIKI_AVG_TEMP
#define MURIKI_TURF_CREATE(x)	x/muriki/nitrogen=MURIKI_MOL_N2;x/muriki/oxygen=MURIKI_MOL_O2;x/muriki/carbon_dioxide=MURIKI_MOL_CO2;x/muriki/phoron=MURIKI_MOL_PHORON;x/muriki/temperature=MURIKI_AVG_TEMP;x/muriki/outdoors=TRUE;x/muriki/update_graphic(list/graphic_add = null, list/graphic_remove = null) return 0
#define MURIKI_TURF_CREATE_UN(x)	x/muriki/nitrogen=MURIKI_MOL_N2;x/muriki/oxygen=MURIKI_MOL_O2;x/muriki/carbon_dioxide=MURIKI_MOL_CO2;x/muriki/phoron=MURIKI_MOL_PHORON;x/muriki/temperature=MURIKI_AVG_TEMP

// This is a wall you surround the area of your "planet" with, that makes the atmosphere inside stay within bounds, even if canisters
// are opened or other strange things occur.
/turf/unsimulated/wall/planetary/muriki
	name = "Ice wall"
	desc = "Rocky outcrop that surrounds the outpost. Impassable."
	icon = 'icons/turf/snow_new.dmi'
	icon_state = "Icerock"
	alpha = 0xFF
	MURIKI_SET_ATMOS