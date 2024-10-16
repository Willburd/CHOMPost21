// Pass radio or other unhandled messages to translators if their normal hear_say code doesn't pick it up.
// This being called multiple times for the same message is not a concern for radios, as the broadcast code collects
// all listening mobs of a message based on radio proximity, and sends the message once to each mob.
/mob/proc/translator_proxy_hear(var/list/message_pieces, var/verb = "says", var/mob/speaker = null)
	// Could be in either hand
	if(isliving(src))
		var/mob/living/L = src
		if(istype(L.l_hand,/obj/item/universal_translator))
			var/obj/item/universal_translator/TR = L.l_hand
			TR.hear_talk(speaker, message_pieces, verb)
		if(istype(L.r_hand,/obj/item/universal_translator))
			var/obj/item/universal_translator/TR = L.r_hand
			TR.hear_talk(speaker, message_pieces, verb)
	// Or earpieces on a human mob
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(istype(H.l_ear,/obj/item/universal_translator))
			var/obj/item/universal_translator/TR = H.l_ear
			TR.hear_talk(speaker, message_pieces, verb)
		if(istype(H.r_ear,/obj/item/universal_translator))
			var/obj/item/universal_translator/TR = H.r_ear
			TR.hear_talk(speaker, message_pieces, verb)
