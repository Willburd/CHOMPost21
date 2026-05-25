/datum/antagonist/proc/create_antagonist(datum/mind/target, move, gag_announcement, preserve_appearance)

	if(!target)
		return

	update_antag_mob(target, preserve_appearance)
	if(!target.current)
		remove_antagonist(target)
		return 0
	if(flags & ANTAG_CHOOSE_NAME)
		spawn(1)
			set_antag_name(target.current)
	if(move)
		place_mob(target.current)
	update_leader()
	create_objectives(target)
	update_icons_added(target)
	greet(target)
	announce_antagonist_spawn()

/datum/antagonist/proc/create_default(mob/source)
	// Outpost 21 edit begin - default antagonist behavior uses currently loaded slot instead of human mobs
	if(mob_path && mob_path != /mob/living/carbon/human) // Humans get special handling
		var/mob/living/new_character = new mob_path(get_turf(source))
		new_character.real_name = source.real_name
		new_character.name = new_character.real_name
		if(!isnull(source.mind))
			source.mind.transfer_to(new_character)
		new_character.ckey = source.ckey
		add_antagonist(new_character.mind, 1, 0, 1) // Equip them and move them to spawn.
		return new_character

	if(!source.client)
		var/mob/living/new_character = new /mob/living/carbon/human(get_turf(source))
		new_character.real_name = source.real_name
		new_character.name = new_character.real_name
		if(!isnull(source.mind))
			source.mind.transfer_to(new_character)
		new_character.ckey = source.ckey
		add_antagonist(new_character.mind, 1, 0, 1) // Equip them and move them to spawn.
		return new_character

	var/player_key = source.client.key
	var/picked_ckey = source.client.ckey
	var/picked_slot = source.client.prefs.default_slot
	var/mob/living/carbon/human/new_character = new(get_turf(source))

	if(!isnull(source.mind))
		source.mind.transfer_to(new_character)
	new_character.ckey = picked_ckey

	new_character.client.prefs.copy_to(new_character)
	if(new_character.dna)
		new_character.dna.ResetUIFrom(new_character)
		new_character.sync_dna_traits(TRUE) // Traitgenes Sync traits to genetics if needed
		new_character.sync_organ_dna()
	new_character.sync_addictions()
	new_character.initialize_vessel()
	new_character.key = player_key

	if(new_character.mind)
		new_character.mind.loaded_from_ckey = picked_ckey
		new_character.mind.loaded_from_slot = picked_slot
		if(new_character.mind.antag_holder)
			new_character.mind.antag_holder.apply_antags(new_character)

	for(var/lang in new_character.client.prefs.alternate_languages)
		var/datum/language/chosen_language = GLOB.all_languages[lang]
		if(chosen_language)
			if(is_lang_whitelisted(new_character,chosen_language) || (new_character.species && (chosen_language.name in new_character.species.secondary_langs)))
				new_character.add_language(lang)
	for(var/key in new_character.client.prefs.language_custom_keys)
		if(new_character.client.prefs.language_custom_keys[key])
			var/datum/language/keylang = GLOB.all_languages[new_character.client.prefs.language_custom_keys[key]]
			if(keylang)
				new_character.language_keys[key] = keylang
	if(new_character.client.prefs.preferred_language) // Do we have a preferred language?
		var/datum/language/def_lang = GLOB.all_languages[new_character.client.prefs.preferred_language]
		if(def_lang)
			new_character.default_language = def_lang

	SEND_SIGNAL(new_character, COMSIG_HUMAN_DNA_FINALIZED)
	new_character.regenerate_icons()
	new_character.update_transform()

	add_antagonist(new_character.mind, 1, 0, 1) // Equip them and move them to spawn.
	return new_character
	// Outpost 21 edit end

/datum/antagonist/proc/create_id(assignment, mob/living/carbon/human/player, equip = 1)

	var/obj/item/card/id/W = new id_type(player)
	if(!W) return
	W.access |= default_access
	W.assignment = "[assignment]"
	player.set_id_info(W)
	if(equip) player.equip_to_slot_or_del(W, slot_wear_id)
	return W

/datum/antagonist/proc/create_radio(freq, mob/living/carbon/human/player)
	var/obj/item/radio/R

	switch(freq)
		if(SYND_FREQ)
			R = new/obj/item/radio/headset/syndicate(player)
		if(RAID_FREQ)
			R = new/obj/item/radio/headset/raider(player)
		else
			R = new/obj/item/radio/headset(player)
			R.set_frequency(freq)

	player.equip_to_slot_or_del(R, slot_l_ear)
	return R

/datum/antagonist/proc/create_nuke(atom/paper_spawn_loc, datum/mind/code_owner)

	// Decide on a code.
	var/obj/effect/landmark/nuke_spawn = locate(nuke_spawn_loc ? nuke_spawn_loc : "landmark*Nuclear-Bomb")

	var/code
	if(nuke_spawn)
		var/obj/machinery/nuclearbomb/nuke = new(get_turf(nuke_spawn))
		code = "[rand(10000, 99999)]"
		nuke.r_code = code

	if(code)
		if(!paper_spawn_loc)
			if(leader && leader.current)
				paper_spawn_loc = get_turf(leader.current)
			else
				paper_spawn_loc = get_turf(locate("landmark*Nuclear-Code"))

		if(paper_spawn_loc)
			// Create and pass on the bomb code paper.
			var/obj/item/paper/P = new(paper_spawn_loc)
			P.info = "The nuclear authorization code is: <b>[code]</b>"
			P.name = "nuclear bomb code"
			if(leader && leader.current)
				if(get_turf(P) == get_turf(leader.current))
					leader.current.put_in_hands(P)

		if(!code_owner && leader)
			code_owner = leader
		if(code_owner)
			code_owner.store_memory(span_bold("Nuclear Bomb Code") + ": [code]", 0, 0)
			to_chat(code_owner.current, "The nuclear authorization code is: <B>[code]</B>")
	else
		message_admins(span_danger("Could not spawn nuclear bomb. Contact a developer."))
		return

	spawned_nuke = code
	return code

/datum/antagonist/proc/greet(datum/mind/player)
	// Makes it harder to miss if you're alt-tabbed or not paying attention.
	if(antag_sound)
		SEND_SOUND(player.current, sound(antag_sound))
	window_flash(player.current.client)

	// Basic intro text.
	to_chat(player.current, span_danger(span_large("You are a [role_text]!")))
	if(leader_welcome_text && player == leader)
		to_chat(player.current, span_notice("[leader_welcome_text]"))
	else
		to_chat(player.current, span_notice("[welcome_text]"))
	if (CONFIG_GET(flag/objectives_disabled))
		to_chat(player.current, span_notice("[antag_text]"))

	if((flags & ANTAG_HAS_NUKE) && !spawned_nuke)
		create_nuke()

	if (!CONFIG_GET(flag/objectives_disabled))
		show_objectives(player)
	return 1

/datum/antagonist/proc/set_antag_name(mob/living/player)
	// Choose a name, if any.
	var/newname = tgui_input_text(player, "You are a [role_text]. Would you like to change your name to something else?", "Name change", null, MAX_NAME_LEN)
	if (newname)
		player.real_name = newname
		player.name = player.real_name
		player.dna.real_name = newname
	if(player.mind) player.mind.name = player.name
	// Update any ID cards.
	update_access(player)
