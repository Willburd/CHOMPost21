/datum/controller/subsystem/events/proc/test_weights()


	var/loops = 100000
	for(var/l = EVENT_LEVEL_MUNDANE to EVENT_LEVEL_MAJOR)
		var/alist/event_summary = alist()
		var/datum/event_container/EC = event_containers[l]

		for(var/i = 1 to loops)
			var/datum/event_meta/EM = EC.acquire_event(TRUE)
			if(EM.name in event_summary)
				event_summary[EM.name] += 1
			else
				event_summary[EM.name] = 1

			// Restore event if it allows it
			EC.available_events += EM

		to_chat(world, "[l] Event tier; Summary for [loops] event attempts")

		var/total_count = 0;
		for(var/key in event_summary)
			total_count += event_summary[key]

		for(var/key in event_summary)
			var/count = event_summary[key]
			to_chat(world, "[key] = [count] or [FLOOR((count / total_count) * 100,1) ]%")
