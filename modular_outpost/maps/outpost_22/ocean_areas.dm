//
// Outpost holomap modifications. !!!OVERRIDES ONLY!!! New areas go in outpost_modular/maps/common/common_areas.dm ---------------------------------------------------------------------
//
/area/centcom // lets NOT
	flags = RAD_SHIELDED|AREA_FLAG_IS_NOT_PERSISTENT|BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT|AREA_BLOCK_GHOST_SIGHT|AREA_FORBID_EVENTS

/area/virtual_reality
	name = "DO NOT USE ME. Use /area/vr"

/area/vr
	name = "Virtual Reality"
	icon_state = "Virtual_Reality"
	dynamic_lighting = 0
	requires_power = 0
	flags = AREA_ALLOW_LARGE_SIZE | AREA_LIMIT_DARK_RESPITE | AREA_FLAG_IS_NOT_PERSISTENT
