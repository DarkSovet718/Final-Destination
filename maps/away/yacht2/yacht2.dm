#include "yacht2_areas.dm"

/obj/effect/overmap/visitable/ship/landable/yacht2
	name = "Yacht"
	shuttle = "Yacht"
	desc = "Sensor array is detecting a small vessel, broadcasting registration codes \"IPV-9384-L-166\". <br>   Armament:   Unknown."
	color = "#ffc966"
	icon_state = "ship"
	moving_state = "ship_moving"
	fore_dir = NORTH
	vessel_size = SHIP_SIZE_SMALL
	burn_delay = 0.5 SECONDS
	hide_from_reports = TRUE
	skill_needed = SKILL_BASIC
	integrity_failure_cap = 120
	vessel_mass = 3000
	max_speed = 0.8/(2 SECONDS)
	initial_restricted_waypoints = list(
		"Yacht Landing Zone" = list("nav_yacht_start")
	)

/obj/effect/shuttle_landmark/yacht
	name = "Yacht Landing Zone"
	landmark_tag = "nav_yacht_start"
	docking_controller = "yacht_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/overmap/visitable/ship/landable/yacht2/New(nloc, max_x, max_y)
	name = "IPV [pick("Razormind", "DonAcDum", "Ferral", "Victory", "Ananasi")], \a [name]"
	..()

/obj/effect/overmap/visitable/sector/yacht
	name = "Small Bluespace Signature"
	desc = "Bluespace trace, left by something small"
	icon_state = "event"
	hide_from_reports = TRUE
	alpha = 5
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE
	known = 0

/obj/machinery/computer/shuttle_control/explore/yacht
	name = "yacht landing control console"
	shuttle_tag = "Yacht"

/datum/map_template/ruin/away_site/yacht2
	name = "Yacht Playable"
	id = "awaysite_yacht2"
	description = "Small movable vessel with wealthy AF liberal pidors."
	suffixes = list("yacht2/yacht2.dmm")
	spawn_cost = 0.5
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/yacht)
	area_usage_test_exempted_root_areas = list(/area/yacht2)

/datum/shuttle/autodock/overmap/yacht
	name = "Yacht"
	move_time = 10
	shuttle_area = list(
		/area/yacht2,
		/area/yacht2/bridge,
		/area/yacht2/living1,
		/area/yacht2/living2,
		/area/yacht2/engine1,
		/area/yacht2/engine2,
		/area/yacht2/hallway,
		/area/yacht2/hallway/aft,
		/area/yacht2/kitchen,
		/area/yacht2/pool,
		/area/yacht2/engineering,
		/area/yacht2/engineering/power,
		/area/yacht2/library
	)
	current_location = "nav_yacht_start"
	range = 0 //range = 1
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	defer_initialisation = TRUE




/obj/effect/submap_landmark/joinable_submap/yacht
	name = "Luxury Yacht"
	archetype = /decl/submap_archetype/yacht

/decl/submap_archetype/yacht
	descriptor = "Luxury Yacht"
	map = "Luxury Yacht"
	crew_jobs = list(
		/datum/job/submap/yacht
	)

/datum/job/submap/yacht
	title = "Yacht Owner"
	total_positions = 2
	spawn_positions = 2
	supervisors = "your wealthy and your business."
	info = "You will probably go insane here, in LUXURY, Lonely, with all your money and gold things.<br>What do you want from this place?<br><center>Suffer?"
	outfit_type = /decl/hierarchy/outfit/yacht
	loadout_allowed = TRUE
	economic_power = 40
	whitelisted_species = list(SPECIES_HUMAN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA = SKILL_BASIC,
		SKILL_BUREAUCRACY = SKILL_TRAINED,
		SKILL_PILOTING = SKILL_BASIC,
		SKILL_FINANCE = SKILL_TRAINED
	)
	alt_titles = list(
		"Casino Owner",
		"Deputy Governor",
		"Individual Entrepreneur",
		"Investor",
		"Company Owner",
		"General Director",
		"Retired Officer",
		"Independent Observer")
	skill_points = 25
	allowed_branches = list(
		/datum/mil_branch/civilian,
		/datum/mil_branch/expeditionary_corps,
		/datum/mil_branch/fleet,
		/datum/mil_branch/solgov
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ,
		/datum/mil_rank/fleet/e7,
		/datum/mil_rank/fleet/e8,
		/datum/mil_rank/fleet/e9,
		/datum/mil_rank/fleet/o0,
		/datum/mil_rank/fleet/o1,
		/datum/mil_rank/fleet/o2,
		/datum/mil_rank/fleet/o3,
		/datum/mil_rank/fleet/o4,
		/datum/mil_rank/ec/e3,
		/datum/mil_rank/ec/e5,
		/datum/mil_rank/ec/e7,
		/datum/mil_rank/ec/o1,
		/datum/mil_rank/ec/o3,
		/datum/mil_rank/sol/gov,
		/datum/mil_rank/sol/duty_agent,
		/datum/mil_rank/sol/agent,
		/datum/mil_rank/sol/senior_agent,
		/datum/mil_rank/sol/inspector_agent,
		/datum/mil_rank/sol/curator_agent,
		/datum/mil_rank/sol/deputy_agent
	)

/decl/hierarchy/outfit/yacht
	name = OUTFIT_JOB_NAME("Yacht Owner")
	id_types = list(/obj/item/card/id/gold)
	gloves = /obj/item/clothing/gloves/white
	uniform = /obj/item/clothing/under/gentlesuit
	suit = /obj/item/clothing/suit/greatcoat
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	shoes = /obj/item/clothing/shoes/dress
	glasses = /obj/item/clothing/glasses/aviators_gold
	backpack_contents = list(/obj/item/device/flashlight/upgraded=1,/obj/item/device/radio/hailing=1,/obj/item/spacecash/bundle/c10000=1)

/obj/effect/submap_landmark/spawnpoint/yacht
	name = "Yacht Owner"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/item/spacecash/bundle/c10000
	name = "10000 Thaler"
	worth = 10000
