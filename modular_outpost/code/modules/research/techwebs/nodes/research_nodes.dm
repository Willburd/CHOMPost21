/datum/techweb_node/outpost_telesci_probes
	id = TECHWEB_NODE_OUTPOST_TSCIBEACONS
	display_name = "Telescience Probes"
	description = "Camera probes used to assist with telescience calculations."
	prereq_ids = list(TECHWEB_NODE_BLUESPACE_THEORY)
	design_ids = list(
		"telesci_probe_monitor",
		"telesci_probe",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(CHANNEL_SCIENCE)

/datum/techweb_node/applied_bluespace
	required_experiments = list(/datum/experiment/scanning/points/bluespace_containing_items)
