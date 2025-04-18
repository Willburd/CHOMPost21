

var/list/talk_sound_map = rlist(
								list(
									"beep-boop",
									"goon speak 1",
									"goon speak 2",
									"goon speak 3",
									"goon speak 4",
									"goon speak blub",
									"goon speak bottalk",
									"goon speak buwoo",
									"goon speak cow",
									"goon speak lizard",
									"goon speak pug",
									"goon speak pugg",
									"goon speak roach",
									"goon speak skelly",
									"xeno speak", // CHOMPEnable
									// Outpost 21 edit begin - Bubber talk sound port. See modular_zubbers\bubbers_attribution.dm
									"Muted String (Low)",
									"Muted String (Medium)",
									"Muted String (High)",
									"Banjo (Medium)",
									"Banjo (High)",
									"Squeaky",
									"Chittery",
									"Synthetic (Grunt)",
									"Synthetic (Normal)",
									"Windy",
									"Brassy",
									"Moff squeak",
									"Meow",
									"Chirp",
									"Caw",
									"Alphys",
									"Asgore",
									"Flowey (normal)",
									"Flowey (evil)",
									"Papyrus",
									"Ralsei",
									"Sans",
									"Toriel",
									"Undyne",
									"Temmie",
									"Susie",
									"Gaster",
									"Mettaton",
									"Generic Monster 1",
									"Generic Monster 2",
									"Wilson",
									"Wolfgang",
									"Woodie",
									"Wurt",
									"wx78",
									"Chittery Alt",
									"Whistle 1",
									"Whistle 2",
									"Caw 2",
									"Caw 3",
									"Caw 4",
									"Ehh 1",
									"Ehh 2",
									"Ehh 3",
									"Ehh 4",
									"Ehh 5",
									"Faucet 1",
									"Faucet 2",
									"Ribbit",
									"Hoot",
									"Tweet",
									"Dwoop",
									"Uhm",
									"Wurtesh",
									"Chitter2"
									// Outpost 21 edit end
								),
								list(
									talk_sound,
									goon_speak_one_sound,
									goon_speak_two_sound,
									goon_speak_three_sound,
									goon_speak_four_sound,
									goon_speak_blub_sound,
									goon_speak_bottalk_sound,
									goon_speak_buwoo_sound,
									goon_speak_cow_sound,
									goon_speak_lizard_sound,
									goon_speak_pug_sound,
									goon_speak_pugg_sound,
									goon_speak_roach_sound,
									goon_speak_skelly_sound,
									xeno_speak_sound, // CHOMPEnable
									// Outpost 21 edit begin - Bubber talk sound port, See modular_zubbers\bubbers_attribution.dm
									bubber_speak_mutedc2,
									bubber_speak_mutedc3,
									bubber_speak_mutedc4,
									bubber_speak_banjoc3,
									bubber_speak_banjoc4,
									bubber_speak_squeaky,
									bubber_speak_chitter,
									bubber_speak_synthetic_grunt,
									bubber_speak_synthetic,
									bubber_speak_bullet,
									bubber_speak_coggers,
									bubber_speak_moff_short,
									bubber_speak_meow,
									bubber_speak_chirp,
									bubber_speak_caw,
									bubber_speak_alphys,
									bubber_speak_asgore,
									bubber_speak_flowey,
									bubber_speak_flowey_evil,
									bubber_speak_papyrus,
									bubber_speak_ralsei,
									bubber_speak_sans,
									bubber_speak_toriel,
									bubber_speak_undyne,
									bubber_speak_temmie,
									bubber_speak_susie,
									bubber_speak_gaster,
									bubber_speak_mettaton,
									bubber_speak_gen_monster,
									bubber_speak_gen_monster_alt2,
									bubber_speak_wilson,
									bubber_speak_wolfgang,
									bubber_speak_woodie,
									bubber_speak_wurt,
									bubber_speak_wx78,
									bubber_speak_chitter_alt,
									bubber_speak_whistle,
									bubber_speak_whistle_alt,
									bubber_speak_caw_alt,
									bubber_speak_caw_alt2,
									bubber_speak_caw_alt3,
									bubber_speak_ehh,
									bubber_speak_ehh_alt,
									bubber_speak_ehh_alt2,
									bubber_speak_ehh_alt3,
									bubber_speak_ehh_alt4,
									bubber_speak_faucet,
									bubber_speak_faucet_alt,
									bubber_speak_ribbit,
									bubber_speak_hoot,
									bubber_speak_tweet,
									bubber_speak_dwoop,
									bubber_speak_uhm,
									bubber_speak_wurtesh,
									bubber_speak_chitter2
									// Outpost 21 edit end
									)
								)

/proc/get_talk_sound(var/voice_sound)
	if(!voice_sound)
		return talk_sound_map[1]
	return talk_sound_map[2][voice_sound]

/proc/rlist(var/list/keys,var/list/values) //short for reversible list generator
	var/list/rlist = list(list(),list(),FALSE,0)
	var/i = 0
	for(i = 1, i <= LAZYLEN(keys), i++)
		to_chat(world,keys[i])
		rlist[1] += keys[i]
		rlist[2][keys[i]] = values[i]
	rlist += TRUE
	rlist += i
	return rlist

/proc/arlist(var/list/altlist)
	var/list/rlist = list(list(),list(),FALSE,0)
	var/i = 0
	for(i = 1, i <= LAZYLEN(altlist), i++)
		rlist[(i % 2) +1] += altlist[i]
	rlist += TRUE
	rlist += i/2
	return rlist
