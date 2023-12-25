#include "smuggler_areas.dm"
#include "smuggler_jobs.dm"
#include "smuggler_shuttles.dm"

// Map template data.
/datum/map_template/ruin/away_site/smuggler
	name = "FTU-TV Miss Fortune"
	id = "awaysite_smuggler"
	description = "."
	suffixes = list("smugglers_ship/smuggler.dmm")
	spawn_cost = 2
	area_usage_test_exempted_root_areas = /area/ship/smuggler
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/smuggler)

/obj/effect/overmap/visitable/sector/smuggler
	name = "Bluespace Residue"
	desc = "/ERROR/."
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE

/obj/effect/submap_landmark/joinable_submap/smuggler
	name = "FTU-TV Miss Fortune"
	archetype = /decl/submap_archetype/smuggler

/turf/simulated/wall/secret_passage
	can_open = 1