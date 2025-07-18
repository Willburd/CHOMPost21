/datum/event/badbody
	endWhen  	 	= 10
	var/in_morgue = FALSE
	var/force_chance = FALSE

/datum/event/badbody/forced
	endWhen  	 	= 10
	force_chance = TRUE

/datum/event/badbody/morgue
	in_morgue = TRUE

/datum/event/badbody/morgue/forced
	in_morgue = TRUE
	force_chance = TRUE

/datum/event/badbody/setup()
	if(prob(60) && !force_chance)
		log_debug("Badbody failed successfully.")
		kill()
		return

	var/list/spawn_locations = list()
	if(in_morgue)
		for(var/obj/structure/morgue/M in get_area_all_atoms(/area/medical/morgue))
			if(M.contents.len == 0)
				spawn_locations.Add(M)
	else
		for(var/obj/effect/landmark/C in GLOB.landmarks_list)
			if(C.name == "badbody" && (C.z in using_map.event_levels))
				spawn_locations.Add(C.loc)

	if(!spawn_locations.len)
		log_debug("Badbody had no spawn points.")
		kill()
		return

	var/bodies = 1
	if(in_morgue)
		bodies = rand(1,6)
		if(bodies > spawn_locations.len)
			bodies = spawn_locations.len
	var/list/client_list = GLOB.clients.Copy()
	if(bodies > client_list.len)
		bodies = client_list.len
	while(client_list.len && bodies > 0)
		var/client/C = pick(client_list)
		client_list.Remove(C)

		var/atom/spot = pick(spawn_locations)
		var/mob/living/carbon/human/badbody = spawn_body(C,spot)
		if(!isnull(badbody))
			spawn(1)
				var/datum/component/badbody/B = badbody.AddComponent(/datum/component/badbody)
				B.harm_body()
				B.set_items()
				log_debug("successfully spawned badbody [badbody.real_name] at [spot.x] [spot.y] [spot.z].")
			bodies--
			if(in_morgue)
				spawn_locations.Remove(spot)
				var/obj/structure/morgue/M = spot
				M.update()
			if(bodies <= 0)
				break

	if(bodies > 0)
		log_debug("Badbody failed to spawn successful body.")
		kill()

/datum/event/badbody/announce()
	return

/datum/event/badbody/start()
	return

/datum/event/badbody/proc/spawn_body(client/picked_client,var/turf/spawnloc)
	// A terrible clone of /client/proc/respawn_character() but with fixed choices.
	if(!spawnloc || !istype(picked_client))
		return

	// check validity before spawn
	var/datum/preferences/P = picked_client.prefs;
	if(!P)
		return
	if(P.species == SPECIES_DIONA || P.species == SPECIES_SHADEKIN || P.species == SPECIES_PROMETHEAN || P.species == SPECIES_PROTEAN) // species that don't leave bodies
		return
	if(P.organ_data[BP_TORSO] == "cyborg") // no FBP, too easy to "repair"
		return
	if(P.job_engsec_high & CYBORG || P.job_engsec_high & AI) // No borgs! If they don't have it as their high job, they spawn as something else anyway, or are abusing code diving to cheese this... Hello by the way.
		return
	var/mob/living/carbon/human/new_character = new(spawnloc)
	anim(spawnloc,new_character,'icons/mob/mob.dmi',,"phasein",,new_character.dir)
	if(!new_character)
		return

	//Write the appearance and whatnot out to the character
	picked_client.prefs.copy_to(new_character)
	if(new_character.dna)
		new_character.dna.ResetUIFrom(new_character)
		new_character.sync_dna_traits(TRUE)
		new_character.sync_organ_dna()
	for(var/lang in picked_client.prefs.alternate_languages)
		var/datum/language/chosen_language = GLOB.all_languages[lang]
		if(chosen_language)
			if(is_lang_whitelisted(picked_client,chosen_language) || (new_character.species && (chosen_language.name in new_character.species.secondary_langs)))
				new_character.add_language(lang)
	// job_master.EquipRank(new_character, JOB_STOWAWAY, 1, FALSE) // This has outplayed it's use... Not really that good?

	//A redraw for good measure
	new_character.regenerate_icons()
	new_character.update_transform() //VOREStation Edit
	return new_character
