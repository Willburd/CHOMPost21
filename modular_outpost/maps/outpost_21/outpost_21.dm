#if !defined(USING_MAP_DATUM)

	#include "outpost_defines.dm"
	#include "outpost_presets.dm"
	#include "outpost_areas.dm"
	#include "outpost_jobs.dm"
	#include "outpost_things.dm"
	#include "job/outfits.dm"

	#ifndef AWAY_MISSION_TEST //Don't include these for just testing away missions
		#include "outpost-01-deepdark.dmm"
		#include "outpost-02-basement.dmm"
		#include "outpost-03-surface.dmm"
		#include "outpost-04-upper.dmm"
		#include "outpost-05-asteroid.dmm"
		#include "outpost-06-confinementbeam.dmm"
		#include "outpost-07-vr.dmm"
		//#include "outpost-08-prospector.dmm"
		//#include "outpost-09-survey.dmm"
	#endif

	#include "../submaps/_outpost_submaps.dm"

	#define USING_MAP_DATUM /datum/map/outpost

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Outpost 21

#endif
