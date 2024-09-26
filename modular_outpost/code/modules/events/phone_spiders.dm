/var/global/list/phones_on_station = list()

/datum/event/phone_spiders
	announceWhen	= 90
	var/spawncount = 1

/datum/event/phone_spiders/setup()
	announceWhen = rand(5,15)
	spawncount = rand(20, 32)

/datum/event/phone_spiders/announce()
	command_announcement.Announce("Anti-spam counter-measures have been redirected toward station communication systems.", "Firewall Notice")

/datum/event/phone_spiders/start()
	while((spawncount >= 1) && phones_on_station.len)
		var/obj/phone = pick(phones_on_station)
		var/sub = rand(5,8)
		var/first = TRUE
		while(sub >= 1)
			var/obj/effect/spider/spiderling/phone_spider/S = new /obj/effect/spider/spiderling/phone_spider(phone.loc)
			if(first)
				phone.visible_message("<span class='warning'>A pack of [S]s makes their way out of \the [phone]!</span>")
				first = FALSE
			sub--
			spawncount--
