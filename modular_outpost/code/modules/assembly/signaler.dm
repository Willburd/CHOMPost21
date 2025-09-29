// The instant boink button
/obj/item/assembly/signaler/AltClick(mob/user)
	INVOKE_ASYNC(src, PROC_REF(signal))
