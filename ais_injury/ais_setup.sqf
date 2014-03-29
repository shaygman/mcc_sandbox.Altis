// by psycho
// AIS INJURY Setup-File

tcb_ais_revive_guaranty			=	true;			//	set to true for a 99% revive chance. False, and the unit got a 50/50 chance to fall in agony or die immediately. Attention: Take note of the settings for "tcb_ais_realistic_mode"!
tcb_ais_realistic_mode			=	false;			//	set to true and units will die if they take a headshot or a heavy explosion nearby. Attention: if set to true, the revive chance guaranty are disabled!

tcb_ais_rambofactor 			= 	2;				//	a higher value means more damage tolerance for the unit before the unit are unconcious ( 1== low, 2 == normal, 3 == higher, 5 == extreme)
tcb_ais_random_lifetime_factor 	= 	200;			//	a higher value means you got more time to heal the unit before bleeding out and die (50 == means round about 1 minute, 100 == means round about 3 minutes, 200 == approximately 8 minutes)
													//	the time depends on the damage the unit takes before they are unconcious. The time is randomized and not exact.
tcb_ais_show_injury_marker		=	0;				//	Set value to 1 and a marker show injured units on the map. 0 means this feature is disabled.
tcb_ais_show_3d_icons			=	1;				//	Set value to 1 and a 3D-icon show you ingame the position of injured units within a range of 30 metres. 0 means this feature is disabled.
tcb_ais_dead_dialog				=	1;				//	Set value to 1 to enable the deadcam and the dead dialog. 0 means this feature is disabled.

tcb_ais_delTime					=	60;				//	Time in seconds until dead bodys are deleted. If zero seconds are select this feature is disabled. (only units witch was handled from AIS Injury System will be deleted!)