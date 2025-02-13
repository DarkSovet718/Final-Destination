/datum/vehicle_interior
	var/id
	var/global/gid = 0

	//11 at max
	var/size_x = 0
	var/size_y = 0

	var/list/mob/living/carbon/human/occupants
	var/obj/effect/vehicle_entrance/entrance
	var/obj/vehicles/large/vehicle
	var/turf/middle_turf
	var/area/area

	var/global/list/datum/map_template/templates_cache = list()

/datum/vehicle_interior/New(datum/map_template/interior_template, new_vehicle)
	if(!(interior_template in templates_cache))
		templates_cache[interior_template] = new interior_template
		sleep(3)

	interior_template = templates_cache[interior_template]

	var/area/A = locate(/area/space)
	for(var/turf/T in A)
		var/valid = TRUE
		for(var/turf/check in interior_template.get_affected_turfs(T))
			if(!istype(check, /turf/space))
				valid = FALSE
				break
		if(valid)
			interior_template.load(T)
			middle_turf = locate(T.x + round(interior_template.width / 2), T.y + round(interior_template.height / 2), T.z)
			area = get_area(middle_turf)
			break
	if(!area)
		CRASH("Failed to load interior")
		return

	id = gid++

	for(var/obj/effect/vehicle_entrance/E in area)
		entrance = E
		entrance.id = id
		break

	for(var/obj/structure/vehicledoor/E in area)
		E.id = id
		E.interior = src

	vehicle = new_vehicle
	if(!vehicle)
		return

	GLOB.vehicle_interiors += src

/obj/effect/vehicle_entrance
	var/id

/obj/vehicles/large
	var/datum/vehicle_interior/interior = null
	var/size_x = 0
	var/size_y = 0
	var/datum/map_template/interior_template = /datum/map_template

/obj/vehicles/large/get_occupants_in_position()
	return ..() + list("passenger")

/obj/vehicles/large/Initialize()
	. = ..()
	interior = new(interior_template, src)

/obj/vehicles/large/proc/move_to_interior(atom/movable/user, puller)
	if(user == puller)
		visible_message(SPAN_NOTICE("[user] enters the interior of [src]."))
	else
		visible_message(SPAN_NOTICE("[puller] put [user] into interior of \the [src]."))
	to_chat(user, SPAN_NOTICE("You are now in the interior of [src]."))
	playsound(src, null, 150, 1, 5)

	if(!interior?.entrance)
		to_chat(user, SPAN_OCCULT("or not."))
		return

	user.forceMove(get_turf(interior.entrance))
	occupants[user] = "passenger"

	return TRUE

/obj/vehicles/large/enter_as_position(mob/user, position)
	if(position == "passenger")
		return move_to_interior(user)
	return ..()

/obj/structure/vehiclewall
	name = "vehicle wall"
	icon = 'icons/fd/halo_vehicles/walls.dmi'
	icon_state = "noborder"

	layer = ABOVE_HUMAN_LAYER

	density = TRUE
	opacity = TRUE
	anchored = TRUE
	breakable = FALSE

/obj/structure/vehicledoor
	name = "vehicle door"
	icon = 'icons/fd/halo_vehicles/walls.dmi'
	icon_state = "ambulancedoor"

	layer = ABOVE_HUMAN_LAYER

	density = TRUE
	opacity = TRUE
	anchored = TRUE

	var/id
	var/datum/vehicle_interior/interior = null

// ;(
/obj/structure/vehicledoor/Move()
	return

/obj/structure/vehicledoor/forceMove(atom/dest)
	return

/obj/structure/vehicledoor/attack_hand(mob/user)
	if(interior.vehicle.loc == null)
		to_chat(user, "\The [src] is locked.")
		return
	interior.vehicle.exit_vehicle(user)

/obj/structure/vehicledoor/MouseDrop_T(mob/target, mob/user)
	. = ..()
	if(ismob(target))
		interior.vehicle.exit_vehicle(target, ignore_incap_check = TRUE, puller = user)
	else
		target.forceMove(interior.vehicle.pick_valid_exit_loc())

/area/interior
	name = "interior"
	dynamic_lighting = TRUE

/area/interiors_spawn
	name = "interiors spawn"