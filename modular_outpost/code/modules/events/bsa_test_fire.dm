/datum/event/bsa_test_fire
	announceWhen = 1
	startWhen = 1
	var/xx = 0
	var/yy = 0
	var/zz = 0

/datum/event/bsa_test_fire/announce()
	command_announcement.Announce("An impromptu bluespace artillery test-fire will be performed in ten minutes. Await further announcements for designated target coordinates.", "Announcement")

/datum/event/bsa_test_fire/start()
	addtimer(CALLBACK(src, PROC_REF(locate_target)), 1 MINUTE, TIMER_DELETE_ME)

/datum/event/bsa_test_fire/proc/locate_target()
	var/list/options = list()
	for(var/thing in landmarks_list)
		if(istype(thing,/obj/effect/landmark/bsa_target))
			options.Add(thing)
	if(!options.len)
		return

	var/obj/effect/landmark/bsa_target/L = pick(options)
	if(!L)
		command_announcement.Announce("A test-fire location could not be acquired. The test has been cancelled.", "Announcement")
		return
	var/turf/T = get_turf(L)
	if(!T)
		command_announcement.Announce("A test-fire location could not be acquired. The test has been cancelled.", "Announcement")
		return
	xx = T.x
	yy = T.y
	zz = T.z
	command_announcement.Announce("A test-fire target has been acquired. Coordinates [xx].[yy].[zz] calibrated. Stay clear for firing. T-9 Minutes", "Announcement")
	addtimer(CALLBACK(src, PROC_REF(final_warn)), 8 MINUTE, TIMER_DELETE_ME)

/datum/event/bsa_test_fire/proc/final_warn()
	command_announcement.Announce("T-60 seconds to bluespace artillery test-fire.", "Announcement")
	addtimer(CALLBACK(src, PROC_REF(test_fire)), 1 MINUTE, TIMER_DELETE_ME)

/datum/event/bsa_test_fire/proc/test_fire()
	var/datum/admin_secret_item/fun_secret/shell_location/A = locate() in admin_secrets.items
	if(A)
		var/cur_delay = rand(1 SECONDS, 4 SECONDS)
		addtimer(CALLBACK(A, TYPE_PROC_REF(/datum/admin_secret_item/fun_secret/shell_location,announce), xx, yy, zz, TRUE), cur_delay, TIMER_DELETE_ME)
	addtimer(CALLBACK(src, PROC_REF(conclude)), 10 SECONDS, TIMER_DELETE_ME)

/datum/event/bsa_test_fire/proc/conclude()
	command_announcement.Announce("Test-fire has concluded, impact confirmed. Adjusting aim by [rand(2,6)] degrees. Test-fire of bluespace artillery successful. Please have a safe and productive shift.", "Announcement")

/obj/effect/landmark/bsa_target
	name = "bsa_target"
	invisibility = 101
	delete_me = 0
