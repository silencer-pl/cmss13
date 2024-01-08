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
	var/puzzlebox_puzzle_subtype // For event shenanigans. Not used in generic chains.
	//defaults
	var/puzzlebox_task_text = "The terminal awaits an input, but does not seem to display any other information otherwise."
	var/puzzlebox_task_answer = "reset"
	var/puzzlebox_task_right = "The console pings and the display turns to a steady flow of code on a green backdrop."
	var/puzzlebox_task_wrong = "The console beeps and nothing happens."
	var/puzzlebox_err_text = "The display is garbled and the terminal seems unresponsive."
	var/puzzlebox_door_id
	//parser list
	var/list/puzzlebox_parser_commands = list("help", "list")
	//end of defaults
	var/puzzlebox_given_answer
	var/puzzlebox_temp_output
	var/puzzlebox_magic_number
	//event
	//001{Shuttle matching
	var/global/puzzlebox_001_task1_answer
	///}001
	///{002 - Cargo Woes
	var/puzzlebox_002_started
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
			puzzlebox_endpoint(puzzlebox_task_answer)
			return
		//info
		if(icon_state == "open_hang")
			to_chat(user, narrate_console("[puzzlebox_task_answer]"))
			return

//Event specifc chains to be replaced at will start here.
//001{ Shuttle Pair Matching Puzzle
	if(puzzlebox_puzzle_state == "01")
		if(!puzzlebox_001_task1_answer)
			puzzlebox_001_task1_answer = GEN_8HEXPAIR
			log_game("[key_name(usr)] generated the answer [puzzlebox_001_task1_answer] for the shuttle pairing puzzle.")
			message_admins("[key_name_admin(usr)] generated the answer [puzzlebox_001_task1_answer] for the shuttle pairing puzzle.")
		if(!puzzlebox_puzzle_subtype)
			to_chat(user, narrate_head("Error. Event puzzle state set with no set subtype. This is most likely a mapping error. Admins have been notified, but just in case, please ahelp and laugh at silencer."))
			message_admins("[key_name_admin(usr)] has found a terminal with no puzzlebox subtype set during an event state.")
			return
		if(puzzlebox_puzzle_subtype == "01-endpoint")
			to_chat(user, narrate_body("The terminal displays a diagram of the shuttle and what looks like a schematic of the PST. A crossed out arrow blinks between the shuttle and the station. Some text is visible underneath:"))
			to_chat(user, narrate_console("ERROR: Annomalous landing vector information data pairs detected. Data corruption. Verify viable vector address on terminals PB_TRM and CB_TRM and enter vector-pair that is matched on both terminals.<br>Estimated time until auto-calibration: 10 minutes."))
			if(tgui_alert(user, "Do you want to type something into the terminal?", "The Terminal", list("Yes", "No")) == "No")
				return
			puzzlebox_given_answer = tgui_input_text(user, "The terminal awaits your input,", "Terminal", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
			if (!puzzlebox_given_answer)
				return
			puzzlebox_endpoint(puzzlebox_001_task1_answer)
			if (puzzlebox_puzzle_type == "ok")
				to_chat(user, narrate_body("The code dances before your eyes. For a split second, you feel like its talking to you, saying your name. The sensation passes quickly. Maybe the montony of space travel is getting to you."))
				to_chat(world, narrate_head("The shuttle engines begin to hum as it appears to be ready to fly again."))
				puzzlebox_puzzle_state = "02"
				return
		if(puzzlebox_puzzle_subtype == "01-info")
			to_chat(user, narrate_body("Upon closer examination, the terminal seems to be displaying 8 sets of number pairs:"))
			to_chat(user, narrate_console("NAVIGATION TRIANGULATION DATA PAIRS:"))
			if (!puzzlebox_temp_output)
				puzzlebox_magic_number = "[rand(1,8)]"
				puzzlebox_hex(puzzlebox_001_task1_answer)
			to_chat(user, narrate_console("[puzzlebox_temp_output]"))

	if(puzzlebox_puzzle_state != "01")
		if(puzzlebox_puzzle_subtype == "01-info")
			user.visible_message(narrate_body("[user] closes the maitenance hatch."), narrate_body("You slide the hatch back into place and hear it lock on the other side."))
			playsound(src.loc, 'sound/machines/windowdoor.ogg', 25)
			name = "maintenance terminal hatch"
			puzzlebox_puzzle_type = "solved"
			puzzle_icon()
// }001
//End of event specifc chains.
	to_chat(user, narrate_body("You see no reason to touch this right now.")) //EOF escaper


/obj/structure/maintterm/proc/puzzlebox_hex(str)
	if(puzzlebox_magic_number == "1") puzzlebox_temp_output = (str) + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "2") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + (str) + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "3") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + (str) + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "4") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + (str) + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "5") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + (str) + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "6") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + (str) + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "7") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + (str) + "</br>" + GEN_8HEXPAIR
	if(puzzlebox_magic_number == "8") puzzlebox_temp_output = GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + GEN_8HEXPAIR + "</br>" + (str)

/obj/structure/maintterm/proc/puzzlebox_endpoint(str)
	puzzlebox_temp_output = (str)
	usr.visible_message(narrate_body("[usr] types something on the maitenance console."), narrate_console("> [puzzlebox_given_answer]"))
	sleep(1 SECONDS)
	if(puzzlebox_given_answer != puzzlebox_temp_output)
		usr.visible_message(narrate_body("[puzzlebox_task_wrong]"))
		log_game("[key_name(usr)] used phrase '[puzzlebox_given_answer]' and failed a puzzle. Expected answer: [puzzlebox_temp_output]")
		message_admins("[key_name_admin(usr)] used phrase '[puzzlebox_given_answer]' and failed a puzzle.")
		puzzlebox_temp_output = null
		playsound(src.loc, 'sound/machines/terminal_error.ogg', 25)
		return
	if(puzzlebox_given_answer == puzzlebox_temp_output)
		usr.visible_message(narrate_body("[puzzlebox_task_right]"))
		log_game("[key_name(usr)] used phrase '[puzzlebox_given_answer]' and solved a puzzle.")
		message_admins("[key_name_admin(usr)] used phrase '[puzzlebox_given_answer]' and solved a puzzle.")
		puzzlebox_puzzle_type = "ok"
		puzzlebox_temp_output = null
		playsound(src.loc, 'sound/machines/terminal_success.ogg', 25)
		puzzle_icon()

/obj/structure/maintterm/proc/puzzle_icon()
	if(puzzlebox_puzzle_type == "endpoint")
		if(icon == 'icons/obj/structures/machinery/clio_term.dmi')
			desc = "A standard computer terminal with the words 'LNT' imprinted on its side. It seems to be flashing a red error message and is awaiting user input."
			desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs. Red error messages typically indicate that the terminal is the end point of a diagnostic issue and will typically require information from other terminals displaying a yellow error screen."
		if(icon == 'icons/obj/structures/machinery/clio_bigboi.dmi')
			desc = "A cluster of computers seemingly somehow connected to each other. Blue liquid swirls and lights up inside of hand sized containers, looks like the light form a pattern of some kind. You can see a screen and a serial number printed right under it on the right side of the cluster. The screen seems to be flashing a red error message and is awaiting user input."
			desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is. Red error messages typically indicate that the terminal is the end point of a diagnostic issue and will typically require information from other terminals displaying a yellow error screen."
		else
			desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be flashing a red error message."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Red error messages typically indicate that the terminal is the end point of a diagnostic issue and will typically require information from other terminals displaying a yellow error screen."
		icon_state = "open_err"
		update_icon()
	if(puzzlebox_puzzle_type == "off")
		if(icon == 'icons/obj/structures/machinery/clio_term.dmi')
			desc = "A standard computer terminal with the words 'LNT' imprinted on its side. The terminal appears to be offline."
			desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs. Terminals being offline means either a power issue or something wrong with the wiring of the terminal itself. This typically requires direct replcaements and precision tools."
		if(icon == 'icons/obj/structures/machinery/clio_bigboi.dmi')
			desc = "A cluster of computers seemingly somehow connected to each other. You can see an inert, shimmering blue liquid resting inside of the capsules mounted across the machine. You can see a screen and a serial number printed right under it on the right side of the cluster. The machine seems to be offline."
			desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is. A computer being offline typically is either a power issue or something wrong with the wiring of the terminal itself. This typically requires direct replacements and precision tools."
		else
			desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be offline."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Terminals being offline means either a power issue or something wrong with the wiring of the terminal itself. This typically requires direct replcaements and precision tools."
		icon_state = "open_off"
		update_icon()
	if(puzzlebox_puzzle_type == "info")
		if(icon == 'icons/obj/structures/machinery/clio_term.dmi')
			desc = "A standard computer terminal with the words 'LNT' imprinted on its side. The terminal seems to be displaying a flood of text on a bright blue blackground."
			desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs. Blue error screens typically mean that an AI process is stuck in an endless loop and will provide critical diagnostic information, usually used on yellow error screen terminals."
		if(icon == 'icons/obj/structures/machinery/clio_bigboi.dmi')
			desc = "A cluster of computers seemingly somehow connected to each other. Blue liquid swirls and lights up inside of hand sized containers, looks like the light form a pattern of some kind. You can see a screen and a serial number printed right under it on the right side of the cluster. The screen seems to be displaying a flood of text on a bright blue blackground."
			desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is. Blue error screens typically mean that an AI process is stuck in an endless loop and will provide critical diagnostic information, usually used on yellow error screen terminals."
		else
			desc = "An open hatch, revealing a maitenance terminal. The terminal seems to be displaying a flood of text on a bright blue blackground."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Blue error screens typically mean that an AI process is stuck in an endless loop and will provide critical diagnostic information, usually used on yellow error screen terminals."
		icon_state = "open_hang"
		update_icon()
	if(puzzlebox_puzzle_type == "parser")
		if(icon == 'icons/obj/structures/machinery/clio_term.dmi')
			desc = "A standard computer terminal with the words 'LNT' imprinted on its side. A body of text with a visible input option on a yellow backdrop seems to be displaed on the screen."
			desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs. Yellow error screens typically output information that can be used to resolve red error terminals, but often require additonal information from terminals displaying blue colored error screens."
		if(icon == 'icons/obj/structures/machinery/clio_bigboi.dmi')
			desc = "A cluster of computers seemingly somehow connected to each other. Blue liquid swirls and lights up inside of hand sized containers, looks like the light form a pattern of some kind. You can see a screen and a serial number printed right under it on the right side of the cluster. The screen seems to be displaying a body of text with a visible input option on a yellow backdrop."
			desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is. Yellow error screens typically output information that can be used to resolve red error terminals, but often require additonal information from terminals displaying blue colored error screens."
		else
			desc = "An open hatch, revealing a maitenance terminal. A body of text with a visible input option on a yellow backdrop seems to be displaed on the screen."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Yellow error screens typically output information that can be used to resolve red error terminals, but often require additonal information from terminals displaying blue colored error screens."
		icon_state = "open_warn"
		update_icon()
	if(puzzlebox_puzzle_type == "ok")
		if(icon == 'icons/obj/structures/machinery/clio_term.dmi')
			desc = "A standard computer terminal with the words 'LNT' imprinted on its side. The terminal is displaying a steady flow of code on a green backdrop."
			desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs. Green colored screens typically indicate normal operation and this terminal is likely ready to return to its standard operating mode."
		if(icon == 'icons/obj/structures/machinery/clio_bigboi.dmi')
			desc = "A cluster of computers seemingly somehow connected to each other. Blue liquid swirls and lights up inside of hand sized containers, looks like the light form a pattern of some kind. You can see a screen and a serial number printed right under it on the right side of the cluster. The system seems to be operating fine, but additional information is avaialble on the screen."
			desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is. Green colored screens typically indicate that an issue has been resolved and this terminal is likely ready to return to its standard operating mode."
		else
			desc = "An open hatch, revealing a maitenance terminal. The terminal is displaying a steady flow of code on a green backdrop."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system. Green colored screens typically indicate normal operation and this terminal can likely be closed."
		icon_state = "open_ok"
		update_icon()
	if(puzzlebox_puzzle_type == "solved")
		if(icon == 'icons/obj/structures/machinery/clio_term.dmi')
			desc = "A standard computer terminal with the words 'LNT' imprinted on its side. It appears to be working normally."
			desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs."
		if(icon == 'icons/obj/structures/machinery/clio_bigboi.dmi')
			desc = "A cluster of computers seemingly somehow connected to each other. Blue liquid swirls and lights up inside of hand sized containers, looks like the light form a pattern of some kind. You can see a screen and a serial number printed right under it on the right side of the cluster."
			desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is."
		else
			desc = "A sliding hatch concealing a terminal used to perform local diagnostic tasks."
			desc_lore = "Most space ships ultilize secondary terminals like these on a room-by-room basis as a failsafe meant to cover for the ship's central, AI-assisted maitenance system."
		icon_state = "closed"
		update_icon()
		puzzlebox_puzzle_type = null
	//Event Specific icon procs

	//End of event specifc icon procs

/obj/structure/maintterm/black
	icon = 'icons/obj/structures/machinery/clio_maint_dark.dmi'

/obj/structure/maintterm/computer
	name = "local network terminal"
	desc = "A standard computer terminal with the words 'LNT' imprinted on its side. It appears to be working normally."
	desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
//manipulator variant, also for open_off puzzles

/obj/structure/maintterm/bigdatablock
	name = "Liquid Data enabled computer"
	desc = "A cluster of computers seemingly somehow connected to each other. Blue liquid swirls and lights up inside of hand sized containers, looks like the light form a pattern of some kind. You can see a screen and a serial number printed right under it on the right side of the cluster."
	desc_lore = "While using Liquid Data enables faster than light communication, practical applications have mostly been successful in utilizing it for large bursts instead of continuous communication. As such Liquid Data machines are typically of large sizes and usually clustered into pairs and constantly checked for integrity. This cluster seems to go against both these principles - it seems to be a trio, not a pair of computers and maintains a continuous connection to whatever its source is."
	icon = 'icons/obj/structures/machinery/clio_bigboi.dmi'


//admin terminal zone
/obj/structure/maintterm/computer/admin

/obj/structure/maintterm/computer/admin/attack_hand(mob/user as mob)

	if(!puzzlebox_puzzle_subtype)
		to_chat(user, narrate_head("Error. This admin control terminal has no subtype. This is most likely a mapping error. Admins have been notified, but just in case, please ahelp and laugh at silencer."))
		message_admins("[key_name_admin(usr)] has found an admin terminal with no puzzlebox subtype set during an event state.")
		return
	if(puzzlebox_puzzle_subtype == "scn1")
		var/puzzlebox_admin_option = tgui_input_list(usr, "Select a function", "Admin Terminal", list("RFID Sequence"), 0)
		if (!puzzlebox_admin_option) return
		if (puzzlebox_admin_option == "RFID Sequence")
			change_lights(lights_id = "sec-1", lights_color = "#9300b8" )
			usr.visible_message(narrate_body("[usr] pushes a few buttons on the console and the scanner activates. The whole area seems unnaturally silent for a moment. You can almost feel something watching through the security bulb for a split second, but it must just be the long hours spent travelling in space. The console beeps after a few seconds and the light changes back to normal."), narrate_console("> PROCESSING..."))
			sleep (3 SECONDS)
			change_lights(lights_id = "sec-1", lights_color = LIGHT_COLOUR_WHITE)
			return
	if(puzzlebox_puzzle_subtype == "scn2")
		var/puzzlebox_admin_option = tgui_input_list(usr, "Select a function", "Admin Terminal", list("Start Second Puzzle Sequence", "Open Scanner Doors"), 0)
		if (!puzzlebox_admin_option) return
		if (puzzlebox_admin_option == "Start Second Puzzle Sequence")
			if (puzzlebox_002_started == TRUE)
				to_chat(user, narrate_body("Second puzzle already started"))
				return
			if (!puzzlebox_002_started)
				puzzlebox_002_started = TRUE
				puzzlebox_puzzle_state = "03"
				return
			else
				to_chat(user, narrate_body("Exception. Something went wrong."))
				return
		if (puzzlebox_admin_option == "Open Scanner Doors")
			if (puzzlebox_puzzle_state == "05")
				open_doors()
			else
				to_chat(user, narrate_body("Exception. Puzzlebox state not 05."))

/obj/structure/maintterm/computer/admin/proc/change_lights(lights_id, lights_color)
	var/bulbid = "[lights_id]"
	var/bulbcolor = "[lights_color]"
	if (!bulbid || !bulbcolor) return
	for(var/obj/structure/machinery/light/L in world)
		if(L.light_id == bulbid)
			L.bulb_color = bulbcolor
			L.light_color = bulbcolor
			L.update()
	return

/obj/structure/maintterm/computer/admin/proc/open_doors()
	for(var/obj/structure/machinery/door/D in world)
		if(D.id == src.puzzlebox_door_id)
			D.open()
