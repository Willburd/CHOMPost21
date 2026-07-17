// smack
/obj/item/material/sword/battleaxe
	armor_penetration = 10
	can_cleave = TRUE
	force_divisor = 0.84
	attackspeed = DEFAULT_ATTACK_COOLDOWN * 2

// stabby stabby
/obj/item/material/sword/gladius
	armor_penetration = 10
	force_divisor = 0.42
	attackspeed = DEFAULT_QUICK_COOLDOWN

// Parry this casual
/obj/item/material/sword/katana
	force_divisor = 0.5
	fragile = TRUE

/obj/item/material/sword/katana/unique_parry_check(mob/user, mob/attacker, atom/damage_source)
	if(user.incapacitated())
		return 0
	if(!istype(damage_source, /obj/item/projectile/) && prob(70)) // Lower chance to parry melee.
		return 0
	var/bad_arc = reverse_direction(user.dir)
	if(!check_shield_arc(user, bad_arc, damage_source, attacker))
		return 0
	return 1

// engarde
/obj/item/material/sword/rapier
	reach = 2
	force_divisor = 0.34
	attackspeed = DEFAULT_QUICK_COOLDOWN

/obj/item/material/sword/rapier/unique_parry_check(mob/user, mob/attacker, atom/damage_source)
	if(user.incapacitated())
		return 0
	if(prob(80)) // Much lower chance (even after the 50% before this)
		return 0
	var/bad_arc = reverse_direction(user.dir)
	if(!check_shield_arc(user, bad_arc, damage_source, attacker))
		return 0
	return 1

// parry machine
/obj/item/material/sword/sabre
	force_divisor = 0.67

/obj/item/material/sword/sabre/unique_parry_check(mob/user, mob/attacker, atom/damage_source)
	if(user.incapacitated())
		return 0
	if(prob(20)) // Lower chance (even after the 50% before this)
		return 0
	if(istype(damage_source, /obj/item/projectile/)) // Can't parry bullets
		return 0
	var/bad_arc = reverse_direction(user.dir)
	if(!check_shield_arc(user, bad_arc, damage_source, attacker))
		return 0
	return 1

// Faster butcher
/obj/item/material/knife/butch
	toolspeed = 0.6

// meant to smack items away
/obj/item/material/twohanded/baseballbat
	force_divisor = 1

// bigboy sword
/obj/item/material/twohanded/longsword
	force_divisor = 0.64
	attackspeed = DEFAULT_ATTACK_COOLDOWN * 2
	can_cleave = TRUE

/obj/item/material/twohanded/longsword/unique_parry_check(mob/user, mob/attacker, atom/damage_source)
	if(user.incapacitated())
		return 0
	if(prob(60)) // Much lower chance (even after the 50% before this)
		return 0
	if(istype(damage_source, /obj/item/projectile/)) // Can't parry bullets
		return 0
	var/bad_arc = reverse_direction(user.dir)
	if(!check_shield_arc(user, bad_arc, damage_source, attacker))
		return 0
	return 1

// Heavy bonker
/obj/item/material/twohanded/sledgehammer
	force_divisor = 1.5

// disarms and non lethal
/obj/item/material/twohanded/staff
	force_divisor = 0.6
	damtype = HALLOSS

/obj/item/material/twohanded/staff/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	if(user?.a_intent == I_DISARM)
		if(prob(min(90, force * 3)) && ishuman(target) && (hit_zone in list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT, BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND)))
			ranged_disarm(target, user, hit_zone)
	..()

/obj/item/material/twohanded/staff/proc/ranged_disarm(mob/living/carbon/human/H, mob/living/user, hit_zone)
	if(istype(H))
		var/list/holding = list(H.get_active_hand() = 40, H.get_inactive_hand() = 20)

		if(hit_zone in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND))
			for(var/obj/item/gun/W in holding)
				if(W && prob(holding[W]))
					var/list/turfs = list()
					for(var/turf/T in view())
						turfs += T
					if(turfs.len)
						var/turf/target = pick(turfs)
						visible_message(span_danger("[H]'s [W] goes off due to \the [src]!"))
						return W.afterattack(target,H)

		if(!(H.species.flags & NO_SLIP) && prob(10) && (hit_zone in list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)))
			var/armor_check = H.run_armor_check(hit_zone, "melee")
			H.apply_effect(3, WEAKEN, armor_check)
			playsound(src, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			if(armor_check < 60)
				visible_message(span_danger("\The [src] has tripped [H]!"))
			else
				visible_message(span_warning("\The [src] attempted to trip [H]!"))
			return

		else
			if(H.break_all_grabs(user))
				playsound(src, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				return

			if(hit_zone in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND))
				for(var/obj/item/I in holding)
					if(I && prob(holding[I]))
						H.drop_from_inventory(I)
						visible_message(span_danger("\The [src] has disarmed [H]!"))
						playsound(src, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						return
