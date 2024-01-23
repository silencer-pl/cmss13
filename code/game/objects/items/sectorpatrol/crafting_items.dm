//Crafting items - everything pickupable

/obj/item/crafting/

	name = "crafting master item"
	desc = "Hi! I should not be in game."
	icon = 'icons/obj/items/sp_crafting.dmi'
	icon_state = "default"
	var/variant_id //For referring unique icon/ccolor variants to transfer

//packages

/obj/item/crafting/packages/
	name = "package"
	icon_state = "package_m"
	desc = "Brown packaging in the shape of a box. If just looked at, seems like cardboard, but when touched, one would see that it seems way more rigid and seems to be in fact some sort of resin.  Seems like it would be easy to break open, but the process would clearly be one way. A label is visible on one of its corners."
	desc_lore = "The Northern Republic Production Standard not only dictates screw hole sizes and tube lengths, but also regulates both packaging and labeling of anything adhering to the standard when it is produced. Essentially this means that every NRPS standard complaint wrapping is made of the same brownish artificial resin, meant to be a combination of cardboard and Styrofoam, and always comes with a label oriented towards the bottom-right hand corner of the package. Essentially this means that if you can read the letters, the package is likely upright."

/obj/item/crafting/packages/chair
	icon_state = "package_l"
	w_class = SIZE_LARGE
	item_serial = "NRPS COMPLIANT<hr>OFFICE STYLE CHAIR, BLACK, ONE<hr>UACM OUTER VEIL PST"
	item_serial_distance = SERIAL_ITEM_SIZE_FAR
	variant_id = "default"

/obj/item/crafting/packages/drawer
	icon_state = "package_l"
	w_class = SIZE_LARGE
	item_serial = "NRPS COMPLIANT<hr>DRAWER CHEST, BLACK, ONE<hr>UACM OUTER VEIL PST"
	item_serial_distance = SERIAL_ITEM_SIZE_FAR
	variant_id = "default"

/obj/item/crafting/packages/lamp
	icon_state = "package_m"
	w_class = SIZE_MEDIUM
	item_serial = "NRPS COMPLIANT<hr>DESK LAMP, BLACK, ONE<hr>UACM OUTER VEIL PST"
	item_serial_distance = SERIAL_ITEM_SIZE_MEDIUM
	variant_id = "default"
