/mob/living/simple_mob/horror/longdemon
	name = "\improper gazer"
	desc = "An abnormally long taur-like weasel beast with a madly twisted toothy smile, sixteen irregularly spaced limbs, and bulging snake like eyes that seem to pierce into your mind as they glow."
	icon = 'modular_outpost/icons/mob/longdemon.dmi'
	icon_state = "longdemon"
	icon_living = "longdemon"
	icon_rest = "longdemon_rest"
	icon_dead = "longdemon_dead"

	maxHealth = 900
	health = 900
	movement_cooldown = 4			// Lower is faster.
	size_multiplier = 1.5

	has_eye_glow = TRUE
	see_in_dark = 10
	universal_understand = TRUE
	supernatural = TRUE
	injury_enrages = TRUE
	hasthermals = FALSE
	has_hands = TRUE
	humanoid_hands = TRUE
	taser_kill = FALSE

	var/psychic_attack_range = 8
	var/used_dominate = FALSE
	var/making_someone_dream = FALSE
	friendly = list("snuggles", "hugs", "cuddles", "squishes") // lets be cute :3
	ai_holder_type = /datum/ai_holder/simple_mob/ranged/careful

	melee_damage_lower = 24
	melee_damage_upper = 32
	armor = list(melee = 10, bullet = 10, laser = 0, energy = 0, bomb = 40, bio = 100, rad = -20)
	poison_resist = 1.0
	shock_resist = -0.2
	threshold = 0.2

	pixel_x = -16
	old_x = -16
	icon_expected_width = 64
	icon_expected_height = 64
	vis_height = 64

/mob/living/simple_mob/horror/longdemon/Initialize(mapload)
	. = ..()
	// psychic critter
	mutations.Add(mRemote)
	mutations.Add(mRemotetalk)
	add_verb(src, list(/mob/living/carbon/human/proc/remoteobserve, /mob/living/carbon/human/proc/remotesay, /mob/living/proc/long_vore))
	// Can sense things nearby, but doesn't have shadekin wall vision
	motiontracker_subscribe()
	// Spawns in UD, so would be trapped if they cannot dig
	ADD_TRAIT(src, TRAIT_NATURALTUNNELER, ROUNDSTART_TRAIT)

/mob/living/simple_mob/horror/longdemon/verb/paralyze_victim()
	set category = "Abilities.Superpower"
	set name = "Paralyze Victim"
	set desc = "Use your psychic influence to put a target into a temporary catatonic state."

	if(world.time - used_dominate < 150)
		to_chat(src, span_warning("You cannot use that ability again so soon."))
		return
	if(stat)
		to_chat(src, span_warning("You cannot do that in your current state."))
		return

	var/list/choices = list()
	for(var/mob/living/carbon/human/attackable in view(psychic_attack_range,src))
		if(attackable.stat == CONSCIOUS)
			choices += attackable
	if(world.time - used_dominate < 150)
		to_chat(src, span_warning("You cannot use that ability again so soon."))
		return

	if(!choices.len)
		to_chat(src, span_notice("There are no viable targets within range..."))
		return
	var/mob/living/carbon/human/attack_target = choices[1]
	if(choices.len > 1)
		tgui_input_list(src, "Who do you wish to dominate?", "Target Choice", choices)

	if(!attack_target || QDELETED(src))
		return
	if(!(attack_target in view(psychic_attack_range,src)))
		to_chat(src, span_warning("\The [attack_target] escaped your influence..."))
		return

	to_chat(src, span_alien("You focus your psychic lance on [attack_target] and freeze their limbs with a wave of terrible dread."))
	to_chat(attack_target, span_vdanger("You feel a creeping, horrible sense of dread come over you, freezing your limbs and setting your heart racing."))
	attack_target.Paralyse(10)
	used_dominate = world.time
	add_attack_logs(src, attack_target, "psychic knockout (longdemon)")

/mob/living/simple_mob/horror/longdemon/verb/induce_nightmare()
	set category = "Abilities.Superpower"
	set name = "Induce Nightmare"
	set desc = "Use your psychic influence to temporarily summon a psychic ghost copy of your victim, to them it will be like a waking nightmare until they wake up back where they were before you summoned them."

	if(stat != CONSCIOUS)
		return

	if(making_someone_dream) // Prevent spam
		to_chat(src, span_warning("You must wait longer before you can do this again..."))
		return
	making_someone_dream = TRUE

	var/turf/current = get_turf(src) // Needs to be on station or same z to perform telepathy
	var/valid_turfs = list()
	for(var/turf/T in orange(4, current))
		if(T.density)
			continue
		if(current.Adjacent(T))
			continue
		valid_turfs += T

	if(!length(valid_turfs))
		to_chat(src, span_warning("There is not enough space around you to do this..."))
		making_someone_dream = FALSE
		return

	var/list/mob/creatures = list()
	for(var/mob/living/carbon/h in GLOB.mob_list)
		if(!h.client)
			continue
		var/turf/temp_turf = get_turf(h)
		if(!istype(temp_turf,/turf))
			continue
		if(!meets_badbody_criteria(h.client))
			continue
		if(!((temp_turf.z in using_map.station_levels) || current.z == temp_turf.z) || h.stat != CONSCIOUS)
			continue
		creatures += h

	if(!length(creatures))
		to_chat(src, span_warning("There is nothing worth your influence..."))
		making_someone_dream = FALSE
		return

	var/mob/target = input ("Who do you want to project your mind to?") as mob in creatures
	if(!target)
		making_someone_dream = FALSE
		return
	if(!((target.z in using_map.station_levels) || current.z == target.z) || target.stat != CONSCIOUS)
		to_chat(src, span_warning("\The [target] has escaped your influence..."))
		making_someone_dream = FALSE
		return

	var/turf/spawn_pos = pick(valid_turfs)
	if(!spawn_pos)
		to_chat(src, span_warning("\The [target] has escaped your influence..."))
		making_someone_dream = FALSE
		return

	// Zoop
	var/datum/component/out_of_body_experience/comp = target.AddComponent(/datum/component/out_of_body_experience/no_bad_body/shadow_realm)
	comp.force_move_badbody(spawn_pos)
	VARSET_IN(src, making_someone_dream, FALSE, 20 SECONDS)
