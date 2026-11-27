/* This comment bypasses grep checks */ /var/__aleslumin

/proc/__detect_aleslumin()
	if (world.system_type == UNIX)
		return __aleslumin = (fexists("./libaleslumin.so") ? "./libaleslumin.so" : "libaleslumin")
	else
		return __aleslumin = "aleslumin"

#define ALESLUMIN (__aleslumin || __detect_aleslumin())
#define ALESLUMIN_CALL(name, args...) call_ext(ALESLUMIN, "byond:" + name)(args)

/proc/aleslumin_version()	return ALESLUMIN_CALL("aleslumin_version")
/proc/aleslumin_features()	return ALESLUMIN_CALL("aleslumin_features")
/proc/aleslumin_cleanup()	return ALESLUMIN_CALL("aleslumin_cleanup")

/world/New()
	aleslumin_cleanup()
	..()
