#define HUD_UPDATE HEALTH_HUD|LIFE_HUD|STATUS_HUD|ID_HUD|WANTED_HUD|IMPLOYAL_HUD|IMPCHEM_HUD|IMPTRACK_HUD|BACKUP_HUD

/obj/item/clothing/under/equipped(mob/user, slot)
	. = ..()
	if (isliving(user))
		var/mob/living/wearer = user
		wearer.hud_updateflag = HUD_UPDATE

/obj/item/clothing/under/dropped(mob/user, equipping, slot)
	. = ..()
	if (isliving(user))
		var/mob/living/wearer = user
		wearer.hud_updateflag = HUD_UPDATE

/obj/item/clothing/under/set_sensors(mob/user)
	. = ..()
	if (isliving(loc))
		var/mob/living/wearer = loc
		wearer.hud_updateflag = HUD_UPDATE

#undef HUD_UPDATE
