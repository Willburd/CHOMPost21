/obj/structure/musician
	name = "Not A Piano"
	desc = "Something broke, contact coderbus."
	var/can_play_unanchored = FALSE
	var/list/allowed_instrument_ids = list("r3grand","r3harpsi","crharpsi","crgrand1","crbright1", "crichugan", "crihamgan","piano")
	var/datum/song/song

/obj/structure/musician/Initialize(mapload)
	. = ..()
	song = new(src, allowed_instrument_ids)
	allowed_instrument_ids = null

/obj/structure/musician/Destroy()
	QDEL_NULL(song)
	return ..()

/obj/structure/musician/attack_hand(mob/M)
	if(!M.IsAdvancedToolUser())
		return

	interact(M)

// CHOMPAdd - Grand piano moving

/obj/structure/musician/attackby(obj/item/W as obj, mob/user as mob)
	if(W.has_tool_quality(TOOL_WRENCH))
		playsound(src, W.usesound, 100, 1)
		if(anchored)
			user.visible_message(span_filter_notice("[user] begins unsecuring \the [src] from the floor."), span_filter_notice("You start unsecuring \the [src] from the floor."))
		else
			user.visible_message(span_filter_notice("[user] begins securing \the [src] to the floor."), span_filter_notice("You start securing \the [src] to the floor."))

		if(do_after(user, 20 * W.toolspeed))
			if(!src) return
			to_chat(user, span_notice("You [anchored? "un" : ""]secured \the [src]!"))
			anchored = !anchored
		return

// CHOMPEnd

/obj/structure/musician/proc/should_stop_playing(mob/user)
	if(!(anchored || can_play_unanchored))
		return TRUE
	if(!user)
		return FALSE
	return !CanUseTopic(user)

/obj/structure/musician/interact(mob/user)
	. = ..()
	song.interact(user)

/*
/obj/structure/musician/wrench_act(mob/living/user, obj/item/I)
	default_unfasten_wrench(user, I, 40)
	return TRUE
*/

/obj/structure/musician/piano
	name = "space minimoog"
	icon = 'icons/obj/musician.dmi'
	icon_state = "minimoog"
	anchored = TRUE
	density = TRUE

/obj/structure/musician/piano/unanchored
	anchored = FALSE

/obj/structure/musician/piano/Initialize(mapload)
	. = ..()
	if(prob(50) && icon_state == initial(icon_state))
		name = "space minimoog"
		desc = "This is a minimoog, like a space piano, but more spacey!"
		icon_state = "minimoog"
	else
		name = "space piano"
		desc = "This is a space piano, like a regular piano, but always in tune! Even if the musician isn't."
		icon_state = "piano"
