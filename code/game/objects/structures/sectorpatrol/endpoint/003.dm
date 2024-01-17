/obj/structure/eventterminal/puzzle03/historyterm
	name = "local network terminal"
	desc = "A standard computer terminal with the words 'LNT' imprinted on its side. Activated by standing in its proximity. It appears to be in standby mode."
	desc_lore = "Local Network Terminals typically regulate local functions of a given area or are used to interface with bigger systems on a ship or installation. They distinction technically means that the terminal interfaces with the local AI somehow, but few outside of systems engineers use the term for its actual intended purpose, sometimes mistaking other terminal types for LNTs."
	icon = 'icons/obj/structures/machinery/clio_term.dmi'
	plane = GAME_PLANE
	var/puzzlebox_playing = FALSE
	var/puzzlebox_complete = FALSE
	var/puzzlebox_saw_lesson1 = FALSE
	var/puzzlebox_saw_lesson2 = FALSE
	var/puzzlebox_saw_lesson3 = FALSE
	var/puzzlebox_saw_lesson4 = FALSE
	var/puzzlebox_saw_lesson5 = FALSE
	icon_state = "open_ok"
	puzzlebox_id = "historylessons"
	item_serial = "UACM-OVPST-PEAK-ORIENTATION-TERM"

/obj/structure/eventterminal/puzzle03/historyterm/crt
	name = "wall mounted display"
	icon = 'icons/obj/structures/machinery/displaymonitor.dmi'
	desc = "A large-scale display, safely mounted inside a slot made in the hull of the station."
	desc_lore = "Computer displays on most ships tend to be adjusted for single colored text, initially due to lack of technology that allowed for better quality displays to survive out in space. Over time this became more a habit than anything else, as evidenced by PDAs which do not limit themselves in terms of display capabilities. Large scale displays such as this one have resisted over a hundred years' worth of technological progress and still reign supreme across human space ships. Truly, you are looking at a classic. For better or worse."
	icon_state = "off"
