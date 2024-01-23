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
	name = "frame master object"
	icon_state = "default"
	desc_lore = "Any object produced in adherence to the Northern Republic Production Standard must have a detachable base, called a frame. Frames can come in all shapes and sizes, typically need to be assembled first and as close to where the given object resides as possible. Per the NRPS, each individual piece of a frame must be attachable and detachable by using only a screwdriver, which typically means that any assembly utilizing the NRPS comes with screws that are used to assemble the frame or can be assembled with just one's hands."


/obj/structure/crafting/frame/table
	name = "assembled table frame"

/obj/structure/crafting/frame/bed

/obj/structure/crafting/frame/drawers

/obj/structure/crafting/frame/chair
