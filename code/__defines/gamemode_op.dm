#define MODE_DEEPHUNGER "deephunger"
#define MODE_CHU "chuinfestation"
#define MODE_SYNX "synxhunt"
#define MODE_ZOMBIE "zombies"

#define BE_TRAITOR    0x1
#define BE_OPERATIVE  0x2
#define BE_CHANGELING 0x4
#define BE_WIZARD     0x8
#define BE_MALF       0x10
#define BE_REV        0x20
#define BE_ALIEN      0x40
#define BE_AI         0x80
#define BE_CULTIST    0x100
#define BE_RENEGADE   0x200
#define BE_NINJA      0x400
#define BE_RAIDER     0x800
#define BE_PLANT	  0x1000
#define BE_MUTINEER   0x2000
#define BE_LOYALIST   0x4000
// Ghost roles
#define BE_PAI        0x8000
#define BE_LOSTDRONE  0x10000
#define BE_MAINTPRED  0x20000
#define BE_DEEPHUNGER 0x40000
#define BE_ZOMBIE	  0x80000
#define BE_SYNX	  	  0x100000

var/global/list/special_roles = list( //keep synced with the defines BE_* in setup.dm --rastaf
	"traitor" = 1,										// 0
	"operative" = 1,									// 1
	"changeling" = 1,									// 2
	"wizard" = 1,										// 3
	"malf AI" = 1,										// 4
	"revolutionary" = 1,								// 5
	"alien candidate" = 1,								// 6
	"positronic brain" = 1,								// 7
	"cultist" = 1,										// 8
	"renegade" = 1,										// 9
	"ninja" = 1,										// 10
	"raider" = 1,										// 11
	"diona" = 1,										// 12
	"mutineer" = 1,										// 13
	"loyalist" = 1,										// 14
	"GHOST" = 0,										// add seperate section for ghost roles
	"pAI candidate" = 1,								// 15
	"lost drone" = 1,									// 16
	"maint pred" = 1,									// 17
	"deep hunger" = 1,									// 18
	"zombie" = 1,										// 19
	"synx" = 1,											// 20
)

GLOBAL_LIST_INIT(be_special_flags, list(
	"Traitor"          = BE_TRAITOR,
	"Operative"        = BE_OPERATIVE,
	"Changeling"       = BE_CHANGELING,
	"Wizard"           = BE_WIZARD,
	"Malf AI"          = BE_MALF,
	"Revolutionary"    = BE_REV,
	"Exotic Species"   = BE_ALIEN,
	"Positronic Brain" = BE_AI,
	"Cultist"          = BE_CULTIST,
	"Renegade"         = BE_RENEGADE,
	"Ninja"            = BE_NINJA,
	"Raider"           = BE_RAIDER,
	"Diona"            = BE_PLANT,
	"Mutineer"         = BE_MUTINEER,
	"Loyalist"         = BE_LOYALIST,
	"pAI"              = BE_PAI,
	"Lost Drone"       = BE_LOSTDRONE,
	"Maint Pred"       = BE_MAINTPRED,
	"Deep Hunger"      = BE_DEEPHUNGER,
	"Zombie"           = BE_ZOMBIE,
	"Synx"             = BE_SYNX
))
