/obj/item/outpost_wiki
	name = "Outpost 21 Handbook"
	icon_state ="rulebook"
	item_state = "book15"

	var/dat = ""
	var/static/index_html
	var/static/list/wiki_pages

/obj/item/outpost_wiki/proc/open_wiki(mob/user)
	change_page(user)

/obj/item/outpost_wiki/Initialize(mapload)
	. = ..()
	if(!wiki_pages)
		wiki_pages = list(
			"Setting" = list(
				#include "wiki/setting/primer.dm"
				#include "wiki/setting/recent.dm"
				#include "wiki/setting/solgovlaw.dm"
				#include "wiki/setting/localarea.dm"
				#include "wiki/setting/muriki.dm"
				#include "wiki/setting/outpost21.dm"
				#include "wiki/setting/outpost22.dm"
				#include "wiki/setting/outpost18.dm"
				#include "wiki/setting/nifpro.dm"
			),
			"Gameplay" = list(
				#include "wiki/gameplay/basics.dm"
				#include "wiki/gameplay/resleeving.dm"
				#include "wiki/gameplay/positronic.dm"
				#include "wiki/gameplay/rank.dm"
			),
			"Species" = list(
				#include "wiki/species/akula.dm"
				#include "wiki/species/alrune.dm"
				#include "wiki/species/altevian.dm"
				#include "wiki/species/diona.dm"
				#include "wiki/species/humans.dm"
				#include "wiki/species/nevrean.dm"
				#include "wiki/species/promethean.dm"
				#include "wiki/species/rapala.dm"
				#include "wiki/species/sergal.dm"
				#include "wiki/species/shadekin.dm"
				#include "wiki/species/skrell.dm"
				#include "wiki/species/tajara.dm"
				#include "wiki/species/teshari.dm"
				#include "wiki/species/unathi.dm"
				#include "wiki/species/vox.dm"
				#include "wiki/species/vulpkanin.dm"
				#include "wiki/species/xenochimera.dm"
				#include "wiki/species/zaddat.dm"
				#include "wiki/species/zorren.dm"
				#include "wiki/species/custom.dm"
			),
			"Factions" = list(
				#include "wiki/factions/blackhole.dm"
				#include "wiki/factions/clowns.dm"
				#include "wiki/factions/eshui.dm"
				#include "wiki/factions/nt.dm"
				#include "wiki/factions/solgov.dm"
				#include "wiki/factions/syndicate.dm"
				#include "wiki/factions/vesper.dm"
				#include "wiki/factions/wizard.dm"
			),
		)
	if(!index_html)
		index_html = {"<html>
		<head>
			<title>[name]: Index</title>
			<style>
				[file2text('wiki/wiki.css')]
			</style>
		</head>
		<body>
		<h1>The Outpost 21 Handbook</h1>
		<p>This guide is written in an OOC perspective, and is used to build a foundation of knowledge for new players about the setting, playable species, lore and gameplay.</p>
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
			unpacked_data = page_list[page_title]
		dat = {"<html>
			<head>
				<title>
					[name]: [section] - [page_title]
				</title>
				<style>
					[file2text('wiki/wiki.css')]
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
