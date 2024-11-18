/decl/emote/visible/floorspin/tantrum
	key = "tantrum"
	emote_message_1p = "You flail around on the floor screaming!"
	emote_message_3p = "flails around on the floor screaming!"
	emote_sound = 'modular_outpost/sound/voice/ragescree.ogg'
	emote_delay = 4.5 SECONDS
	var/static/list/spin_dirs_tantrum = list(
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		EAST,
		WEST,
		EAST,
		SOUTH,
		NORTH,
		SOUTH
	)

/decl/emote/visible/floorspin/tantrum/do_extra(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.Stun(5)
		if(H.jitteriness < 80)
			H.make_jittery(95)

/decl/emote/visible/floorspin/tantrum/spin_dir(var/mob/user)
	set waitfor = FALSE
	for(var/i in spin_dirs_tantrum)
		user.set_dir(i)
		sleep(1)
		if(QDELETED(user))
			return

/decl/emote/visible/floorspin/tantrum/spin_anim(var/mob/user)
	set waitfor = FALSE
	sleep(1)
	if(!QDELETED(user))
		user.SpinAnimation(10,7) // two loops

/decl/emote/visible/sdance
	key = "sdance"
	check_restraints = TRUE
	emote_message_3p = "gracefully spins!"
	emote_delay = 2 SECONDS

/decl/emote/visible/sdance/do_extra(mob/user)
	if(istype(user))
		user.spin(20, 1)
