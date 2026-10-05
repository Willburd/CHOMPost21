/obj/machinery/porta_turret
	// Ref to the AI currently controlling this turret
	var/ai_currently_inhabited = null
	/// Forbids the AI from manually controlling this turret
	var/forbid_ai_control = FALSE

/obj/machinery/porta_turret/click_alt(mob/user)
	if(!isAI(user))
		return
	if(forbid_ai_control)
		to_chat(user, span_warning("This turret is beyond your control!"))
		return
	if(ai_currently_inhabited && ai_currently_inhabited != user)
		to_chat(user, span_warning("This turret is already being directly controlled!"))
		return
	if(!(src.z in using_map.ai_shell_allowed_levels))
		return
	user.AddComponent(/datum/component/remote_view, focused_on = src, viewsize = 10, vconfig_path = /datum/remote_view_config/ai_turret_view)
	var/obj/item/gun/energy/E = installation
	var/armed = "nothing"
	if(E)
		armed = "a [E?.name]"
	to_chat(user, span_notice("You've assumed direct control of \the [src], armed with [armed]."))

// Remote view
/datum/remote_view_config/ai_turret_view
	relay_movement = FALSE
	will_stun = FALSE
	will_weaken = FALSE
	will_paralyze = FALSE
	will_sleep = FALSE
	will_blind = FALSE

// We are responsible for restoring the health UI's icons on removal
/datum/remote_view_config/ai_turret_view/attached_to_mob(datum/component/remote_view/owner_component, mob/host_mob)
	host_mob.click_intercept = src
	var/obj/machinery/porta_turret/turret = owner_component.get_target()
	turret.ai_currently_inhabited = host_mob
	turret.popUp()

/datum/remote_view_config/ai_turret_view/detatch_from_mob(datum/component/remote_view/owner_component, mob/host_mob)
	host_mob.click_intercept = null
	var/obj/machinery/porta_turret/turret = owner_component.get_target()
	turret.ai_currently_inhabited = null
	turret.popDown()

/datum/remote_view_config/ai_turret_view/proc/InterceptClickOn(mob/user, params, atom/target)
	if(user.stat || user.paralysis || user.stunned)
		return FALSE
	var/datum/component/remote_view/comp = user.GetComponent(/datum/component/remote_view)
	if(!comp)
		return FALSE

	// Fire the turret!
	var/obj/machinery/porta_turret/turret = comp.get_target()
	if(!turret || turret.disabled)
		return TRUE
	if(turret.raising || !turret.raised)
		return TRUE
	if(!target)
		return TRUE

	// Pew pew pew
	turret.last_target = target
	var/old_dir = turret.dir
	turret.set_dir(get_dir(turret, target))
	if(turret.dir != old_dir)
		playsound(turret, 'sound/machines/turrets/turret_rotate.ogg', 100, 1)
	spawn()
		turret.shootAt(target)

	return TRUE


//////////////////////////////////////////////////////////////////////////////////////////////////////
// Subtypes
//////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/machinery/porta_turret/heavy
	name = "hardened defense turret"
	desc = "Specialized, hardened turrets for securing the most valuable assets. Not to be taken lightly."
	installation = /obj/item/gun/energy/lasercannon //Bigger gun, bigger ow
	health = 400 // Since lasers do 40 each. //op- So 10 hits~? Sounds fair~
	maxhealth = 400
	faction = "outpost21" //Makes sure specific station critters, like swoopies, aren't targeted
	shot_delay = 2 SECONDS //These are... a bit nasty so let's slow them down.
	auto_repair = TRUE
	lethal = TRUE
	lethal_is_configurable = FALSE //Always angry, always lethal

/obj/machinery/porta_turret/heavy/sniper
	name = "hardened defense turret"
	desc = "Specialized, hardened turrets for securing the most valuable assets. Not to be taken lightly."
	installation = /obj/item/gun/projectile/automatic/serdy/hectate //MASSIVE gun
	projectile = /obj/item/projectile/bullet/rifle/a145 //SHOULD pull from the gun.... but just incase
	lethal_projectile = /obj/item/projectile/bullet/rifle/a145 //Always angy
	shot_sound = "sound/weapons/serdy/sks.ogg"
	lethal_shot_sound = "sound/weapons/serdy/sks.ogg"
	shot_delay = 2.5 SECONDS //Slower firing, but it hits like a truck. 1 shot will almost down you, 2 will paincrit. 3 confirms the kill.
	reqpower = 50 //Significantly less, due to actual gun, not laser

/obj/machinery/porta_turret/heavy/lmg
	name = "hardened defense turret"
	desc = "Specialized, hardened turrets for securing the most valuable assets. Not to be taken lightly."
	installation = /obj/item/gun/projectile/automatic/l6_saw
	projectile = /obj/item/projectile/bullet/rifle/a545
	lethal_projectile = /obj/item/projectile/bullet/rifle/a545
	shot_sound = "sound/weapons/Gunshot_light.ogg"
	lethal_shot_sound = "sound/weapons/Gunshot_light.ogg"
	shot_delay = 0.18 SECONDS //Super fast fire rate. It's a machine gun. Vali set the number, blame her :P
	reqpower = 50

/obj/machinery/porta_turret/heavy/disabler
	name = "hardened defense turret"
	desc = "Specialized, hardened turrets for securing the most valuable assets. Not to be taken lightly."
	installation = /obj/item/gun/energy/robotic/disabler //Drop em boys! Nonlethally~ :>
	health = 400 // Since lasers do 40 each. //op- So 10 hits~? Sounds fair~
	maxhealth = 400
	faction = "outpost21" //Makes sure specific station critters, like swoopies, aren't targeted
	shot_delay = 1.5 SECONDS
	auto_repair = TRUE
	lethal = TRUE
	lethal_is_configurable = FALSE //Always angry, always lethal


/obj/machinery/porta_turret/stationary/CIWS //Why do the AA guns suck?
	installation = /obj/item/gun/projectile/automatic/l6_saw
	shot_delay = 0.18 SECONDS //Super fast fire rate. It's a machine gun. Vali set the number, blame her :P
	reqpower = 50

/obj/machinery/porta_turret/stationary/syndie/CIWS
	installation = /obj/item/gun/projectile/automatic/serdy/rpk //Give the syndies a different gun
	shot_delay = 0.18 SECONDS //Super fast fire rate. It's a machine gun. Vali set the number, blame her :P
	reqpower = 50

/obj/machinery/porta_turret/heavy/target(mob/living/target)
	if(disabled)
		return FALSE
	if(target)
		if(target in check_trajectory(target, src))	//Finally, check if we can actually hit the target
			last_target = target
			popUp()				//pop the turret up if it's not already up.
			set_dir(get_dir(src, target))	//even if you can't shoot, follow the target
//			playsound(src, 'sound/machines/turrets/turret_rotate.ogg', 100, 1) // Play rotating sound
			spawn()
				shootAt(target)
			return TRUE
	return FALSE


//////////////////////////////////////////////////////////////////////////////////////////////////////
// AI core controlled Subtypes (Doesn't mean they can't be hacked, just that they start disabled and ai locked)
//////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/machinery/porta_turret/ai_station_offensive
	enabled = FALSE
	req_one_access = list(ACCESS_SYNTH)
