/datum/persistent/library_books
	name = "paintings"
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

	if(fexists(filename))
		fdel(filename)
	to_file(file(filename), json_encode(SSpersistence.all_books))
