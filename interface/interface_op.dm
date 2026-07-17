GLOBAL_DATUM(outpost_universe_wiki, /obj/item/outpost_wiki)

//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "wiki"
	set desc = "Open the Outpost 21 guidebook."
	set category = "OOC.Resources"

	if (SSticker.current_state < GAME_STATE_PREGAME)
		to_chat(usr, span_danger("The world is not yet ready to reveal its secrets... Wait until the game has finished setting up."))
		return
	if(!GLOB.outpost_universe_wiki)
		GLOB.outpost_universe_wiki = new /obj/item/outpost_wiki()
	GLOB.outpost_universe_wiki.open_wiki(usr)
