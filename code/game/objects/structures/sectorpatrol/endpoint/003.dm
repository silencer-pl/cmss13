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

/obj/structure/eventterminal/puzzle03/historycrt
	name = "wall mounted display"
	icon = 'icons/obj/structures/machinery/displaymonitor.dmi'
	desc = "A large-scale display, safely mounted inside a slot made in the hull of the station."
	desc_lore = "Computer displays on most ships tend to be adjusted for single colored text, initially due to lack of technology that allowed for better quality displays to survive out in space. Over time this became more a habit than anything else, as evidenced by PDAs which do not limit themselves in terms of display capabilities. Large scale displays such as this one have resisted over a hundred years' worth of technological progress and still reign supreme across human space ships. Truly, you are looking at a classic. For better or worse."
	icon_state = "off"
	puzzlebox_id = "theatherscreen"

/obj/structure/eventterminal/puzzle03/historycrt/attack_hand(mob/user as mob)
	to_chat(usr, narrate_body("There does not seem to be any way of controlling the monitor, it only has status indicators. Perhaps there is a console somewhere around here."))
	return

/obj/structure/eventterminal/puzzle03/historycrt/proc/lesson1()
	for (var/obj/structure/eventterminal/puzzle03/historyterm/T in world)
		for (var/obj/structure/machinery/light/marker/admin/A in world )
			while (A.light_id == "theathervoice")
				T.puzzlebox_playing = TRUE
				emoteas("comes alive and displays the UACM logo.")
				icon_state = "uacm"
				update_icon()
				sleep(5)
				A.name = "Voice of RDML. Boulette"
				A.langchat_color = "#25664d"
				A.talkas("Welcome back home, Marines.", 20)
				A.talkas("As some of you may already know, I am Admiral Boulette and I will be the officer in charge of the entire Second Logistics division of the UACM.", 40)
				A.talkas("While the name 'division' may sound impressive, it's not meant to be this way.", 30)
				A.langchat_color = COLOR_WHITE
				A.name = "RDML. Boulette"
				A.emoteas("clears his throat audibly.", 20)
				A.langchat_color = "#25664d"
				A.name = "Voice of RDML. Boulette"
				A.talkas("I will be frank. Part of the reason why Commanders Reed-Wilo and myself have been given such broad permissions in how to organize and setup the PST...", 40)
				A.talkas("...is that as I believe, they do not think any of what we're trying to achieve is possible. ", 30)
				A.name = "RDML. Boulette"
				A.langchat_color = COLOR_WHITE
				A.emoteas("pauses for a few seconds and takes a deep breath.", 30)
				A.name = "Voice of RDML. Boulette"
				A.langchat_color = "#25664d"
				A.talkas("Everyone that is in any major way connected to the USCMC or Task Force 14, I think everyone just sort of expects the victims of the purges to just lay there and die.", 40)
				A.talkas("It's unfair. Unjust. And that is why we are all here.", 20)
				A.talkas("I can guarantee you that everyone in the Second has someone to prove wrong. That includes myself and the Reed-Wilos.", 35)
				A.talkas("Before I'll let you go and move into your new home, I would like you to take the time and review briefings recorded by myself and the commanders.", 40)
				A.talkas("Where we will briefly explain the purpose of the Second Logistics and the PST.", 30)
				T.puzzlebox_playing = FALSE
				A.name = "RDML. Boulette"
				A.langchat_color = COLOR_WHITE
				A.emoteas("takes an audible deep breath.", 30)
				A.name = "Voice of RDML. Boulette"
				A.langchat_color = "#25664d"
				A.talkas("I also believe that Cassandra left you something about her involvement in the demise of the USCMC and your personal fortunes during those events. I ask that you hear her out.", 40)
				A.talkas("I can assure you that I would not agree to any of this, or their presence, if I didn't think they were genuinely trying to make amends.", 35)
				A.talkas("I assure you; we won't be long. Again, welcome back to the UACM. Welcome home, Marines.", 30)
				emoteas("flickers and shuts down.")
				T.puzzlebox_playing = FALSE
				if(T.puzzlebox_saw_lesson1 == FALSE) T.puzzlebox_saw_lesson1 = TRUE
				return

/obj/structure/eventterminal/puzzle03/historycrt/proc/lesson2()
	for (var/obj/structure/eventterminal/puzzle03/historyterm/T in world)
		for (var/obj/structure/machinery/light/marker/admin/A in world )
			while (A.light_id == "theathervoice")
				T.puzzlebox_playing = TRUE
				emoteas("turns on with an audible pop.")
				icon_state = "blank"
				update_icon()
				sleep(5)
				A.name = "Voice of RDML. Boulette"
				A.langchat_color = "#25664d"
				A.talkas("This part of orientation means to remind you all how we got here through our rocky history.", 30)
				emoteas("prints the Admiral's speech as the admiral speaks.")
				icon_state = "text"
				update_icon()
				A.talkas("While the UACM seeks to unify and improve the model, it itself is not a revolution. The USCMC however, the formation preceding it, was.", 35)
				A.talkas("The Colony Wars ended in 2128 and left all major superpowers virtually without colonial fleets. The UA elected to elevate one of its smaller member formations, the US Marines, and use them as a foundation to build a new colonial QRF.", 50)
				A.talkas("Built in partnership with Weyland-Yutani and some smaller corporate consortiums, the newly minted Marines were a strength to be reckoned with.", 35)
				A.talkas("With the horrors of the Colony Wars still fresh in the mind of everyone in the colonies, but a new wave of exploration and colonization clearly more than ready to go following the end of the war, the Marines would soon be baptized in fire.", 50)
				A.talkas("They called it The Sweep, although the name just like most of its infamy was attributed to the operation post-factum.", 35)
				A.talkas("Today, we know that this victory was likely more a matter of overwhelming numbers than the supposed tactical and training superiority of the USCMC, but for better or worse...", 40)
				A.talkas("...The label of fierce, scrappy warriors that were protectors of the common colonist stuck with the Marines for decades. As did the peace that they carved out in the Veil.", 40)
				A.langchat_color = COLOR_WHITE
				A.name = "RDML. Boulette"
				A.emoteas("pauses for a few seconds and sighs audibly.", 20)
				A.langchat_color = "#25664d"
				A.name = "Voice of RDML. Boulette"
				A.talkas("It was at this time that other formations were called to life, the UAAC seeking to replicate its success. Marine leadership would claim these formations denied the USCMC resources they needed to keep the peace.", 45)

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
					for (var/obj/structure/eventterminal/puzzle03/historycrt/T in world)
						INVOKE_ASYNC(T, TYPE_PROC_REF(/obj/structure/eventterminal/puzzle03/historycrt, lesson1))
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

