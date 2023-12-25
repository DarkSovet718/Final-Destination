//random room spawner. takes random rooms from their appropriate map file and places them. the room will spawn with the spawner in the bottom left corner
/obj/effect/spawner/room
	name = "random room spawner"
	icon = 'icons/fd/landmarks.dmi'
	icon_state = "closet-red"
	dir = NORTH
	var/datum/map_template/ruin/random_room/template
	var/room_width = 0
	var/room_height = 0
	var/room_type = "maintenance" // Used so we can place landmarks in ruins and such.

/obj/effect/spawner/room/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/spawner/room/LateInitialize()
	var/list/possibletemplates = list()
	var/datum/map_template/ruin/random_room/candidate = null
	for(var/ID in SSmapping.random_room_templates)
		candidate = SSmapping.random_room_templates[ID]
		if(istype(candidate, /datum/map_template/ruin/random_room) && (room_height == candidate.template_height) && (room_width == candidate.template_width) && (room_type == candidate.room_type))
			if(!candidate.spawned)
				possibletemplates[candidate] = candidate.weight
		candidate = null
	if(possibletemplates.len)
		template = pickweight(possibletemplates)
		template.stock --
		template.weight = (template.weight / 2)
		if(template.stock <= 0)
			template.spawned = TRUE
		addtimer(CALLBACK(src, /obj/effect/spawner/room.proc/LateSpawn), 300)
	else
		template = null
	if(!template)
		qdel(src)

/obj/effect/spawner/room/proc/LateSpawn()
	template.load(get_turf(src), centered = template.centerspawner)
	qdel(src)

/* Spawner landmarks */

/obj/effect/spawner/room/threexthree
	name = "3x3 room spawner"
	room_width = 3
	room_height = 3