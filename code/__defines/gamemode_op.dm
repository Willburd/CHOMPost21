#define MODE_DEEPHUNGER "deephunger"
#define MODE_CHU "chuinfestation"
#define MODE_SYNX "synxhunt"
#define MODE_ZOMBIE "zombies"
#define MODE_RUSTDRONE "rustdrone"

#define BE_TRAITOR    0x1
#define BE_OPERATIVE  0x2
#define BE_CHANGELING 0x4
#define BE_WIZARD     0x8
#define BE_MALF       0x10
#define BE_NINJA	  0x20
#define BE_ALIEN      0x40
#define BE_AI         0x80
#define BE_CULTIST    0x100
#define BE_RAIDER     0x200
#define BE_PLANT	  0x400
#define BE_PAI        0x800
#define BE_LOSTDRONE  0x1000

GLOBAL_LIST_INIT(special_roles, list(
	"traitor" = 1,										// 0
	"operative" = 1,									// 1
	"changeling" = 1,									// 2
	"wizard" = 1,										// 3
	"malf AI" = 0,										// 4
	"ninja" = 0,										// 5
	"exotic species" = 1,								// 6
	"positronic brain" = 1,								// 7
	"cultist" = 0,										// 8
	"raider" = 1,										// 9
	"diona" = 1,										// 10
	"pAI candidate" = 1,								// 11
	"Lost Drone" = 1,									// 12
))

GLOBAL_LIST_INIT(be_special_flags, list(
	"Traitor"          = BE_TRAITOR,
	"Operative"        = BE_OPERATIVE,
	"Changeling"       = BE_CHANGELING,
	"Wizard"           = BE_WIZARD,
	"Malf AI"          = BE_MALF,
	"Ninja"            = BE_NINJA,
	"Exotic Species"   = BE_ALIEN,
	"Positronic Brain" = BE_AI,
	"Cultist"          = BE_CULTIST,
	"Raider"           = BE_RAIDER,
	"Diona"            = BE_PLANT,
	"pAI Candidate"    = BE_PAI,
	"Lost Drone"       = BE_LOSTDRONE,
))
