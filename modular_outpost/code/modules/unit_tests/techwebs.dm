/datum/unit_test/techwebs_must_all_have_multiple_departments

/datum/unit_test/techwebs_must_all_have_multiple_departments/Run()
	var/failed = FALSE

	// Each node in the web
	for(var/node_id in SSresearch.techweb_nodes)
		var/datum/techweb_node/node = SSresearch.techweb_nodes[node_id]
		if(node.id == /datum/techweb_node/error_node::id)
			continue
		if(node.starting_node)
			continue
		if(node.announce_channels.len > 1)
			continue
		if(node.announce_channels[1] != CHANNEL_ENGINEERING)
			continue
		TEST_NOTICE(src, "TECHWEB NODE - [node.type] only had research department, it must be accessible by at least one other department.")
		failed = TRUE

	if(failed)
		TEST_FAIL("All techweb entries must be researchable by departments outside of science")
