/// What cursed things exist here.

// Outpost 21 edit(port) - Departmentgoal signals

// base /proc/say_dead_direct() : (mob/source, message)
#define COMSIG_GLOB_DEAD_SAY "!hear_dead_talk"
// base /turf/wash() : (turf/source)
#define COMSIG_GLOB_MOPFLOOR "!mopped_floor"
// base /obj/machinery/artifact_harvester/proc/harvest() : (atom/source, obj/item/anobattery/inserted_battery, mob/user)
#define COMSIG_GLOB_HARVEST_ARTIFACT "!harvest_artifact"
// upon harvesting a slime's extract : (atom/source, obj/item/slime_extract/newly_made_core)
#define COMSIG_GLOB_HARVEST_SLIME_CORE "!harvest_slime_core"
