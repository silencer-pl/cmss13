//Crafting items - everything pickupable

/obj/structure/crafting/

	name = "crafting master structure"
	desc = "Hi! I should not be in game."
	icon = 'icons/obj/items/sp_crafting.dmi'
	icon_state = "default"
	var/variant_id //For referring unique icon/ccolor variants to transfer

//packages

/obj/structure/crafting/packages/
	name = "package"
	icon_state = "package_xl"
	desc = "Brown packaging in the shape of a box. If just looked at, seems like cardboard, but when touched, one would see that it seems way more rigid and seems to be in fact some sort of resin.  Seems like it would be easy to break open, but the process would clearly be one way. A label is visible on one of its corners."
	desc_lore = "The Northern Republic Production Standard not only dictates screw hole sizes and tube lengths, but also regulates both packaging and labeling of anything adhering to the standard when it is produced. Essentially this means that every NRPS standard complaint wrapping is made of the same brownish artificial resin, meant to be a combination of cardboard and Styrofoam, and always comes with a label oriented towards the bottom-right hand corner of the package. Essentially this means that if you can read the letters, the package is likely upright."

/obj/structure/crafting/packages/table
	icon_state = "package_xl"
	item_serial = "NRPS COMPLIANT<hr>ALL-PURPOSE TABLE, SQUARE, BLACK, ONE<hr>UACM OUTER VEIL PST"
	item_serial_distance = SERIAL_STRUCTURE_SIZE_FAR
	variant_id = "default"

/obj/structure/crafting/packages/bed
	icon_state = "package_long"
	item_serial = "NRPS COMPLIANT<hr>PLAIN BED AND EXPANDING MATTRESS PACKAGE, COMES WITH ONE (1) STANDARD BED SHEET<hr>UACM OUTER VEIL PST"
	item_serial_distance = SERIAL_STRUCTURE_SIZE_FAR
	variant_id = "default"

//frames

/obj/structure/crafting/frame/
	name = "structure frame master object"
	icon_state = "default"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands."
	anchored = 0
	var/crafting_top_ready = FALSE

/obj/structure/crafting/frame/table
	name = "table frame"
	desc = "A set of metal rods in two distinct lengths, put together to form a table frame and secured by a set of screws."
	icon_state = "table_metal_frame"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands. Once assembled, table frames need a top, which then should be secured using a wrench."

/obj/structure/crafting/frame/table/attack_hand(mob/user)
	if(crafting_top_ready == TRUE)
		if(user.a_intent == INTENT_GRAB)
			user.visible_message(SPAN_NOTICE("[user] lifts a table top of its frame."), SPAN_INFO("You lift a table top of its frame."))
			if(do_after(user, (10 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				switch(icon_state)
					if("table_metal_black")
						var/obj/item/crafting/top/table/tabletop = new(get_turf(user))
						user.put_in_active_hand(tabletop)
					if("table_metal_gray")
						var/obj/item/crafting/top/table/gray/tabletop = new(get_turf(user))
						user.put_in_active_hand(tabletop)
				name = "table frame"
				icon_state = "table_metal_frame"
				desc = "A set of metal rods in two distinct lengths, put together to form a table frame and secured by a set of screws."
				crafting_top_ready = FALSE
				anchored = 0
				return
	return


/obj/structure/crafting/frame/table/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/crafting/top/table/))
		var/obj/item/crafting/top/table/W = C
		user.visible_message(SPAN_NOTICE("[user] starts starts to align a table top with a frame."), SPAN_INFO("You start to to align a table top with a frame."))
		if(do_after(user, (20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			switch(W.variant_id)
				if("default")
					icon_state = "table_metal_black"
				if("gray")
					icon_state = "table_metal_gray"
			name = "table frame with an aligned top"
			desc = "A set of metal rods in two distinct lengths, put together to form a table frame and secured by a set of screws. A table top is aligned with the frame."
			crafting_top_ready = TRUE
			anchored = 1
			qdel(W)
			return

	if(HAS_TRAIT(C, TRAIT_TOOL_WRENCH))
		if(crafting_top_ready == TRUE)
			user.visible_message(SPAN_NOTICE("[user] tightens the screws attaching the table top to its frame."), SPAN_INFO("You tighten the screws attaching the table top to its frame."), SPAN_DANGER("You hear metal scratch against metal."))
			if(do_after(user, (30 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
				switch(icon_state)
					if("table_metal_black")
						new /obj/structure/surface/modular/table(get_turf(src))
						qdel(src)
						return
					if("table_metal_gray")
						new /obj/structure/surface/modular/table/gray(get_turf(src))
						qdel(src)
						return

	if(HAS_TRAIT(C, TRAIT_TOOL_SCREWDRIVER))
		if(crafting_top_ready == TRUE)
			to_chat(usr, SPAN_NOTICE("Remove the top before disassembling the frame. To remove the top, click the frame with an empty hand in GRAB mode."))
			return
		user.visible_message(SPAN_NOTICE("[user] starts to disassemble the frame."), SPAN_INFO("You start to disassemble the frame."))
		if(do_after(user, (20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION)), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			var/obj/item/crafting/frame_elements/elements = new(get_turf(usr))
			elements.variant_id = variant_id
			qdel(src)
			return

	to_chat(usr, SPAN_NOTICE("You don't seem to be able to use this at the moment. Place a table top before trying to tighten the screws or use a screwdriver in GRAB mode to disassemble the frame."))
	return


/obj/structure/crafting/frame/bed
	name = "bed frame"
	desc = "Four metal bards and supporting rods, put together into a bed frame. Held together by a series of screws."
	icon_state = "bed_frame"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands. Once assembled, bed frames are ready for an expandable mattress and don't require any further tinkering."

/obj/structure/crafting/frame/drawers
	name = "cabinet frame"
	desc = "Several sheets of metal snapped together along the edges using a series of premade hooks and holes."
	icon_state = "drawer_frame"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands. Once assembled, cabinet frames need a set of drawers that clip onto inlaid tracks and don't require any additional tinkering. "

/obj/structure/crafting/frame/chair
	name = "office chair base with wheels"
	desc = "An office chair with four 'legs', each one has a colored wheel at its tip."
	var/crafting_chair_wheel_id = "default"
	icon_state = "chair_base_wheels"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands. Once the wheels are secured, office chairs need a seat attached and then tightened with a wrench."
