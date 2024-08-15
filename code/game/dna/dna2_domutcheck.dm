// (Re-)Apply mutations.
// TODO: Turn into a /mob proc, change inj to a bitflag for various forms of differing behavior.
// M: Mob to mess with
// connected: Machine we're in, type unchecked so I doubt it's used beyond monkeying
// flags: See below, bitfield.
#define MUTCHK_FORCED        1
#define MUTCHK_HIDEMSG       2 // Traitgenes edit - Hide gene activation/deactivation messages, mostly for resleeving so you don't get spammed
/proc/domutcheck(var/mob/living/M, var/connected=null, var/flags=0)
	// Traitgenes edit begin - Sort genes into currently active, and deactivated... Genes that are active and may deactivate should do so before attempting to activate genes(to avoid conflicts blocking them!)
	var/list/enabled_genes = list()
	var/list/disabled_genes = list()
	for(var/datum/dna/gene/gene in dna_genes)
		if(!M || !M.dna)
			return
		if(gene.block)
			if(gene.name in M.active_genes || gene.flags & GENE_ALWAYS_ACTIVATE)
				enabled_genes.Add(gene)
			else
				disabled_genes.Add(gene)
	for(var/datum/dna/gene/gene in enabled_genes + disabled_genes)
	// Traitgenes edit end
		if(!M || !M.dna)
			return
		if(!gene.block)
			continue

		// Sanity checks, don't skip.
		if(!gene.can_activate(M,flags))
			//testing("[M] - Failed to activate [gene.name] (can_activate fail).")
			continue

		// Current state
		var/gene_active = (gene.flags & GENE_ALWAYS_ACTIVATE)
		if(!gene_active)
			gene_active = M.dna.GetSEState(gene.block)

		// Prior state
		var/gene_prior_status = (gene.name in M.active_genes) // Traitgenes edit - Use name instead, cannot use type with dynamically setup traitgenes
		var/changed = gene_active != gene_prior_status || (gene.flags & GENE_ALWAYS_ACTIVATE)

		// If gene state has changed:
		if(changed || flags & MUTCHK_FORCED) // Traitgenes edit - MUTCHK_FORCED always applies or removes genes
			// Gene active (or ALWAYS ACTIVATE)
			if(gene_active || (gene.flags & GENE_ALWAYS_ACTIVATE))
				// Traitgenes edit begin - Handle trait conflicts, do not activate if so!
				if(istype(gene,/datum/dna/gene/trait))
					var/datum/dna/gene/trait/TG = gene
					if(!ishuman(M))
						continue // Trait genes are human only
					var/mob/living/carbon/human/H = M
					if(TG.has_conflict(H.species.traits))
						continue // The SE is on, but the gene is denied...
				// Traitgenes edit end
				//testing("[gene.name] activated!")
				gene.activate(M,connected,flags)
				if(M)
					M.active_genes |= gene.name // Traitgenes edit - Use name instead, cannot use type with dynamically setup traitgenes
					M.update_icon = 1
			// If Gene is NOT active:
			else
				//testing("[gene.name] deactivated!")
				gene.deactivate(M,connected,flags)
				if(M)
					M.active_genes -= gene.name // Traitgenes edit - Use name instead, cannot use type with dynamically setup traitgenes
					M.update_icon = 1
