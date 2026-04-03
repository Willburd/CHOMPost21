/datum/event/tram_breaker

/datum/event/tram_breaker/setup()
	announceWhen = rand(5, 10)
	endWhen = rand(15, 30)

/datum/event/tram_breaker/announce()
	GLOB.command_announcement.Announce("Tram over-current protection tripped. APC breaker in Tram Control maintenance room requires manual reset.", "Tram Monitor")

/datum/event/tram_breaker/start()
	var/area/tram_control = GLOB.areas_by_type[/area/maintenance/substation/tram_control]
	var/obj/machinery/power/apc/owner_apc = tram_control?.get_apc()
	if(!owner_apc)
		return
	owner_apc.locked = FALSE
	owner_apc.toggle_breaker()
	owner_apc.visible_message("clicks","clicks")
	SSmotiontracker.ping(owner_apc,100)
