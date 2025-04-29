/datum/asset/simple/lobby_files
	keep_local_name = TRUE
	assets = list(
		"lobby_loading.gif" = 'html/lobby/loading.gif',
		//"load.ogg" = 'sound/lobby/lobby_load.ogg',
		"load.ogg" = 'sound/lobby/lobby_load_outpost.ogg', // Outpost 21 edit - Use our wind instead of computer noises
	)

/datum/asset/simple/lobby_files/register()
	// not actually a gif
	assets["lobby_bg.gif"] = pick(using_map.lobby_screens)
	. = ..()
