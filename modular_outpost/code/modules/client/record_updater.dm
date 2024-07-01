var/global/client_record_update_lock = FALSE

// Manually updating records from medical console to a player's save. Because players can barely be trusted to update records themselves. Just let medical do it.
/proc/get_current_mob_from_record(var/datum/data/record/active)
	var/datum/transcore_db/db = SStranscore.db_by_mind_name(active.fields["name"])
	if(db)
		var/datum/transhuman/mind_record/record = db.backed_up[active.fields["name"]]
		if(record.mind_ref)
			var/datum/mind/D = record.mind_ref
			return D.current
	return null


/proc/client_update_record(var/datum/data/record/active, var/user, var/record_string = "employment")
	if(jobban_isbanned(user, "Records") )
		return "Update syncronization denied (OOC: You are banned from editing records)"

	if(client_record_update_lock)
		to_chat(user,"Update already in progress! Please wait a moment...")
		return "Update already in progress! Please wait a moment..."
	client_record_update_lock = TRUE
	spawn(60 SECONDS)
		client_record_update_lock = FALSE

	var/mob/M = get_current_mob_from_record(active)
	if(!M)
		return "Update syncronization failed (OOC: Client mob does not exist, or has no mind record)"

	var/client/C = M.client
	if(!C)
		return "Update syncronization failed (OOC: Record's owner is offline)"

	to_chat(user,"Update sent! Please wait for a response...")
	message_admins("[user] pushed [record_string] record update to [active.fields["name"]].")

	var/choice = tgui_alert(M, "Your [record_string] record has been updated from the a records console by [user]. Please review the changes made to your [record_string] record. Accepting these changes will SAVE your CURRENT character slot! If your new [record_string] record has errors, it is recomended to have it corrected IC instead of editing it yourself.", "Record Updated", list("Review Changes","Refuse Update"))
	if(choice == "Refuse Update")
		message_admins("[active.fields["name"]] refused [record_string] record update from [user] without review.")
		return "Update syncronization failed (OOC: Client refused without review)"

	var/datum/preferences/P = C.prefs
	var/new_data = strip_html_simple(tgui_input_text(M,"Please review [user]'s changes to your [record_string] record before confirming. Confirming will SAVE your CURRENT character slot! If your new [record_string] record has errors, it is recomended to have it corrected IC instead of editing it yourself.","Character Preference", html_decode(active.fields["notes"]), MAX_RECORD_LENGTH, TRUE, prevent_enter = TRUE), MAX_RECORD_LENGTH)
	if(!new_data)
		message_admins("[active.fields["name"]] refused [record_string] record update from [user] with review.")
		return "Update syncronization failed (OOC: Client refused with review)"
	if(!M || !M.client || !P)
		message_admins("[active.fields["name"]]'s [record_string] record could not be updated, client disconnected.")
		return "Update syncronization failed (OOC: Client does not exist)"

	// This is awful
	if(record_string == "medical")
		P.med_record = new_data
	if(record_string == "security")
		P.sec_record = new_data
	if(record_string == "employment")
		P.gen_record = new_data
	P.save_preferences()
	P.save_character()
	message_admins("[active.fields["name"]] accepted the [record_string] record update from [user].")

	return "Record syncronized."
