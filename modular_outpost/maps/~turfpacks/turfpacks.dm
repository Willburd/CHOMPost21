// Available turfpacks:
// packs_sim/turfpacks_sim_tiled
// packs_sim/turfpacks_sim_outdoors
// packs_sim/turfpacks_sim_walls
// packs_sim/turfpacks_sim_special
// packs_unsim/turfpacks_unsim_tiled
// packs_unsim/turfpacks_unsim_outdoors
// packs_unsim/turfpacks_unsim_walls
// packs_unsim/turfpacks_unsim_special

// MURIKI ATMOS
#define TURFPACK_PACKNAME muriki
#define TURFPACK_TEMP MURIKI_AVG_TEMP
#define TURFPACK_O2 MURIKI_MOL_O2
#define TURFPACK_N2 MURIKI_MOL_N2
#define TURFPACK_PHORON 0
#define TURFPACK_CO2 MURIKI_MOL_CO2

#include "packs_sim/turfpacks_sim_tiled.dm"
#include "packs_sim/turfpacks_sim_outdoors.dm"
#include "packs_sim/turfpacks_sim_walls.dm"
#include "packs_sim/turfpacks_sim_special.dm"
#include "packs_unsim/turfpacks_unsim_tiled.dm"
#include "packs_unsim/turfpacks_unsim_outdoors.dm"
#include "packs_unsim/turfpacks_unsim_walls.dm"
#include "packs_unsim/turfpacks_unsim_special.dm"

#undef TURFPACK_PACKNAME
#undef TURFPACK_TEMP
#undef TURFPACK_O2
#undef TURFPACK_N2
#undef TURFPACK_PHORON
#undef TURFPACK_CO2

// AIRLESS ATMOS
#define TURFPACK_PACKNAME airless
#define TURFPACK_TEMP T20C
#define TURFPACK_O2 0
#define TURFPACK_N2 0
#define TURFPACK_PHORON 0
#define TURFPACK_CO2 0

#include "packs_sim/turfpacks_sim_tiled.dm"
#include "packs_sim/turfpacks_sim_outdoors.dm"
#include "packs_sim/turfpacks_sim_walls.dm"
#include "packs_sim/turfpacks_sim_special.dm"
#include "packs_unsim/turfpacks_unsim_tiled.dm"
#include "packs_unsim/turfpacks_unsim_outdoors.dm"
#include "packs_unsim/turfpacks_unsim_walls.dm"
#include "packs_unsim/turfpacks_unsim_special.dm"

#undef TURFPACK_PACKNAME
#undef TURFPACK_TEMP
#undef TURFPACK_O2
#undef TURFPACK_N2
#undef TURFPACK_PHORON
#undef TURFPACK_CO2

// STATION ATMOS
#define TURFPACK_PACKNAME station
#define TURFPACK_TEMP T20C
#define TURFPACK_O2 MOLES_O2STANDARD
#define TURFPACK_N2 MOLES_N2STANDARD
#define TURFPACK_PHORON 0
#define TURFPACK_CO2 0

#include "packs_sim/turfpacks_sim_tiled.dm"
#include "packs_sim/turfpacks_sim_outdoors.dm"
#include "packs_sim/turfpacks_sim_walls.dm"
#include "packs_sim/turfpacks_sim_special.dm"
#include "packs_unsim/turfpacks_unsim_tiled.dm"
#include "packs_unsim/turfpacks_unsim_outdoors.dm"
#include "packs_unsim/turfpacks_unsim_walls.dm"
#include "packs_unsim/turfpacks_unsim_special.dm"

#undef TURFPACK_PACKNAME
#undef TURFPACK_TEMP
#undef TURFPACK_O2
#undef TURFPACK_N2
#undef TURFPACK_PHORON
#undef TURFPACK_CO2
