/datum/job/qm/New()
	. = ..()
	access |= list(ACCESS_KEYCARD_AUTH, ACCESS_TELEPORTER, ACCESS_HEADS, ACCESS_CHANGE_IDS, ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_HYDROPONICS, ACCESS_XENOBOTANY, ACCESS_XENOBIOLOGY, ACCESS_XENOARCH)
	minimal_access |= list(ACCESS_KEYCARD_AUTH, ACCESS_TELEPORTER, ACCESS_HEADS, ACCESS_CHANGE_IDS, ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_HYDROPONICS, ACCESS_XENOBOTANY, ACCESS_XENOBIOLOGY, ACCESS_XENOARCH)
	alt_titles |= list(JOB_ALT_CHIEF_STEWARD = /datum/alt_title/chief_steward)


// Alt titles
/datum/alt_title/chief_steward
	title = JOB_ALT_CHIEF_STEWARD
	title_blurb = "The " + JOB_ALT_CHIEF_STEWARD + " manages the Supply department. They focus more on civilian operations such as the kitchen, janitorial, and hydroponics. They must still oversee cargo orders."


/datum/job/cargo_tech/New()
	. = ..()
	access |= list(ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_XENOBIOLOGY, ACCESS_XENOARCH)
	minimal_access |= list(ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_XENOBIOLOGY, ACCESS_XENOARCH)


/datum/job/mining/New()
	. = ..()
	access |= list(ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_XENOBIOLOGY, ACCESS_XENOARCH)
	minimal_access |= list(ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_XENOBIOLOGY, ACCESS_XENOARCH)
	alt_titles |= list(JOB_ALT_XENOARCHAEOLOGIST = /datum/alt_title/xenoarch, JOB_ALT_XENOPALEONTOLOGIST = /datum/alt_title/xenopaleontologist)


// Alt titles
/datum/alt_title/xenoarch
	title_outfit = /datum/decl/hierarchy/outfit/job/cargo/mining/xenoarcheologist

/datum/alt_title/xenopaleontologist
	title_outfit = /datum/decl/hierarchy/outfit/job/cargo/mining/xenoarcheologist
