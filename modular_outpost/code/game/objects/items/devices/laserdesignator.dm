#define CAM_DIST 18
#define CAM_SIZE 6

/obj/item/laser_designator
	name = "laser designator"
	desc = "Used to call down the fist of God!"
	icon = 'modular_outpost/icons/obj/device.dmi'
	icon_state = "designator"
	item_state = "designator"
	slot_flags = SLOT_BELT
	matter = list(MAT_GLASS = 500, MAT_STEEL = 500)
	w_class = 2 //Increased to 2, because diodes are w_class 2. Conservation of matter.
	var/turf/pointer_loc
	var/energy = 3
	var/max_energy = 3
	var/cooldown = 10
	var/last_used_time = 0
	var/recharging = 0
	var/recharge_locked = 0

/obj/item/laser_designator/attack_self(mob/user)
	. = ..(user)
	if(.)
		return TRUE
	zoom(user, CAM_DIST, CAM_SIZE) // long but small vision range

/obj/item/laser_designator/attack(mob/living/M, mob/user)
	laser_act(M, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/laser_designator/afterattack(var/atom/target, var/mob/living/user, flag, params)
	if(flag)	//we're placing the object on a table or in backpack
		return
	laser_act(target, user)

/obj/item/laser_designator/proc/laser_act(var/atom/target, var/mob/living/user)
	if(!(user in (viewers(world.view + CAM_DIST + CAM_SIZE,target))))
		return
	if(!(world.time - last_used_time >= cooldown))
		return
	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return

	add_fingerprint(user)

	//nothing happens if the battery is drained
	if(recharge_locked)
		to_chat(user, span_notice("You point [src] at [target], but it's still charging."))
		return

	/*
	var/choice = tgui_alert(user, "Confirm designation? Station alert level will be elevated to code blue.", "Designate target", list("YES", "NO"))
	if(choice != "YES")
		return
	*/

	var/turf/targloc = get_turf(target)

	//laser pointer image
	icon_state = "[item_state]_used"
	var/list/showto = list()
	for(var/mob/M in viewers(world.view,targloc))
		if(M.client)
			showto.Add(M.client)
	var/image/I = image('icons/obj/projectiles.dmi',targloc,"purple_laser",cooldown)
	I.plane = PLANE_LIGHTING_ABOVE
	I.pixel_x = target.pixel_x + rand(-5,5)
	I.pixel_y = target.pixel_y + rand(-5,5)

	user.visible_message("[user] points [src] at [target].", "You point [src] at [target].")

	last_used_time = world.time
	energy -= 1
	if(energy <= max_energy)
		if(!recharging)
			recharging = 1
			START_PROCESSING(SSobj, src)
		if(energy <= 0)
			to_chat(user, span_warning("You've overused the battery of [src], now it needs time to recharge!"))
			recharge_locked = 1
			return

	call_down_the_fist_of_god(user,target,targloc)
	flick_overlay(I, showto, cooldown)
	spawn(cooldown)
		icon_state = item_state

/obj/item/laser_designator/proc/call_down_the_fist_of_god(var/mob/user, var/atom/target,var/turf/hithere)
	if(target && !istype(hithere))
		hithere = get_turf(target)
	if(!target && !hithere)
		return

	if(GLOB.security_level < SEC_LEVEL_RED)
		set_security_level(SEC_LEVEL_RED)
		GLOB.command_announcement.Announce("Bluespace artillery fire detected. Brace for impact.")
	log_and_message_admins("[key_name(target)] has been hit by Bluespace Artillery fired by [key_name(user ? user : usr)]")

	spawn(10 SECONDS)
		if(hithere)
			var/hitsize = 3
			explosion(hithere, 2, hitsize,hitsize * 1.5)

/obj/item/laser_designator/process()
	if(prob(5))
		energy += 1
		if(energy >= max_energy)
			energy = max_energy
			recharging = 0
			recharge_locked = 0
			visible_message(span_notice("\The [src] has recharged!"))
			..()

#undef CAM_DIST
#undef CAM_SIZE
