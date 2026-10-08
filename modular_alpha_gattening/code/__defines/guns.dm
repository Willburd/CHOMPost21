///////////////////////////////////
// Defines
///////////////////////////////////

#define PER_BULLET_MATERIAL_COST 60

// rest of the caliber sizes here
#define CALIBER_TYPE_10MM "tenmm"


#define BULLET_DEFINE_HUD(hud_str) hud_state = hud_str;
#define BULLET_DEFINE_BLUNT embed_chance = 0;sharp = FALSE;
#define BULLET_DEFINE_STANDARD_MATERIALS matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST);

// Bullet types
#define BULLET_TYPE_PRACTICE practice
#define BULLET_TYPE_RUBBER rubber
#define BULLET_TYPE_ARMORPIERCING ap
#define BULLET_TYPE_HOLLOWPOINT hp


// Bullet damages
#define BULLET_DAMAGE_MINIMAL 1
#define BULLET_DAMAGE_LOW 5
#define BULLET_DAMAGE_MILD 10
#define BULLET_DAMAGE_MODERATE 20
#define BULLET_DAMAGE_MEDIUM 40
#define BULLET_DAMAGE_HIGH 50
#define BULLET_DAMAGE_VERYHIGH 60
#define BULLET_DAMAGE_EXTREME 75
#define BULLET_DAMAGE_LETHAL 100


// Bullet AP
#define BULLET_PENETRATION_BAD -15
#define BULLET_PENETRATION_POOR -10
#define BULLET_PENETRATION_NONE 0
#define BULLET_PENETRATION_GOOD 10
#define BULLET_PENETRATION_GREAT 15
