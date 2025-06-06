/obj/item/gun/projectile
	name = "gun"
	desc = "A gun that fires bullets."
	icon_state = "revolver"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	w_class = ITEMSIZE_NORMAL
	matter = list(MAT_STEEL = 1000)
	recoil = 1
	projectile_type = /obj/item/projectile/bullet/pistol/strong	//Only used for chameleon guns

	var/caliber = ".357"		//determines which casings will fit
	var/handle_casings = EJECT_CASINGS	//determines how spent casings should be handled
	var/load_method = SINGLE_CASING|SPEEDLOADER //1 = Single shells, 2 = box or quick loader, 3 = magazine
	var/obj/item/ammo_casing/chambered = null

	reload_time = 1				//Ballistics reload fast, but not instantly

	//For SINGLE_CASING or SPEEDLOADER guns
	var/max_shells = 0			//the number of casings that will fit inside
	var/ammo_type = null		//the type of ammo that the gun comes preloaded with
	var/list/loaded = list()	//stored ammo

	//For MAGAZINE guns
	var/magazine_type = null	//the type of magazine that the gun comes preloaded with
	var/obj/item/ammo_magazine/ammo_magazine = null //stored magazine
	var/allowed_magazines		//determines list of which magazines will fit in the gun
	var/auto_eject = 0			//if the magazine should automatically eject itself when empty.
	var/auto_eject_sound = null
	//TODO generalize ammo icon states for guns
	//var/magazine_states = 0
	//var/list/icon_keys = list()		//keys
	//var/list/ammo_states = list()	//values

	var/random_start_ammo = FALSE	//randomize amount of starting ammo

/obj/item/gun/projectile/Initialize(mapload, var/starts_loaded = 1)
	. = ..()
	if(starts_loaded)
		if(ispath(ammo_type) && (load_method & (SINGLE_CASING|SPEEDLOADER)))
			for(var/i in 1 to max_shells)
				loaded += new ammo_type(src)
				if(random_start_ammo)
					loaded.Cut(0,rand(0,max_shells))
		if(ispath(magazine_type) && (load_method & MAGAZINE))
			ammo_magazine = new magazine_type(src)
			allowed_magazines += /obj/item/ammo_magazine/smart
			if(random_start_ammo)
				var/ammo_cut = rand(0,ammo_magazine.max_ammo)
				ammo_magazine.contents.Cut(0,ammo_cut)
				ammo_magazine.stored_ammo.Cut(0,ammo_cut)
	// update_icon() Outpost 21 edit - overlay runtime fix

/obj/item/gun/projectile/consume_next_projectile()
	//get the next casing
	if(loaded.len)
		chambered = loaded[1] //load next casing.
		if(handle_casings != HOLD_CASINGS)
			loaded -= chambered
	else if(ammo_magazine && ammo_magazine.stored_ammo.len)
		chambered = ammo_magazine.stored_ammo[ammo_magazine.stored_ammo.len]
		if(handle_casings != HOLD_CASINGS)
			ammo_magazine.stored_ammo -= chambered

	var/mob/living/M = loc // TGMC Ammo HUD
	if(istype(M)) // TGMC Ammo HUD
		M?.hud_used.update_ammo_hud(M, src)

	if (chambered)
		return chambered.BB
	return null

/obj/item/gun/projectile/handle_post_fire()
	..()
	if(chambered)
		chambered.expend()
		process_chambered()

/obj/item/gun/projectile/handle_click_empty()
	..()
	process_chambered()

/obj/item/gun/projectile/proc/process_chambered()
	if (!chambered) return

	// Aurora forensics port, gunpowder residue.
	if(chambered.leaves_residue)
		var/mob/living/carbon/human/H = loc
		if(istype(H))
			if(!istype(H.gloves, /obj/item/clothing))
				H.add_gunshotresidue(chambered)
			else
				var/obj/item/clothing/G = H.gloves
				G.add_gunshotresidue(chambered)

	switch(handle_casings)
		if(EJECT_CASINGS) //eject casing onto ground.
			if(chambered.caseless)
				qdel(chambered)
				return
			else
				chambered.loc = get_turf(src)
				playsound(src, "casing", 50, 1)
		if(CYCLE_CASINGS) //cycle the casing back to the end.
			if(ammo_magazine)
				ammo_magazine.stored_ammo += chambered
			else
				loaded += chambered

	if(handle_casings != HOLD_CASINGS)
		chambered = null

	var/mob/living/M = loc // TGMC Ammo HUD
	if(istype(M)) // TGMC Ammo HUD
		M?.hud_used.update_ammo_hud(M, src)


//Attempts to load A into src, depending on the type of thing being loaded and the load_method
//Maybe this should be broken up into separate procs for each load method?
/obj/item/gun/projectile/proc/load_ammo(var/obj/item/A, mob/user)
	if(istype(A, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/AM = A
		if(!(load_method & AM.mag_type) || caliber != AM.caliber || allowed_magazines && !is_type_in_list(A, allowed_magazines))
			to_chat(user, span_warning("[AM] won't load into [src]!"))
			return
		switch(AM.mag_type)
			if(MAGAZINE)
				if(ammo_magazine)
					to_chat(user, span_warning("[src] already has a magazine loaded.")) //already a magazine here
					return
				if(do_after(user, reload_time * AM.w_class))
					user.remove_from_mob(AM)
					AM.loc = src
					ammo_magazine = AM
					user.visible_message("[user] inserts [AM] into [src].", span_notice("You insert [AM] into [src]."))
					user.hud_used.update_ammo_hud(user, src)
					playsound(src, 'sound/weapons/flipblade.ogg', 50, 1)
			if(SPEEDLOADER)
				if(loaded.len >= max_shells)
					to_chat(user, span_warning("[src] is full!"))
					return
				var/count = 0
				for(var/obj/item/ammo_casing/C in AM.stored_ammo)
					if(loaded.len >= max_shells)
						break
					if(C.caliber == caliber)
						C.loc = src
						loaded += C
						AM.stored_ammo -= C //should probably go inside an ammo_magazine proc, but I guess less proc calls this way...
						count++
						user.hud_used.update_ammo_hud(user, src)
				if(do_after(user, reload_time * AM.w_class))
					if(count)
						user.visible_message("[user] reloads [src].", span_notice("You load [count] round\s into [src]."))
						user.hud_used.update_ammo_hud(user, src)
						playsound(src, 'sound/weapons/empty.ogg', 50, 1)
		AM.update_icon()
	else if(istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/C = A
		if(!(load_method & SINGLE_CASING) || caliber != C.caliber)
			return //incompatible
		if(loaded.len >= max_shells)
			to_chat(user, span_warning("[src] is full."))
			return

		if(do_after(user, reload_time * C.w_class))
			user.remove_from_mob(C)
			C.loc = src
			loaded.Insert(1, C) //add to the head of the list
			user.visible_message("[user] inserts \a [C] into [src].", span_notice("You insert \a [C] into [src]."))
			playsound(src, 'sound/weapons/empty.ogg', 50, 1)

	else if(istype(A, /obj/item/storage))
		var/obj/item/storage/storage = A
		if(!(load_method & SINGLE_CASING))
			return //incompatible

		to_chat(user, span_notice("You start loading \the [src]."))
		sleep(1 SECOND)
		for(var/obj/item/ammo_casing/ammo in storage.contents)
			if(caliber != ammo.caliber)
				continue

			load_ammo(ammo, user)

			if(loaded.len >= max_shells)
				to_chat(user, span_warning("[src] is full."))
				break
			sleep(1 SECOND)

	update_icon()
	user.hud_used.update_ammo_hud(user, src)

//attempts to unload src. If allow_dump is set to 0, the speedloader unloading method will be disabled
/obj/item/gun/projectile/proc/unload_ammo(mob/user, var/allow_dump=1)
	if(ammo_magazine)
		user.put_in_hands(ammo_magazine)
		user.visible_message("[user] removes [ammo_magazine] from [src].", span_notice("You remove [ammo_magazine] from [src]."))
		playsound(src, 'sound/weapons/empty.ogg', 50, 1)
		ammo_magazine.update_icon()
		ammo_magazine = null
		user.hud_used.update_ammo_hud(user, src)
	else if(loaded.len)
		//presumably, if it can be speed-loaded, it can be speed-unloaded.
		if(allow_dump && (load_method & SPEEDLOADER))
			var/count = 0
			var/turf/T = get_turf(user)
			if(T)
				for(var/obj/item/ammo_casing/C in loaded)
					C.loc = T
					count++
				loaded.Cut()
			if(count)
				user.visible_message("[user] unloads [src].", span_notice("You unload [count] round\s from [src]."))
		else if(load_method & SINGLE_CASING)
			var/obj/item/ammo_casing/C = loaded[loaded.len]
			loaded.len--
			user.put_in_hands(C)
			user.visible_message("[user] removes \a [C] from [src].", span_notice("You remove \a [C] from [src]."))
		playsound(src, 'sound/weapons/empty.ogg', 50, 1)
		user.hud_used.update_ammo_hud(user, src)
	else
		to_chat(user, span_warning("[src] is empty."))
	update_icon()
	user.hud_used.update_ammo_hud(user, src)

/obj/item/gun/projectile/attackby(var/obj/item/A as obj, mob/user as mob)
	..()
	load_ammo(A, user)

/obj/item/gun/projectile/attack_self(mob/user as mob)
	if(firemodes.len > 1)
		switch_firemodes(user)
	else
		unload_ammo(user)

/obj/item/gun/projectile/attack_hand(mob/user as mob)
	if(user.get_inactive_hand() == src)
		unload_ammo(user, allow_dump=0)
	else
		return ..()

/obj/item/gun/projectile/afterattack(atom/A, mob/living/user)
	..()
	if(auto_eject && ammo_magazine && ammo_magazine.stored_ammo && !ammo_magazine.stored_ammo.len)
		ammo_magazine.loc = get_turf(src.loc)
		user.visible_message(
			"[ammo_magazine] falls out and clatters on the floor!",
			span_notice("[ammo_magazine] falls out and clatters on the floor!")
			)
		if(auto_eject_sound)
			playsound(src, auto_eject_sound, 40, 1)
		ammo_magazine.update_icon()
		ammo_magazine = null
		update_icon() //make sure to do this after unsetting ammo_magazine
		user.hud_used.update_ammo_hud(user, src)

/obj/item/gun/projectile/examine(mob/user)
	. = ..()
	if(ammo_magazine)
		. += "It has \a [ammo_magazine] loaded."
	. += "It has [getAmmo()] round\s remaining."

/obj/item/gun/projectile/proc/getAmmo()
	var/bullets = 0
	if(loaded)
		bullets += loaded.len
	if(ammo_magazine && ammo_magazine.stored_ammo)
		bullets += ammo_magazine.stored_ammo.len
	if(chambered)
		bullets += 1
	return bullets

/* Unneeded -- so far.
//in case the weapon has firemodes and can't unload using attack_hand()
/obj/item/gun/projectile/verb/unload_gun()
	set name = "Unload Ammo"
	set category = "Object"
	set src in usr

	if(usr.stat || usr.restrained()) return

	unload_ammo(usr)
*/

// TGMC Ammo HUD Insertion
/obj/item/gun/projectile/has_ammo_counter()
	return TRUE

/obj/item/gun/projectile/get_ammo_type()
	if(load_method & MAGAZINE)
		if(chambered) // Do we have an ammo casing chambered
			var/obj/item/ammo_casing/A = chambered
			var/obj/item/projectile/P = A.projectile_type
			return list(initial(P.hud_state), initial(P.hud_state_empty))
		else if(ammo_magazine && ammo_magazine.stored_ammo.len) // Do we have a mag, and have ammo in the mag, but nothing chambered?
			var/obj/item/ammo_casing/A = ammo_magazine.stored_ammo[1]
			var/obj/item/projectile/P = A.projectile_type
			return list(initial(P.hud_state), initial(P.hud_state_empty))
		else if(src.projectile_type) // Else, we're entirely empty, and irregardless of the mag we have loaded (as it's empty, or it would've passed the length check above), return the DEFAULT projectile_type on the gun, if set.
			var/obj/item/projectile/P = src.projectile_type
			return list(initial(P.hud_state), initial(P.hud_state_empty))
		else
			return list("unknown", "unknown") // Safety, this shouldn't happen, but just in case
	else if(load_method & (SINGLE_CASING|SPEEDLOADER)) // Do we load with single casings OR speedloaders?
		if(chambered) // Do we have an ammo casing loaded in the chamber? All casings still have a projectile_type var.
			var/obj/item/ammo_casing/A = chambered
			var/obj/item/projectile/P = A.projectile_type
			return list(initial(P.hud_state), initial(P.hud_state_empty)) // Return the casing's projectile_type ammo hud state
		else if(loaded.len) // Else, is the gun loaded, but no ammo casings in chamber currently?
			var/obj/item/ammo_casing/A = loaded[1]
			var/obj/item/projectile/P = A.projectile_type
			return list(initial(P.hud_state), initial(P.hud_state_empty)) // Return the ammunition loaded in the gun's hud_state
		else if(src.projectile_type) // Else, we're entirely empty, and have nothing loaded in the gun, and nothing in the chamber. Return the DEFAULT projectile_type on the gun, if set.
			var/obj/item/projectile/P = src.projectile_type
			return list(initial(P.hud_state), initial(P.hud_state_empty))
		else
			return list("unknown", "unknown") // Safety, this shouldn't happen, but just in case
	else if(src.projectile_type) // Failsafe if we somehow don't pass the above. Return the DEFAULT projectile_type on the gun, if set.
		var/obj/item/projectile/P = src.projectile_type
		return list(initial(P.hud_state), initial(P.hud_state_empty))
	else  // Failsafe if we somehow fail all three methods
		return list("unknown", "unknown")

/obj/item/gun/projectile/get_ammo_count()
	if(ammo_magazine) // Do we have a magazine loaded?
		var/shots_left
		if(chambered && chambered.BB) // Do we have a bullet in the currently-chambered casing, if any?
			shots_left++
		for(var/obj/item/ammo_casing/bullet in ammo_magazine.stored_ammo)
			if(bullet.BB)
				shots_left++

		if(shots_left > 0)
			return shots_left
		else
			return 0 // No ammo left or failsafe.
	else if(loaded) // Do we use internal ammunition
		var/shots_left
		if(chambered && chambered.BB) // Do we have a bullet in the currently-chambered casing, if any?
			shots_left++
		for(var/obj/item/ammo_casing/bullet in loaded)
			if(bullet.BB) // Only increment how many shots we have left if we're loaded.
				shots_left++

		if(shots_left > 0)
			return shots_left
		else
			return 0 // No ammo left or failsafe.
	else if(chambered) // If we don't have a magazine or internal ammunition loaded, but we have a casing in chamber, return the amount.
		return chambered.BB ? 1 : 0
	else // Failsafe, or completely unloaded
		return 0
