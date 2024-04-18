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

//Going to take this chance to sneak in emoting and speaking procs :P

/obj/item/proc/speakas(str, delay) //Talk as item. Delay in BYOND ticks (about 1/10 of a second per tick) If not provided, delay calculated automatically depending in message length.
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE)
	src.visible_message("<b>[src]</b> says, \"[str]\"")
	var/talkdelay = delay
	if (!talkdelay)
		if ((length("[str]")) <= 64)
			talkdelay = 40
		if ((length("[str]")) > 64)
			talkdelay = 60
	sleep(talkdelay)
	return


/obj/item/proc/emoteas(str, delay) //Emote as item. Delay in BYOND ticks (about 1/10 of a second per tick) If not provided, delay calculated automatically depending in message length.
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	src.visible_message("<b>[src]</b> [str]")
	var/talkdelay = delay
	if (!talkdelay)
		if ((length("[str]")) <= 64)
			talkdelay = 40
		if ((length("[str]")) > 64)
			talkdelay = 60
	sleep(talkdelay)
	return

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

//As above

/obj/structure/proc/talkas(str, delay) //Talk as structure. Delay in BYOND ticks (about 1/10 of a second per tick) If not provided, delay calculated automatically depending in message length.
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE)
	src.visible_message("<b>[src]</b> says, \"[str]\"")
	var/talkdelay = delay
	if (!talkdelay)
		if ((length("[str]")) <= 64)
			talkdelay = 40
		if ((length("[str]")) > 64)
			talkdelay = 60
	sleep(talkdelay)
	return

/obj/structure/proc/emoteas(str, delay) //Emote as structure. Delay in BYOND ticks (about 1/10 of a second per tick) If not provided, delay calculated automatically depending in message length.
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	src.visible_message("<b>[src]</b> [str]")
	var/talkdelay = delay
	if (!talkdelay)
		if ((length("[str]")) <= 64)
			talkdelay = 40
		if ((length("[str]")) > 64)
			talkdelay = 60
	sleep(talkdelay)
	return
