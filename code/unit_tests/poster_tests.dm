/datum/unit_test/posters_shall_have_legal_states
	name = "POSTERS: All poster decls shall have valid icon and icon overrides"

/datum/unit_test/posters_shall_have_legal_states/start_test()
	var/failed = FALSE
	var/list/all_posters = decls_repository.get_decls_of_type(path)
	all_posters -= decls_repository.get_decl(/decl/poster/lewd) // Dumb exclusion for now. This really needs to become a valid poster instead of an illegal made base type

	for(var/decl/poster/D in all_posters)
		var/obj/structure/sign/poster/P = /obj/structure/sign/poster // The base poster shows ALL subtypes except /lewd, so all posters should function here regardless!
		var/icon/I = initial(P.icon)
		if(D.icon_override)
			I = D.icon_override
		if(!(D.icon_state in cached_icon_states(I)))
			failed = TRUE
			log_unit_test("[D.type]: Poster - missing icon_state \"[D.icon_state]\" in \"[I]\", as [D.icon_override ? "override" : "base"] dmi.")

	if(failed)
		fail("One or more posters have missing icon_states or bad icon overrides.")
	else
		pass("All posters have their icon_states and overrides set correctly.")

	return TRUE
