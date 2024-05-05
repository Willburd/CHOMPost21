/datum/admin_secret_item/fun_secret/drain_all_smes
	name = "Drain All SMES"

/datum/admin_secret_item/fun_secret/drain_all_smes/execute(var/mob/user)
	. = ..()
	if(.)
		power_kill_quick()
