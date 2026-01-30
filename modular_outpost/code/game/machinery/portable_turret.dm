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
	installation = /obj/item/gun/energy/taser/disabler //Drop em boys! Nonlethally~ :>
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

/obj/machinery/porta_turret/heavy/target(var/mob/living/target)
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

//This seems hacky as fuck, taken from the alien turrets.
/obj/machinery/porta_turret/heavy/emp_act(severity, recursive) // This is overrided to give an EMP resistance as well as avoid scambling the turret settings.
	if(prob(75)) // seems to just disable it for a time?
		return
	enabled = FALSE
	spawn(rand(1 MINUTE, 2 MINUTES))
		if(!enabled)
			enabled = TRUE
