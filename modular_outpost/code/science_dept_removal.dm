/// This file moves multiple techweb nodes out of being science only, so that all departments are able to research the full techweb by working together.

/datum/techweb_node/alientech
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_SUPPLY)

/datum/techweb_node/gene_engineering
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_MEDICAL)

/datum/techweb_node/mod_equip
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING)

/datum/techweb_node/mod_anomaly
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING)

/datum/techweb_node/bluespace_theory
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/bluespace_travel
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/xenoarch
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_SUPPLY)

/datum/techweb_node/anomaly_research
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/anomaly_shells
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/anomaly_harvesting
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/applied_anomaly_harvesting
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/telekinetics
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)

/datum/techweb_node/illegal
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_SUPPLY)

/datum/techweb_node/fireworks
	announce_channels = list(CHANNEL_SCIENCE, CHANNEL_ENGINEERING, CHANNEL_SUPPLY)
