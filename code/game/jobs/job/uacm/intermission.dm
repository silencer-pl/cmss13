/datum/job/uacm/basepc
	title = JOB_UACM_BASEPC
	total_positions = -1
	spawn_positions = -1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uacm/basepc
	entry_message_intro = "You are a commissioned officer in the UACM. You were a member of the USCMC before it was disbanded a year ago, but any command or rank you held in that formation is null and void."
	entry_message_body = "You have been brought back to active service via a special training program run by the UAAC offered to qualifying and enlisted and commissioned officers of the USCMC. After a period of intensive retraining, you were given the rank of Ensign in the UACM and assigned to the Second Outer Rim Supply and Support Fleet under RDML Thomas Boulette."
	entry_message_end = "You are currently located on board the UACM Outer Void Primary Supply Terminal in the Neroid Sector, the home of the second fleet. The stations' massive cargo bays and logistics are mostly run by Artificial Intelligences and robots, so you are either drilled or assigned down time most of the time here. This is one such moment from your life on board the station."
/obj/effect/landmark/start/basepc
	name = JOB_UACM_BASEPC
	icon_state = "so_spawn"
	job = /datum/job/uacm/basepc
