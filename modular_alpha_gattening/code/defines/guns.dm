///////////////////////////////////
// Defines
///////////////////////////////////

#define PER_BULLET_MATERIAL_COST 60

#define GUN_CHAMBER_10MIL "10mm"
// rest of the caliber sizes here


///////////////////////////////////
// Gun identities
// Guns share magazine compatibility.
// All magazines of a specific caliber fit all guns of that caliber.
// No exceptions. This system not compatible with realism of your historical gun's
// hyper specific snowflake magazine only made in the 1930s. This is hundreds of years in
// the future, and part of completely standardized system for the sake of GAMEPLAY.
///////////////////////////////////

#define SET_GUN_PROJECTILE_ANY \
load_method = MAGAZINE; \
magazine_type = /obj/item/ammo_magazine; \
allowed_magazines = list(/obj/item/ammo_magazine); \
projectile_type = /obj/item/projectile/bullet; \
caliber = "";

#define SET_GUN_PROJECTILE_TENMILL \
load_method = MAGAZINE; \
magazine_type = /obj/item/ammo_magazine/m10mm; \
allowed_magazines = list(/obj/item/ammo_magazine/m10mm); \
projectile_type = /obj/item/projectile/bullet/a10mm; \
caliber = GUN_CHAMBER_10MIL;
