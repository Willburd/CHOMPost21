

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
									// Outpost 21 edit begin - Bubber talk sound port. See bubbers_attribution.dm
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
									GLOB.talk_sound,
									GLOB.goon_speak_one_sound,
									GLOB.goon_speak_two_sound,
									GLOB.goon_speak_three_sound,
									GLOB.goon_speak_four_sound,
									GLOB.goon_speak_blub_sound,
									GLOB.goon_speak_bottalk_sound,
									GLOB.goon_speak_buwoo_sound,
									GLOB.goon_speak_cow_sound,
									GLOB.goon_speak_lizard_sound,
									GLOB.goon_speak_pug_sound,
									GLOB.goon_speak_pugg_sound,
									GLOB.goon_speak_roach_sound,
									GLOB.goon_speak_skelly_sound,
									GLOB.xeno_speak_sound, // CHOMPEnable
									// Outpost 21 edit begin - Bubber talk sound port, See bubbers_attribution.dm
									GLOB.bubber_speak_mutedc2,
									GLOB.bubber_speak_mutedc3,
									GLOB.bubber_speak_mutedc4,
									GLOB.bubber_speak_banjoc3,
									GLOB.bubber_speak_banjoc4,
									GLOB.bubber_speak_squeaky,
									GLOB.bubber_speak_chitter,
									GLOB.bubber_speak_synthetic_grunt,
									GLOB.bubber_speak_synthetic,
									GLOB.bubber_speak_bullet,
									GLOB.bubber_speak_coggers,
									GLOB.bubber_speak_moff_short,
									GLOB.bubber_speak_meow,
									GLOB.bubber_speak_chirp,
									GLOB.bubber_speak_caw,
									GLOB.bubber_speak_alphys,
									GLOB.bubber_speak_asgore,
									GLOB.bubber_speak_flowey,
									GLOB.bubber_speak_flowey_evil,
									GLOB.bubber_speak_papyrus,
									GLOB.bubber_speak_ralsei,
									GLOB.bubber_speak_sans,
									GLOB.bubber_speak_toriel,
									GLOB.bubber_speak_undyne,
									GLOB.bubber_speak_temmie,
									GLOB.bubber_speak_susie,
									GLOB.bubber_speak_gaster,
									GLOB.bubber_speak_mettaton,
									GLOB.bubber_speak_gen_monster,
									GLOB.bubber_speak_gen_monster_alt2,
									GLOB.bubber_speak_wilson,
									GLOB.bubber_speak_wolfgang,
									GLOB.bubber_speak_woodie,
									GLOB.bubber_speak_wurt,
									GLOB.bubber_speak_wx78,
									GLOB.bubber_speak_chitter_alt,
									GLOB.bubber_speak_whistle,
									GLOB.bubber_speak_whistle_alt,
									GLOB.bubber_speak_caw_alt,
									GLOB.bubber_speak_caw_alt2,
									GLOB.bubber_speak_caw_alt3,
									GLOB.bubber_speak_ehh,
									GLOB.bubber_speak_ehh_alt,
									GLOB.bubber_speak_ehh_alt2,
									GLOB.bubber_speak_ehh_alt3,
									GLOB.bubber_speak_ehh_alt4,
									GLOB.bubber_speak_faucet,
									GLOB.bubber_speak_faucet_alt,
									GLOB.bubber_speak_ribbit,
									GLOB.bubber_speak_hoot,
									GLOB.bubber_speak_tweet,
									GLOB.bubber_speak_dwoop,
									GLOB.bubber_speak_uhm,
									GLOB.bubber_speak_wurtesh,
									GLOB.bubber_speak_chitter2
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
