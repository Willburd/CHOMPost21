/////////////////////////
// (mostly) DNA2 SETUP
/////////////////////////

/* Traitgenes edit - Blocks have finally been retired, huzzah!
// Randomize block, assign a reference name, and optionally define difficulty (by making activation zone smaller or bigger)
// The name is used on /vg/ for species with predefined genetic traits,
//  and for the DNA panel in the player panel.
/proc/getAssignedBlock(var/name,var/list/blocksLeft, var/activity_bounds=DNA_DEFAULT_BOUNDS)
	if(blocksLeft.len==0)
		warning("[name]: No more blocks left to assign!")
		return 0
	var/assigned = pick(blocksLeft)
	blocksLeft.Remove(assigned)
	assigned_blocks[assigned]=name
	dna_activity_bounds[assigned]=activity_bounds
	//testing("[name] assigned to block #[assigned].")
	return assigned

/proc/setupgenetics()
	if (prob(50))
		// Currently unused.  Will revisit. - N3X
		BLOCKADD = rand(-300,300)
	if (prob(75))
		DIFFMUT = rand(0,20)

	var/list/numsToAssign=new()
	for(var/i=1;i<DNA_SE_LENGTH;i++)
		numsToAssign += i

	//testing("Assigning DNA blocks:")

	// Standard muts, imported from older code above.
	BLINDBLOCK         = getAssignedBlock("BLIND",         numsToAssign)
	DEAFBLOCK          = getAssignedBlock("DEAF",          numsToAssign)
	HULKBLOCK          = getAssignedBlock("HULK",          numsToAssign, DNA_HARD_BOUNDS)
	TELEBLOCK          = getAssignedBlock("TELE",          numsToAssign, DNA_HARD_BOUNDS)
	FIREBLOCK          = getAssignedBlock("FIRE",          numsToAssign, DNA_HARDER_BOUNDS)
	XRAYBLOCK          = getAssignedBlock("XRAY",          numsToAssign, DNA_HARDER_BOUNDS)
	CLUMSYBLOCK        = getAssignedBlock("CLUMSY",        numsToAssign)
	FAKEBLOCK          = getAssignedBlock("FAKE",          numsToAssign)

	// Outpost 21 edit begin - no longer unused
	COUGHBLOCK         = getAssignedBlock("COUGH",         numsToAssign)
	GLASSESBLOCK       = getAssignedBlock("GLASSES",       numsToAssign)
	EPILEPSYBLOCK      = getAssignedBlock("EPILEPSY",      numsToAssign)
	TWITCHBLOCK        = getAssignedBlock("TWITCH",        numsToAssign)
	NERVOUSBLOCK       = getAssignedBlock("NERVOUS",       numsToAssign)
	// Outpost 21 edit end

	// Bay muts (UNUSED)
	//HEADACHEBLOCK      = getAssignedBlock("HEADACHE",      numsToAssign)
	NOBREATHBLOCK      = getAssignedBlock("NOBREATH",      numsToAssign, DNA_HARD_BOUNDS)
	//REMOTEVIEWBLOCK    = getAssignedBlock("REMOTEVIEW",    numsToAssign, DNA_HARDER_BOUNDS)
	REGENERATEBLOCK    = getAssignedBlock("REGENERATE",    numsToAssign, DNA_HARDER_BOUNDS)
	//INCREASERUNBLOCK   = getAssignedBlock("INCREASERUN",   numsToAssign, DNA_HARDER_BOUNDS)
	REMOTETALKBLOCK    = getAssignedBlock("REMOTETALK",    numsToAssign, DNA_HARDER_BOUNDS)
	MORPHBLOCK         = getAssignedBlock("MORPH",         numsToAssign, DNA_HARDER_BOUNDS)
	//COLDBLOCK          = getAssignedBlock("COLD",          numsToAssign)
	//HALLUCINATIONBLOCK = getAssignedBlock("HALLUCINATION", numsToAssign)
	//NOPRINTSBLOCK      = getAssignedBlock("NOPRINTS",      numsToAssign, DNA_HARD_BOUNDS)
	//SHOCKIMMUNITYBLOCK = getAssignedBlock("SHOCKIMMUNITY", numsToAssign)
	//SMALLSIZEBLOCK     = getAssignedBlock("SMALLSIZE",     numsToAssign, DNA_HARD_BOUNDS)

	//
	// Static Blocks
	/////////////////////////////////////////////.

	// Monkeyblock is always last.
	MONKEYBLOCK = DNA_SE_LENGTH

	// And the genes that actually do the work. (domutcheck improvements)
	var/list/blocks_assigned[DNA_SE_LENGTH]
	for(var/gene_type in typesof(/datum/dna/gene))
		var/datum/dna/gene/G = new gene_type
		if(G.block)
			if(G.block in blocks_assigned)
				warning("DNA2: Gene [G.name] trying to use already-assigned block [G.block] (used by [english_list(blocks_assigned[G.block])])")
			dna_genes.Add(G)
			var/list/assignedToBlock[0]
			if(blocks_assigned[G.block])
				assignedToBlock=blocks_assigned[G.block]
			assignedToBlock.Add(G.name)
			blocks_assigned[G.block]=assignedToBlock
*/

// Traitgenes edit begin - Setup gentics using traits as a foundation for each gene. Basically making genetics automagic instead of something that needs to be maintained...
/proc/setupgenetics(var/list/trait_list)
	if(!trait_list)
		return
	var/list/blocks_remaining = list()
	var/I = 0
	while(I++ <= DNA_SE_LENGTH)
		blocks_remaining.Add(I)
	for(var/TI in trait_list)
		var/datum/trait/T = trait_list[TI]
		if(T.is_genetrait)
			if(blocks_remaining.len <= 0)
				CRASH("DNA2: Ran out of usable blocks! DNA_SE_LENGTH limit is [DNA_SE_LENGTH]. Raise it if you need more!")
			// Init
			var/datum/dna/gene/trait/G = new /datum/dna/gene/trait()
			G.block = pick(blocks_remaining)
			var/tex = uppertext(T.name)
			G.name = "[copytext(tex,1,min( 8, length(tex)+1 ))]:[G.block]"
			T.linked_gene = G
			G.linked_trait = T
			dna_activity_bounds[G.block]=T.activity_bounds
			// Handle global block data
			log_world("DNA2: Assigned [G.name] - Linked to trait [T.name].")
			assigned_blocks[G.block]=G.name
			dna_genes.Add(G)
			blocks_remaining.Remove(G.block)
	log_world("DNA2: Created traitgenes with [blocks_remaining.len] remaining blocks. Used [DNA_SE_LENGTH - blocks_remaining.len] out of [DNA_SE_LENGTH] ")
	if(blocks_remaining.len < 10)
		warning("DNA2: Blocks remaining is less than 10. The DNA_SE_LENGTH should be raised.")
// Traitgenes edit end
