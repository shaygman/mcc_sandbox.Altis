private ["_pos", "_dir","_class","_type","_faction","_unitspawned","_dummy","_notEmpty","_init","_name","_dummyGroup","_loc","_vehicleClass","_tempInit"];
_pos 	 = _this select 0;
_dir 	 = _this select 1;
_class	 = _this select 2;
_type	 = _this select 3;
_faction = _this select 4;
_notEmpty	 = _this select 5;
_init	 = _this select 6;
_name	 = _this select 7;
_loc	 = _this select 8;

if ( ( (isServer) && ( (_loc == 0) || !(MCC_isHC) ) ) || ( (MCC_isLocalHC) && (_loc == 1) ) ) then
{
	diag_log format ["%1 - spawning 3D Editor object [%2]", time, _class];

	switch (_type) do		//Which type do we want
			{
				case "MAN":
				{
					_unitspawned = createGroup (((getNumber (configFile >> "CfgVehicles" >> _class >> "side")) call BIS_fnc_sideType));
					_dummy = _unitspawned createUnit [_class, _pos, [], 0, "NONE"];
					_dummy setpos _pos;
					_dummy setdir _dir;
					sleep 0.01;

					_tempInit = _init;
					if (!MCC_align3D) then
					{
						_dummy setpos _pos;
						_tempInit= _tempInit +	FORMAT [";_this setpos %1;",_pos];
					};

					_dummy setVariable ["vehicleinit", _tempInit, true];

					//setskill
					_unitspawned setformdir _dir;

					_dummy setSkill ["aimingspeed", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
					_dummy setSkill ["spotdistance", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
					_dummy setSkill ["aimingaccuracy", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
					_dummy setSkill ["aimingshake", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
					_dummy setSkill ["spottime", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
					_dummy setSkill ["commanding", (missionNamespace getVariable ["MCC_AI_Command",0.5])];
					_dummy setSkill ["general", (missionNamespace getVariable ["MCC_AI_Skill",0.5])];

					if (_name != "") then
					{
						[[[netid _dummy,_dummy], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
					};
					[[[netid _dummy,_dummy], _init, false], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

					//Curator
					{_x addCuratorEditableObjects [[_dummy],false]} forEach allCurators;
				};

				case "ANIMAL":
				{
					_unitspawned = createGroup sidelogic;
					_dummy = _unitspawned createUnit [_class, _pos, [], 0, "NONE"];
					_dummy setpos _pos;
					_dummy setdir _dir;
					sleep 0.01;

					_tempInit = _init;
					if (!MCC_align3D) then
					{
						_dummy setpos _pos;
						_tempInit= _tempInit +	FORMAT [";_this setpos %1;",_pos];
					};

					_dummy setVariable ["vehicleinit", _tempInit, true];

					_unitspawned setformdir _dir;
					if (_name != "") then
					{
						[[[netid _dummy,_dummy], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
					};
					[[[netid _dummy,_dummy], _init, false], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

					//Curator
					{_x addCuratorEditableObjects [[_dummy],false]} forEach allCurators;
				};

				case "VEHICLE":
				{
					if (_notEmpty) then
					{
						private ["_side","_veh","_crew"];
						_side = (((getNumber (configFile >> "CfgVehicles" >> _class >> "side")) call BIS_fnc_sideType));

						if (!isnil "Object3D") then {waitUntil {_pos distance Object3D > 15}};
						_veh = createvehicle [_class,_pos,[],0,"none"];
						_veh setpos _pos;
						_veh setdir _dir;
						_grp = createGroup _side;

						//If autonomous
						_vehicleClass 	=  getText (configFile >> "CfgVehicles" >> _class >> "vehicleClass");
						if (_vehicleClass == "autonomous") then
						{
							createVehicleCrew _veh;
						};

						_crew = [_veh, _grp] call BIS_fnc_spawnCrew;
						_dummy = [_veh,_crew,_grp];

						(_dummy select 0) setSkill ["aimingspeed", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
						(_dummy select 0) setSkill ["spotdistance", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
						(_dummy select 0) setSkill ["aimingaccuracy", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
						(_dummy select 0) setSkill ["aimingshake", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
						(_dummy select 0) setSkill ["spottime", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
						(_dummy select 0) setSkill ["commanding", (missionNamespace getVariable ["MCC_AI_Command",0.5])];
						(_dummy select 0) setSkill ["general", (missionNamespace getVariable ["MCC_AI_Skill",0.5])];

						if (_name != "") then
						{
							[[[netid (_dummy select 0),(_dummy select 0)], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
						};

						_tempInit = _init +	FORMAT [";group _this setFormDir %1;",_dir];
						if (!MCC_align3D) then
						{
							(_dummy select 0) setpos _pos;
							_tempInit= _tempInit +	FORMAT [";_this setpos %1;",_pos];
						};

						(_dummy select 0) setVariable ["vehicleinit", _tempInit, true];


						[[[netid (_dummy select 0),(_dummy select 0)], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

						//Curator
						{_x addCuratorEditableObjects [[(_dummy select 0)],true]} forEach allCurators;
					}
					else
					{
						if (!isnil "Object3D") then {waitUntil {_pos distance Object3D > 15}};
						_dummy = _class createvehicle _pos;
						_dummy setpos _pos;
						_dummy setdir _dir;
						sleep 0.01;

						_tempInit = _init;
						if (!MCC_align3D) then
						{
							_dummy setpos _pos;
							_tempInit= _tempInit +	FORMAT [";_this setpos %1;",_pos];
						};

						_dummy setVariable ["vehicleinit", _tempInit, true];

						if (_name != "") then
						{
							[[[netid _dummy,_dummy], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
						};
						[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

						//Curator
						{_x addCuratorEditableObjects [[_dummy],false]} forEach allCurators;
					};
				};

				case "AMMO":
				{
					_dummy = _class createvehicle _pos;
					_dummy setpos _pos;
					_dummy setdir _dir;
					sleep 0.01;

					_tempInit = _init;
					if (!MCC_align3D) then
					{
						_dummy setpos _pos;
						_tempInit= _tempInit +	FORMAT [";_this setpos %1;",_pos];
					};

					_dummy setVariable ["vehicleinit", _tempInit, true];

					if (_name != "") then
					{
						[[[netid _dummy,_dummy], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
					};
					[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

					//Curator
					{_x addCuratorEditableObjects [[_dummy],false]} forEach allCurators;
				};

				case "MINES":
				{
					_dummy = createMine [_class, _pos, [], 0];
					_dummy setpos _pos;
					_init = format ["%1;_this setdir %2;",_init,_dir];
					sleep 0.01;
					if (_name != "") then
					{
						[[[netid _dummy,_dummy], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
					};
					[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

					//Curator
					{_x addCuratorEditableObjects [[_dummy],false]} forEach allCurators;
				};

				case "DOC":
				{
					_unitspawned =[ _pos, _dir, _class] call MCC_fnc_objectMapper;
				};
			};
	if (!isnil "_dummy") then
	{
		MCC_lastSpawn set [count MCC_lastSpawn,_dummy];
		publicVariable "MCC_lastSpawn";
	};
};

MCC_mccFunctionDone = true;
publicvariable "MCC_mccFunctionDone";
