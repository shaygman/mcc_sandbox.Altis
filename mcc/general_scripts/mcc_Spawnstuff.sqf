#define DEBUG
private ["_ar","_diaryrecord","_behavior"];

//time to request something so lets number it
mcc_request=mcc_request+1;

//safe that string man!
if (MCC_capture_state) then
	{
		hint "Action captured";
		if (mcc_spawntype == "GROUP") then 
		{
			MCC_capture_var=MCC_capture_var + FORMAT ["
				  mcc_spawntype='%1';
				  mcc_classtype='%2';
				  mcc_isnewzone=%3;
				  mcc_spawnwithcrew=%4;
				  mcc_spawnname='%5';
				  mcc_spawnfaction='%6';
				  mcc_zone_number=%7;
				  mcc_zoneinform='%8';
				  mcc_zone_markername='%9';
				  mcc_spawnbehavior='%10';
				  mcc_grouptype     ='%11';
				  mcc_spawndisplayname ='%12';
				  mcc_track_units = %13;
				  mcc_awareness = '%14';
				  mcc_sidename = '%15';
				  mcc_hc = %16;
				  mcc_spawn_dir = %18;
				  script_handler = [0] execVM '%17mcc\general_scripts\mcc_SpawnStuff.sqf';"								 
				  , mcc_spawntype
				  , mcc_classtype
				  , mcc_isnewzone
				  , mcc_spawnwithcrew
				  , mcc_spawnname
				  , mcc_spawnfaction
				  , mcc_zone_number
				  , mcc_zoneinform
				  , mcc_zone_markername
				  , mcc_spawnbehavior
				  , mcc_grouptype 
				  , mcc_spawndisplayname
				  , mcc_track_units
				  , mcc_awareness
				  , mcc_sidename
				  , mcc_hc
				  , MCC_path
				  , mcc_spawn_dir
				  ];
		}
		else
		{
			MCC_capture_var=MCC_capture_var + FORMAT ['
				  mcc_spawntype=["%1"] select 0;
				  mcc_classtype=["%2"] select 0;
				  mcc_isnewzone=%3;
				  mcc_spawnwithcrew=%4;
				  mcc_spawnname=["%5"] select 0;
				  mcc_spawnfaction=["%6"] select 0;
				  mcc_zone_number=%7;
				  mcc_zoneinform=["%8"] select 0;
				  mcc_zone_markername=["%9"] select 0;
				  mcc_spawnbehavior=["%10"] select 0;
				  mcc_grouptype     =["%11"] select 0;
				  mcc_spawndisplayname =[%12] select 0;
				  mcc_track_units = %13;
				  mcc_awareness = ["%14"] select 0;
				  mcc_sidename = ["%15"] select 0;
				  mcc_hc = %16;
				  mcc_spawn_dir = %18;
				  script_handler = [0] execVM "%17mcc\general_scripts\mcc_SpawnStuff.sqf";'								 
				  , mcc_spawntype
				  , mcc_classtype
				  , mcc_isnewzone
				  , mcc_spawnwithcrew
				  , mcc_spawnname
				  , mcc_spawnfaction
				  , mcc_zone_number
				  , mcc_zoneinform
				  , mcc_zone_markername
				  , mcc_spawnbehavior
				  , mcc_grouptype 
				  , mcc_spawndisplayname
				  , mcc_track_units
				  , mcc_awareness
				  , mcc_sidename
				  , mcc_hc
				  , MCC_path
				  , mcc_spawn_dir
				  ];
		};
	}
	else
	{
		if (!mcc_isloading && mcc_isnewzone)then 
		{
			mcc_safe=mcc_safe + FORMAT ["
				  mcc_spawntype='%1';
				  mcc_classtype='%2';
				  mcc_isnewzone=%3;
				  mcc_spawnwithcrew=%4;
				  mcc_spawnname='%5';
				  mcc_spawnfaction='%6';
				  mcc_zone_number=%7;
				  mcc_zoneinform='%8';
				  mcc_zone_markername='%9';
				  mcc_spawnbehavior='%10';
				  mcc_grouptype     ='%11';
				  mcc_spawndisplayname ='%12';
				  mcc_track_units = %13;
				  mcc_awareness = '%14';
				  mcc_sidename = '%15';
				  mcc_hc = %16;
				  mcc_spawn_dir = %18;
				  mcc_marker_dir = %19;
				  script_handler = [0] execVM '%17mcc\general_scripts\mcc_SpawnStuff.sqf';
				   waitUntil {scriptDone script_handler};
				  "								 
				  , mcc_spawntype
				  , mcc_classtype
				  , mcc_isnewzone
				  , mcc_spawnwithcrew
				  , mcc_spawnname
				  , mcc_spawnfaction
				  , mcc_zone_number
				  , mcc_zoneinform
				  , mcc_zone_markername
				  , mcc_spawnbehavior
				  , mcc_grouptype 
				  , mcc_spawndisplayname
				  , mcc_track_units
				  , mcc_awareness
				  , mcc_sidename
				  , mcc_hc
				  , MCC_path
				  , mcc_spawn_dir
				  , mcc_marker_dir
				  ];
		};
	
		#ifdef DEBUG
		if !mcc_resetmissionmaker then
			{
				if !(mcc_isnewzone) then 
				{
					// Allright we are doing something else then making / updating zones, report that by hint				
					player sideChat format["Request ID: %3. Spawn %1 in zone %2. Contacting server......", mcc_spawnname , mcc_zone_markername,mcc_request];
					 
					//Set the behavior back from script understanding to human readable again											
					switch (mcc_spawnbehavior) do
					{
						case "MOVE":
						{
							_behavior = "Agressive";
						};

						case "NOFOLLOW":
						{
							_behavior = "Defensive";
						};

						case "NOMOVE":
						{					
							_behavior = "Passive";
						};
						
						case "FORTIFY":
						{					
							_behavior = "Fortify";
						};
						
						case "AMBUSH":
						{					
							_behavior = "Ambush";
						};
						
						default
						{					
							_behavior = "Defensive";
						};
					};												
					_diaryrecord = "";
					// Lets find out what you want and put that in our diary on the right zone
					switch (mcc_spawntype) do
					{
						case "MAN":
						{
							
							_diaryrecord = format ["Spawned (Man) %1, with behavior %2.",mcc_spawndisplayname, _behavior] ;				
						};

						case "VEHICLE":
						{
							
							if mcc_spawnwithcrew then 
								{ 
									_diaryrecord = format ["Spawned (Vehicle) %1, with behavior %2.",mcc_spawndisplayname, _behavior];
								}
							else
								{ 
									_diaryrecord = format ["Spawned (Vehicle) empty %1.",mcc_spawndisplayname, _behavior];
								};
						};						
						
						case "AMMO":
						{
							
							
									_diaryrecord = format ["Spawned %1.",mcc_spawndisplayname, _behavior];
							
						};

						case "DOC":
						{					
							
							if mcc_spawnwithcrew then 
								{ 
									_diaryrecord = format ["Spawned (DOC) %1 with defensive units.",mcc_spawndisplayname, _behavior];
								}
							else
								{ 
									_diaryrecord = format ["Spawned (doc) %1 with no units in it.",mcc_spawndisplayname, _behavior];
								};																
						};
						
						case "GROUP":
						{					
								
								_diaryrecord = format ["Spawned (Group) %1, with behavior %2.",mcc_spawndisplayname, _behavior] ;							
						};
						
						case "PARATROOPER":
						{					
								
								_diaryrecord = "Spawned paratroopers";
						};
					}; // end switch (mcc_spawntype) do				
					
					
					player createDiaryRecord ["MCCZones", [mcc_zone_markername, _diaryrecord]];
				}
				else
				{
					// We are creating/updating a zone, lets report that by hint
					player sideChat format["Request ID: %2. Update zone %1. Contacting server......",  mcc_zone_markername,mcc_request];
				};
			}
			else
			{
				player sideChat format["Request ID: %2. Requesting to logout %1. Contacting server......",  player,mcc_request];
				ace_sys_spectator_can_exit_spectator = false;			
			};
			#endif
			//obviously when we are loading there is no need to safe it again since that will influence the load process by double output


			// Save data in my_pv variable
			_ar =	[ mcc_spawntype
					, mcc_classtype
					, mcc_isnewzone
					, mcc_spawnwithcrew
					, mcc_spawnname
					, mcc_spawnfaction
					, mcc_zone_number
					, mcc_zoneinform
					, mcc_zone_markername
					, mcc_spawnbehavior
					, (mcc_zone_pos select (mcc_zone_number))
					, (mcc_zone_size select (mcc_zone_number))
					, ((mcc_zone_size select (mcc_zone_number)) select 1)
					, mcc_sidename
					, player
					, mcc_request
					, mcc_track_units
					, mcc_resetmissionmaker
					, (name player)
					, mcc_awareness
					, mcc_hc
					, mcc_spawn_dir
					, 0 //(mcc_zonetype select 0 ) select 1
					, 0 //(mcc_zonetypenr select 0 ) select 1
					, mcc_marker_dir
					];

			// Send data over the network, or when on server, execute directly
			
			if ( (isServer) && ( (mcc_hc == 0) || !(MCC_isHC) ) ) then 
			{
				[_ar, "mcc_setup", false, false] spawn BIS_fnc_MP;

				if ( ( mcc_hc == 1 ) && (MCC_isHC) ) then 
				{
					// mcc_hc zone defined but no HC found
					diag_log format ["Called 'mcc_setup' Local Event on Server - isServer [%1] - isHC: [%2] - MCC_HC: [%3]", isServer, MCC_isHC, mcc_hc];
				};
			}
			else 
			{
				if ( ( mcc_hc == 0 ) || !(MCC_isHC) ) then
				{
					//[_ar, "mcc_setup", true, false] spawn BIS_fnc_MP;
					[_ar, "mcc_setup", false, false] spawn BIS_fnc_MP;
					diag_log format ["Called 'mcc_setup' Remote Event on Server - isServer [%1] - isHC: [%2] - MCC_HC: [%3]", isServer, MCC_isHC, mcc_hc];
				};
				
				if (( mcc_hc == 1 ) && (MCC_isHC)) then
				{
					//[_ar, "mcc_setup_hc", true, false] spawn BIS_fnc_MP;
					[_ar, "mcc_setup_hc", MCC_ownerHC, false] spawn BIS_fnc_MP;
					diag_log format ["Called 'mcc_setup_hc' Remote Event on Headless Client - isServer [%1] - isHC: [%2] - MCC_HC: [%3] - MCC_HC_Owner: [%4]", isServer, MCC_isHC, mcc_hc, MCC_ownerHC];
				};					
			};

			//If we came out of here then we need reset some stuff empty
			mcc_isnewzone = false;
			mcc_grouptype = "";
			mcc_spawntype = "";
			mcc_classtype = "";
			mcc_spawnname = "";
			mcc_spawnfaction ="";
			mcc_resetmissionmaker = false;
	};
		