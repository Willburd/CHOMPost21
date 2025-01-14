#if !defined(USING_MAP_DATUM)

	#include "outpost-04-deepdark.dmm"
	#include "outpost-01-basement.dmm"
	#include "outpost-02-surface.dmm"
	#include "outpost-03-upper.dmm"
	#include "outpost-05-centcom.dmm"
	#include "outpost-06-misc.dmm"
	#include "outpost-07-asteroid.dmm"
	//#include "outpost-08-prospector.dmm"
	//#include "outpost-09-survey.dmm"
	#include "outpost-10-vr.dmm"
	#include "outpost-11-confinementbeam.dmm"

	#include "outpost_defines.dm"
	#include "outpost_areas.dm"
	#include "outpost_turfs.dm"
	#include "outpost_shuttle_defs.dm"
	#include "outpost_shuttles.dm"
	#include "outpost_telecomms.dm"
	#include "outpost_jobs.dm"
	#include "outpost_things.dm"
	#include "job/outfits.dm"

	#define USING_MAP_DATUM /datum/map/outpost

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Outpost 21

#endif
