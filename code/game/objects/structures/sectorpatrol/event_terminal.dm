//Event terminal master. All global and general procs go here.
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
	var/global/puzzlebox_global_status = 0 // Global event progression measurment goes here
	var/puzzlebox_pythia_sign = "0"// For determining if this terminal had a Pythia episode
	var/puzzlebox_id //for doors and lights etc

//Cutscene tools - speaking, doors, lights, etc

/obj/structure/eventterminal/proc/speak(str)
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE)
	src.visible_message("<b>[src]</b> says, \"[str]\"")

/obj/structure/eventterminal/proc/emote(str)
	if (!str) return
	var/list/heard = get_mobs_in_view(GLOB.world_view_size, src)
	src.langchat_speech(str, heard, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	src.visible_message("<b>[src]</b> [str]")

/obj/structure/eventterminal/proc/open_doors(door_id = puzzlebox_id)
	var/dooorid = "[door_id]"
	if (!dooorid) return
	for(var/obj/structure/machinery/door/D in world)
		if(D.id == dooorid)
			D.open()

/obj/structure/eventterminal/proc/change_lights(lights_id = puzzlebox_id, light_state = 1, lights_color, light_brightness = null, light_flicker = 0)
	var/bulbid = "[lights_id]"
	var/bulbcolor = "[lights_color]"
	var/bulbbright = light_brightness
	var/bulbonoff = light_state
	var/bulbflicker = light_flicker
	if (!bulbid || !bulbcolor) return
	for(var/obj/structure/machinery/light/L in world)
		if(L.light_id == bulbid)
			L.bulb_color = bulbcolor
			L.light_color = bulbcolor
			L.on = bulbonoff
			if (bulbbright != null) L.brightness = bulbbright
			L.update()
			if (bulbflicker != 0) L.flicker(bulbflicker)
	return

//Terminal output shortcuts
#define TERMINAL_STANDARD_SLEEP 10
#define TERMINAL_LOOKUP_SLEEP 20

/obj/structure/eventterminal/proc/terminal_speak(str, delay = TERMINAL_STANDARD_SLEEP)
	var/puzzlebox_temp_say = str
	var/puzzlebox_temp_delay = delay
	if (!puzzlebox_temp_say) return
	to_chat(usr, narrate_console("[puzzlebox_temp_say]"))
	if (puzzlebox_temp_delay != null)sleep(puzzlebox_temp_delay)
