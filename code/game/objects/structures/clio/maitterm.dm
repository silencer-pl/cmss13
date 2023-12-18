/obj/structure/maintterm
	icon = 'icons/obj/structures/machinery/clio_maint.dmi'
	icon_state = "closed"
	name = "maintenance terminal hatch"
	desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks"
	desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
	anchored = TRUE
	unacidable = TRUE
	unslashable = TRUE
	var/puzzle = "No"
	var/task_text
	var/task_answer

/obj/structure/maintterm/attack_hand(mob/user as mob)
	if(puzzle == "No")
		to_chat(user, narrate_body("You see no reason to touch this right now."))
		return
	if(icon_state == "closed")
		if(tgui_alert(user, "A green light indicates the hatch is unlock. Do you wish to open it?", "The Hatch", list("Yes", "No")) == "No")
			return
		user.visible_message(SPAN_NOTICE("[user] opens the maitenance hatch."), narrate_body("You open the maintenance hatch, revealing the machinery underneath."))
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
		name = "open maintenance terminal hatch"
		desc = "An open sliding hatch, with a terminal used to perform local diagnostic tasks visible underneath. The terminal appears to be displaying a red error sign, perhaps a closer look is warranted."
		icon_state = puzzle
		update_icon()
		return
	if(icon_state == "open_err")
		if(!task_answer)
			to_chat(user, narrate_body("The error message seems garbled and the terminal is unresponsive."))
			return
		if(!task_text)
			to_chat(user, narrate_body("The error message seems garbled, but the terminal is responsive and seems ready to accept a command."))
		else
			to_chat(user, narrate_body("[task_text]"))
		var/given_answer = tgui_input_text(user, "The terminal awaits your input,", "Terminal", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
		if (!given_answer)
			return
		if(given_answer != task_answer)
			to_chat(user, narrate_body("The console beeps and rejects your input."))
			return
		if(given_answer == task_answer)
			to_chat(user, narrate_body("The console pings and the error seems to clear."))
			puzzle = "Solved"
			icon_state = "open_ok"
			update_icon()
			return
	if(icon_state == "open_ok")
		user.visible_message(SPAN_NOTICE("[user] closes the maitenance hatch."), narrate_body("You slide the hatch back into place and hear it lock on the other side."))
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
		name = "maintenance terminal hatch"
		desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks."
		icon_state = "closed"
		puzzle = "No"
		update_icon()
		return

/obj/structure/maintterm/black
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'
