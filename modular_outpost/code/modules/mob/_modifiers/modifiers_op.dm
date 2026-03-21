/datum/modifier/shield_projection/melee_focus //Reworking the melee PSG because holy SHIT it's busted
	damage_cost = 25 //Was 5, the DEFAULT is 50

	//.50% resistance at a full charge, 35% resistance at when we're about to empty.
	max_brute_resistance = 0.5
	min_brute_resistance = 0.65
	effective_brute_resistance = 1

	//.50% resistance at a full charge, 35% resistance at when we're about to empty.
	max_fire_resistance = 0.5
	min_fire_resistance = 0.65
	effective_fire_resistance = 1

	//500% damage taken from halloss. Anti PVP. This is meant to be a PvE weapon.
	//This also means that mobs that deal halloss will wreck users of this...Those are (extremely) rare as far as I know.
	min_hal_resistance = 5
	max_hal_resistance = 5
	effective_hal_resistance = 1

	disable_duration_percent = 0.5 //Was 0.5. This reduces stun duration, 0.5 is half.
	evasion = 0 //Was: 35. In pvp, this just makes it silly.
	slowdown = 0 //Was: -0.5 The speed increase is just nuts
	attack_speed_percent = 0.8 	//Was: 0.8 Controls how fast you can punch.
	outgoing_melee_damage_percent = 1.25 //Was 1.25. Controls outbound melee damage
	bleeding_rate_percent = 0.75 //You bleed SLIGHTLY slower, since you are taking more hits.
