/obj/structure/maintterm
	icon = 'icons/obj/structures/machinery/clio_maint.dmi'
	icon_state = "closed"
	name = "maintenance terminal hatch"
	desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
	desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
	anchored = TRUE
	plane = FLOOR_PLANE
	unacidable = TRUE
	unslashable = TRUE
	var/global/puzzlebox_puzzle_state = "0"
	var/puzzlebox_puzzle_type
	var/puzzlebox_err_text = "The display is garbled and the terminal seems unresponsive."
	var/puzzlebox_task_text = "The terminal awaits an input, but does not seem to display any other information otherwise."
	var/puzzlebox_task_answer = "reset"
	var/puzzlebox_task_wrong = "The console beeps and rejects your input."
	var/puzzlebox_task_right = "The console pings and the error seems to clear."

/obj/structure/maintterm/attack_hand(mob/user as mob)
	if(puzzlebox_puzzle_state == "0")
		to_chat(user, narrate_body("You see no reason to touch this right now."))
		return
	if(!puzzlebox_puzzle_type)
		to_chat(user, narrate_body("The hatch is sealed and locked."))
		return
	if(icon_state == "closed")
		if(tgui_alert(user, "A green light indicates the hatch is unlocked. Do you wish to open it?", "The Hatch", list("Yes", "No")) == "No")
			return
		user.visible_message(SPAN_NOTICE("[user] opens the maitenance hatch."), narrate_body("You open the maintenance hatch, revealing the machinery underneath."))
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
		name = "open maintenance terminal hatch"
		puzzle_icon()
		return
	if(icon_state == "open_ok")
		user.visible_message(SPAN_NOTICE("[user] closes the maitenance hatch."), narrate_body("You slide the hatch back into place and hear it lock on the other side."))
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
		name = "maintenance terminal hatch"
		puzzle_icon()
		return
// Default/tester chains. Can be used for semi random/impromptu messages too.

	if(puzzlebox_puzzle_state == "test")
		//parser
		if(icon_state == "open_err")
			to_chat(user, narrate_body("[puzzlebox_task_text]"))
			var/puzzlebox_given_answer = tgui_input_text(user, "The terminal awaits your input,", "Terminal", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
			if (!puzzlebox_given_answer)
				return
			if(puzzlebox_given_answer != puzzlebox_task_answer)
				to_chat(user, narrate_body("[puzzlebox_task_wrong]"))
				log_game("[key_name(usr)] used phrase [puzzlebox_given_answer] and failed a puzzle.")
				message_admins("[key_name_admin(usr)] used phrase [puzzlebox_given_answer] and failed a puzzle.")
				return
			if(puzzlebox_given_answer == puzzlebox_task_answer)
				to_chat(user, narrate_body("[puzzlebox_task_right]"))
				log_game("[key_name(usr)] used phrase [puzzlebox_given_answer] and solved a puzzle.")
				message_admins("[key_name_admin(usr)] used phrase [puzzlebox_given_answer] and solved a puzzle.")
				puzzlebox_puzzle_type = "ok"
				puzzle_icon()
				return



/obj/structure/maintterm/proc/puzzle_icon()
	if(puzzlebox_puzzle_type == "endpoint")
		desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be flashing a red error message."
		desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Red error messages typically indicate that the terminal is the end point of a diagnostic issue and will typically require information from other terminals displaying a yellow error screen."
		icon_state = "open_err"
		update_icon()
	if(puzzlebox_puzzle_type == "off")
		desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be offline."
		desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Terminals being offline means either a power issue or something wrong with the wiring of the terminal itself. This typically requires direct replcaements and precision tools."
		icon_state = "open_off"
		update_icon()
	if(puzzlebox_puzzle_type == "info")
		desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be displaying a flood of text on a brigth blue blackground."
		desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Blue error screens typically mean that an AI process is stuck in an endless loop and will provide critical diagnostic information, usually used on yellow error screen terminals."
		icon_state = "open_hang"
		update_icon()
	if(puzzlebox_puzzle_type == "parser")
		desc = "An open hatch, revealing a maitenance terminal. A body of text with a visible input option on a yellow backdrop seems to be displaed on the screen."
		desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Yellow error screens typically output information that can be used to resolve red error terminals, but often require additonal information from terminals displaying blue colored error screens."
		icon_state = "open_warn"
		update_icon()
	if(puzzlebox_puzzle_type == "ok")
		desc = "An open hatch, revealing a maitenance terminal. The terminal id displaying a steady flow of code on a green backdrop."
		desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Green colored screens typically indicate normal operation and this terminal can likely be closed."
		icon_state = "open_ok"
		update_icon()
	if(puzzlebox_puzzle_type == "solved")
		desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks."
		desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
		icon_state = "closed"
		update_icon()
		puzzlebox_puzzle_type = null

/obj/structure/maintterm/black
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'
