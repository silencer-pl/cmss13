//Event terminal master. All global and general procs go here.

#define TERMINAL_STANDARD_SLEEP 10
#define TERMINAL_LOOKUP_SLEEP 20


/obj/structure/eventterminal
	icon = 'icons/obj/structures/machinery/clio_maint.dmi'
	icon_state = "closed"
	name = "manipulator - placeholder"
	desc = "An admin or placeholder version of interaction terminals."
	desc_lore = "Use event specifc terminals you dunce."
	anchored = TRUE
	plane = FLOOR_PLANE
	unacidable = TRUE
	unslashable = TRUE
	var/global/puzzlebox_state = 0
	var/global/puzzlebox_id = "000"
