#if !defined(USING_MAP_DATUM)

	#include "ocean_defines.dm"
	#include "ocean_presets.dm"
	#include "ocean_areas.dm"
	#include "../outpost_21/outpost_jobs.dm"
	#include "../outpost_21/outpost_things.dm"
	#include "../outpost_21/job/outfits.dm"

	#ifndef AWAY_MISSION_TEST //Don't include these for just testing away missions
		//#include "ocean-01-x.dmm"
		//#include "ocean-02-x.dmm"
		//#include "ocean-03-x.dmm"
		//#include "ocean-04-x.dmm"

		#include "outpost-05-asteroid.dmm"
		#include "outpost-06-confinementbeam.dmm"
		#include "outpost-07-vr.dmm"
	#endif

	#include "ocean_lateload.dm"

	#define USING_MAP_DATUM /datum/map/outpost_ocean

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Outpost 22

#endif
