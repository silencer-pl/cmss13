/obj/item

	name = "Generic item, or missed empty name iheritance. Please report this if you see it in the wild."
	var/item_serial
	var/item_serial_distance = SERIAL_ITEM_SIZE_MEDIUM

/obj/item/examine(mob/user)
	..()
	if (item_serial != null)
		if(!isxeno(user) && (get_dist(user, src) < item_serial_distance || isobserver(user)))
			to_chat(user, narrate_body("The serial number is:"))
			to_chat(user, narrate_serial_block(narrate_serial("[item_serial]")))

/obj/structure

	name = "Generic structure, or missed empty name inheritance. Should not be seen anywhere in game. Plese report this if you see it in the wild."
	var/item_serial
	var/item_serial_distance = SERIAL_STRUCTURE_SIZE_MEDIUM

/obj/structure/examine(mob/user)
	..()
	if (item_serial != null)
		if(!isxeno(user) && (get_dist(user, src) < item_serial_distance || isobserver(user)))
			to_chat(user, narrate_body("The serial number is:"))
			to_chat(user, narrate_serial_block(narrate_serial("[item_serial]")))
