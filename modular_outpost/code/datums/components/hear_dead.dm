/datum/component/hear_dead
	var/mob/our_listener

/datum/component/hear_dead/Initialize()
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	our_listener = parent
	RegisterSignal(SSdcs, COMSIG_OUTPOST_HEAR_DEAD, PROC_REF(hear_dead))
	tgui_alert(our_listener, "At first it begins as a whisper, then a raging torrent of voices, before silence... Yet the whispers persist in the back of your mind, as if they have become a piece of you... (OOC: You can now hear deadchat nearby. This has been gifted to you by admemes, and should be treated as some kind of whispering insanity IC. Either voices in your mind, or hearing the ramblings of demons or ghosts. Ghost chat also likes to meme and talk about ooc things. Try to keep stuff as IC as reasonable, you're absolute allowed to lie about what they're saying too! It's likely only you that hears them.)", "Voices beyond the veil reach out", list("Awaken Your Mind"))

/datum/component/hear_dead/Destroy(force)
	UnregisterSignal(SSdcs, COMSIG_OUTPOST_HEAR_DEAD)
	tgui_alert(our_listener, "The voices fall silent. You are now alone in your head once more. (OOC: You will no longer hear deadchat messages.)", "The Voices Are Silent", list("Silence..."))
	our_listener = null
	. = ..()

/datum/component/hear_dead/proc/hear_dead(mob/source, message)
	SIGNAL_HANDLER
	var/turf/our_turf = get_turf(our_listener)
	var/turf/ghost_turf = get_turf(source)
	var/dist = our_turf.Distance(ghost_turf)
	var/say_sound = pick(list("whimpers","cries","whispers","gasps"))
	if(our_listener.stat != CONSCIOUS)
		return
	if(dist > 32)
		return
	if(dist > 16)
		if(prob(80))
			return
		to_chat(our_listener, span_deadsay("Something distant [say_sound], \"[Gibberish(message, 100)]\""))
		return
	if(dist > 8)
		if(prob(60))
			return
		to_chat(our_listener, span_deadsay("Something distant [say_sound], \"[Gibberish(message, 70)]\""))
		return
	if(dist > 4)
		if(prob(30))
			return
		to_chat(our_listener, span_deadsay("Something close [say_sound], \"[Gibberish(message, 50)]\""))
		return
	to_chat(our_listener, span_deadsay("Something beside you [say_sound], \"[Gibberish(message, 20)]\""))
