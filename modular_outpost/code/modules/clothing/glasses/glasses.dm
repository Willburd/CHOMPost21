#define VISION_GOGGLE_USES_CELL(x) \
x\
{\
	var/ignore_cell = FALSE;\
	var/obj/item/cell/device/cell;\
}\
\
x/ignores_cell\
{\
	ignore_cell = TRUE;\
}\
\
x/Initialize(mapload)\
{\
	. = ..();\
	cell = new(src);\
	if(!ignore_cell)\
	{\
		disable_goggles();\
		START_PROCESSING(SSobj, src);\
	}\
}\
\
x/Destroy()\
{\
	STOP_PROCESSING(SSobj, src);\
	QDEL_NULL(cell);\
	. = ..();\
}\
\
x/get_cell()\
{\
	return cell;\
}\
\
x/toggle_active(mob/living/user)\
{\
	if(!ignore_cell && !cell?.charge)\
	{\
		disable_goggles();\
		to_chat(user, span_warning("\The [src] won't turn on."));\
		return;\
	}\
	. = ..();\
}\
\
x/proc/disable_goggles()\
{\
	if(!active)\
	{\
		return;\
	}\
	active = FALSE;\
	icon_state = off_state;\
	flash_protection = FLASH_PROTECTION_NONE;\
	tint = TINT_NONE;\
	away_planes = enables_planes;\
	enables_planes = null;\
	if(ismob(loc))\
	{\
		var/mob/M = loc;\
		M.update_inv_glasses();\
		M.update_mob_action_buttons();\
		M.recalculate_vis();\
	}\
}\
\
x/attack_hand(mob/user)\
{\
	if(user.get_inactive_hand() != src || ignore_cell || !cell)\
	{\
		return ..();\
	}\
	cell.update_icon();\
	user.put_in_hands(cell);\
	cell = null;\
	to_chat(user, span_notice("You remove the cell from the [src]."));\
	playsound(src, 'sound/machines/button.ogg', 30, 1, 0);\
	disable_goggles();\
	return;\
}\
\
x/attackby(obj/item/I, mob/user)\
{\
	if(istype(I,/obj/item/cell/device) && !ignore_cell)\
	{\
		if(!cell)\
		{\
			user.drop_item();\
			I.loc = src;\
			cell = I;\
			to_chat(user, span_notice("You install a cell in \the [src]."));\
			playsound(src, 'sound/machines/button.ogg', 30, 1, 0);\
		}\
		else\
		{\
			to_chat(user, span_notice("\The [src] already has a cell."));\
		}\
		return;\
	}\
	. = ..();\
}\
\
x/process()\
{\
	if(ignore_cell || isrobot(loc))\
	{\
		return;\
	}\
	if(!active)\
	{\
		return;\
	}\
	if((!cell || !cell.checked_use(2)))\
	{\
		disable_goggles();\
		visible_message(span_warning("\The [src] flickers and turn off."));\
	}\
};

VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/meson)
VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/graviton)
VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/thermal)
VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/material)
VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/night)
VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/omni)
VISION_GOGGLE_USES_CELL(/obj/item/clothing/glasses/omnihud/eng/meson)

/*
/obj/item/clothing/glasses/hud
/obj/item/clothing/glasses/omnihud
*/

#undef VISION_GOGGLE_USES_CELL
