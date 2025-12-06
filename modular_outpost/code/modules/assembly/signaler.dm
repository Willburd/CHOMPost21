// The instant boink button
/obj/item/assembly/signaler/click_alt(mob/user)
	..()
	INVOKE_ASYNC(src, PROC_REF(signal))
	return CLICK_ACTION_SUCCESS
