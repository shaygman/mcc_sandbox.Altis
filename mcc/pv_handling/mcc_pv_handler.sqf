// Enable debug mode, enables tracing to rpt. PARAMS_# autotracing etc.
#define DEBUG_MODE_FULL
// Define functions

my_pv = [];
#define DEBUG

if (isServer) then
{

	if (isnil "MCC_Chat") then {MCC_Chat = true};

	mcc_setup =  {_this call my_pv_handler};
	diag_log format ["Added 'mcc_setup' EventHandler for Server"];
};

if ( MCC_isLocalHC ) then
{
	if (isnil "MCC_Chat") then {MCC_Chat = true};
	mcc_setup_hc ={_this call my_pv_handler};
	if (isnil "MCC_Chat") then {MCC_Chat = true};
	diag_log format ["Added 'mcc_setup_hc' EventHandler for HeadLess Client"];
};

my_pv_handler =
	{
		private ["_p_mcc_spawntype"
				,"_p_mcc_classtype"
				,"_p_mcc_iszone_update"
				,"_p_mcc_spawnwithcrew"
				,"_p_mcc_spawnname"
				,"_p_mcc_spawnfaction"
				,"_p_mcc_zone_number"
				,"_p_mcc_zone_inform"
				,"_p_mcc_zone_markername"
				,"_p_mcc_zone_behavior"
				,"_p_mcc_zone_markposition"
				,"_p_mcc_zone_markerSize"
				,"_p_maxrange"
				,"_p_mcc_grouptype"
				,"_p_mcc_player"
				,"_p_mcc_request"
				,"_p_mcc_track_units"
				,"_p_mcc_resetmissionmaker"
				,"_p_mcc_player_name"
				,"_p_safepos"
				,"_unitspawned"
				,"_mappos"
				,"_trackername"
				,"_markerobj"
				,"_markertype"
			    ,"_track_units"
				,"_spawndirection"
				,"_p_mcc_zonetype"
				,"_p_mcc_zonetypenr"
				,"_p_mcc_marker_zone_dir"
				,"_p_mcc_marker_zone_type"
				,"_p_mcc_patrol_wps"
				,"_p_mcc_hc"
				,"_p_mcc_spawn_dir"
				,"_p_mcc_cache"
				,"_mmcZoneTypeNr"
				,"_specialUps"
				,"_specialUpsNr"
				,"_specialUpsRandom"
				,"_zoneSize"
				,"_radius"
				,"_zoneLogType"
				];

		disableSerialization;

		_p_mcc_spawntype 			= _this select 0;
		_p_mcc_classtype			= _this select 1;
		_p_mcc_iszone_update		= _this select 2;
		_p_mcc_spawnwithcrew		= _this select 3;
		_p_mcc_spawnname			= _this select 4;
		_p_mcc_spawnfaction			= _this select 5;
		_p_mcc_zone_number			= _this select 6;
		_p_mcc_zone_inform			= _this select 7;
		_p_mcc_zone_markername		= _this select 8;
		_p_mcc_zone_behavior		= _this select 9;
		_p_mcc_zone_markposition	= _this select 10;
		_p_mcc_zone_markerSize		= _this select 11;
		_p_maxrange					= _this select 12;
		_p_mcc_grouptype			= _this select 13;
		_p_mcc_player				= _this select 14;
		_p_mcc_request				= _this select 15;
		_p_mcc_track_units			= _this select 16;
		_p_mcc_resetmissionmaker	= _this select 17;
		_p_mcc_player_name			= _this select 18;
		_p_mcc_awareness			= _this select 19;
		_p_mcc_hc					= _this select 20;
		_p_mcc_spawn_dir 			= _this select 21; if ( isNil "_p_mcc_spawn_dir"       ) then { _p_mcc_spawn_dir = [0,0,0];       };
		_p_mcc_zonetype				= 0; //_this select 22; if ( isNil "_p_mcc_zonetype"        ) then { _p_mcc_zonetype = 0;        };
		_p_mcc_zonetypenr			= 0; //_this select 23; if ( isNil "_p_mcc_zonetypenr"      ) then { _p_mcc_zonetypenr = 0;      };
		_p_mcc_marker_zone_dir		= _this select 24; if ( isNil "_p_mcc_marker_zone_dir" ) then { _p_mcc_marker_zone_dir = 0; };
		_p_safepos					= _this select 25;
		_p_mcc_cache				= if (count _this > 26) then {_this select 26} else {false};
		_p_mcc_delayed				= if (count _this > 27) then {_this select 27} else {false};
		_p_mcc_marker_zone_type 	= "RECTANGLE";
		_p_mcc_patrol_wps			= [];

		if !(_p_mcc_delayed and !_p_mcc_iszone_update) then
		{

				if (TypeName _p_mcc_grouptype != "STRING") then {_p_mcc_grouptype = str _p_mcc_grouptype};

				//_zoneSize		= mcc_zone_size select (_p_mcc_zone_number);
				//_radius 		= (((_zoneSize select 0) + (_zoneSize select 1))/2);
				_radius 		= (((_p_mcc_zone_markerSize select 0) + (_p_mcc_zone_markerSize select 1))/2);

				//------------ Start Special Zone Stuff ----------

				_specialUps = "";
				_specialUpsNr = 1;
				_specialUpsRandom = "";

				switch (_p_mcc_zonetype) do		//Which zone type
					{
						case 0:	//regular
						{
							_zoneLogType = "MCC REGULAR";
							_specialUpsNr = "";
						};

						case 1:	//repawn
						{
							_zoneLogType = "MCC RESPAWN";
							if ( _p_mcc_zonetypenr == 0 ) then
							{
								_specialUps = "RESPAWN";
								_specialUpsNr = "";
								_specialUpsRandom = "RANDOMDN";
							}
							else
							{
								_specialUps = "RESPAWN:";
								_specialUpsNr = _p_mcc_zonetypenr;
								_specialUpsRandom = "RANDOMDN";
							};
						};

						case 2:	//patrol
						{
							_zoneLogType = "MCC PATROL";
							_specialUps = "NOWAIT";
							_specialUpsNr = "";
						};

						case 3:	//reinforcement
						{
							_zoneLogType = "MCC REINFORCEMENT";
							_specialUpsNr = "";
						};
					};

			//------------ End Special Zone Stuff ----------

			#ifdef DEBUG
				diag_log format["my_pv: %1 - %2",_zoneLogType, _this];
			#endif

				if _p_mcc_track_units then { _track_units = "TRACK";} else { _track_units = "NOTHING";};

				if ( _p_mcc_resetmissionmaker ) then
				{
					if (MCC_Chat) then
					{
						[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> %2 Logged out as Misson Maker",_p_mcc_request,mcc_missionMaker], false],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
					};
					mcc_missionmaker="";
					publicVariable "mcc_missionmaker";
				}
				else
				{
					// If it is a new zone (marker) then we need to make it also on the server
					if _p_mcc_iszone_update then
							{
							 if  (format["%1", getMarkerPos _p_mcc_zone_markername]== "[0,0,0]") then
								{
									// Create Marker
									createMarkerLocal [_p_mcc_zone_markername, _p_mcc_zone_markposition];
									_p_mcc_zone_markername setMarkerShapeLocal _p_mcc_marker_zone_type;
									_p_mcc_zone_markername setMarkerSizeLocal _p_mcc_zone_markerSize;
									_p_mcc_zone_markername setMarkerDirLocal _p_mcc_marker_zone_dir;
								}
							else
								{
									_p_mcc_zone_markername SetMarkerPosLocal _p_mcc_zone_markposition;
									_p_mcc_zone_markername setMarkerShapeLocal _p_mcc_marker_zone_type;
									_p_mcc_zone_markername setMarkerSizeLocal _p_mcc_zone_markerSize;
									_p_mcc_zone_markername setMarkerDirLocal _p_mcc_marker_zone_dir;
								};
							};

					// Dont start using the BIS functions till they are ready for lift off sir...3...2...1.... GO
					waituntil {!isnil "bis_fnc_init"};

				if (format["%1",_p_safepos] != "[-500,-500,0]" ) then
				{
					// As some stuff needs to be spawned from the inside of the zone to the outside we need that direction
					_spawndirection = [_p_mcc_zone_markposition, _p_safepos] call BIS_fnc_dirTo;

					if (_p_mcc_spawntype == "Reinforcement") then
					{
						if (_p_mcc_spawnname in ["0","1","2","3","4","5","6","7","8"] || _p_mcc_spawnname in [0,1,2,3,4,5,6,7,8]) then
						{
							[[(_p_safepos select 0),(_p_safepos select 1),0],_p_mcc_grouptype,_p_mcc_spawnname,_p_mcc_zone_markername,_p_mcc_zone_behavior,_p_mcc_awareness,_p_mcc_spawnfaction,_p_mcc_spawn_dir] spawn MCC_fnc_paratroops;
						}
						else
						{
							[[(_p_safepos select 0),(_p_safepos select 1),0],_p_mcc_grouptype, _p_mcc_spawnname,_p_mcc_zone_markername,_p_mcc_spawnfaction,_p_mcc_spawn_dir] spawn MCC_fnc_reinforcement;
						};
					};

					//Hey its a dude, lets get him out there
					if (_p_mcc_spawntype == "MAN") then
						{
							if (_p_mcc_spawnfaction=="GUER") then
								{_unitspawned = createGroup resistance;};
							if (_p_mcc_spawnfaction=="WEST") then
								{_unitspawned = createGroup west;};
							if (_p_mcc_spawnfaction=="EAST") then
								{_unitspawned = createGroup east;};
							if (_p_mcc_spawnfaction=="CIV") then
								{_unitspawned = createGroup civilian;};


							_dummyUnit = _unitspawned createUnit [_p_mcc_spawnname, _p_safepos, [],0,""];

							//Curator
							MCC_curator addCuratorEditableObjects [[_dummyUnit],false];

									_dummyUnit setSkill ["aimingspeed", MCC_AI_Aim];
									_dummyUnit setSkill ["spotdistance", MCC_AI_Spot];
									_dummyUnit setSkill ["aimingaccuracy", MCC_AI_Aim];
									_dummyUnit setSkill ["aimingshake", MCC_AI_Aim];
									_dummyUnit setSkill ["spottime", MCC_AI_Spot];
									_dummyUnit setSkill ["commanding", MCC_AI_Command];
									_dummyUnit setSkill ["general", MCC_AI_Skill];

							if (MCC_Chat) then
							{
								[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned ""%2"" of type %3.",_p_mcc_request,_unitspawned,_p_mcc_spawnname], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
							};

							if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
							{
								//nul = [leader _unitspawned, _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units,"spawned" ,_p_mcc_awareness  ] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
								_unitspawned setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
								_unitspawned setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
							}
							else
							{
								_unitspawned setvariable ["MCC_canbecontrolled",true,true];
								if (_p_mcc_zone_behavior == "bisd") then {[_unitspawned, getPos leader _unitspawned] call bis_fnc_taskDefend};
								if (_p_mcc_zone_behavior == "bisp") then {[_unitspawned, getPos leader _unitspawned, _radius] call bis_fnc_taskPatrol};
							};

							if ( MCC_trackdetail_units ) then {  [leader _unitspawned, "WP"] execVm format ["%1scripts\track.sqf",MCC_path] };
						};

					//Hey its an animal, lets get him out there
					if (_p_mcc_spawntype == "ANIMAL") then
						{
							_unitspawned = createGroup sidelogic;
							_dummyUnit = _unitspawned createUnit [_p_mcc_spawnname, _p_safepos, [],0,""];

							//Curator
							MCC_curator addCuratorEditableObjects [[_dummyUnit],false];

							if (MCC_Chat) then
							{
								[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned ""%2"" of type %3.",_p_mcc_request,_unitspawned,_p_mcc_spawnname], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
							};

						};

					//Incase we encounter a vehicle
					if ((_p_mcc_spawntype == "VEHICLE") or (_p_mcc_spawntype == "AMMO")) then
						{
							if (_p_mcc_spawnwithcrew and (_p_mcc_spawntype == "VEHICLE") ) then
								{
									private ["_vehicleClass"];
									//Some sort of vehicle, now if the config has any crew we spawn it with it, incase not, well its still empty
									_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> _p_mcc_spawnname >> "vehicleClass"));
									if (typeName _p_mcc_spawnfaction == "SIDE") then {_p_mcc_spawnfaction = str _p_mcc_spawnfaction};

									if (_p_mcc_spawnfaction=="GUER") then
										{_unitspawned 	=	[_p_safepos, _spawndirection, _p_mcc_spawnname, resistance] call BIS_fnc_spawnVehicle;};
									if (_p_mcc_spawnfaction=="WEST") then
										{ _unitspawned 	=	[_p_safepos, _spawndirection, _p_mcc_spawnname, WEST] call BIS_fnc_spawnVehicle;};
									if (_p_mcc_spawnfaction=="EAST") then
										{ _unitspawned 	=	[_p_safepos, _spawndirection, _p_mcc_spawnname, EAST] call BIS_fnc_spawnVehicle;};
									if (_p_mcc_spawnfaction=="CIV") then
										{ _unitspawned 	=	[_p_safepos, _spawndirection, _p_mcc_spawnname, civilian] call BIS_fnc_spawnVehicle;};

									//If UAV or UGV
									if (_vehicleClass == "autonomous") then
										{
											createVehicleCrew (_unitspawned select 0);
											(group (_unitspawned select 0)) setvariable ["MCC_canbecontrolled",true,true];
										};

									//Curator
									MCC_curator addCuratorEditableObjects [[(_unitspawned select 0)],true];

									//Find out who is the poor bastard leading this joint and then give him something to do with UPS
									//Specific resctrictions or lifting rescrictions on type of unit in UPS
									switch (_p_mcc_classtype) do
										{
											case "AIR":
											{
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader (_unitspawned select 2), _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER","NOWAIT","NOSLOW",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units,"spawned",_p_mcc_awareness] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
													(_unitspawned select 2) setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													//(_unitspawned select 2) setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													(_unitspawned select 2) setvariable ["MCC_canbecontrolled",true,true];
												};
											};

											case "LAND":
											{
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader (_unitspawned select 2), _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER",_track_units,"spawned",_specialUps,_specialUpsNr,_specialUpsRandom, _p_mcc_awareness] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
													(_unitspawned select 2) setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													(_unitspawned select 2) setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													(_unitspawned select 2) setvariable ["MCC_canbecontrolled",true,true];
												};
											};

											case "WATER":
											{
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader (_unitspawned select 2), _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER","NOWAIT",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units,"spawned",_p_mcc_awareness] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
													(_unitspawned select 2) setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													(_unitspawned select 2) setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													(_unitspawned select 2) setvariable ["MCC_canbecontrolled",true,true];
												};
											};
										};

									if ( MCC_trackdetail_units ) then {  [leader (_unitspawned select 2), "WP"] execVm format ["%1scripts\track.sqf",MCC_path] };

									if (MCC_Chat) then
									{
										[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned ""%3"" of type %2.",_p_mcc_request,_p_mcc_spawnname,(_unitspawned select 0)], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
									};
								}
							else
								{
									//Vehicle without any crew, so here we go
									// May spawn on land and water..
									_safepos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,1,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;

									_unitspawned 	= _p_mcc_spawnname createVehicle _p_safepos;

									//Curator
									MCC_curator addCuratorEditableObjects [[_unitspawned],false];

									if (MCC_Chat) then
									{
										[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned type %2.",_p_mcc_request,_p_mcc_spawnname], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
									};
								};

						};


					//What we do if we find a DOC (Dynamic Object Composition)
					if (_p_mcc_spawntype == "DOC") then
						{
							//Well we need a dynamic object composition to spawn so we us a BIS function for that.
							_unitspawned =[ _p_safepos, _spawndirection, _p_mcc_spawnname] call MCC_fnc_objectMapper;

							if (MCC_Chat) then
							{
								[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned type %2.",_p_mcc_request,_p_mcc_spawnname], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
							};


						};

					//Now the spawntype is a predefined group in the config, now this needs some specific handling, a BIS function is available so lets go
					if (_p_mcc_spawntype == "GROUP") then
						{
									_p_mcc_spawnfaction = if (typeName _p_mcc_spawnfaction == "STRING") then {(call compile _p_mcc_spawnfaction)} else {_p_mcc_spawnfaction};
									//Depending on faction we spawn for side
									if (_p_mcc_grouptype=="GUER") then
										{_unitspawned=[_p_safepos, resistance, _p_mcc_spawnfaction,[],[],[0.1,MCC_AI_Skill]] call MCC_fnc_spawnGroup;};
									if (_p_mcc_grouptype=="WEST") then
										{_unitspawned=[_p_safepos, west, _p_mcc_spawnfaction,[],[],[0.1,MCC_AI_Skill]] call MCC_fnc_spawnGroup;};
									if (_p_mcc_grouptype=="EAST") then
										{_unitspawned=[_p_safepos, east, _p_mcc_spawnfaction,[],[],[0.1,MCC_AI_Skill]] call MCC_fnc_spawnGroup;};
									if (_p_mcc_grouptype=="CIV") then
										{_unitspawned=[_p_safepos, civilian, _p_mcc_spawnfaction,[],[],[0.1,MCC_AI_Skill]] call MCC_fnc_spawnGroup;};

									{
										_x setSkill ["aimingspeed", MCC_AI_Aim];
										_x setSkill ["spotdistance", MCC_AI_Spot];
										_x setSkill ["aimingaccuracy", MCC_AI_Aim];
										_x setSkill ["aimingshake", MCC_AI_Aim];
										_x setSkill ["spottime", MCC_AI_Spot];
										_x setSkill ["commanding", MCC_AI_Command];
										_x setSkill ["general", MCC_AI_Skill];
									} foreach units _unitspawned;

									//Find out who is the poor bastard leading this joint and then give him something to do with UPS
									//Specific resctrictions or lifting rescrictions on type of unit in UPS
									switch (_p_mcc_classtype) do
										{
											case "AIR":
											{
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader _unitspawned, _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER", "NOWAIT", "NOSLOW", "spawned",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units, _p_mcc_awareness  ] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
													_unitspawned setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													_unitspawned setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													_unitspawned setvariable ["MCC_canbecontrolled",true,true];
												};
											};

											case "LAND":
											{
												_unitspawned setFormation (MCC_groupFormation select (floor random (count MCC_groupFormation)));
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader _unitspawned, _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units, "spawned", _p_mcc_awareness   ] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
													_unitspawned setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													_unitspawned setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													_unitspawned setvariable ["MCC_canbecontrolled",true,true];
													if (_p_mcc_zone_behavior == "bisd") then {[_unitspawned, getPos leader _unitspawned] call bis_fnc_taskDefend};
													if (_p_mcc_zone_behavior == "bisp") then {[_unitspawned, getPos leader _unitspawned, _radius] call bis_fnc_taskPatrol};
												};
											};

											case "DIVER":
											{
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader _unitspawned, _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER", "NOWAIT",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units, "spawned", _p_mcc_awareness  ] execVm format ["%1scripts\UPSMON.sqf",MCC_path];
													_unitspawned setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													_unitspawned setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													_unitspawned setvariable ["MCC_canbecontrolled",true,true];
													if (_p_mcc_zone_behavior == "bisd") then {[_unitspawned, getPos leader _unitspawned] call bis_fnc_taskDefend};
													if (_p_mcc_zone_behavior == "bisp") then {[_unitspawned, getPos leader _unitspawned, _radius] call bis_fnc_taskPatrol};
												};
											};

											case "WATER":
											{
												if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
												{
													//nul = [leader _unitspawned, _p_mcc_zone_markername, _p_mcc_zone_behavior, "SHOWMARKER", "NOWAIT",_specialUps,_specialUpsNr,_specialUpsRandom,_track_units, "spawned", _p_mcc_awareness  ] execVm format ["%1scripts\UPSMON.sqf",MCC_path];;
													_unitspawned setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];
													_unitspawned setVariable ["mcc_gaia_cache",_p_mcc_cache, true];
												}
												else
												{
													_unitspawned setvariable ["MCC_canbecontrolled",true,true];
												};
											};
										};

									//if ( MCC_trackdetail_units ) then {  [leader _unitspawned, "GROUP","WP"] execVm format ["%1scripts\track.sqf",MCC_path] };

									if (MCC_Chat) then
									{
										[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned ""%3"" of type %2.",_p_mcc_request,_p_mcc_spawnname,((units _unitspawned) select 0)], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
									};


						};

					// Special zone stuff
					if ( ( _p_mcc_zonetype == 2 ) && ( _p_mcc_spawntype != "" ) ) then
					{
						_patrolGrp = _unitspawned;

						//Patrol zone -> start patrol cycle
						//diag_log format ["MCC PATROL START: %1 - %2 - %3 - %4", _p_mcc_zone_number, _patrolGrp, _p_mcc_zone_markername, _p_mcc_patrol_wps];
						[_p_mcc_zone_number, _patrolGrp, _p_mcc_zone_markername, _p_mcc_patrol_wps] spawn mcc_patrol_switch;
					};
					//===================
				};
				if _p_mcc_iszone_update then
					{
						if (MCC_Chat) then
						{
							[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Created/Updated zone: %2.",_p_mcc_request,_p_mcc_zone_markername], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
						};
					}
				else
					{
						if (format["%1",_p_safepos] != "[-500,-500,0]" )
						then
							{
								if (MCC_Chat) then
								{
									[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Spawned in grid: %2.",_p_mcc_request,(_p_safepos call BIS_fnc_PosToGrid)], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
								};
							}
						else
							{
								if (MCC_Chat) then
								{
									[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> SPAWN FAILED! No good position found!",_p_mcc_request], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
								};
							};
					};
				};
		}
		else
		// We are delaying the spawn, so stack it up (same as caching system)
		{
			MCC_DELAYED_SPAWNS = MCC_DELAYED_SPAWNS+ [_p_safepos];
			_var2 = "MCC_DELAY" + str(_p_safepos);
			missionNamespace setVariable [_var2, _this ];
			[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Delayed Spawned in grid: %2.",_p_mcc_request,(_p_safepos call BIS_fnc_PosToGrid)], true],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;

		};
	};
