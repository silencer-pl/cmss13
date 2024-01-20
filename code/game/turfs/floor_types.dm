



//Floors

/turf/open/floor/plating
	name = "plating"
	icon_state = "plating"
	intact_tile = FALSE
	tool_flags = NO_FLAGS

/turf/open/floor/plating/is_plating()
	return TRUE

/turf/open/floor/plating/is_plasteel_floor()
	return FALSE

/turf/open/floor/plating/is_light_floor()
	return FALSE

/turf/open/floor/plating/is_grass_floor()
	return FALSE

/turf/open/floor/plating/is_wood_floor()
	return FALSE

/turf/open/floor/plating/is_carpet_floor()
	return FALSE


/turf/open/floor/plating/attackby(obj/item/C, mob/user)
	if(istypestrict(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		if(R.get_amount() < 2)
			to_chat(user, SPAN_WARNING("You need more rods."))
			return
		to_chat(user, SPAN_NOTICE("You start reinforcing the floor."))
		var/current_type = type
		if(do_after(user, 30 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD) && current_type == type)
			if(!R)
				return
			if(R.use(2))
				ChangeTurf(/turf/open/floor/engine)
				playsound(src, 'sound/items/Deconstruct.ogg', 25, 1)
		return
	if(istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = C
		coil.turf_place(src, user)
		return
	if(iswelder(C))
		if(!HAS_TRAIT(C, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("You need a stronger blowtorch!"))
			return
		var/obj/item/tool/weldingtool/welder = C
		if(welder.isOn() && (broken || burnt))
			if(welder.remove_fuel(0, user))
				to_chat(user, SPAN_WARNING("You fix some dents on the broken plating."))
				playsound(src, 'sound/items/Welder.ogg', 25, 1)
				icon_state = "plating"
				burnt = FALSE
				broken = FALSE
			else
				to_chat(user, SPAN_WARNING("You need more welding fuel to complete this task."))
		return
	if(istype(C, /obj/item/stack/tile))
		if(broken || burnt)
			to_chat(user, SPAN_NOTICE("This section is too damaged to support a tile. Use a welder to fix the damage."))
			return
		var/obj/item/stack/tile/T = C
		if(T.get_amount() < 1)
			return
		playsound(src, 'sound/weapons/Genhit.ogg', 25, 1)
		T.use(1)
		T.build(src)
		return
	if(istype(C, /obj/item/stack/catwalk))
		if(broken || burnt)
			to_chat(user, SPAN_NOTICE("This section is too damaged to support a catwalk. Use a welder to fix the damage."))
			return
		var/obj/item/stack/catwalk/T = C
		if(T.get_amount() < 1)
			return
		playsound(src, 'sound/weapons/Genhit.ogg', 25, 1)
		T.use(1)
		T.build(src)
		return
	return ..()

/turf/open/floor/plating/make_plating()
	return

/turf/open/floor/plating/prison
	icon = 'icons/turf/floors/prison.dmi'

/turf/open/floor/plating/almayer
	icon = 'icons/turf/almayer.dmi'

/turf/open/floor/plating/airless
	icon_state = "plating"
	name = "airless plating"

/turf/open/floor/plating/airless/Initialize(mapload, ...)
	. = ..()
	name = "plating"

/turf/open/floor/plating/icefloor
	icon_state = "plating"
	name = "ice colony plating"

/turf/open/floor/plating/icefloor/Initialize(mapload, ...)
	. = ..()
	name = "plating"

/// Visually like plating+catwalks but without overlaying or interactions - mainly for Reqs Elevator
/turf/open/floor/plating/bare_catwalk
	name = "catwalk"
	desc = "Cats really don't like these things."
	icon = 'icons/turf/almayer.dmi'
	icon_state = "plating_catwalk"

/turf/open/floor/plating/plating_catwalk
	name = "catwalk"
	desc = "Cats really don't like these things."
	icon = 'icons/turf/almayer.dmi'
	icon_state = "plating_catwalk"
	var/base_state = "plating" //Post mapping
	var/covered = TRUE

/turf/open/floor/plating/plating_catwalk/Initialize(mapload, ...)
	. = ..()

	icon_state = base_state
	update_icon()

/turf/open/floor/plating/plating_catwalk/update_icon()
	. = ..()
	if(covered)
		overlays += image(icon, src, "catwalk", CATWALK_LAYER)

/turf/open/floor/plating/plating_catwalk/attackby(obj/item/W as obj, mob/user as mob)
	if (HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		if(covered)
			var/obj/item/stack/catwalk/R = new(src, 1, type)
			R.add_to_stacks(usr)
			covered = FALSE
			to_chat(user, SPAN_WARNING("You remove the top of the catwalk."))
			playsound(src, 'sound/items/Crowbar.ogg', 25, 1)
			update_icon()
			return
	if(istype(W, /obj/item/stack/catwalk))
		if(!covered)
			var/obj/item/stack/catwalk/E = W
			E.use(1)
			covered = TRUE
			to_chat(user, SPAN_WARNING("You replace the top of the catwalk."))
			playsound(src, 'sound/items/Crowbar.ogg', 25, 1)
			update_icon()
			return
	return ..()

/turf/open/floor/plating/plating_catwalk/break_tile()
	if(covered)
		covered = 0
		update_icon()
	..()

/turf/open/floor/plating/plating_catwalk/break_tile_to_plating()
	if(covered)
		covered = 0
		update_icon()
	..()

/turf/open/floor/plating/plating_catwalk/prison
	icon = 'icons/turf/floors/prison.dmi'

/turf/open/floor/plating/plating_catwalk/strata
	icon = 'icons/turf/floors/strata_floor.dmi'

/turf/open/floor/plating/plating_catwalk/shiva
	icon = 'icons/turf/floors/ice_colony/shiva_floor.dmi'



/turf/open/floor/plating/ironsand
	name = "Iron Sand"

/turf/open/floor/plating/ironsand/Initialize(mapload, ...)
	. = ..()
	icon_state = "ironsand[rand(1,15)]"



/turf/open/floor/plating/catwalk
	icon = 'icons/turf/floors/catwalks.dmi'
	icon_state = "catwalk0"
	name = "catwalk"
	desc = "Cats really don't like these things."


/turf/open/floor/almayer
	icon = 'icons/turf/almayer.dmi'
	icon_state = "default"
	plating_type = /turf/open/floor/plating/almayer

/// Admin level thunderdome floor. Doesn't get damaged by explosions and such for pristine testing
/turf/open/floor/tdome
	icon = 'icons/turf/almayer.dmi'
	icon_state = "plating"
	plating_type = /turf/open/floor/tdome
	hull_floor = TRUE

//Cargo elevator
/turf/open/floor/almayer/empty
	name = "empty space"
	desc = "There seems to be an awful lot of machinery down below"
	icon = 'icons/turf/floors/floors.dmi'
	icon_state = "black"

/turf/open/floor/almayer/empty/Initialize(mapload, ...)
	. = ..()
	GLOB.asrs_empty_space_tiles_list += src

/turf/open/floor/almayer/empty/Destroy(force) // may as well
	. = ..()
	GLOB.asrs_empty_space_tiles_list -= src

/turf/open/floor/almayer/empty/is_weedable()
	return NOT_WEEDABLE

/turf/open/floor/almayer/empty/ex_act(severity) //Should make it indestructible
	return

/turf/open/floor/almayer/empty/fire_act(exposed_temperature, exposed_volume)
	return

/turf/open/floor/almayer/empty/attackby() //This should fix everything else. No cables, etc
	return

/turf/open/floor/almayer/empty/Entered(atom/movable/AM)
	..()
	if(!isobserver(AM))
		addtimer(CALLBACK(src, PROC_REF(enter_depths), AM), 0.2 SECONDS)

/turf/open/floor/almayer/empty/proc/enter_depths(atom/movable/AM)
	if(AM.throwing == 0 && istype(get_turf(AM), /turf/open/floor/almayer/empty))
		AM.visible_message(SPAN_WARNING("[AM] falls into the depths!"), SPAN_WARNING("You fall into the depths!"))
		if(!ishuman(AM))
			qdel(AM)
			return
		var/mob/living/carbon/human/thrown_human = AM
		for(var/atom/computer as anything in GLOB.supply_controller.bound_supply_computer_list)
			computer.balloon_alert_to_viewers("you hear horrifying noises coming from the elevator!")

		var/area/area_shuttle = GLOB.supply_controller.shuttle?.get_location_area()
		if(!area_shuttle)
			return
		var/list/turflist = list()
		for(var/turf/turf in area_shuttle)
			turflist |= turf

		thrown_human.forceMove(pick(turflist))

		var/timer = 0.5 SECONDS
		for(var/index in 1 to 10)
			timer += 0.5 SECONDS
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(maul_human), thrown_human), timer)
		return

	else
		for(var/obj/effect/decal/cleanable/C in contents) //for the off chance of someone bleeding mid=flight
			qdel(C)

//Others
/turf/open/floor/almayer/uscm
	icon_state = "logo_c"
	name = "\improper USCM Logo"

/turf/open/floor/almayer/uscm/directional
	icon_state = "logo_directional"

/turf/open/floor/almayer/no_build
	allow_construction = FALSE
	hull_floor = TRUE

// RESEARCH STUFF
/turf/open/floor/almayer/research/containment/entrance
	icon_state = "containment_entrance"

/turf/open/floor/almayer/research/containment/floor1
	icon_state = "containment_floor_1"

/turf/open/floor/almayer/research/containment/floor2
	icon_state = "containment_floor_2"

/turf/open/floor/almayer/research/containment/corner
	icon_state = "containment_corner"

/turf/open/floor/almayer/research/containment/corner1
	icon_state = "containment_corner_1"

/turf/open/floor/almayer/research/containment/corner2
	icon_state = "containment_corner_2"

/turf/open/floor/almayer/research/containment/corner3
	icon_state = "containment_corner_3"

/turf/open/floor/almayer/research/containment/corner4
	icon_state = "containment_corner_4"

/turf/open/floor/almayer/research/containment/corner_var1
	icon_state = "containment_corner_variant_1"

/turf/open/floor/almayer/research/containment/corner_var2
	icon_state = "containment_corner_variant_2"






//Outerhull

/turf/open/floor/almayer_hull
	icon = 'icons/turf/almayer.dmi'
	icon_state = "outerhull"
	name = "hull"
	hull_floor = TRUE








//////////////////////////////////////////////////////////////////////





/turf/open/floor/airless
	icon_state = "floor"
	name = "airless floor"

/turf/open/floor/airless/Initialize(mapload, ...)
	. = ..()
	name = "floor"

/turf/open/floor/icefloor
	icon_state = "floor"
	name = "ice colony floor"
	plating_type = /turf/open/floor/plating/icefloor

/turf/open/floor/icefloor/Initialize(mapload, ...)
	. = ..()
	name = "floor"

/turf/open/floor/wood
	name = "wooden floor"
	icon_state = "wood"
	tile_type = /obj/item/stack/tile/wood
	tool_flags = BREAK_CROWBAR|REMOVE_SCREWDRIVER

/turf/open/floor/wood/is_wood_floor()
	return TRUE

/turf/open/floor/wood/ship
	name = "fake wooden floor"
	desc = "This metal floor has been painted to look like one made of wood. Unfortunately, wood and high-pressure internal atmosphere don't mix well. Wood is a major fire hazard don't'cha know."
	tile_type = /obj/item/stack/tile/wood/fake

/turf/open/floor/vault
	icon_state = "rockvault"

/turf/open/floor/vault/Initialize(mapload, type)
	. = ..()
	icon_state = "[type]vault"



/turf/open/floor/engine
	name = "reinforced floor"
	icon_state = "engine"
	intact_tile = 0
	breakable_tile = FALSE
	burnable_tile = FALSE
	baseturfs = /turf/open/floor

/turf/open/floor/engine/make_plating()
	return

/turf/open/floor/engine/attackby(obj/item/C as obj, mob/user as mob)
	if(!C)
		return
	if(!user)
		return
	if(HAS_TRAIT(C, TRAIT_TOOL_WRENCH))
		user.visible_message(SPAN_NOTICE("[user] starts removing [src]'s protective cover."),
		SPAN_NOTICE("You start removing [src]'s protective cover."))
		playsound(src, 'sound/items/Ratchet.ogg', 25, 1)
		if(do_after(user, 30 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			new /obj/item/stack/rods(src, 2)
			var/turf/open/floor/F = ScrapeAway()
			if(istype(/turf/open/floor, F))
				F.make_plating()


/turf/open/floor/engine/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(25))
				break_tile_to_plating()
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			break_tile_to_plating()


/turf/open/floor/engine/nitrogen

/turf/open/floor/engine/cult
	name = "engraved floor"
	icon_state = "cult"


/turf/open/floor/engine/vacuum
	name = "vacuum floor"
	icon_state = "engine"


/turf/open/floor/engine/mars/exterior
	name = "floor"
	icon_state = "ironsand1"





/turf/open/floor/bluegrid
	icon = 'icons/turf/floors/floors.dmi'
	icon_state = "bcircuit"

/turf/open/floor/greengrid
	icon = 'icons/turf/floors/floors.dmi'
	icon_state = "gcircuit"


/turf/open/floor/grass
	name = "grass patch"
	icon_state = "grass1"
	tile_type = /obj/item/stack/tile/grass
	tool_flags = null

/turf/open/floor/grass/Initialize(mapload, ...)
	. = ..()
	icon_state = "grass[pick("1","2","3","4")]"
	update_icon()
	return INITIALIZE_HINT_LATELOAD

/turf/open/floor/grass/LateInitialize()
	. = ..()
	for(var/direction in GLOB.cardinals)
		if(istype(get_step(src,direction),/turf/open/floor))
			var/turf/open/floor/FF = get_step(src,direction)
			FF.update_icon() //so siding get updated properly

/turf/open/floor/grass/is_grass_floor()
	return TRUE

/turf/open/floor/grass/update_icon()
	. = ..()
	if(!broken && !burnt)
		if(!(icon_state in list("grass1", "grass2", "grass3", "grass4")))
			icon_state = "grass[pick("1", "2", "3", "4")]"

/turf/open/floor/grass/make_plating()
	return

/turf/open/floor/carpet
	name = "carpet"
	icon_state = "carpet"
	tile_type = /obj/item/stack/tile/carpet
	tool_flags = REMOVE_SCREWDRIVER

/turf/open/floor/carpet/Initialize(mapload, ...)
	. = ..()
	if(!icon_state)
		icon_state = "carpet"
	return INITIALIZE_HINT_LATELOAD

/turf/open/floor/carpet/LateInitialize()
	. = ..()
	update_icon()
	for(var/direction in list(1,2,4,8,5,6,9,10))
		if(istype(get_step(src,direction),/turf/open/floor))
			var/turf/open/floor/FF = get_step(src,direction)
			FF.update_icon() //so siding get updated properly

/turf/open/floor/carpet/is_carpet_floor()
	return TRUE

/turf/open/floor/carpet/update_icon()
	. = ..()
	if(!broken && !burnt)
		if(icon_state != "carpetsymbol")
			var/connectdir = 0
			for(var/direction in GLOB.cardinals)
				if(istype(get_step(src, direction), /turf/open/floor))
					var/turf/open/floor/FF = get_step(src, direction)
					if(FF.is_carpet_floor())
						connectdir |= direction

			//Check the diagonal connections for corners, where you have, for example, connections both north and east
			//In this case it checks for a north-east connection to determine whether to add a corner marker or not.
			var/diagonalconnect = 0 //1 = NE; 2 = SE; 4 = NW; 8 = SW

			//Northeast
			if(connectdir & NORTH && connectdir & EAST)
				if(istype(get_step(src,NORTHEAST),/turf/open/floor))
					var/turf/open/floor/FF = get_step(src,NORTHEAST)
					if(FF.is_carpet_floor())
						diagonalconnect |= 1

			//Southeast
			if(connectdir & SOUTH && connectdir & EAST)
				if(istype(get_step(src,SOUTHEAST),/turf/open/floor))
					var/turf/open/floor/FF = get_step(src,SOUTHEAST)
					if(FF.is_carpet_floor())
						diagonalconnect |= 2

			//Northwest
			if(connectdir & NORTH && connectdir & WEST)
				if(istype(get_step(src,NORTHWEST),/turf/open/floor))
					var/turf/open/floor/FF = get_step(src,NORTHWEST)
					if(FF.is_carpet_floor())
						diagonalconnect |= 4

			//Southwest
			if(connectdir & SOUTH && connectdir & WEST)
				if(istype(get_step(src,SOUTHWEST),/turf/open/floor))
					var/turf/open/floor/FF = get_step(src,SOUTHWEST)
					if(FF.is_carpet_floor())
						diagonalconnect |= 8

			icon_state = "carpet[connectdir]-[diagonalconnect]"

/turf/open/floor/carpet/make_plating()
	for(var/direction in GLOB.alldirs)
		if(istype(get_step(src, direction), /turf/open/floor))
			var/turf/open/floor/FF = get_step(src,direction)
			FF.update_icon() // So siding get updated properly
	return ..()

/turf/open/floor/carpet/edge
	icon_state = "carpetside"

// Start Prison tiles

/turf/open/floor/prison
	icon = 'icons/turf/floors/prison.dmi'
	icon_state = "floor"
	plating_type = /turf/open/floor/plating/prison

/turf/open/floor/prison/trim/red
	icon_state = "darkred2"

/turf/open/floor/prison/chapel_carpet
	icon = 'icons/turf/floors/carpet_manual.dmi'//I dunno man, CM-ified carpet sprites are placed manually and I can't be bothered to write a new system for 'em.
	icon_state = "single"

// Mechbay
/turf/open/floor/mech_bay_recharge_floor
	name = "Mech Bay Recharge Station"
	icon = 'icons/obj/structures/props/mech.dmi'
	icon_state = "recharge_floor"

/turf/open/floor/mech_bay_recharge_floor/break_tile()
	if(broken)
		return
	ChangeTurf(/turf/open/floor/plating)
	broken = TRUE


/turf/open/floor/interior
	icon = 'icons/turf/floors/interior.dmi'

/turf/open/floor/interior/wood
	name = "wooden floor"
	icon_state = "oldwood1"
	tile_type = /obj/item/stack/tile/wood

/turf/open/floor/interior/wood/is_wood_floor()
	return TRUE

/turf/open/floor/interior/wood/alt
	icon_state = "oldwood2"

/turf/open/floor/interior/tatami
	name = "tatami flooring"
	desc = "A type of flooring often used in traditional Japanese-style housing."
	icon_state = "tatami"

/turf/open/floor/interior/plastic
	name = "plastic floor"
	icon_state = "plasticfloor1"

/turf/open/floor/interior/plastic/alt
	icon_state = "plasticfloor2"

// Biodome tiles

/turf/open/floor/corsat
	icon = 'icons/turf/floors/corsat.dmi'
	icon_state = "plating"

//Sector Patrol. Also fixing tiling. Just kill me.

/turf/open/floor/plating/modular

	name = "UACM standarized interior plating"
	desc = "Metal plates attached to the hull, with small, predrilled holes doting their surface."
	desc_lore = "This special plating is typically permanently installed on ship hull floors meant for private or recreational locations. They come with small holes predrilled in preset, standardized distances that allow for the installation of modular tile struts, which in turn are used with the UACM standardized tiling system to add some color to private quarters of UACM personnel. The tiles themselves are printed in the PST's fabrication wings at minimal material cost. The drawback here is the amount of manual labor required to put these together and the fact that, some Marines argue at least, the UACM lacks any sense of style. Most agree that the jury is still out on that last one."
	icon = 'icons/obj/items/floortiles.dmi'
	icon_state = "plating"
	intact_tile = FALSE
	tool_flags = NO_FLAGS
	var/struts_install = 0
	var/struts_ready = 0
	var/tiles_install = 0

/turf/open/floor/plating/modular/attackby(obj/item/C, mob/user)
	if(iswelder(C))
		if(!HAS_TRAIT(C, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("You need a stronger blowtorch!"))
			return
		var/obj/item/tool/weldingtool/welder = C
		if(welder.isOn() && broken == 1)
			if(welder.remove_fuel(1, user))
				playsound(src, 'sound/items/Welder.ogg', 25, 1)
				if(struts_install > 0)
					user.visible_message(SPAN_NOTICE("[user] starts to fix the struts and plating."), SPAN_INFO("You start fixing the struts and plating." ), SPAN_DANGER("You hear a hissing that gets distinctly louder for short intervals."))
					if(do_after(user, (40 + (15 * struts_install)) * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
						user.visible_message(SPAN_NOTICE("[user] fixes the struts and plating."), SPAN_INFO("You fix the struts and plating." ), SPAN_DANGER("The hissing stops."))
						icon_state = "[initial(icon_state)]_s[struts_install]"
						name = "[initial(name)] and modular struts"
						desc = "[initial(desc)] At least one metal strut has been placed and matched to the openings on the plating, ready to be attached to the platform."
						desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence."
						broken = FALSE
						burnt = FALSE
						return
				if(struts_install == 0)
					user.visible_message(SPAN_NOTICE("[user] starts to fix the plating."), SPAN_INFO("You start fixing the plating." ), SPAN_DANGER("You hear a hissing that gets distinctly louder for short intervals."))
					if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
						user.visible_message(SPAN_NOTICE("[user] fixes the plating."), SPAN_INFO("You fix the plating." ), SPAN_DANGER("The hissing stops."))
						icon_state = initial(icon_state)
						desc = initial(desc)
						desc_lore = initial(desc_lore)
						broken = FALSE
						burnt = FALSE
						return
			else
				to_chat(user, SPAN_WARNING("You need more welding fuel to complete this task."))
		to_chat(user, SPAN_NOTICE("There does not seem to be a way to put these two together at the moment."))
		return
	if(istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = C
		coil.turf_place(src, user)
		return
	if(istype(C, /obj/item/stack/modulartiles))
		var/obj/item/stack/modulartiles/T = C
		if(T.get_amount() < 1)
			return
		if(tiles_install >= 4)
			return
		if(broken)
			to_chat(user, SPAN_NOTICE("There is too much damage to continue installing the tiles. Use a welder to fix the damage."))
			return
		if(burnt)
			to_chat(user, SPAN_NOTICE("There is too much damage to continue installing the tiles. Use a screwdriver to start cleaning it."))
			return
		if(struts_ready < 4)
			to_chat(user, SPAN_NOTICE("To avoid damage and make sure they are even, you should finish installing four struts on the panel before you start attaching tiles."))
			return
		if(tiles_install < 4)
			if(tiles_install == 0)
				name = "Partially finished floor tiling"
				desc = "Four metal struts attached to holes on the floor plating with some modular floor tiles already slotted into the struts. "
				desc_lore = "These modular tiles are typically attached onto special plating that is typically permanently installed on ship hull floors meant for private or recreational locations. The plating comes with small holes predrilled in preset, standardized distances that allow for the installation of modular tile struts, which in turn are used with the UACM standardized tiling system to add some color to private quarters of UACM personnel. The tiles and struts that hold them are themselves are printed in the PST's fabrication wings at minimal material cost. "
			user.visible_message(SPAN_NOTICE("[user] starts snapping panels onto struts."), SPAN_INFO("You start to snap panels onto struts."),SPAN_INFO("You hear a series of oddly satisfying clicks."))
			while(tiles_install < 4)
				T.use(1)
				tiles_install += 1
				if(tiles_install == 4)
					icon_state = "[T.tile_icon]"
					update_icon()
					name = "modular floor tiling"
					desc = "Four NRPS compliant modular tiles snapped to struts attached to special plating attached to the hull. A Northern Republic classic. "
					desc_lore = "These modular tiles are typically attached onto special plating that is typically permanently installed on ship hull floors meant for private or recreational locations. The plating comes with small holes predrilled in preset, standardized distances that allow for the installation of modular tile struts, which in turn are used with the UACM standardized tiling system to add some color to private quarters of UACM personnel. The tiles and struts that hold them are themselves are printed in the PST's fabrication wings at minimal material cost. "
				else
					icon_state = "[T.tile_icon][tiles_install]"
					update_icon()
					sleep(3)
			user.visible_message(SPAN_NOTICE("[user] finishes attaching floor tiles to struts."), SPAN_INFO("You finish snapping the pannels to the struts."),SPAN_INFO("The clicks stop."))
			return
		to_chat(user, SPAN_NOTICE("There does not seem to be a way to put these two together at the moment."))
		return

	if(istype(C, /obj/item/stack/rods/floorstrut))
		if(broken)
			to_chat(user, SPAN_NOTICE("There is too much damage to continue installing the struts. Use a welder to fix the damage."))
			return
		if(burnt)
			to_chat(user, SPAN_NOTICE("There is too much damage to continue installing the struts. Use a screwdriver to start cleaning it."))
			return
		if(struts_install < 4)
			var/obj/item/stack/rods/floorstrut/F = C
			if(F.get_amount() < 1)
				return
			user.visible_message(SPAN_NOTICE("[user] starts laying out and aligning struts on the floor."), SPAN_INFO("You start putting the struts down and aligning them with the holes in the plating." ), SPAN_DANGER("You hear a shuffling."))
			if(struts_install == 0)
				name = "[initial(name)] and modular struts"
				desc = "[initial(desc)] At least one metal strut has been placed and matched to the openings on the plating, ready to be attached to the platform."
				desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence."
			while(struts_install < 4)
				if(do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					F.use(1)
					struts_install += 1
					icon_state = "[initial(icon_state)]_s[struts_install]"
					update_icon()
			user.visible_message(SPAN_NOTICE("[user] finishes setting a strut."), SPAN_INFO("You align a strut and its screws with one of the rows of predrilled holes. It's ready to be fastened."))
			return
		if(struts_install >= 4)
			to_chat(usr, SPAN_WARNING("All predrilled openings already have a strut on them."))
			return
		to_chat(user, SPAN_NOTICE("There does not seem to be a way to put these two together at the moment."))
		return

	if(HAS_TRAIT(C, TRAIT_TOOL_SCREWDRIVER))
		if(broken)
			to_chat(user, SPAN_NOTICE("There is too much damage to continue installing the struts. Use a welder to fix the damage."))
			return
		if(burnt)
			user.visible_message(SPAN_NOTICE("[user] starts to unscrew and clean the struts and plating."), SPAN_INFO("You start to unscrew and clean the struts and plating.."), SPAN_DANGER("You hear a very faint scraping noise."))
			if(do_after(user, (40 + (15 * struts_ready)) * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				user.visible_message(SPAN_NOTICE("[user] fixes the struts and plating."), SPAN_INFO("You fix the struts and plating." ), SPAN_DANGER("The scraping stops."))
				if(struts_install)
					icon_state = "[initial(icon_state)]_s[struts_ready]"
					update_icon()
					name = "[initial(name)] and modular struts"
					desc = "[initial(desc)] At least one metal strut has been placed and matched to the openings on the plating, ready to be attached to the platform."
					desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence."
					broken = FALSE
					burnt = FALSE
				return
		if (user.a_intent == INTENT_GRAB)
			if  (struts_ready > 0)
				user.visible_message(SPAN_NOTICE("[user] uses a screwdriver on the plating struts."), SPAN_INFO("You start to unscrew the strut."))
				while(struts_ready > 0)
					if(do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION),INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
						sleep(2)
						if(do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION),INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
							struts_ready -= 1
				user.visible_message(SPAN_NOTICE("[user] finishes working on the plating."), SPAN_INFO("You finished unfasting all of the struts." ))
			if (struts_ready == 0)
				to_chat(user, SPAN_NOTICE("All the struts are already unfastened."))
				return
		if (user.a_intent == INTENT_HELP)
			if (struts_install == 0)
				to_chat(user, SPAN_NOTICE("There is noting for you to screw in. Place a strut first."))
				return
			if (struts_install == struts_ready)
				if (struts_ready < 4)
					to_chat(user, SPAN_NOTICE("There is noting more for you to screw in. Place anoter strut first."))
					return
				if (struts_ready >= 4)
					to_chat(user, SPAN_NOTICE("All the struts are in place and secured. There is nothing else to screw in."))
					return
			if (struts_install > struts_ready)
				user.visible_message(SPAN_NOTICE("[user] uses a screwdriver on a strut on the paneling."), SPAN_INFO("You start to secure the strut."))
				while (struts_install > struts_ready)
					if(do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
						sleep(2)
						if(do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
							struts_ready += 1
				user.visible_message(SPAN_NOTICE("[user] finishes working on the plating."), SPAN_INFO("You fasten all available struts." ))
				return
		to_chat(user, SPAN_NOTICE("There does not seem to be a way to put these two together at the moment."))
		return

	if(HAS_TRAIT(C, TRAIT_TOOL_CROWBAR))
		if (user.a_intent == INTENT_GRAB)
			if(tiles_install > 0 && tiles_install <= 4)
				user.visible_message(SPAN_NOTICE("[user] starts to detach floor tiles from their struts. They make an audible, disticnt pop."), SPAN_INFO("You start detaching tiles. They make an audible, distinct pop."), SPAN_DANGER("You hear disticnt, quiet popping."))
				while (tiles_install > 0)
					tiles_install -= 1
					var/obj/item/stack/modulartiles/R = new(src, 1, /obj/item/stack/modulartiles)
					R.add_to_stacks(usr)
					sleep(2)
				user.visible_message(SPAN_NOTICE("[user] finishes detaching the tiles."), SPAN_INFO("You finish detaching the tiles."), SPAN_DANGER("The popping stops."))
				return
			if (tiles_install == 0)
				to_chat(usr, SPAN_INFO("There are no tiles to remove."))
				return
		to_chat(user, SPAN_NOTICE("There does not seem to be a way to put these two together at the moment."))
		return



/turf/open/floor/plating/modular/break_tile_to_plating()
	if (!broken)
		struts_install = initial(struts_install)
		struts_ready = initial(struts_ready)
		tiles_install = initial(tiles_install)
		icon_state = "platingdmg[pick(1, 3)]"
		name = "heavilly damaged [initial(name)]"
		desc = "[initial(desc)] ]It's heavily damaged and in need of repairs. The attached struts are mangled beyond repair."
		desc_lore = "[initial(desc_lore)] Physical damage on plating like this is best removed using a welder. Modular struts that attach tiles to the ground are not particularly explosion resistant, so they get damaged easily, requiring complete replacements. This fact is not seen as a flow by the Northern Republic that maintains the standard, as they argue explosions should not be an occurrence in areas where these tiles are used unless something is very wrong."
		broken = 1
	return

/turf/open/floor/plating/modular/break_tile()
	if (!broken && !burnt)
		tiles_install = 0
		if (struts_ready == 0)
			icon_state = "platingdmg2"
			name = "damaged [initial(name)]"
			desc = "[initial(desc)] It's damaged and in need of repairs."
			desc_lore = "[initial(desc_lore)] Physical damage on plating like this is best removed using a welder. Somehow the struts on this panel survived whatever blew off the tiles, but typically they are not particularly explosion resistant, so they get damaged easily, requiring complete replacements. This fact is not seen as a flow by the Northern Republic that maintains the standard, as they argue explosions should not be an occurrence in areas where these tiles are used unless something is very wrong."
		if (struts_ready > 0)
			icon_state = "[initial(icon_state)]_s[struts_ready]"
			name = "damaged [initial(name)] and modular struts"
			desc = "[initial(desc)] At least one metal strut has been placed and matched to the openings on the plating, ready to be attached to the platform. The plating and struts are badly damaged and will need repairs."
			desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence. Physical damage on plating like this is best removed using a welder. Somehow the struts on this panel survived whatever blew off the tiles, but typically they are not particularly explosion resistant, so they get damaged easily, requiring complete replacements. This fact is not seen as a flow by the Northern Republic that maintains the standard, as they argue explosions should not be an occurrence in areas where these tiles are used unless something is very wrong."
		broken = 1
	return

/turf/open/floor/plating/modular/burn_tile()
	if (!broken && !burnt)
		tiles_install = 0
		if (struts_ready == 0)
			icon_state = "panelscorched"
			name = "burnt [initial(name)]"
			desc = "[initial(desc)] It looks badly burnt and will need to be cleaned before use."
			desc_lore = "[initial(desc_lore)] The tiles following the Northern Republic standard will by design burn off as fast as possible while generating as little heat and smoke as possible. This typically is enough to save the struts that hold them in place, all they need is a little cleaning that will require you to loosen their bolts with a screwdriver first."
		if (struts_ready > 0)
			icon_state = "[initial(icon_state)]_s[struts_ready]"
			name = "burnt [initial(name)] and modular struts"
			desc = "[initial(desc)] At least one metal strut has been placed and matched to the openings on the plating, ready to be attached to the platform. It looks badly burnt and will need to be cleaned before use."
			desc_lore = "[initial(desc_lore)] The struts, screws and other elements that can be attached to the plating are all in compliance with the Northern Republic Production Standard, guaranteeing compatibility with almost any human ship in existence. The tiles following the Northern Republic standard will by design burn off as fast as possible while generating as little heat and smoke as possible. This typically is enough to save the struts that hold them in place, all they need is a little cleaning that will require you to loosen their bolts with a screwdriver first."
		burnt = 1
	return

