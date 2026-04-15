/obj/item/outpost_wiki
	name = "Outpost 21 Handbook"
	icon_state ="rulebook"
	item_state = "book15"

	var/dat = ""
	var/static/index_html
	var/static/list/wiki_pages = list(
		"Setting" = list(
			"Primer" = 'modular_outpost/code/books/wiki/setting/primer.html',
			"Recent History" = 'modular_outpost/code/books/wiki/setting/recent.html',
			"Solgov Law" = 'modular_outpost/code/books/wiki/setting/solgovlaw.html',
			"Local Area" = 'modular_outpost/code/books/wiki/setting/localarea.html',
			"Muriki" = 'modular_outpost/code/books/wiki/setting/muriki.html',
			"Outpost 21" = 'modular_outpost/code/books/wiki/setting/outpost21.html',
			"Outpost 22" = 'modular_outpost/code/books/wiki/setting/outpost22.html',
			"Outpost 18" = 'modular_outpost/code/books/wiki/setting/outpost18.html',
		),
		"Gameplay" = list(
			"Basics" = 'modular_outpost/code/books/wiki/gameplay/basics.html',
			"Resleeving" = 'modular_outpost/code/books/wiki/gameplay/resleeving.html',
			"Positronics" = 'modular_outpost/code/books/wiki/gameplay/positronic.html',
			"Rank" = 'modular_outpost/code/books/wiki/gameplay/rank.html',
		),
		"Species" = list(
			"Akula" = 'modular_outpost/code/books/wiki/species/akula.html',
			"Alrune" = 'modular_outpost/code/books/wiki/species/alrune.html',
			"Altevians" = 'modular_outpost/code/books/wiki/species/altevian.html',
			"Diona" = 'modular_outpost/code/books/wiki/species/diona.html',
			"Humans" = 'modular_outpost/code/books/wiki/species/humans.html',
			"Nevreans" = 'modular_outpost/code/books/wiki/species/nevrean.html',
			"Promethean" = 'modular_outpost/code/books/wiki/species/promethean.html',
			"Rapala" = 'modular_outpost/code/books/wiki/species/rapala.html',
			"Sergals" = 'modular_outpost/code/books/wiki/species/sergal.html',
			"Shadekin" = 'modular_outpost/code/books/wiki/species/shadekin.html',
			"Skrell" = 'modular_outpost/code/books/wiki/species/skrell.html',
			"Tajara" = 'modular_outpost/code/books/wiki/species/tajara.html',
			"Teshari" = 'modular_outpost/code/books/wiki/species/teshari.html',
			"Unathi" = 'modular_outpost/code/books/wiki/species/unathi.html',
			"Vox" = 'modular_outpost/code/books/wiki/species/vox.html',
			"Vulpkanin" = 'modular_outpost/code/books/wiki/species/vulpkanin.html',
			"Xenochimera" = 'modular_outpost/code/books/wiki/species/xenochimera.html',
			"Zaddat" = 'modular_outpost/code/books/wiki/species/zaddat.html',
			"Zorren" = 'modular_outpost/code/books/wiki/species/zorren.html',
		),
		"Factions" = list(
			"Eshui" = 'modular_outpost/code/books/wiki/factions/eshui.html',
			"Solgov" = 'modular_outpost/code/books/wiki/factions/solgov.html',
			"NT" = 'modular_outpost/code/books/wiki/factions/nt.html',
			"Syndicate" = 'modular_outpost/code/books/wiki/factions/syndicate.html',
			"Vesper" = 'modular_outpost/code/books/wiki/factions/vesper.html',
			"Blackhole" = 'modular_outpost/code/books/wiki/factions/blackhole.html',
		),
	)

/obj/item/outpost_wiki/proc/open_wiki(mob/user)
	change_page(user)

/obj/item/outpost_wiki/Initialize(mapload)
	. = ..()
	if(!index_html)
		index_html = {"<html>
		<head>
			<title>[name]: Index</title>
			<style>
				[file2text('modular_outpost/code/books/wiki/wiki.css')]
			</style>
		</head>
		<body>
		<p>The Outpost 21 guidebook to the setting, species, lore and gameplay. This guide is written in an OOC perspective, and is used to build a foundation of knowledge for new players.</p>
		"}
		// List of pages
		for(var/title_text in wiki_pages)
			index_html += "<div class='_dimmer'><h1>[title_text]</h1><ul>"
			var/list/page_list = wiki_pages[title_text]
			for(var/page_text in page_list)
				index_html += "<li><a href='byond://?src=[REF(src)];section=[title_text];page=[page_text]'>[page_text]</a></li>"
			index_html += "</ul></div><br>"
		// End
		index_html += {"
			</body>
		</html>"}

/obj/item/outpost_wiki/Topic(href, href_list, datum/tgui_state/state)
	if(href_list["close"])
		return
	change_page(usr, href_list["section"], href_list["page"])

/obj/item/outpost_wiki/proc/change_page(mob/user, section = null, page_title = null)
	var/unpacked_data = ""
	if(section in wiki_pages)
		var/list/page_list = wiki_pages[section]
		if(page_title in page_list)
			unpacked_data = file2text(page_list[page_title])
		dat = {"<html>
			<head>
				<title>
					[name]: [section] - [page_title]
				</title>
				<style>
					[file2text('modular_outpost/code/books/wiki/wiki.css')]
				</style>
			</head>
			<body>
				<a href='byond://?src=[REF(src)];section=index;page=index'>Back</a><br>
				[unpacked_data]
			</body>
		</html>"}
		display_content(user)
		return
	// Index if fails
	dat = index_html
	display_content(user)

/obj/item/outpost_wiki/proc/display_content(mob/living/user)
	user << browse( dat, "window=outpostwikibook")
