/**
 * Ensures all chemicals BY DEFAULT will only affect the living, even if on a stablizer or during cpr. See change in reagents.dm for details.
 */
/datum/reagent
	affects_dead = FALSE
	var/allow_stabilizer = FALSE // If cpr/stablizer is allowed to process chems

/******************************************************************
 * 							REBALANCES
 ******************************************************************/
