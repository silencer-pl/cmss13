#define GEN_8HEXSTRING "[pick(GLOB.hex_string)][pick(GLOB.hex_string)][pick(GLOB.hex_string)][pick(GLOB.hex_string)][pick(GLOB.hex_string)][pick(GLOB.hex_string)][pick(GLOB.hex_string)][pick(GLOB.hex_string)]"
#define GEN_8HEXPAIR GEN_8HEXSTRING + "-" + GEN_8HEXSTRING

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
	var/puzzlebox_task_wrong = "The console beeps and nothing happens."
	var/puzzlebox_task_right = "The console pings and the display turns to a steady flow of code on a green backdrop."
	var/puzzlebox_puzzle_subtype // For event shenanigans. Not used in generic chains.
	var/puzzlebox_given_answer
	var/puzzlebox_temp_output
	var/puzzlebox_magic_number

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
		user.visible_message(narrate_body("[user] opens the maitenance hatch."), narrate_body("You open the maintenance hatch, revealing the machinery underneath."))
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
		name = "open maintenance terminal hatch"
		puzzle_icon()
		return
	if(icon_state == "open_ok")
		user.visible_message(narrate_body("[user] closes the maitenance hatch."), narrate_body("You slide the hatch back into place and hear it lock on the other side."))
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
		name = "maintenance terminal hatch"
		puzzlebox_puzzle_type = "solved"
		puzzle_icon()
		return
// Default/tester chains. Can be used for semi random/impromptu messages too.

	if(puzzlebox_puzzle_state == "test")
		//endpoint
		if(icon_state == "open_err")
			to_chat(user, narrate_body("[puzzlebox_task_text]"))
			puzzlebox_given_answer = tgui_input_text(user, "The terminal awaits your input,", "Terminal", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
			puzzlebox_endpoint()
			return
		//info
		if(icon_state == "open_hang")
			to_chat(user, narrate_console("[puzzlebox_task_answer]"))
			return

//Event specifc chains to be replaced at will start here.

	if(puzzlebox_puzzle_state == "01")
		if(!puzzlebox_puzzle_subtype)
			to_chat(user, narrate_head("Error. Event puzzle state set with no set subtype. This is most likely a mapping error. Admins have been notified, but just in case, please ahelp and laugh at silencer."))
			message_admins("[key_name_admin(usr)] has found a terminal with no puzzlebox subtype set during an event state.")
			return
		if(puzzlebox_puzzle_subtype == "01-endpoint")
			to_chat(user, narrate_body("The terminal displays a diagram of the shuttle and what looks like a schematic of the PST. A crossed out arrow blinks between the shuttle and the station. Some text is visible underneath:"))
			to_chat(user, narrate_console("ERROR: Annomalous landing vector information data pairs detected. Data corruption. Verify viable vector address on terminals PB_TRM and CB_TRM and enter vector-pair that is matched on both terminals.<br>Estimated time until auto-calibration: 10 minutes."))
			if(tgui_alert(user, "Do you want to type something into the terminal?", "The Terminal", list("Yes", "No")) == "No")
				return
			puzzlebox_endpoint()
			to_chat(world, narrate_head("The shuttle engines begin to hum as it appears to be ready to fly again."))
			puzzlebox_puzzle_state = "02"
		if(puzzlebox_puzzle_subtype == "01-info1")
			to_chat(user, narrate_body("Upon closer examination, the terminal seems to be displaying 8 sets of number pairs:"))
			to_chat(user, narrate_console("NAVIGATION TRIANGULATION DATA PAIRS:"))
			if (!puzzlebox_temp_output)
				puzzlebox_magic_number = "[rand(1,8)]"
				puzzlebox_hex()
			to_chat(user, narrate_console("[puzzlebox_temp_output]"))


//End of event specifc chains.


/obj/structure/maintterm/proc/puzzlebox_hex()
	if(puzzlebox_magic_number == "1") puzzlebox_temp_output = puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "2") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "3") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "4") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "5") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "6") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "7") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "8") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + puzzlebox_task_answer

/obj/structure/maintterm/proc/puzzlebox_endpoint()
	if (!puzzlebox_given_answer)
		return
	usr.visible_message(narrate_body("[usr] types something on the maitenance console."), narrate_body("You type '[puzzlebox_given_answer]' and confirm your input. The console processes your request."))
	sleep(1 SECONDS)
	if(puzzlebox_given_answer != puzzlebox_task_answer)
		usr.visible_message(narrate_body("[puzzlebox_task_wrong]"))
		log_game("[key_name(usr)] used phrase '[puzzlebox_given_answer]' and failed a puzzle.")
		message_admins("[key_name_admin(usr)] used phrase '[puzzlebox_given_answer]' and failed a puzzle.")
		return
	if(puzzlebox_given_answer == puzzlebox_task_answer)
		usr.visible_message(narrate_body("[puzzlebox_task_right]"))
		log_game("[key_name(usr)] used phrase '[puzzlebox_given_answer]' and solved a puzzle.")
		message_admins("[key_name_admin(usr)] used phrase '[puzzlebox_given_answer]' and solved a puzzle.")
		puzzlebox_puzzle_type = "ok"
		puzzle_icon()

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
	//Event Specific icon procs

	//End of event specifc icon procs

/obj/structure/maintterm/black
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'
