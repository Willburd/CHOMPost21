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
		for(var/obj/effect/landmark/C in landmarks_list)
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
				set_items(badbody)
				harm_body(badbody)
				badbody.AddComponent(/datum/component/badbody)
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
	job_master.EquipRank(new_character, JOB_STOWAWAY, 1, FALSE)

	//A redraw for good measure
	new_character.regenerate_icons()
	new_character.update_transform() //VOREStation Edit
	return new_character

/datum/event/badbody/proc/set_items(var/mob/living/carbon/human/badbody)
	// Strip body of some stuff
	var/obj/item/find_id = locate(/obj/item/card/id) in badbody.contents
	if(find_id)
		badbody.drop_from_inventory(find_id)
		qdel(find_id)
	for(var/obj/item/clothing/C in badbody.contents)
		if(prob(30))
			badbody.drop_from_inventory(C)
			qdel(C)
	// Plant gps...
	var/obj/item/gps/G = new /obj/item/gps(badbody.loc)
	G.gps_tag = pick("SOS","ERROR","BAD NAME","OUT OF RANGE","BAD SIGNAL","CHECK NAME","CHECK SIGNAL","TEST MODE ACTIVE",badbody.real_name)
	G.tracking = TRUE
	G.name = "global positioning system ([G.gps_tag])"
	G.update_holder()
	G.update_icon()
	G.attack_hand(badbody) // yoink

/datum/event/badbody/proc/harm_body(var/mob/living/carbon/human/badbody)
	// Always break these
	var/obj/item/organ/external/left_leg = badbody.get_organ(BP_L_LEG)
	left_leg?.fracture()
	var/obj/item/organ/external/right_leg = badbody.get_organ(BP_R_LEG)
	right_leg?.fracture()
	// so they can't scream!
	badbody.stat = DEAD
	badbody.SetSpecialVoice("Unknown")
	// Brainrot
	var/obj/item/organ/internal/brain/B = badbody.internal_organs_by_name[O_BRAIN]
	if(!isnull(B))
		B.removed(null)
		qdel(B)
	// Damage organs
	for(var/org in badbody.organs_by_name)
		var/obj/item/organ/internal/O = badbody.internal_organs_by_name[org]
		if(istype(O,/obj/item/organ/internal))
			if(prob(5))
				O.removed(null)
				qdel(O)
			else
				O.take_damage(rand(20,200),TRUE)
	// Mess em up
	var/emergency = 500
	while(badbody.health > rand(-1500,-200) && emergency-- > 0)
		if(badbody.status_flags & GODMODE)
			badbody.status_flags ^= GODMODE
		var/pick_zone = ran_zone()
		var/obj/item/organ/external/org = badbody.get_organ(pick_zone)
		if(org)
			badbody.apply_damage( rand(85,150), pick( TOX, OXY, BURN, ELECTROCUTE), pick_zone)
			org.wounds +=  new /datum/wound/cut/small(4)
			if(((org.damage >= 10 && prob(2)) || (org.damage >= 30 && prob(5)) || org.damage >= 80))
				if(!(pick_zone == BP_GROIN || pick_zone == BP_TORSO || pick_zone == BP_HEAD))
					if(!istype( badbody.loc, /obj/structure/morgue))
						org.droplimb(TRUE, DROPLIMB_ACID)
		badbody.updatehealth()
