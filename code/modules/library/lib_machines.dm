/* Library Machines
 *
 * Contains:
 *		Borrowbook datum
 *		Library Public Computer
 *		Library Computer
 *		Library Scanner
 *		Book Binder
 */

#define INVPAGESIZE 5

/*
 * Borrowbook datum
 */
/datum/borrowbook // Datum used to keep track of who has borrowed what when and for how long.
	var/bookname
	var/mobname
	var/getdate
	var/duedate

/*
 * Library Public Computer
 */
/obj/machinery/librarypubliccomp
	name = "visitor computer"
	icon = 'icons/obj/library.dmi'
	icon_state = "computer"
	anchored = TRUE
	density = TRUE
	var/screenstate = 0
	var/title
	var/category = "Any"
	var/author
	/* Outpost 21 edit begin - Books to SSpersistence
	var/SQLquery
	var/list/SQLargs //CHOMPEdit TGSQL
	*/

/obj/machinery/librarypubliccomp/attack_hand(var/mob/user as mob)
	usr.set_machine(src)
	var/dat = "<HEAD><TITLE>Library Visitor</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	switch(screenstate)
		if(0)
			dat += {"<h2>Search Settings</h2><br>
			<A href='?src=\ref[src];settitle=1'>Filter by Title: [title]</A><BR>
			<A href='?src=\ref[src];setcategory=1'>Filter by Category: [category]</A><BR>
			<A href='?src=\ref[src];setauthor=1'>Filter by Author: [author]</A><BR>
			<A href='?src=\ref[src];search=1'>\[Start Search\]</A><BR>"}
		if(1)
			if(!SSpersistence.all_books)
				dat +=	"<font color=red><b>ERROR</b> Something has gone seriously wrong. Contact System Administrator for more information.</font>"
			else if(!SSpersistence.all_books.len)
				dat +=	"<font color=red><b>ERROR</b> The external archive is currently empty.</font>"
			else
				dat += {"<table>
				<tr><td>AUTHOR</td><td>TITLE</td><td>CATEGORY</td><td>SS<sup>13</sup>BN</td></tr>"}
				for(var/token_id in SSpersistence.all_books)
					var/list/token = SSpersistence.all_books[token_id]
					if(token && !token["deleted"])
						dat += "<tr><td>[token["author"]]</td><td>[token["title"]]</td><td>[token["libcategory"]]</td><td></td></tr>"
				dat += "</table>"
			dat += "<A href='?src=\ref[src];back=1'>\[Go Back\]</A><BR>"
			// Outpost 21 edit end
	user << browse(dat, "window=publiclibrary")
	onclose(user, "publiclibrary")

/obj/machinery/librarypubliccomp/Topic(href, href_list)
	if(..())
		usr << browse(null, "window=publiclibrary")
		onclose(usr, "publiclibrary")
		return

	if(href_list["settitle"])
		var/newtitle = tgui_input_text(usr, "Enter a title to search for:")
		if(newtitle)
			title = sanitize(newtitle)
		else
			title = null
		title = sanitizeSQL(title)
	if(href_list["setcategory"])
		var/newcategory = tgui_input_list(usr, "Choose a category to search for:", "Category", list("Any", "Fiction", "Non-Fiction", "Adult", "Reference", "Religion"))
		if(newcategory)
			category = sanitize(newcategory)
		else
			category = "Any"
		category = sanitizeSQL(category)
	if(href_list["setauthor"])
		var/newauthor = tgui_input_text(usr, "Enter an author to search for:")
		if(newauthor)
			author = sanitize(newauthor)
		else
			author = null
		author = sanitizeSQL(author)
	if(href_list["search"])
		/* Outpost 21 edit begin - Books to SSpersistence
		SQLquery = "SELECT author, title, category, id FROM library WHERE "
		SQLargs = list() //CHOMPEdit begin
		if(category == "Any")
			SQLquery += "author LIKE '%:t_author%' AND title LIKE '%:t_title%'"
			SQLargs["t_author"] = author
			SQLargs["t_title"] = title
		else
			SQLquery += "author LIKE CONCAT('%',:t_author,'%') AND title LIKE CONCAT('%',:t_title,'%') AND category=:t_category"
			SQLargs["t_author"] = author
			SQLargs["t_title"] = title
			SQLargs["t_category"] = category //CHOMPEdit End
		*/
		screenstate = 1

	if(href_list["back"])
		screenstate = 0

	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return


/*
 * Library Computer
 */
// TODO: Make this an actual /obj/machinery/computer that can be crafted from circuit boards and such
// It is August 22nd, 2012... This TODO has already been here for months.. I wonder how long it'll last before someone does something about it. // Nov 2019. Nope.
/obj/machinery/librarycomp
	name = "Check-In/Out Computer"
	desc = "Print books from the archives! (You aren't quite sure how they're printed by it, though.)"
	icon = 'icons/obj/library.dmi'
	icon_state = "computer"
	anchored = TRUE
	density = TRUE
	var/screenstate = 0
	var/inventory_page = 0
	var/sortby = "author"
	var/buffer_book
	var/buffer_mob
	var/list/checkouts = list()
	var/list/inventory = list()
	var/checkoutperiod = 5 // In minutes
	var/obj/machinery/libraryscanner/scanner // Book scanner that will be used when uploading books to the Archive

	var/bibledelay = 0 // LOL NO SPAM (1 minute delay) -- Doohl

	var/static/list/all_books

	var/static/list/base_genre_books

/obj/machinery/librarycomp/Initialize()
	. = ..()

	if(!base_genre_books || !base_genre_books.len)
		base_genre_books = list(
			/obj/item/book/custom_library/fiction,
			/obj/item/book/custom_library/nonfiction,
			/obj/item/book/custom_library/reference,
			/obj/item/book/custom_library/religious,
			/obj/item/book/bundle/custom_library/fiction,
			/obj/item/book/bundle/custom_library/nonfiction,
			/obj/item/book/bundle/custom_library/reference,
			/obj/item/book/bundle/custom_library/religious
			)

	if(!all_books || !all_books.len)
		all_books = list()

		for(var/path in subtypesof(/obj/item/book/codex/lore))
			var/obj/item/book/C = new path(null)
			all_books[C.name] = C

		for(var/path in subtypesof(/obj/item/book/custom_library) - base_genre_books)
			var/obj/item/book/B = new path(null)
			all_books[B.title] = B

		for(var/path in subtypesof(/obj/item/book/bundle/custom_library) - base_genre_books)
			var/obj/item/book/M = new path(null)
			all_books[M.title] = M

/obj/machinery/librarycomp/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LibraryPublicComp", name)
		ui.open()

/obj/machinery/librarycomp/tgui_data(mob/user)
	var/data[0]
	data["screenstate"] = screenstate
	data["emagged"] = emagged
	// Book storage
	var/list/inv = list()
	var/list/checks = list()
	var/start_entry = 1 + (inventory_page * INVPAGESIZE) // 6 per page in inventory
	var/entry_count = 0
	var/inv_left = (inventory_page > 0)
	var/inv_right = TRUE
	switch(screenstate)
		if("inventory") // barcode scanned books for checkout
			if(inventory_page + 1 > inventory.len / INVPAGESIZE)
				inv_right = FALSE
			for(var/obj/item/book/B in inventory)
				entry_count++
				if(entry_count < start_entry)
					continue
				if(entry_count >= start_entry + INVPAGESIZE)
					break
				if(B)
					inv += list(tgui_add_book(B))
		if("online") // internal archive (hardcoded books)
			if(inventory_page + 1 > all_books.len / INVPAGESIZE)
				inv_right = FALSE
			for(var/BP in all_books)
				entry_count++
				if(entry_count < start_entry)
					continue
				if(entry_count >= start_entry + INVPAGESIZE)
					break
				var/obj/item/book/B = all_books[BP]
				if(B)
					inv += list(tgui_add_book(B))
		if("archive") // external archive (SSpersistance database)
			if(inventory_page + 1 > SSpersistence.all_books.len / INVPAGESIZE)
				inv_right = FALSE
			for(var/token_id in SSpersistence.all_books)
				entry_count++
				if(entry_count < start_entry)
					continue
				if(entry_count >= start_entry + INVPAGESIZE)
					break
				var/list/token = SSpersistence.all_books[token_id]
				if(token)
					inv += list(tgui_add_token(token))
		if("checkedout") // books checked out of the library
			if(inventory_page + 1 > checkouts.len / INVPAGESIZE)
				inv_right = FALSE
			for(var/datum/borrowbook/BB in checkouts)
				entry_count++
				if(entry_count < start_entry)
					continue
				if(entry_count >= start_entry + INVPAGESIZE)
					break
				// for returns
				var/list/book = list()
				book["bookname"] = BB.bookname
				book["mobname"] = BB.mobname
				var/timetaken = world.time - BB.getdate
				timetaken /= 600
				timetaken = round(timetaken)
				var/timedue = BB.duedate - world.time
				timedue /= 600
				book["timetaken"] = round(timetaken)
				book["timedue"] = round(timedue)
				book["overdue"] = round(timedue) <= 0
				book["ref"] = REF(BB)
				checks += list(book)
	data["inventory"] = inv
	data["checks"] = checks
	data["inv_left"] = inv_left
	data["inv_right"] = inv_right
	// Book scanner
	data["scanned"] = null
	data["scanner_error"] = ""
	if(!scanner)
		for(var/obj/machinery/libraryscanner/S in range(9))
			scanner = S
			break
	if(!scanner)
		data["scanner_error"] = "No scanner found within wireless network range."
	else if(!scanner.cache)
		data["scanner_error"] = "No data found in scanner memory."
	else
		data["scanned"] = tgui_add_book(scanner.cache)
	// Checkout entrys
	data["checkoutperiod"] = checkoutperiod
	data["world_time"] = world.time
	data["buffer_book"] = buffer_book
	data["buffer_mob"] = buffer_mob
	return data

/obj/machinery/librarycomp/proc/tgui_add_book(var/obj/item/book/B)
	var/list/book = list()
	book["id"] = B.type
	book["title"] = B.name
	if(B.author)
		book["author"] = B.author
	else
		book["author"] = "Anonymous"
	book["category"] = B.libcategory
	book["deleted"] = FALSE
	book["protected"] = TRUE
	book["unique"] = B.unique
	book["ref"] = "[REF(B)]"
	book["type"] = "[B.type]"
	return book

/obj/machinery/librarycomp/proc/tgui_add_token(var/list/token)
	var/list/book = list()
	book["id"] = token["uid"]
	book["title"] = token["title"]
	if(token["author"])
		book["author"] = token["author"]
	else
		book["author"] = "Anonymous"
	book["category"] = token["libcategory"]
	book["deleted"] = token["deleted"]
	book["protected"] = token["protected"] // ADMIN deletion prevention
	book["unique"] = FALSE
	book["ref"] = token["uid"]
	book["type"] = "[/obj/item/book]"
	return book

/obj/machinery/librarycomp/tgui_act(action, params)
	if(..())
		return TRUE
	add_fingerprint(usr)
	switch(action)
		if("switchscreen")
			inventory_page = 0 // reset inv menus
			if(params["switchscreen"] != "bible") // don't change screens if printing a bible
				screenstate = params["switchscreen"]
			if(screenstate == "arcane")
				if(!src.emagged)
					screenstate = "inventory" // Prevent access to forbidden lore vault if emag is fixed somehow
			else if(screenstate == "bible")
				if(!bibledelay)
					new /obj/item/storage/bible(src.loc)
					bibledelay = 1
					spawn(60)
						bibledelay = 0
				else
					for (var/mob/V in hearers(src))
						V.show_message(span_infoplain(span_bold("[src]") + "'s monitor flashes, \"Bible printer currently unavailable, please wait a moment.\""))
			. = TRUE

		if("increasetime")
			checkoutperiod += 1
			. = TRUE

		if("decreasetime")
			checkoutperiod -= 1
			if(checkoutperiod < 5)
				checkoutperiod = 5
			. = TRUE

		if("editbook")
			buffer_book = sanitizeSafe(tgui_input_text(usr, "Enter the book's title:"))
			. = TRUE

		if("editmob")
			buffer_mob = sanitize(tgui_input_text(usr, "Enter the recipient's name:", null, null, MAX_NAME_LEN), MAX_NAME_LEN)
			. = TRUE

		if("checkout")
			var/datum/borrowbook/b = new /datum/borrowbook
			b.bookname = sanitizeSafe(buffer_book)
			b.mobname = sanitize(buffer_mob)
			b.getdate = world.time
			b.duedate = world.time + (checkoutperiod * 600)
			checkouts.Add(b)
			screenstate = "checkedout" // more clear what happened
			. = TRUE

		if("checkin")
			var/datum/borrowbook/b = locate(params["checkin"]) in checkouts
			checkouts.Remove(b)
			. = TRUE

		if("delbook")
			var/obj/item/book/b = locate(params["delbook"]) in inventory
			inventory.Remove(b)
			. = TRUE

		if("quickcheck")
			// Quickly set a checkout title
			var/obj/item/book/b = locate(params["delbook"]) in inventory
			buffer_book = sanitize(b.title)
			screenstate = "checking"
			. = TRUE

		if("inv_prev")
			inventory_page--
			if(inventory_page < 0)
				inventory_page = 0

		if("inv_nex")
			inventory_page++
			var/siz = 0
			switch(screenstate)
				if("inventory") // barcode scanned books for checkout
					siz = inventory.len / INVPAGESIZE
				if("online") // internal archive (hardcoded books)
					siz = all_books.len / INVPAGESIZE
				if("archive") // external archive (SSpersistance database)
					siz = SSpersistence.all_books.len / INVPAGESIZE
				if("checkedout") // books checked out of the library
					siz = checkouts.len / INVPAGESIZE
			if(inventory_page > siz)
				inventory_page-- // go back


		if("setauthor")
			var/newauthor = sanitize(tgui_input_text(usr, "Enter the author's name: "))
			if(newauthor)
				scanner.cache.author = newauthor
			. = TRUE

		if("setcategory")
			var/newcategory = tgui_input_list(usr, "Choose a category: ", "Category", list("Fiction", "Non-Fiction", "Adult", "Reference", "Religion"))
			if(newcategory)
				scanner.cache.libcategory = newcategory
			. = TRUE

		if("upload")
			if(scanner)
				if(scanner.cache)
					if(!scanner.cache.unique)
						spawn(0)
							var/datum/persistent/library_books/SSBooks = SSpersistence.persistence_datums[/datum/persistent/library_books]
							var/status = SSBooks.add_new_book(scanner.cache,usr.client)
							switch(status)
								if(0)
									tgui_alert_async(usr, "Uploaded book \"[scanner.cache.name]\" by \"[scanner.cache.author]\" already exists, and is protected .")
								if(1)
									tgui_alert_async(usr, "\"[scanner.cache.name]\" by \"[scanner.cache.author]\", Upload Complete!")
								if(2)
									tgui_alert_async(usr, "Replaced book \"[scanner.cache.name]\" by \"[scanner.cache.author]\".")
								if(3)
									tgui_alert_async(usr, "Upload failed to parse \"[scanner.cache.name]\" by \"[scanner.cache.author]\".")
								if(4)
									tgui_alert_async(usr, "Please wait, still processing.")
			. = TRUE

		if("orderbyid")
			var/orderid = tgui_input_number(usr, "Enter your order:")
			if(orderid)
				if(isnum(orderid))
					var/nhref = "src=\ref[src];targetid=[orderid]"
					spawn() src.Topic(nhref, params2list(nhref), src)
			. = TRUE

		if("sort")
			if(params["sort"] in list("author", "title", "category"))
				sortby = params["sort"]
				. = TRUE

		if("hardprint")
			var/newpath = params["hardprint"]
			var/obj/item/book/NewBook = new newpath(get_turf(src))
			NewBook.name = "Book: [NewBook.name]"
			NewBook.unique = TRUE
			. = TRUE

		if("import_external")
			var/get_id = params["import_external"]
			var/datum/persistent/library_books/SSBooks = SSpersistence.persistence_datums[/datum/persistent/library_books]
			if(isnull(SSBooks.get_stored_book(get_id,get_turf(src))))
				tgui_alert_async(usr, "This book's data is invalid, please try another from the catalogue.")
			. = TRUE

		if("delete_external")
			var/get_id = params["delete_external"]
			var/datum/persistent/library_books/SSBooks = SSpersistence.persistence_datums[/datum/persistent/library_books]
			var/status = SSBooks.delete_stored_book(get_id)
			if(status)
				tgui_alert_async(usr, "Deletion Complete!")
			else
				tgui_alert_async(usr, "This book cannot be deleted due to administrative request.")
			. = TRUE

		if("restore_external")
			var/get_id = params["restore_external"]
			var/datum/persistent/library_books/SSBooks = SSpersistence.persistence_datums[/datum/persistent/library_books]
			SSBooks.restore_stored_book(get_id)
			. = TRUE

		if("protect_external")
			var/get_id = params["protect_external"]
			var/datum/persistent/library_books/SSBooks = SSpersistence.persistence_datums[/datum/persistent/library_books]
			SSBooks.protect_stored_book(get_id)
			. = TRUE

		if("arcane_checkout")
			new /obj/item/book/tome(src.loc)
			var/datum/gender/T = gender_datums[usr.get_visible_gender()]
			to_chat(usr, span_warning("Your sanity barely endures the seconds spent in the vault's browsing window. The only thing to remind you of this when you stop browsing is a dusty old tome sitting on the desk. You don't really remember printing it."))
			usr.visible_message(span_infoplain(span_bold("\The [usr]") + " stares at the blank screen for a few moments, [T.his] expression frozen in fear. When [T.he] finally awakens from it, [T.he] looks a lot older."), 2)
			screenstate = "home"
			. = TRUE

/obj/machinery/librarycomp/attack_hand(var/mob/user as mob)
	usr.set_machine(src)
	tgui_interact(user)

//VOREStation Addition Start
/obj/machinery/librarycomp/attack_ghost(mob/user)

	var/show_admin_options = check_rights(R_ADMIN, show_msg = FALSE)
	if(!show_admin_options)
		. = ..()

	else
		usr.set_machine(src)
		var/dat = "<HEAD><TITLE>Book Inventory Management</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
		dat += "<h3>ADMINISTRATIVE MANAGEMENT</h3>"
		if(!SSpersistence.all_books)
			dat +=	"<font color=red><b>ERROR</b> Something has gone seriously wrong. Contact System Administrator for more information.</font>"
		else if(!SSpersistence.all_books.len)
			dat +=	"<font color=red><b>ERROR</b> The external archive is currently empty.</font>"
		else
			dat += {"<table>
			<tr><td>AUTHOR</td><td>TITLE</td><td>CATEGORY</td><td>SS<sup>13</sup>BN</td></tr>"}
			for(var/token_id in SSpersistence.all_books)
				var/list/token = SSpersistence.all_books[token_id]
				if(!token)
					continue
				var/protected = ""
				if(!token["deleted"])
					if(token["protected"])
						protected = "PROTECT - "
					dat += "<tr><td>[protected][token["author"]]</td><td>[token["title"]]</td><td>[token["libcategory"]]</td><td><A href='?src=\ref[src];delete_external=[token["uid"]]'>\[Del\]</A> <A href='?src=\ref[src];protect_external=[token["uid"]]'>\[Protect\]</A></td></tr>"
				else
					dat += "<tr><td>DELETED - [token["author"]]</td><td>[token["title"]]</td><td>[token["libcategory"]]</td><td><A href='?src=\ref[src];restore_external=[token["uid"]]'>\[Restore\]</A> <A href='?src=\ref[src];protect_external=[token["uid"]]'>\[Protect\]</A></td></tr>"
			dat += "</table>"
		dat += "<BR><A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"

		user << browse(dat, "window=library")
		onclose(user, "library")
//VOREStation Addition End

/obj/machinery/librarycomp/emag_act(var/remaining_charges, var/mob/user)
	if (src.density && !src.emagged)
		src.emagged = 1
		return 1

/obj/machinery/librarycomp/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/barcodescanner))
		var/obj/item/barcodescanner/scanner = W
		scanner.computer = src
		to_chat(user, "[scanner]'s associated machine has been set to [src].")
		for (var/mob/V in hearers(src))
			V.show_message("[src] lets out a low, short blip.", 2)
	else
		..()


/*
 * Library Scanner
 */
/obj/machinery/libraryscanner
	name = "scanner"
	desc = "A scanner for scanning in books and papers."
	icon = 'icons/obj/library.dmi'
	icon_state = "bigscanner"
	anchored = TRUE
	density = TRUE
	var/obj/item/book/cache		// Last scanned book

/obj/machinery/libraryscanner/attackby(var/obj/O as obj, var/mob/user as mob)
	if(cache) // Prevent stacking books in here, unlike the original code.
		to_chat(user,span_warning("\The [src] already has a book inside it!"))
		return
	if(istype(O, /obj/item/book))
		user.drop_item()
		O.loc = src
		cache = O
		visible_message(span_notice("\The [O] was inserted into \the [src]."))

/obj/machinery/libraryscanner/attack_hand(var/mob/user as mob)
	if(cache) // Prevent stacking books in here
		cache = null
		for(var/obj/item/book/B in contents) // The old code allowed stacking, if multiple things end up in here somehow we may as well drop them all out too.
			B.loc = src.loc
		visible_message(span_notice("\The [src] ejects a book."))
		return
	to_chat(user,span_warning("There is nothing to eject from \the [src]!"))


/*
 * Book binder
 */
/obj/machinery/bookbinder
	name = "Book Binder"
	desc = "Bundles up a stack of inserted paper into a convenient book format."
	icon = 'icons/obj/library.dmi'
	icon_state = "binder"
	anchored = TRUE
	density = TRUE

/obj/machinery/bookbinder/attackby(var/obj/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/paper) || istype(O, /obj/item/paper_bundle))
		if(istype(O, /obj/item/paper))
			user.drop_item()
			O.loc = src
			user.visible_message("[user] loads some paper into [src].", "You load some paper into [src].")
			src.visible_message("[src] begins to hum as it warms up its printing drums.")
			sleep(rand(200,400))
			src.visible_message("[src] whirs as it prints and binds a new book.")
			var/obj/item/book/b = new(src.loc)
			b.dat = O:info
			b.name = "Print Job #" + "[rand(100, 999)]"
			b.icon_state = "book[rand(1,7)]"
			qdel(O)
		else
			user.drop_item()
			O.loc = src
			user.visible_message("[user] loads some paper into [src].", "You load some paper into [src].")
			src.visible_message("[src] begins to hum as it warms up its printing drums.")
			sleep(rand(300,500))
			src.visible_message("[src] whirs as it prints and binds a new book.")
			var/obj/item/book/bundle/b = new(src.loc)
			b.pages = O:pages
			for(var/obj/item/paper/P in O.contents)
				P.forceMove(b)
			for(var/obj/item/photo/P in O.contents)
				P.forceMove(b)
			b.name = "Print Job #" + "[rand(100, 999)]"
			b.icon_state = "book[rand(1,7)]"
			qdel(O)
	else
		..()

#undef INVPAGESIZE
