/// Used for undead mobs that need to revive themselves randomly after death
/datum/component/undead_revival
	var/mob/living/simple_mob/host
	var/revive_chance
	var/health_percent_revive_at
	var/revive_text
	var/revive_time

/datum/component/undead_revival/Initialize(rev_time = 1 MINUTE, rev_chance = 30, rev_hppercent = 70, rev_text = "shudders and twitches, moving once more!")
	if(!isanimal(parent)) // No humans for you
		return COMPONENT_INCOMPATIBLE
	host = parent
	revive_time = rev_time
	revive_text = rev_text
	revive_chance = rev_chance
	health_percent_revive_at = rev_hppercent
	RegisterSignal(host, COMSIG_MOB_DEATH, PROC_REF(on_mob_death))

/datum/component/undead_revival/Destroy(force = FALSE)
	UnregisterSignal(host, COMSIG_MOB_DEATH)
	host = null
	. = ..()

/datum/component/undead_revival/proc/on_mob_death(datum/source, gibbed)
	SIGNAL_HANDLER
	if(gibbed) // No need to bother
		return
	addtimer(CALLBACK(src, PROC_REF(revive_action)), revive_time + (revive_time * rand(0,1)), TIMER_DELETE_ME)

/datum/component/undead_revival/proc/revive_action()
	if(host.stat != DEAD)
		return
	if(!prob(revive_chance)) // Retry later
		addtimer(CALLBACK(src, PROC_REF(revive_action)), revive_time + (revive_time * rand(0,1)), TIMER_DELETE_ME)
		return
	// Time for fun!
	host.visible_message(span_danger("\The [host] [revive_text]"))
	host.make_jittery(110) // Looks better if they "animate" a bit
	playsound(host, 'sound/effects/splat.ogg', 50, 1)
	playsound(host, 'sound/voice/hiss5.ogg', 50, 1)
	addtimer(CALLBACK(src, PROC_REF(finalize_revive)), 1.2 SECONDS, TIMER_DELETE_ME)

/datum/component/undead_revival/proc/finalize_revive()
	if(host.stat != DEAD)
		return
	host.revive()
	host.health *= (health_percent_revive_at / 100)
	host.health += rand(0,host.health * 0.1) // Get some randomized health
	host.health = CLAMP(host.health, 0, initial(host.health))
	host.loot_list = list() // Clear the loot list, we already dropped our loot!
