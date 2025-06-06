/mob/living/simple_mob/animal/borer/verb/release_host()
	set category = "Abilities.Borer"
	set name = "Release Host"
	set desc = "Slither out of your host."

	if(!host)
		to_chat(src, span_warning("You are not inside a host body."))
		return

	if(stat)
		to_chat(src, span_warning("You cannot leave your host in your current state."))

	if(docile)
		to_chat(src, span_blue("You are feeling far too docile to do that."))
		return

	if(!host || !src) return

	to_chat(src, span_warning("You begin disconnecting from [host]'s synapses and prodding at their internal ear canal."))

	if(!host.stat)
		to_chat(host, span_warning("An odd, uncomfortable pressure begins to build inside your skull, behind your ear..."))

	spawn(100)

		if(!host || !src) return

		if(src.stat)
			to_chat(src, span_warning("You cannot release your host in your current state."))
			return

		to_chat(src, span_warning("You wiggle out of [host]'s ear and plop to the ground."))
		if(host.mind)
			if(!host.stat)
				to_chat(host, span_danger("Something slimy wiggles out of your ear and plops to the ground!"))
			to_chat(host, span_danger("As though waking from a dream, you shake off the insidious mind control of the brain worm. Your thoughts are your own again."))

		detatch()
		leave_host()

/mob/living/simple_mob/animal/borer/verb/infest()
	set category = "Abilities.Borer"
	set name = "Infest"
	set desc = "Infest a suitable humanoid host."

	if(host)
		to_chat(src, span_warning("You are already within a host."))
		return

	if(stat)
		to_chat(src, span_warning("You cannot infest a target in your current state."))
		return

	var/list/choices = list()
	for(var/mob/living/carbon/C in view(1,src))
		if(src.Adjacent(C))
			choices += C

	if(!choices.len)
		to_chat(src, span_warning("There are no viable hosts within range..."))
		return

	// Outpost 21 edit begin - borer fixes
	var/mob/living/carbon/M = choices[1]
	if(choices.len > 1)
		M = tgui_input_list(src, "Who do you wish to infest?", "Target Choice", choices)

	if(!M || !src)
		return

	if(!(src.Adjacent(M)))
		to_chat(src, "<span class='warning'>\The [M] has escaped your range...</span>")
		return
	// Outpost 21 edit end

	if(M.has_brain_worms())
		to_chat(src, span_warning("You cannot infest someone who is already infested!"))
		return

	var/entering_timer = 30 // Outpost 21 edit begin - borer fixes
	var/protected = FALSE  // Outpost 21 edit begin - borer fixes
	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		var/obj/item/organ/external/E = H.organs_by_name[BP_HEAD]
		if(!E || E.is_stump())
			to_chat(src, span_warning("\The [H] does not have a head!"))

		if(!H.should_have_organ(O_BRAIN))
			to_chat(src, span_warning("\The [H] does not seem to have an ear canal to breach."))
			return

		if(H.check_head_coverage())
			to_chat(src, span_warning("You begin to eat through \the [H]'s protection or find another way inside.")) // Outpost 21 edit begin - borer fixes
			entering_timer = 55 // Outpost 21 edit begin - borer fixes
			protected = TRUE  // Outpost 21 edit begin - borer fixes
			// return

	if(!protected) // Outpost 21 edit begin - borer fixes
		to_chat(M, "Something slimy begins probing at the opening of your ear canal...")
	else
		to_chat(M, "Something slimy begins trying to find a way past your protective gear...") // Outpost 21 edit begin - borer fixes
	to_chat(src, span_warning("You slither up [M] and begin probing at their ear canal..."))

	if(!do_after(src,entering_timer)) // Outpost 21 edit begin - borer fixes
		to_chat(src, span_warning("As [M] moves away, you are dislodged and fall to the ground."))
		return

	if(!M || !src) return

	if(src.stat)
		to_chat(src, span_warning("You cannot infest a target in your current state."))
		return

	if(M in view(1, src))
		to_chat(src, span_warning("You wiggle into [M]'s ear."))
		if(!M.stat)
			to_chat(M, "Something disgusting and slimy wiggles into your ear!")

		src.host = M
		src.forceMove(M)

		//Update their traitor status.
		if(host.mind)
			borers.add_antagonist_mind(host.mind, 1, borers.faction_role_text, borers.faction_welcome)
			// Outpost 21 edit begin - Make it clear to the player not to scream on radio instantly
			tgui_alert(host, "You have been infested by a cortical borer, and are now held hostage by a brain worm. Please listen to what they have to say; they're in your head. Shouting over radio that you've been infected is probably a bad idea...", "Borer Infestation", list("Ok"))
			// Outpost 21 edit end

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/obj/item/organ/I = H.internal_organs_by_name[O_BRAIN]
			if(!I) // No brain organ, so the borer moves in and replaces it permanently.
				replace_brain()
			else
				// If they're in normally, implant removal can get them out.
				var/obj/item/organ/external/head = H.get_organ(BP_HEAD)
				head.implants += src

		return
	else
		to_chat(src, span_warning("They are no longer in range!"))
		return

/*
/mob/living/simple_mob/animal/borer/verb/devour_brain()
	set category = "Abilities.Borer"
	set name = "Devour Brain"
	set desc = "Take permanent control of a dead host."

	if(!host)
		to_chat(src, span_warning("You are not inside a host body."))
		return

	if(host.stat != 2)
		to_chat(src, span_warning("Your host is still alive."))
		return

	if(stat)
		to_chat(src, span_warning("You cannot do that in your current state."))

	if(docile)
		to_chat(src, span_warning(span_blue("You are feeling far too docile to do that.")))
		return


	to_chat(src, span_danger("It only takes a few moments to render the dead host brain down into a nutrient-rich slurry..."))
	replace_brain()
*/

// BRAIN WORM ZOMBIES AAAAH.
/mob/living/simple_mob/animal/borer/proc/replace_brain()

	var/mob/living/carbon/human/H = host

	if(!istype(host))
		to_chat(src, span_warning("This host does not have a suitable brain."))
		return

	to_chat(src, span_danger("You settle into the empty brainpan and begin to expand, fusing inextricably with the dead flesh of [H]."))

	H.add_language("Cortical Link")

	if(host.stat == 2)
		add_verb(H, /mob/living/carbon/human/proc/jumpstart)

	add_verb(H, /mob/living/carbon/human/proc/psychic_whisper)
	add_verb(H, /mob/living/carbon/human/proc/tackle)
	if(antag)
		add_verb(H, /mob/living/carbon/proc/spawn_larvae)

	if(H.client)
		H.ghostize(0)

	if(src.mind)
		src.mind.special_role = "Borer Husk"
		src.mind.transfer_to(host)

	H.ChangeToHusk()

	var/obj/item/organ/internal/borer/B = new(H)
	H.internal_organs_by_name[O_BRAIN] = B
	H.internal_organs |= B

	var/obj/item/organ/external/affecting = H.get_organ(BP_HEAD)
	affecting.implants -= src

	var/s2h_id = src.computer_id
	var/s2h_ip= src.lastKnownIP
	src.computer_id = null
	src.lastKnownIP = null

	if(!H.computer_id)
		H.computer_id = s2h_id

	if(!H.lastKnownIP)
		H.lastKnownIP = s2h_ip

/mob/living/simple_mob/animal/borer/verb/secrete_chemicals()
	set category = "Abilities.Borer"
	set name = "Secrete Chemicals"
	set desc = "Push some chemicals into your host's bloodstream."

	if(!host)
		to_chat(src, span_warning("You are not inside a host body."))
		return

	if(stat)
		to_chat(src,  span_warning("You cannot secrete chemicals in your current state."))

	if(docile)
		to_chat(src,  span_warning(span_blue("You are feeling far too docile to do that.")))
		return

	// Outpost 21 edit begin - borer fixes
	var/chems_used = 50
	if(chemicals < chems_used)
		to_chat(src,  span_warning("You don't have enough chemicals!"))
		return

	var/injectsize = 10
	var/chem = tgui_input_list(src	,"Select a chemical to secrete."
									,"Chemicals", list(
									"Repair Brain Tissue (alkysine)",
									"Repair Body (bicaridine)",
									"Make Drunk (ethanol)",
									"Cure Drunk (ethylredoxrazine)",
									"Enhance Speed (hyperzine)",
									"Pain Killer (tramadol)",
									"Euphoric High (bliss)",
									"Stablize Mind (citalopram)",
									"Cure Infection (spaceacillin)",
									"Revive Dead Host"
								))
	switch(chem) // scan for simplified name
		if("Repair Brain Tissue (alkysine)")
			chem = REAGENT_ID_ALKYSINE
		if("Repair Body (bicaridine)")
			chem = REAGENT_ID_BICARIDINE
		if("Make Drunk (ethanol)")
			chem = REAGENT_ID_ETHANOL
			injectsize = 5
		if("Cure Drunk (ethylredoxrazine)")
			chem = REAGENT_ID_ETHYLREDOXRAZINE
		if("Enhance Speed (hyperzine)")
			chem = REAGENT_ID_HYPERZINE
		if("Pain Killer (tramadol)")
			chem = REAGENT_ID_TRAMADOL
		if("Euphoric High (bliss)")
			chem = REAGENT_ID_BLISS
			injectsize = 5
		if("Stablize Mind (citalopram)")
			chem = REAGENT_ID_CITALOPRAM
		if("Cure Infection (spaceacillin)")
			chem = REAGENT_ID_SPACEACILLIN
		if("Revive Dead Host")
			if(chemicals < chems_used || !host || controlling || !src || stat) //Sanity check.
				return
			if(host.stat != DEAD)
				to_chat(src, span_bolddanger("Your host must be dead!"))
				return
			to_chat(src, span_bolddanger("You squirt an intense mix of chemicals from your reservoirs into [host]'s bloodstream."))
			// This is meant to be a bit silly, cause borers don't have much options otherwise
			host.setHalLoss(0)
			host.setOxyLoss(0)
			host.adjustBruteLoss(-20)
			host.adjustFireLoss(-20)
			host.adjust_nutrition(-200)
			host.jumpstart() // defib time
			host.reagents.add_reagent(REAGENT_BICARIDINE, 5)
			host.reagents.add_reagent(REAGENT_KELOTANE, 5)
			host.reagents.add_reagent(REAGENT_ID_TRAMADOL, 5)
			host.reagents.add_reagent(REAGENT_ID_ALKYSINE, 5)
			chemicals -= chems_used
		else
			if(chem)
				// why did this happen?
				to_chat(src, "<font color='red'><B>The option [chem] did not link to any valid option, inform a dev that the switch in borer_powers.dm/secrete_chemicals() is broken</B></font>")
				chem = null
	// Outpost 21 edit end

	if(!chem || chemicals < chems_used || !host || controlling || !src || stat) //Sanity check.
		return

	to_chat(src, span_bolddanger("You squirt a measure of [chem] from your reservoirs into [host]'s bloodstream."))
	host.reagents.add_reagent(chem, injectsize) // Outpost 21 edit - borer fixes
	chemicals -= chems_used

/mob/living/simple_mob/animal/borer/verb/dominate_victim()
	set category = "Abilities.Borer"
	set name = "Paralyze Victim"
	set desc = "Freeze the limbs of a potential host with supernatural fear."

	if(world.time - used_dominate < 150)
		to_chat(src, span_warning("You cannot use that ability again so soon."))
		return

	if(host)
		to_chat(src, span_warning("You cannot do that from within a host body."))
		return

	if(src.stat)
		to_chat(src, span_warning("You cannot do that in your current state."))
		return

	var/attack_range = 5 // Outpost 21 edit - borer fixes, attack range
	var/list/choices = list()
	for(var/mob/living/carbon/C in view(attack_range,src)) // Outpost 21 edit - borer fixes, attack range
		if(C.stat != 2)
			choices += C

	if(world.time - used_dominate < 150)
		to_chat(src, span_warning("You cannot use that ability again so soon."))
		return

	// Outpost 21 edit begin - borer fixes, no targets
	if(!choices.len)
		to_chat(src, "<span class='notice'>There are no viable targets within range...</span>")
		return

	var/mob/living/carbon/M = choices[1]
	if(choices.len > 1)
		tgui_input_list(src, "Who do you wish to dominate?", "Target Choice", choices)
	// Outpost 21 edit end

	if(!M || !src) return

	// Outpost 21 edit begin - borer fixes, target lost
	if(!(M in view(attack_range,src)))
		to_chat(src, "<span class='warning'>\The [M] escaped your influence...</span>")
		return
	// Outpost 21 edit end

	if(M.has_brain_worms())
		to_chat(src, span_warning("You cannot infest someone who is already infested!"))
		return

	to_chat(src, span_red("You focus your psychic lance on [M] and freeze their limbs with a wave of terrible dread."))
	to_chat(M, span_red("You feel a creeping, horrible sense of dread come over you, freezing your limbs and setting your heart racing."))
	// Outpost 21 edit begin - borer fixes, host needs to sleep to avoid radio screaming that ruins the borer interactions
	M.Sleeping(30)
	// Outpost 21 edit end

	used_dominate = world.time

/mob/living/simple_mob/animal/borer/verb/bond_brain()
	set category = "Abilities.Borer"
	set name = "Assume Control"
	set desc = "Fully connect to the brain of your host."

	if(!host)
		to_chat(src, span_warning("You are not inside a host body."))
		return

	if(src.stat)
		to_chat(src, span_warning("You cannot do that in your current state."))
		return

	if(docile)
		to_chat(src, span_blue("You are feeling far too docile to do that."))
		return

	to_chat(src, span_warning("You begin delicately adjusting your connection to the host brain..."))

	spawn(100+(host.brainloss*5))

		if(!host || !src || controlling)
			return
		else

			to_chat(src, span_bolddanger("You plunge your probosci deep into the cortex of the host brain, interfacing directly with their nervous system."))
			to_chat(host, span_bolddanger("You feel a strange shifting sensation behind your eyes as an alien consciousness displaces yours."))
			host.add_language("Cortical Link")

			// host -> brain
			var/h2b_id = host.computer_id
			var/h2b_ip= host.lastKnownIP
			host.computer_id = null
			host.lastKnownIP = null

			qdel(host_brain)
			host_brain = new(src)

			host_brain.ckey = host.ckey

			host_brain.name = host.name

			if(!host_brain.computer_id)
				host_brain.computer_id = h2b_id

			if(!host_brain.lastKnownIP)
				host_brain.lastKnownIP = h2b_ip

			// self -> host
			var/s2h_id = src.computer_id
			var/s2h_ip= src.lastKnownIP
			src.computer_id = null
			src.lastKnownIP = null

			host.ckey = src.ckey

			if(!host.computer_id)
				host.computer_id = s2h_id

			if(!host.lastKnownIP)
				host.lastKnownIP = s2h_ip

			controlling = 1

			add_verb(host, /mob/living/carbon/proc/release_control)
			add_verb(host, /mob/living/carbon/proc/punish_host)
			if(antag)
				add_verb(host, /mob/living/carbon/proc/spawn_larvae)

			return

/mob/living/carbon/human/proc/jumpstart()
	set category = "Abilities.Borer"
	set name = "Revive Host"
	set desc = "Send a jolt of electricity through your host, reviving them."

	if(stat != 2)
		to_chat(src, "Your host is already alive.")
		return

	// Outpost 21 edit begin - borer fixes
	if(HUSK in mutations)
		to_chat(src, "Your host is too destroyed to revive.")
		return
	// Outpost 21 edit end

	remove_verb(src, /mob/living/carbon/human/proc/jumpstart)
	visible_message(span_warning("With a hideous, rattling moan, [src] shudders back to life!"))

	rejuvenate()
	restore_blood()
	fixblood()
	update_canmove()
