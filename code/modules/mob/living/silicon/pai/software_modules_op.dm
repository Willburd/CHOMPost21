/datum/pai_software/deathalarm
	name = "Death Alarm"
	ram_cost = 25
	id = "death_alarm"

/datum/pai_software/deathalarm/toggle(mob/living/silicon/pai/user)
	user.paiDA = !user.paiDA

/datum/pai_software/deathalarm/is_active(mob/living/silicon/pai/user)
	return user.paiDA
