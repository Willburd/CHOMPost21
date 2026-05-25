/datum/component/hallucinations/proc/event_out_of_body()
	PROTECTED_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	our_human.AddComponent(/datum/component/out_of_body_experience/no_bad_body/shadow_realm)
