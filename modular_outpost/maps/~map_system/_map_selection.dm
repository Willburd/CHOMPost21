#if !defined(CITESTING)

/*********************/
/* MAP SELECTION     */
/* FOR LIVE SERVER   */
/*********************/

#define USE_MAP_OUTPOST21

// #define USE_MAP_OUTPOST22

// Debug

/*********************/
/* End Map Selection */
/*********************/

#endif

// Outpost 21 - Terraformer
#ifdef USE_MAP_OUTPOST21
#include "../outpost_21/outpost_21.dm"
#endif

// Outpost 22 - Ocean Monitoring
#ifdef USE_MAP_OUTPOST22
#include "../outpost_22/outpost_22.dm"
#endif
