/datum/transcore_db/proc/removed_mind(var/datum/transhuman/mind_record/MR)
	ASSERT(MR)
	backed_up.Remove("[MR.mindname]")
	log_world("## DEBUG: Removed [MR.mindname] from transcore DB.")
