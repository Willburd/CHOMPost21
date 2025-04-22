// See initialization order in /code/game/world.dm
// GLOBAL_REAL(config, /datum/controller/configuration)
GLOBAL_REAL(config, /datum/controller/configuration) = new

GLOBAL_DATUM_INIT(revdata, /datum/getrev, new)

GLOBAL_VAR_INIT(game_version, "Outpost21") // CHOMPEdit TFF 24/12/19 - Chompers // Outpost 21 edit - Station name
GLOBAL_VAR_INIT(changelog_hash, "")

// Debug2 is used in conjunction with a lot of admin verbs and therefore is actually legit.
GLOBAL_VAR_INIT(Debug2, FALSE)
