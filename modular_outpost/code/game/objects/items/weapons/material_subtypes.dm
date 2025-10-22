// Makes mat overrides for all
#define WEAPON_SET(x,y); \
/obj/item/material/knife/tacknife/combatknife/x {default_material = ##y;}\
/obj/item/material/knife/tacknife/butterflyblade/x {default_material = ##y;}\
/obj/item/material/knife/machete/x {default_material = ##y;}\
/obj/item/material/knife/tacknife/survival/x {default_material = ##y;}\
/obj/item/material/twohanded/fireaxe/x {default_material = ##y;}\
/obj/item/material/twohanded/spear/x {default_material = ##y;}\
/obj/item/material/twohanded/baseballbat/x {default_material = ##y;}\
/obj/item/material/butterfly/switchblade/x {default_material = ##y;}\
/obj/item/material/butterfly/boxcutter/x {default_material = ##y;}\
/obj/item/material/twohanded/longsword/x {default_material = ##y;}\
/obj/item/material/knife/butch/x {default_material = ##y;}\
/obj/item/material/sword/battleaxe/x {default_material = ##y;}

WEAPON_SET(dura, MAT_DURASTEEL)
WEAPON_SET(durahull, MAT_DURASTEELHULL)
WEAPON_SET(plas, MAT_PLASTEEL)
WEAPON_SET(plashull, MAT_PLASTEELHULL)

#undef WEAPON_SET
