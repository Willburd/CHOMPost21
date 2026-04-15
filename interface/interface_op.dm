GLOBAL_DATUM_INIT(outpost_universe_wiki, /obj/item/outpost_wiki, new())

//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "wiki"
	set desc = "Open the Outpost 21 guidebook."
	set category = "OOC.Resources"

	if(!SSatoms?.initialized || !GLOB.outpost_universe_wiki)
		to_chat(usr, span_danger("The world is not yet ready to reveal its secrets... Wait about 5 more minutes?"))
		return
	GLOB.outpost_universe_wiki.open_wiki(usr)
