#define BASE_SURGERY_TOOL_SPEED 0.55
#define ALIEN_SURGERY_TOOL_SPEED 0.15

// Major med rebalance - Surgery speeds increased.

//////////////////////////////////////////////////////
// Base tools
//////////////////////////////////////////////////////
/obj/item/surgical/retractor
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/hemostat
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/cautery
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/surgicaldrill
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/scalpel
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/circular_saw
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/FixOVein
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/bone_clamp
	toolspeed = BASE_SURGERY_TOOL_SPEED

/obj/item/surgical/bioregen
	toolspeed = BASE_SURGERY_TOOL_SPEED


//////////////////////////////////////////////////////
// Upgrades
//////////////////////////////////////////////////////
/obj/item/surgical/scalpel/laser1
	toolspeed = BASE_SURGERY_TOOL_SPEED * 0.8

/obj/item/surgical/scalpel/laser2
	toolspeed = BASE_SURGERY_TOOL_SPEED * 0.75

/obj/item/surgical/scalpel/laser3
	toolspeed = BASE_SURGERY_TOOL_SPEED * 0.6


//////////////////////////////////////////////////////
// Misc tools
//////////////////////////////////////////////////////
/obj/item/surgical/scalpel/ripper
	toolspeed = BASE_SURGERY_TOOL_SPEED * 0.75

/obj/item/surgical/scalpel/manager
	toolspeed = 0.9 // Slower but does multiple


//////////////////////////////////////////////////////
// Aliens
//////////////////////////////////////////////////////
/obj/item/surgical/retractor/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/hemostat/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/cautery/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/surgicaldrill/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/scalpel/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/circular_saw/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/FixOVein/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

/obj/item/surgical/bone_clamp/alien
	toolspeed = ALIEN_SURGERY_TOOL_SPEED

#undef BASE_SURGERY_TOOL_SPEED
#undef ALIEN_SURGERY_TOOL_SPEED
