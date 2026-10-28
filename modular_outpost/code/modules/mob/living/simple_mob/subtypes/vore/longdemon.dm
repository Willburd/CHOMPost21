/mob/living/simple_mob/horror/longdemon
	name = "long demon"
	desc = "An abnormally long taur-like weasel beast with a madly twisted toothy smile, sixteen irregularly spaced limbs, and bulging snake like eyes that seem to pierce into your mind as they glow."
	icon_state = "longdemon"
	icon_living = "longdemon"
	icon_rest = "longdemon_rest"
	icon_dead = "longdemon_dead"
	has_eye_glow = TRUE
	maxHealth = 900
	health = 900
	movement_cooldown = 3			// Lower is faster.
	seedarkness = FALSE
	universal_understand = TRUE
	armor = list(melee = 10, bullet = 10, laser = 0, energy = 0, bomb = 40, bio = 100, rad = -20)
	var/used_dominate = 0
	var/psychic_attack_range = 8

/mob/living/simple_mob/horror/longdemon/Initialize(mapload)
	. = ..()
	// psychic critter
	mutations.Add(TK)
	mutations.Add(mRemote)
	mutations.Add(mRemotetalk)
	add_verb(src, list(/mob/living/carbon/human/proc/remoteobserve, /mob/living/carbon/human/proc/remotesay))
	// Can sense things nearby, but doesn't have shadekin wall vision
	motiontracker_subscribe()
	// Spawns in UD, so would be trapped if they cannot dig
	ADD_TRAIT(src, TRAIT_NATURALTUNNELER, ROUNDSTART_TRAIT)

/mob/living/simple_mob/horror/longdemon/verb/knockout_victim()
	set category = "Abilities.Superpower"
	set name = "Knockout Victim"
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
