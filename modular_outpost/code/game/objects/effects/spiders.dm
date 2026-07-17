/obj/effect/spider/spiderling/outpost
	grow_as = list(/mob/living/simple_mob/animal/giant_spider, /mob/living/simple_mob/animal/giant_spider/nurse, /mob/living/simple_mob/animal/giant_spider/hunter)

/obj/effect/spider/spiderling/phone_spider
	name = "phone spider"
	desc = "Has science finally gone too far!?"
	icon = 'modular_outpost/icons/effects/effects.dmi'
	icon_state = "phone_spider"
	alpha = 200
	grow_as = list()
	amount_grown = -1

/obj/effect/spider/spiderling/phone_spider/die()
	visible_message(span_alert("[src] fades away!"))
	qdel(src)
