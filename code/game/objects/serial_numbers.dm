/obj/item

	name = "Generic item. Should not be seen anywhere in game. Plese please report this."
	var/item_serial = "AAAAA-BBBBB-CCCCC-DDDDD-EEEEE"

/obj/item/examine(mob/user)
	..()
	if (!item_serial) to_chat(user, narrate_head("Warning. Looked at an item witha null serial value. This should not be possible unless for some reason it was nulled by code. Please ahelp this."))
	to_chat(user, narrate_body("There is a serial number printed on the object. It reads:"))
	to_chat(user, examine_block(narrate_serial("[item_serial]")))

/obj/structure

	name = "Generic structure. Should not be seen anywhere in game. Plese please report this."
	var/item_serial = "AAAAA-BBBBB-CCCCC-DDDDD-EEEEE"

/obj/structure/examine(mob/user)
	..()
	if (!item_serial) to_chat(user, narrate_head("Warning. Looked at an item witha null serial value. This should not be possible unless for some reason it was nulled by code. Please ahelp this."))
	to_chat(user, narrate_body("There is a serial number printed on the object. It reads:"))
	to_chat(user, examine_block(narrate_serial("[item_serial]")))
