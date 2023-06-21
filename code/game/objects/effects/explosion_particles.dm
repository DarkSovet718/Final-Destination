/obj/effect/expl_particles
	name = "explosive particles"
	icon = 'icons/effects/effects.dmi'
	icon_state = "explosion_particle"
	opacity = 1
	anchored = TRUE
	does_spin = FALSE
	mouse_opacity = 0

/obj/effect/expl_particles/New()
	..()
	QDEL_IN(src, 1 SECOND)

/datum/effect/system/expl_particles
	var/number = 10
	var/turf/location
	var/total_particles = 0

/datum/effect/system/expl_particles/proc/set_up(n = 10, loca)
	number = n
	if(istype(loca, /turf/)) location = loca
	else location = get_turf(loca)

/datum/effect/system/expl_particles/proc/start()
	var/i = 0
	for(i=0, i<src.number, i++)
		spawn(0)
			var/obj/effect/expl_particles/expl = new /obj/effect/expl_particles(src.location)
			expl.SetTransform(scale = 0.50)
			var/direct = pick(GLOB.alldirs)
			for(i=0, i<pick(1;25,2;50,3,4;200), i++)
				sleep(1)
				step(expl,direct)

/obj/effect/explosion
	name = "explosive particles"
	icon = 'icons/effects/explosion.dmi'
	icon_state = "explosion"
	opacity = 1
	anchored = TRUE
	does_spin = FALSE
	mouse_opacity = 0
	pixel_x = -18
	pixel_y = -15

/obj/effect/explosion/New()
	..()
	QDEL_IN(src, 1 SECOND)

/datum/effect/system/explosion
	var/power
	var/matric_size = 0
	var/turf/location

/datum/effect/system/explosion/proc/set_up(loca)
	if(istype(loca, /turf/)) location = loca
	else location = get_turf(loca)

/datum/effect/system/explosion/proc/start()
	var/obj/effect/explosion/boom = new/obj/effect/explosion( location )
	boom.SetTransform(scale = power/4)
	boom.set_light(1, power, power+2, 2, l_color = "#f18c47")
	var/datum/effect/system/expl_particles/P = new/datum/effect/system/expl_particles()
	P.set_up(10,location)
	P.start()
//	addtimer(CALLBACK(src, .proc/make_smoke), 5)

/*/datum/effect/system/explosion/proc/make_smoke()
	var/datum/effect/effect/system/smoke_spread/S = new/datum/effect/effect/system/smoke_spread()
	S.set_up(5,0,location,null)
	S.start()*/