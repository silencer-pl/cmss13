/obj/structure/surface/modular/table
	name = "table"
	icon = 'icons/obj/items/sp_crafting.dmi'
	icon_state = "table_metal_black"
	desc = "A tabletop attached to a frame with a set of screws. The top is made to look like wood, but on closer inspection is clearly artificial. Can be used to put things on top of, believe it or not."
	desc_lore = "Tables are, well, tables. Any time a human and sometimes non-human needs a place to put things, point at things, nap, sleep, drink, eat on, eat off, hit in anger, throw at enemies, play cards on and many, many, MANY other uses, tables are the devices of choice. Out in space, tables are used as often and in as many applications as they are back on Earth and will likely continue doing so in the foreseeable future. "
	var/variant_id = "default"
	anchored = 1

/obj/structure/surface/modular/table/attackby(obj/item/C, mob/user)

	if(HAS_TRAIT(C, TRAIT_TOOL_WRENCH))
		if(user.a_intent == INTENT_GRAB)
			user.visible_message(SPAN_NOTICE("[user] loosens the screws attaching the table top to its frame."), SPAN_INFO("You loosen the screws attaching the table top to its frame."), SPAN_DANGER("You hear metal scratch against metal."))
			if(do_after(user, (30 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				var/obj/structure/crafting/frame/table/frame = new(get_turf(src))
				frame.icon_state = icon_state
				frame.variant_id = variant_id
				frame.crafting_top_ready = TRUE
				qdel(src)
				return
	..()


/obj/structure/surface/modular/table/gray
	icon_state = "table_metal_gray"
	variant_id = "gray"

/obj/structure/bed/modular/
	name = "bed"
	desc = "A metal frame supporting an expanding foam mattress and a pillow."
	desc_lore = "Beds, like chairs, tend to be one of the most customized items on board human spaceships. From decorative arts to whole customized frames and patterned mattress covers, to hand woven, non-replicated bedsheets. Personal space can be a signifier of status and most out in the galaxy start with their bed itself."
	icon = 'icons/obj/items/sp_crafting.dmi'
	var/crafting_bed_bedsheet_id = "default"
	var/variant_id = "default"

/obj/structure/bed/modular/attackby(obj/item/C, mob/user)

	if(HAS_TRAIT(C, TRAIT_TOOL_MULTITOOL))
		if(user.a_intent == INTENT_GRAB)
			user.visible_message(SPAN_NOTICE("[user] Attaches the multitool to the port on the side of the mattress. The device beeps."), SPAN_INFO("You attach the multitool to the port on the side of the mattress. The device beeps."), SPAN_DANGER("You hear a soft beep."))
			if(do_after(user, (50 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				var/obj/structure/crafting/frame/bed/frame = new(get_turf(src))
				frame.icon_state = icon_state
				frame.variant_id = variant_id
				var/obj/item/crafting/top/bed/top = new(get_turf(src))
				top.icon_state = crafting_bed_bedsheet_id
				top.variant_id = crafting_bed_bedsheet_id
				qdel(src)
				return
	else
		. = ..()

/obj/structure/bed/modular/verb/rotate_pillow()
	set category = "Object"
	set name = "Rotate Pillow"
	set src in view(1)

	if(usr.is_mob_incapacitated())
		return

	if(ishuman(usr))
		usr.visible_message(SPAN_NOTICE("[usr] moves the pilow to the other side of the mattress."), SPAN_INFO("You move the pilow to the other side of the mattress."))
		if (dir == NORTH)
			dir = SOUTH
			return
		else
			dir = NORTH
			return
	return
