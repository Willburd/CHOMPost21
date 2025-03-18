/datum/map
	spawnpoint_died = /datum/spawnpoint/cryo // Used if you end the round dead.
	spawnpoint_left = /datum/spawnpoint/elevator // Used of you end the round at centcom.
	spawnpoint_stayed = /datum/spawnpoint/dorm // Used if you end the round on the station.

// Boolean for if we should use SSnightshift night hours
/datum/map/get_nightshift()
	return get_night(3) // Use surface map on 3 for outpost
