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
	w_class = SIZE_HUGE

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

/obj/structure/crafting/frame/table
	name = "table frame"
	desc = "A set of metal rods in two distinct lengths, put together to form a table frame and secured by a set of screws."
	icon_state = "table_metal_frame"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands. Once assembled, table frames need a top, which then should be secured using a wrench. "

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
	desc = "An office chair with four 'legs', each one has a colored wheel at its tip.
	var/frame_wheels = "default"
	icon_state = "chair_base_wheels"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands. Once the wheels are secured, office chairs need a seat attached and then tightened with a wrench."
