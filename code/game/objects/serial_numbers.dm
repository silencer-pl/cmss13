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

/obj/item/proc/speak(str)
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE)
	src.visible_message("<b>[src]</b> says, \"[str]\"")

/obj/item/proc/emote(str)
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	src.visible_message("<b>[src]</b> [str]")

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

/obj/structure/proc/talkas(str)
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE)
	src.visible_message("<b>[src]</b> says, \"[str]\"")

/obj/structure/proc/emoteas(str)
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	src.visible_message("<b>[src]</b> [str]")
