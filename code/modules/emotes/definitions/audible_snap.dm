/decl/emote/audible/snap
	key = "snap"
	emote_message_1p = "You snap your fingers."
	emote_message_3p = "snaps USER_THEIR fingers."
	emote_message_1p_target = "You snap your fingers at TARGET."
	emote_message_3p_target = "snaps USER_THEIR fingers at TARGET."
	emote_sound = 'sound/effects/fingersnap.ogg'

/decl/emote/audible/snap/proc/can_snap(var/atom/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		for(var/limb in list(BP_L_HAND, BP_R_HAND))
			var/obj/item/organ/external/L = H.get_organ(limb)
			if(istype(L) && L.is_usable() && !L.splinted)
				return TRUE
	else if(isanimal(user))		//VOREStation Addition Start
		var/mob/living/simple_mob/S = user
		if(S.has_hands)
			return TRUE
	else if(ispAI(user))
		return TRUE
	else						//VOREStation Addition End
		return FALSE

// Outpost 21 edit begin - a pretty awful way to do this, but it's not used anywhere else at all, and I'm not making it a 1% chance to burst into flames for no reason on a single snap
/mob/living
	var/lastsnapemotetime = 0
// Outpost 21 edit end

/decl/emote/audible/snap/do_emote(var/atom/user, var/extra_params)
	if(!can_snap(user))
		to_chat(user, span_warning("You need at least one working hand to snap your fingers."))
		return FALSE

	// outpost 21 edit begin - add the sillier interactions
	if(isliving(user))
		var/mob/living/L = user
		var/lasttime = L.lastsnapemotetime
		L.lastsnapemotetime = world.time
		if((L.lastsnapemotetime - lasttime) <= 2.5 SECONDS)
			if(prob(3))
				L.adjust_fire_stacks(2)
				L.IgniteMob()
				L.visible_message(span_danger("[L] bursts into flames!"))
	// outpost 21 edit end

	. = ..()
