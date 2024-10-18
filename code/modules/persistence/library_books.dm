/datum/persistent/library_books
	name = "library_books"
	//entries_expire_at = 1000 // Basically forever
	var/max_entries = 1000 //1000 paintings is a lot, and will take a long time to cycle through.

/datum/persistent/library_books/SetFilename()
    filename = "data/persistent/[lowertext(using_map.name)]-library_books.json"

/datum/persistent/library_books/Initialize()
	. = ..()
	if(fexists(filename))
		SSpersistence.all_books = json_decode(file2text(filename))
		var/list/tokens = SSpersistence.all_books
		for(var/list/token in tokens)
			if(!CheckTokenSanity(token))
				tokens -= token

/datum/persistent/library_books/CheckTokenSanity(var/list/token)
	return ( \
		!isnull(token["uid"]) && \
		!isnull(token["title"]) && \
		!isnull(token["author"]) && \
		!isnull(token["deleted"])
	)

/datum/persistent/library_books/proc/CheckBookSanity(var/list/token)
	return ( \
		!isnull(token["uid"]) && \
		!isnull(token["name"]) && \
		!isnull(token["title"]) && \
		!isnull(token["dat"]) && \
		!isnull(token["libcategory"]) && \
		!isnull(token["author"]) && \
		!isnull(token["icon_state"])
	)

/datum/persistent/library_books/Shutdown()
	if(SSpersistence.all_books.len > max_entries)
		var/this_many = SSpersistence.all_books.len
		var/over = this_many - max_entries
		log_admin("There are [over] more book(s) stored than the maximum allowed.")
		while(over > 0)
			var/list/d = SSpersistence.all_books[1]
			if(SSpersistence.all_books.Remove(list(d)))
				log_admin("A book was deleted")
			else
				log_and_message_admins("Attempted to delete a book, but failed.")
			over --

	// cleanup list
	var/list/output_list = list()
	for(var/list/entry in SSpersistence.all_books)
		if(!CheckTokenSanity(entry))
			continue
		if(!entry["deleted"])
			log_admin("A book was deleted during the round")
			output_list.Add(list(entry))
		else
			var/hash = md5(entry["uid"])
			var/filecheck = "data/persistent/library/[hash]-library_book.json"
			if(fexists(filecheck))
				fdel(filecheck)

	// Saving library index file
	if(fexists(filename))
		fdel(filename)
	to_file(file(filename), json_encode(output_list))
	SSpersistence.all_books = output_list // Update list, for manual debugging

/datum/persistent/library_books/proc/add_new_book(var/obj/item/book/B,var/client/C)
	var/search_id = "[B.name]_[B.author]_[B.libcategory]"
	var/replacing = null
	for(var/entry in SSpersistence.all_books)
		if(entry["uid"] != search_id)
			continue
		if(entry["deleted"] || ( C && C.holder && C.holder.rights & R_ADMIN ))
			replacing = entry // store the data entry from the list for editing later
			break
		else
			return 0 // no replace

	// Append a list with the new token, formatting is weird because it's all_books + newlist(token).
	// If it was just the token it would add all the token's keys to the all_books list!
	var/list/data = list(
		"uid" = search_id,
		"title" = B.name,
		"author" = B.author,
		"deleted" = FALSE
	)

	if(replacing)
		var/was_deleted = FALSE
		if(replacing["deleted"])
			was_deleted = TRUE
		for(var/key in data)
			replacing["[key]"] = data["[key]"] // bulk replace all keys
		save_book_to_file(B)
		if(was_deleted)
			return 1 // pretend it's newly saved
		return 2 // replaced old one
	else
		SSpersistence.all_books += list(data)
		save_book_to_file(B)
		return 1 // new saved

/datum/persistent/library_books/proc/get_stored_book(var/uid,var/location,var/unique = TRUE)
	for(var/list/token in SSpersistence.all_books)
		if(token["uid"] != uid)
			continue
		if(token["deleted"])
			return
		var/list/data = load_book_from_file(token)
		if(!data)
			return
		var/obj/item/book/NewBook
		if(data["pages"])
			// not false or null, assume a bundle book!
			var/obj/item/book/bundle/bund = new /obj/item/book/bundle(location)
			for(var/page in data["pages"])
				bund.pages.Add(page)
			NewBook = bund
		else
			// normal book
			NewBook = new(location)
		NewBook.name = "[data["name"]]"
		NewBook.title = "[data["title"]]"
		NewBook.dat = "[data["dat"]]"
		NewBook.libcategory = "[data["libcategory"]]"
		NewBook.author = "[data["author"]]"
		NewBook.icon_state = "[data["icon_state"]]"
		NewBook.unique = unique
		return NewBook

/datum/persistent/library_books/proc/delete_stored_book(var/uid,var/client/C,var/force = FALSE)
	if(!uid) // somehow null ui, possibly bad data used
		return FALSE
	if(force || (C && C.holder && C.holder.rights & R_ADMIN))
		for(var/list/token in SSpersistence.all_books)
			if(token["uid"] != uid)
				continue
			token["deleted"] = TRUE // We remove books during Shutdown, so admins can undelete books using VV before round ends
			return TRUE
		return FALSE
	else
		return FALSE

/datum/persistent/library_books/proc/save_book_to_file(var/obj/item/book/B)
	var/search_id = "[B.name]_[B.author]_[B.libcategory]"
	var/list/data = list(
							"uid" = search_id,
							"name" = B.name,
							"title" = B.name,
							"dat" = B.dat, // Is there any way to base64 encode these keys for safety when storing it? I don't like storing even sanitized raw html
							"libcategory" = B.libcategory,
							"author" = B.author,
							"icon_state" = B.icon_state
						)
	if(istype(B,/obj/item/book/bundle))
		// Collect pages if a bundle
		var/obj/item/book/bundle/bund = B
		var/list/PG = list()
		for(var/page in bund.pages)
			PG.Add(page)
		data["pages"] = PG
	else
		// false otherwise
		data["pages"] = FALSE
	// I sense stupidity
	if(!CheckBookSanity(data))
		return
	var/hash = md5(data["uid"])
	var/filecheck = "data/persistent/library/[hash]-library_book.json"
	if(fexists(filecheck))
		fdel(filecheck) // remove old
	to_file(file(filecheck), json_encode(data))

/datum/persistent/library_books/proc/load_book_from_file(var/token)
	if(!token)
		return
	if(!CheckTokenSanity(token))
		delete_stored_book(token["uid"],null,TRUE) // Invalid token entry somehow
		return
	var/hash = md5(token["uid"])
	var/filecheck = "data/persistent/library/[hash]-library_book.json"
	if(!fexists(filecheck))
		return
	var/str = file2text(filecheck)
	if(!str)
		delete_stored_book(token["uid"],null,TRUE) // WELP, failed parse.
		return
	var/decode = json_decode(str)
	if(!decode || !CheckBookSanity(decode))
		delete_stored_book(token["uid"],null,TRUE) // Why?... Old format?
		return
	return decode
