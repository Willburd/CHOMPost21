#if !defined(CITESTING)

/*********************/
/* MAP SELECTION     */
/* FOR LIVE SERVER   */
/*********************/

#define USE_MAP_OUTPOST21

// Debug
//#define USE_MAP_MINITEST

/*********************/
/* End Map Selection */
/*********************/

#endif

// Outpost 21
#ifdef USE_MAP_OUTPOST21
#include "../outpost_21/outpost_21.dm"
#endif

#ifdef USE_MAP_MINITEST
#include "../../../modular_chomp/maps/virgo_minitest/virgo_minitest.dm"
#endif
