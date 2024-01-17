/obj/structure/eventterminal/puzzle03/historyterm
	name = "local network terminal"
	desc = "A standard computer terminal with the words 'LNT' imprinted on its side. Activated by standing in its proximity. It appears to be in standby mode."
	desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	var/puzzlebox_playing = FALSE
	var/puzzlebox_parser_mode = "HOME"
	var/puzzlebox_complete = FALSE
	var/puzzlebox_saw_lesson1 = FALSE
	var/puzzlebox_saw_lesson2 = FALSE
	var/puzzlebox_saw_lesson3 = FALSE
	var/puzzlebox_saw_lesson4 = FALSE
	var/puzzlebox_saw_lesson5 = FALSE
	icon_state = "open_ok"
	puzzlebox_id = "historylessons"
	item_serial = "UACM-OVPST-PEAK-ORIENTATION-TERM"

/obj/structure/eventterminal/puzzle03/historyterm/attack_hand(mob/user as mob)
	if (puzzlebox_complete == TRUE)
		to_chat(usr, narrate_body("The terminal displays:"))
		terminal_speak("Orientation complete. Please proceed to your quarters, elevator B.")
		to_chat(usr, narrate_body("There is no response to any inputs."))
		return
	if (puzzlebox_playing == TRUE)
		to_chat(usr, narrate_body("The terminal displays:"))
		terminal_speak("Error: Presentation already in progress. ")
		to_chat(usr, narrate_body("There is no response to any inputs."))
		return
	if (!puzzlebox_parser_mode) puzzlebox_parser_mode = "HOME"
	if (puzzlebox_parser_mode == "HOME")
		to_chat(usr, narrate_body("The terminal displays:"))
		terminal_speak("Outer Veil Primary Support Terminal Memorial and Orientation.")
		terminal_speak("Welcome, first members UACM Second Logistics Test Crews!")
		terminal_speak("The following presentations are currently available:")
		terminal_speak("NOTE: Completion of orientation may require viewing of additional presentations that will be made available in order. Please make sure you check this terminal for any new entries.")
		if (puzzlebox_saw_lesson4 == TRUE)
			terminal_speak("1. A welcome message from Admiral Boulette - COMPLETE")
			terminal_speak("2. Our Legacy - The Colony Wars, The USCMC, The Sweep - RDML. Boulette. - COMPLETE")
			terminal_speak("3. Our Home - The Outer Veil PST - RDML. Boulette and CDR. Reed-Wilo. - COMPLETE")
			terminal_speak("4. Task Force 14 and your legacy - CDR. Reed-Wilo. - COMPLETE")
			terminal_speak("Error: Buffer mismatch. The following presentation is likely not part of intended course, exists on course list anyway. Ca", 2)
			terminal_speak("?#!#", 5)
			terminal_speak("5 - Our Mission and the Truth.")
			puzzlebox_parser_mode = "HOME_INPUT"
			attack_hand(user)
		if (puzzlebox_saw_lesson1 == FALSE)
			terminal_speak("1. A welcome message from Admiral Boulette")
			puzzlebox_parser_mode = "HOME_INPUT"
			attack_hand(user)
		if (puzzlebox_saw_lesson1 == TRUE)
			terminal_speak("1. A welcome message from Admiral Boulette - COMPLETE")
			if(puzzlebox_saw_lesson2 == FALSE && puzzlebox_saw_lesson3 == FALSE)
				terminal_speak("2. Our Legacy - The Colony Wars, The USCMC, The Sweep - RDML. Boulette")
				terminal_speak("3. Our Home - The Outer Veil PST - RDML. Boulette and CDR. Reed-Wilo.")
				puzzlebox_parser_mode = "HOME_INPUT"
				attack_hand(user)
			if(puzzlebox_saw_lesson2 == TRUE && puzzlebox_saw_lesson3 == FALSE)
				terminal_speak("2. Our Legacy - The Colony Wars, The USCMC, The Sweep - RDML. Boulette - COMPLETE")
				terminal_speak("3. Our Home - The Outer Veil PST - RDML. Boulette and CDR. Reed-Wilo.")
				puzzlebox_parser_mode = "HOME_INPUT"
				attack_hand(user)
			if(puzzlebox_saw_lesson2 == FALSE && puzzlebox_saw_lesson3 == TRUE)
				terminal_speak("2. Our Legacy - The Colony Wars, The USCMC, The Sweep - RDML. Boulette")
				terminal_speak("3. Our Home - The Outer Veil PST - RDML. Boulette and CDR. Reed-Wilo. - COMPLETE")
				puzzlebox_parser_mode = "HOME_INPUT"
				attack_hand(user)
			if(puzzlebox_saw_lesson2 == TRUE && puzzlebox_saw_lesson3 == TRUE)
				terminal_speak("2. Our Legacy - The Colony Wars, The USCMC, The Sweep - RDML. Boulette. - COMPLETE")
				terminal_speak("3. Our Home - The Outer Veil PST - RDML. Boulette and CDR. Reed-Wilo. - COMPLETE")
				terminal_speak("4. Task Force 14 and your legacy - CDR. Reed-Wilo.")
				puzzlebox_parser_mode = "HOME_INPUT"
				attack_hand(user)
		if (puzzlebox_parser_mode == "HOME_INPUT")
			to_chat(usr, narrate_body("The terminal awaits your input. There is only a number pad and an enter key available."))
			var/puzzlebox_parser_input = tgui_input_text(usr, "Pick a number corresponding to a presentation or cancel to leave. Typing in 0 should replay the introduction message. ", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
			if(!puzzlebox_parser_input) return
			if(puzzlebox_parser_input == "0")
				puzzlebox_parser_mode = "HOME"
				attack_hand(user)
			if(puzzlebox_parser_input == "1")
				if (puzzlebox_saw_lesson1 == FALSE)
					terminal_speak("Playing presentation 1.")
					puzzlebox_parser_mode = "HOME"
					return
				if (puzzlebox_saw_lesson1 == TRUE)
					terminal_speak("The presentation was already played. Repeat number to confirm replaying.")
					puzzlebox_parser_input = tgui_input_text(usr, "Pick a number corresponding to a presentation or cancel to leave.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
					if(!puzzlebox_parser_input) return
					if(puzzlebox_parser_input == "1")
						terminal_speak("Replaying presentation 1.")
						puzzlebox_parser_mode = "HOME"
						return
					terminal_speak("Returning to presentation selection.")
					puzzlebox_parser_mode = "HOME"
					attack_hand(user)
			if(puzzlebox_parser_input == "2")
				if(puzzlebox_saw_lesson1 == FALSE)
					terminal_speak("Presentation unavailable.")
					puzzlebox_parser_mode = "HOME"
					attack_hand(user)
				if(puzzlebox_saw_lesson1 == TRUE)
					if (puzzlebox_saw_lesson2 == FALSE)
						terminal_speak("Playing presentation 2.")
						puzzlebox_parser_mode = "HOME"
						return
					if (puzzlebox_saw_lesson2 == TRUE)
						terminal_speak("The presentation was already played. Repeat number to confirm replaying.")
						puzzlebox_parser_input = tgui_input_text(usr, "Pick a number corresponding to a presentation or cancel to leave.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
						if(!puzzlebox_parser_input) return
						if(puzzlebox_parser_input == "2")
							terminal_speak("Replaying presentation 2.")
							puzzlebox_parser_mode = "HOME"
							return
						terminal_speak("Returning to presentation selection.")
						puzzlebox_parser_mode = "HOME"
						attack_hand(user)
			if(puzzlebox_parser_input == "3")
				if(puzzlebox_saw_lesson1 == FALSE)
					terminal_speak("Presentation unavailable.")
					puzzlebox_parser_mode = "HOME"
					attack_hand(user)
				if(puzzlebox_saw_lesson1 == TRUE)
					if (puzzlebox_saw_lesson3 == FALSE)
						terminal_speak("Playing presentation 3.")
						puzzlebox_parser_mode = "HOME"
						return
					if (puzzlebox_saw_lesson3 == TRUE)
						terminal_speak("The presentation was already played. Repeat number to confirm replaying.")
						puzzlebox_parser_input = tgui_input_text(usr, "Pick a number corresponding to a presentation or cancel to leave.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
						if(!puzzlebox_parser_input) return
						if(puzzlebox_parser_input == "3")
							terminal_speak("Replaying presentation 3.")
							puzzlebox_parser_mode = "HOME"
							return
						terminal_speak("Returning to presentation selection.")
						puzzlebox_parser_mode = "HOME"
						attack_hand(user)
			if(puzzlebox_parser_input == "4")
				if(puzzlebox_saw_lesson2 == TRUE && puzzlebox_saw_lesson3 == TRUE)
					if (puzzlebox_saw_lesson4 == FALSE)
						terminal_speak("Playing presentation 4.")
						puzzlebox_parser_mode = "HOME"
						return
					if (puzzlebox_saw_lesson4 == TRUE)
						terminal_speak("The presentation was already played. Repeat number to confirm replaying.")
						puzzlebox_parser_input = tgui_input_text(usr, "Pick a number corresponding to a presentation or cancel to leave.", "Terminal input", max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = FALSE, timeout = 0)
						if(!puzzlebox_parser_input) return
						if(puzzlebox_parser_input == "4")
							terminal_speak("Replaying presentation 4.")
							puzzlebox_parser_mode = "HOME"
							return
						terminal_speak("Returning to presentation selection.")
						puzzlebox_parser_mode = "HOME"
						attack_hand(user)
				terminal_speak("Presentation unavailable.")
				puzzlebox_parser_mode = "HOME"
				attack_hand(user)
			if(puzzlebox_parser_input == "5")
				if(puzzlebox_saw_lesson4 == FALSE)
					terminal_speak("Presentation unavailable.")
					puzzlebox_parser_mode = "HOME"
					attack_hand(user)
				if(puzzlebox_saw_lesson4 == TRUE)
					terminal_speak("Playing presentation 5.")
					puzzlebox_parser_mode = "HOME"
					return

/obj/structure/eventterminal/puzzle03/historyterm/crt
	name = "wall mounted display"
	icon = 'icons/obj/structures/machinery/displaymonitor.dmi'
	desc = "A large-scale display, safely mounted inside a slot made in the hull of the station."
	desc_lore = "Computer displays on most ships tend to be adjusted for single colored text, initially due to lack of technology that allowed for better quality displays to survive out in space. Over time this became more a habit than anything else, as evidenced by PDAs which do not limit themselves in terms of display capabilities. Large scale displays such as this one have resisted over a hundred years' worth of technological progress and still reign supreme across human space ships. Truly, you are looking at a classic. For better or worse."
	icon_state = "off"
	puzzlebox_id = "theatherscreen"

/obj/structure/eventterminal/puzzle03/historyterm/attack_hand(mob/user as mob)
	to_chat(usr, narrate_body("There does not seem to be any way of controlling the monitor, it only has status indicators. Perhaps there is a console somewhere around here."))
	return

/obj/structure/eventterminal/puzzle03/historyterm/proc/lesson1()
	for (var/obj/structure/eventterminal/puzzle03/historyterm/T in world)
		for (var/obj/structure/machinery/light/marker/admin/A in world)
			if (A.light_id == "theathervoice")
				T.puzzlebox_playing = TRUE
				emoteas("comes alive and displays the UACM logo.")
				icon_state = "uacm"
				update_icon()
				sleep(5)
				A.name = "Voice of RDML. Boulette"
				A.talkas("Welcome, suckas", 10)
				A.emoteas("farts", 50)
				T.talkas("Idiot.")
				T.puzzlebox_playing = FALSE
				return
	return
