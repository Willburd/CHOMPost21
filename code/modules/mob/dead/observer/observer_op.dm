/mob/observer/dead/verb/become_jil()
	set name = "Become jil"
	set category = "Ghost.Join"

	if(CONFIG_GET(flag/disable_player_mice)) // CHOMPEdit
		to_chat(src, "<span class='warning'>Spawning as a jil is currently disabled.</span>")
		return

	//VOREStation Add Start
	if(jobban_isbanned(src, "GhostRoles"))
		to_chat(src, "<span class='warning'>You cannot become a jil because you are banned from playing ghost roles.</span>")
		return
	//VOREStation Add End

	if(!MayRespawn(1))
		return

	var/turf/T = get_turf(src)
	if(!T || (T.z in using_map.admin_levels))
		to_chat(src, "<span class='warning'>You may not spawn as a jil on this Z-level.</span>")
		return

	var/timedifference = world.time - client.time_died_as_mouse
	if(client.time_died_as_mouse && timedifference <= mouse_respawn_time * 600)
		var/timedifference_text
		timedifference_text = time2text(mouse_respawn_time * 600 - timedifference,"mm:ss")
		to_chat(src, "<span class='warning'>You may only spawn again as a jil more than [mouse_respawn_time] minutes after your death. You have [timedifference_text] left.</span>")
		return

	var/response = tgui_alert(src, "Are you -sure- you want to become a jil? You will have no rights or OOC protections.","Are you sure you want to squeek? You will have no rights or OOC protections.",list("Merp!","Nope!")) //CHOMP Edit
	if(response != "Merp!") return  //Hit the wrong key...again.


	//find a viable mouse candidate
	var/mob/living/simple_mob/vore/alienanimals/jil/host
	var/obj/machinery/atmospherics/unary/vent_pump/vent_found
	var/list/found_vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/v in machines)
		if(!v.welded && v.z == T.z && v.network && v.network.normal_members.len > 20)
			found_vents.Add(v)
	if(found_vents.len)
		vent_found = pick(found_vents)
		host = new /mob/living/simple_mob/vore/alienanimals/jil(vent_found)
	else
		to_chat(src, "<span class='warning'>Unable to find any unwelded vents to spawn mice at.</span>")

	if(host)
		if(CONFIG_GET(flag/uneducated_mice)) // CHOMPEdit
			host.universal_understand = 0
		announce_ghost_joinleave(src, 0, "They are now a jil.")
		host.ckey = src.ckey
		host.add_ventcrawl(vent_found)
		to_chat(host, "<span class='info'>You are now a Jil, a fluffy little thief that seeks to steal anything you can grab, and bring it back to your nest. Be warned, the crew might not like you taking their things.</span>")

/mob/observer/dead/proc/alert_of_death(var/datum/transhuman/mind_record/MR)
	ASSERT(MR)
	if(!client)	return

	var/turf/T = null
	if(mind && mind.current && can_reenter_corpse)
		if(!istype(T,/turf/space))
			T = get_turf(mind.current.loc)
		if(T && !(T.z in using_map.station_levels))
			T = null // lost in spess

	if(T)
		// Found location of body
		var/xx = T.x + rand(-5,5)
		var/yy = T.y + rand(-5,5)
		global_announcer.autosay("[MR.mindname]'s bio-signature was recently lost on TransCore wide area scan. Their last known GPS location was near [xx], [yy], [ using_map.get_zlevel_name(T.z) ]. The crew is advised to recover their body if possible. They have been verified as deceased by scout drones. No other bio-signature matches detected, resleeving is confirmed legal.", "TransCore Oversight", CHANNEL_COMMON)
	else
		// No body found
		global_announcer.autosay("[MR.mindname]'s bio-signature was recently lost on TransCore wide area scan, and cannot be located on the planet's surface. Medical is advised to resleeve them if possible, as scanner drones have been unable to locate their body. A missing persons notice will be forwarded to SolGov authorities if an abduction has occured.", "TransCore Oversight", CHANNEL_COMMON)
