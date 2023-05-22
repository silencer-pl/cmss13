/obj/structure/machinery/door/proc/checkForMultipleDoors()
	if(!src.loc)
		return 0
	for(var/obj/structure/machinery/door/D in src.loc)
		if(!istype(D, /obj/structure/machinery/door/window) && D.density)
			return 0
	return 1

/turf/closed/wall/proc/checkForMultipleDoors()
	if(!src.loc)
		return 0
	for(var/obj/structure/machinery/door/D in locate(src.x,src.y,src.z))
		if(!istype(D, /obj/structure/machinery/door/window) && D.density)
			return 0
	//There are no false wall checks because that would be fucking retarded
	return 1