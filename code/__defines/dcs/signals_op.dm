/// What cursed things exist here.

// Outpost 21 edit(port) - Departmentgoal signals

// base /proc/say_dead_direct() : (message)
#define COMSIG_GLOB_DEAD_SAY "!hear_dead_talk"
// base /turf/wash() : ()
#define COMSIG_GLOB_MOPFLOOR "!mopped_floor"
// base /obj/machinery/artifact_harvester/proc/harvest() : (obj/item/anobattery/inserted_battery, mob/user)
#define COMSIG_GLOB_HARVEST_ARTIFACT "!harvest_artifact"
// upon harvesting a slime's extract : (obj/item/slime_extract/newly_made_core)
#define COMSIG_GLOB_HARVEST_SLIME_CORE "!harvest_slime_core"
// base /datum/recipe/proc/make_food() : (obj/container, list/results)
#define COMSIG_GLOB_FOOD_PREPARED "!recipe_food_completed"
// base /datum/construction/proc/spawn_result() : (/obj/mecha/result_mech)
#define COMSIG_GLOB_MECH_CONSTRUCTED "!mecha_constructed"
