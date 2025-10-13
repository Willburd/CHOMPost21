////////////////////////////////////////////////////////////////////////////////
// Internal seats

/obj/structure/bed/chair/vehicle_interior_seat
	name = "shuttle seat"
	desc = "A comfortable, secure seat. It has a sturdy-looking buckling system for smoother drives."
	base_icon = "shuttle_chair"
	icon_state = "shuttle_chair_preview"
	buckle_movable = TRUE // we do some silly stuff though
	var/buckling_sound = 'sound/effects/metal_close.ogg'
	var/padding = "blue"
	var/obj/machinery/computer/vehicle_interior_console/paired_console = null

/obj/structure/bed/chair/vehicle_interior_seat/Initialize(mapload, new_material, new_padding_material)
	. = ..(mapload, MAT_STEEL, new_padding_material)

/obj/structure/bed/chair/vehicle_interior_seat/post_buckle_mob()
	playsound(src,buckling_sound,75,1)
	if(has_buckled_mobs())
		base_icon = "shuttle_chair-b"
	else
		base_icon = "shuttle_chair"
	..()

/obj/structure/bed/chair/vehicle_interior_seat/update_icon()
	..()
	var/image/I = image(icon, "[base_icon]_over")
	I.layer = ABOVE_MOB_LAYER
	I.plane = MOB_PLANE
	I.color = material.icon_colour
	add_overlay(I)
	if(!has_buckled_mobs())
		I = image(icon, "[base_icon]_special")
		I.plane = MOB_PLANE
		I.layer = ABOVE_MOB_LAYER
		if(applies_material_colour)
			I.color = material.icon_colour
		add_overlay(I)

/obj/structure/bed/chair/vehicle_interior_seat/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	if(paired_console.is_viewing_tank())
		playsound(src, "keyboard", 40) // out of console
		SEND_SIGNAL(paired_console,COMSIG_REMOTE_VIEW_CLEAR)
		buckled_mob.setClickCooldown(1) // lower cooldown than normal, but still have one
	else
		. = ..()

/obj/structure/bed/chair/vehicle_interior_seat/Destroy()
	SEND_SIGNAL(paired_console,COMSIG_REMOTE_VIEW_CLEAR)
	return ..()

/obj/structure/bed/chair/vehicle_interior_seat/ex_act(severity)
	SEND_SIGNAL(paired_console,COMSIG_REMOTE_VIEW_CLEAR)

////////////////////////////////////////////////////////////////////////////////
// Pilot seat
/obj/structure/bed/chair/vehicle_interior_seat/pilot/relaymove(mob/user, direction)
	if(paired_console.is_viewing_tank()) // only if driver is looking!
		return paired_console.interior_controller.relaymove(user, direction) // forward to vehicle!
	else
		return FALSE

//-------------------------------------------
// Click through procs, for when you click in vehicle view!
//-------------------------------------------

/obj/structure/bed/chair/vehicle_interior_seat/proc/click_action(atom/target,mob/user, params)
	if(paired_console.controls_weapon_index > 0)
		var/obj/item/vehicle_interior_weapon/W = paired_console.interior_controller.internal_weapons_list[paired_console.controls_weapon_index]
		if(!W || paired_console.interior_controller.health <= 0)
			to_chat(user, span_warning("Weapon is inoperable!"))
		else
			W.action(target, params, user)
