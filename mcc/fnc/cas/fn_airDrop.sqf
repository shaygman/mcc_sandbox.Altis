//========================================================MCC_fnc_airDrop =========================================
//  Parameter(s):
//     	0: _ammount - 	integer
//     	1: spawnkind: 	ARRAY of STRING  - CAS type class Gun-run short","Gun-run long","Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)
//		2: _pos:		POSITION - cas target pos
//		3: _planeType:	STRING plane vehicle class for CAS or "west","east","guer","civ","logic" for airdrop
//		4: _spawn		POSITION: plane spawn pos
//		5: _away		POSITION: plane despawn pos
//		6: _isParachute	INTEGER: <optional> 0 - parachute from helicopter. 1 - if it is slingload.  2 - parachute from thin air 3 - spawn crew
//		CAS Script by Shay_gman 08.01.12
//==============================================================================================================================================================================

private ["_ammount", "_spawnkind", "_pos", "_spawn", "_away", "_pilot1", "_pilotGroup1", "_wp", "_wp2", "_plane1", "_planepos","_missile", "_planeType", "_planeAltitude", "_target", "_fakeTarget", "_lasertargets", "_nukeType", "_bomb2", "_cas_name", "_poswp", "_distA","_distB", "_nul", "_loop","_x","_wp","_plane2","_pilot2","_pilotGroup2","_typeOfAircraft", "_distStart", "_distEngage", "_targetList", "_startTime", "_casMarker", "_casApproach","_isParachute","_planeClasss","_isHeliDLC","_object","_sling"];
#define mcc_playerConsole_IDD 2993

_ammount				= _this select 0;
_spawnkind				= _this select 1 select 0;
_pos					= _this select 2;
_planeType				= _this select 3 select 0;
_spawn					= _this select 4;
_away					= _this select 5;
_isParachute			= param [6,0,[0]];

//=====================================================

//start the drop
//If it's an airdrop
if (tolower _planeType in ["west","east","guer","civ","logic"]) then  {

	//If parachute from thin air exit here:
	if (_isParachute >= 2) exitWith {
		_pos = [_pos select 0,_pos select 1, (_pos select 2) + 300];
		for [{_x=0},{_x < count _spawnkind},{_x=_x+1}] do {
			_pos = [_pos, [_pos,_away] call BIS_fnc_dirTo,20] call BIS_fnc_relPos;
			[_pos, _spawnkind select _x, objNull,_isParachute == 3] spawn MCC_fnc_CreateAmmoDrop;
			sleep 3 + random 3;
		};
	};

	//Lets Spawn a plane
	_isHeliDLC = isClass (configFile >> "CfgPatches" >> "A3_Air_F_Heli_Heli_Transport_03");
 	_planeClasss = if (_isHeliDLC) then {
		switch (tolower _planeType) do {
		    case "east": {"O_Heli_Transport_04_F"};
		    case "west": {"B_Heli_Transport_03_unarmed_F"};
		    default {"I_Heli_Transport_02_F"};
		};
	} else {"I_Heli_Transport_02_F"};

	_plane1 			= [_planeClasss, _spawn, _pos, 100, true] call MCC_fnc_createPlane;		//Spawn plane 1
	_pilotGroup1		= group _plane1;
	_pilot1				= driver _plane1;

	if (tolower _planeType == "east" && !_isHeliDLC) then
	{
		_plane1 setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
		_plane1 setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
		_plane1 setObjectTextureGlobal [2,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
	};

	if (tolower _planeType == "west" && !_isHeliDLC) then
	{
		_plane1 setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
		_plane1 setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
		_plane1 setObjectTextureGlobal [2,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
	};

	//Attach slingload
	if (_isParachute == 1) then {
		_object = (_spawnkind select 0) createvehicle [10,10,500];
		_object setpos (_plane1 modeltoworld [0,0,-15]);
		_sling = _plane1 setSlingload _object;

		sleep 2;
		_wp = (group _plane1) addWaypoint [[_pos select 0, _pos select 1, 0], 0];	//Add WP
		_wp setWaypointType "UNHOOK";
		_wp setWaypointStatements ["true", ""];
		_wp setWaypointSpeed "FULL";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointCompletionRadius 200;
		_plane1 flyInHeight 100;

		waitUntil {((((count (waypoints _pilotGroup1)) - currentWaypoint _pilotGroup1)==0)) || (!alive _plane1)};
		if (!alive _plane1) exitWith {};

		//workaround for some reason after vhicle is slingloaded it can't be driven
		_object spawn {
			private ["_pos","_dir","_class","_object"];
			waituntil {(isNull attachedTo _this) && ((getpos _this) select 2) < 2};

			_pos = getpos _this;
			_dir = getdir _this;
			_class = typeof _this;
			deleteVehicle _this;
			waituntil {isNull _this};
			_object = _class createvehicle _pos;
			_object setDir _dir;
			{_x addCuratorEditableObjects [[_object],false]} forEach allCurators;
		};

		sleep 5;
		//If the AI didn't make the drop
		if !(isnull (getSlingLoad _plane1)) then {
			_plane1 flyInHeight 15;
			sleep 30;
			{
				ropeCut [ _x, 5];
			} forEach (ropes _plane1);
			_plane1 flyInHeight 100;
		};

		//Delete the plane when finished
		[_pilotGroup1, _pilot1, _plane1, _away] spawn MCC_fnc_deletePlane;

	} else {
		sleep 2;
		_wp = (group _plane1) addWaypoint [[_pos select 0, _pos select 1, 0], 0];	//Add WP
		_wp setWaypointType "MOVE";
		_wp setWaypointStatements ["true", ""];
		_wp setWaypointSpeed "FULL";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointCompletionRadius 200;
		_plane1 flyInHeight 200;

		waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 600) || (!alive _plane1)};
		if (!alive _plane1) exitWith {};

		//Opend doors
		{_plane1 animateDoor [_x, 1]} foreach ["CargoRamp_Open"];

		sleep 5;
		//Make the drop

		//Delete the plane when finished
		[_pilotGroup1, _pilot1, _plane1, _away] spawn MCC_fnc_deletePlane;

		for [{_x=0},{_x < count _spawnkind},{_x=_x+1}] do {
			_planepos = getpos _plane1;
			[_planepos, _spawnkind select _x, _pilot1] spawn MCC_fnc_CreateAmmoDrop;
			sleep 3 + random 3;
		};

		{_plane1 animateDoor [_x, 0]} foreach ["CargoRamp_Open"];
	}
} else {
	//Case CAS

	//cruise missile
	if (tolower _spawnkind == "cruise missile") exitWith {
		while {dialog} do {closeDialog 0};
		//disable mouse control at start
		MCC_ConsoleUAVMouseButtonDown = false;

		_missile = "Bo_GBU12_LGB" createVehicle [_pos select 0, _pos select 1, 600];
		waituntil {alive _missile};
		missionNamespace setVariable ["MCC_ConolseUAV",_missile];

		//Switch to thermal
		missionNamespace setVariable ["MCC_ConsoleUAVCameraMod",2];

		createDialog "MCC_playerConsole2";
		waitUntil {!isNull (missionNamespace getVariable ["MCC_fakeUAV",objNull]) && !isNull (missionNamespace getVariable ["MCC_fakeUAVCenter",objNull])};

		playSound "missileLunch";
		[[[netid _missile,_missile], "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		[(missionNamespace getVariable ["MCC_fakeUAVCenter",objNull]), [ getpos _missile, 100, random 360] call BIS_fnc_relPos, _missile,80,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
	};

	//ac-130
	if (tolower _spawnkind == "ac-130") exitWith {
		//AC-130

		//If we pressed the AC 130 when we have one retired the last one.
		if (alive(missionNamespace getVariable ["MCC_ACConsoleUp",objNull])) then {
			private _uav = (missionNamespace getVariable ["MCC_ACConsoleUp",objNull]);
			[group driver _uav, driver _uav, _uav, _away] call MCC_fnc_deletePlane;
			missionNamespace setVariable ["MCC_ACConsoleUp",objNull];
			publicVariable "MCC_ACConsoleUp";

			[[2,compile format ['["MCCNotifications",["AC-130 Left the scene","%1data\AC130_icon.paa",""]] call bis_fnc_showNotification;',MCC_path]], "MCC_fnc_globalExecute", playerSide, false] spawn BIS_fnc_MP;
		} else {

			[[2,compile format ['["MCCNotifications",["AC-130 Entered the scene","%1data\AC130_icon.paa",""]] call bis_fnc_showNotification;',MCC_path]], "MCC_fnc_globalExecute", playerSide, false] spawn BIS_fnc_MP;

			_pos set [2,(_pos select 2)+400];

			//register AC-130
			//==================================
			_side =  (getNumber (configFile >> "CfgVehicles" >> _planeType >> "side")) call BIS_fnc_sideType;
			_uav = [_planeType, _spawn, _pos, 500, false,_side] call MCC_fnc_createPlane;

			_grp = group driver _uav;
			_grp setCombatMode "BLUE";
			_grp setBehaviour "CARELESS";

			_wp = _grp addWaypoint [_pos, 0];
			_wp setWaypointType "LOITER";
			_wp setWaypointLoiterType "CIRCLE_L";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointLoiterRadius 400;


			missionNamespace setVariable ["MCC_ACConsoleUp",_uav];
			missionNamespace setVariable ["MCC_consoleACpos",_pos];
			missionNameSpace setVariable ["MCC_ConsoleACTime",9999];
			publicVariable "MCC_ConsoleACTime";
			publicVariable "MCC_ACConsoleUp";
			publicVariable "MCC_consoleACpos";

			//Make controlabel
			_grp setvariable ["MCC_canbecontrolled",true,true];

			//Delete projectiles
			_uav addeventhandler["fired", {deletevehicle (nearestobject[_this select 0, _this select 4])}];

			//Fire some flares
			_uav spawn {
				while {alive _this} do {
					_plane = _this;
					( driver _plane) forceweaponfire ["CMFlareLauncher","burst"];
					_plane setAmmo ["CMFlareLauncher", 1];
					sleep 30 + (random 30);
				};
			};
		};
	};

	//UAV
	if (tolower _spawnkind in ["uav","controllable"]) exitWith {
		//UAV

		[_pos,_planeType,360,_spawnkind,_spawn] spawn {
			private ["_uav","_time","_grp","_wp","_flyHight","_side"];
			params ["_pos","_planeType","_time","_spawnkind","_spawn"];

			_pos set [2,(_pos select 2)+500];
			_side =  (getNumber (configFile >> "CfgVehicles" >> _planeType >> "side")) call BIS_fnc_sideType;
			_uav = [_planeType, _spawn, _pos, 500, false,_side] call MCC_fnc_createPlane;

			_grp = group driver _uav;
			_grp setCombatMode "BLUE";
			_grp setBehaviour "CARELESS";
			_grp setSpeedMode "LIMITED";

			_wp = _grp addWaypoint [_pos, 0];
			_wp setWaypointType "LOITER";
			_wp setWaypointLoiterType "CIRCLE_L";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointLoiterRadius 1000;

			//Make controlabel
			_grp setvariable ["MCC_canbecontrolled",true,true];
			_grp setvariable ["MCC_canbecontrolledUAV",true,true];
			_uav setVehicleLock "LOCKED";

			//Spawn detection
			if (_spawnkind == "uav") then {
				[_uav,_time] spawn MCC_fnc_uavDetect;
			};
		};
	};

	if (_spawnkind in ["Gun-run short","Gun-run long","Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)"]) then {
		if (_spawnkind in ["Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)"]) then {
			private ["_group","_dir","_cas","_casType"];
			_side =  getNumber (configFile >> "CfgVehicles" >> _planeType >> "side");

			switch (_side) do
			{
				case 0:					//east
				{
					_planeType = "O_Plane_CAS_02_F";
				};

				case 1:					//west
				{
					_planeType = "B_Plane_CAS_01_F";
				};

				case 2:					//GUR
				{
					_planeType = "I_Plane_Fighter_03_CAS_F";
				};

				default
				{
					_planeType = "I_Plane_Fighter_03_CAS_F";
				};
			};

			switch (_spawnkind) do
			{
				case "Gun-run (Zeus)":
				{
					_casType = 0;
				};

				case "Rockets-run (Zeus)":
				{
					_casType = 1;
				};

				case "CAS-run (Zeus)":
				{
					_casType = 2;
				};
			};

			_group = createGroup sideLogic;
			_dir = [_spawn, _pos] call BIS_fnc_dirTo;
			_cas = _group createUnit ["ModuleCAS_F",_pos , [], 0, ""];
			_cas setDir _dir;
			_cas setVariable ["vehicle",_planeType];
			_cas setVariable ["type", _casType];
		} else {
			diag_log format ["gun-run: [%1]", _this];

			if (_planeType isKindOf "Plane") then
			{
				_distStart = 3000;
				_distEngage = 2500;
				_planeAltitude = 500;
				_typeOfAircraft = 1; //plane
			}
			else
			{
				_distStart = 1200;
				_distEngage = 500;
				_planeAltitude = 150;
				_typeOfAircraft = 0; //helicopter
			};

			//Lets Spawn a plane
			_plane1 			= [_planeType, _spawn, _pos, _planeAltitude, false] call MCC_fnc_createPlane;		//Spawn plane 1
			_pilotGroup1		= group _plane1;
			_pilot1				= driver _plane1;

			//set CAS name based on plane number
			_cas_name = format ["%1 %2",["Venom","Viking","Beamer"] call BIS_fnc_selectRandom,(round(random 19)) + 1];

			//workaround to crash plane in rare case it doesn't return to spawn/end location
			_plane1 setFuel 0.1;

			_pilotGroup1 move _pos; //Set waypoint

			_pilotGroup1 setCombatMode "BLUE";
			_pilotGroup1 setSpeedMode "FULL";
			_pilotGroup1 setBehaviour "CARELESS";
			_plane1 disableAI "AUTOTARGET";
			_plane1 disableAI "TARGET";

			private ["_weapons","_planeCfg","_modes","_mode","_weaponOnPlane","_turret"];
			_planeCfg = configfile >> "cfgvehicles" >> _planeType;
			if (count (getarray (_planeCfg >> "Turrets" >> "MainTurret" >> "weapons"))>0) then
				{
					_weaponOnPlane = getarray (_planeCfg >> "Turrets" >> "MainTurret" >> "weapons");
					_turret = true;
				}
				else
				{
					_weaponOnPlane = getarray (_planeCfg >> "weapons");
					_turret = false;
				};

			_weapons = [];
			{
				if (tolower ((_x call bis_fnc_itemType) select 1) in ["machinegun"]) then
				{
					_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
					if (count _modes > 0) then
					{
						_mode = _modes select 0;
						if (_mode == "this") then {_mode = _x;};
						_weapons set [count _weapons,[_x,_mode]];
					};
				};
			} foreach _weaponOnPlane;

			//Fail safe if no weapons found
			if (count _weapons == 0) then
			{
				_modes = getarray (configfile >> "cfgweapons" >> (_weaponOnPlane select 0) >> "modes");
				if (isnil "_modes") then {_modes = ["this"]};
					if (count _modes > 0) then
					{
						_mode = _modes select 0;
						if (_mode == "this") then {_mode = (_weaponOnPlane select 0)};
						_weapons set [count _weapons,[(_weaponOnPlane select 0),_mode]];
					};
			};

			_pilot1 setskill 1;
			_plane1 setskill 1;

			_poswp = [_pos select 0,_pos select 1,0];

			_wp = _pilotGroup1 addWaypoint [_poswp, 0];
			[_pilotGroup1, 1] setWaypointType "MOVE";
			[_pilotGroup1, 1] setWaypointSpeed "FULL";
			[_pilotGroup1, 1] setWaypointSpeed "FULL";
			[_pilotGroup1, 1] setWaypointCompletionRadius 100;

			_casMarker = createMarkerLocal [_cas_name,_poswp];
			_casMarker setMarkerTypeLocal "MIL_TRIANGLE";
			_casMarker setMarkerSizeLocal [0.8, 1.4];
			_casMarker setMarkertextLocal "CAS";
			_casMarker setMarkerColorLocal "ColorRed";
			_casMarker setMarkerDirLocal (direction _plane1);

			_casApproach = true;

			while { ( ( alive _plane1 ) && ( _casApproach ) ) } do
			{
				sleep 5;
				_distA = getPosATL _plane1;
				sleep 3;
				_distB = getPosATL _plane1;

				if ( (_distA distance _distB) < 10 ) then
				{
					// chopper got stuck and is hovering at same location, so trigger function again
					{ deleteWaypoint _x; } foreach waypoints _pilotGroup1;
					sleep 0.1;
					_poswp = [_pos select 0,_pos select 1,0];

					_wp = _pilotGroup1 addWaypoint [_poswp, 0];
					[_pilotGroup1, 1] setWaypointType "MOVE";
				};

				waitUntil {sleep 1;(_plane1 distance _poswp) < 2000};
				_pilotGroup1 setBehaviour "COMBAT";
				_pilotGroup1 setCombatMode "YELLOW";

				[playerSide,'HQ'] sidechat format ["%1 entering target area, ETA %2 seconds", _cas_name, round ((_plane1 distance _pos) / ((speed _plane1) * 0.25 ))];

				//make invisible target primary target
				//ACE invisible targets: http://freeace.wikkii.com/wiki/Class_Lists_for_ACE2

				if (((side _plane1) getFriend east) < 0.6) then // enemy
				{
					//create "EAST" target
					_fakeTarget = "B_TargetSoldier" createVehicle _pos;
				}
				else
				{
					//create "WEST" target
					_fakeTarget = "O_TargetSoldier" createVehicle _pos;
				};

				_fakeTarget addRating -3000;
				_fakeTarget setpos _pos;
				_target = _fakeTarget;

				//Create list of real vehicle targets in 60 m radius of the designated gun-run area
				_targetList = _pos nearEntities [ ["Tank", "Wheeled_APC", "StaticWeapon", "Truck"], 100];

				if ( (count _targetList) > 1 ) then
				{
					// If real vehicle found assign that one as gun-run target
					_target = _targetList select 1;
				};

				waitUntil {sleep 0.5;(_plane1 distance _target) < _distStart};

				_pilotGroup1 reveal _target;

				//_plane1 enableAI "TARGET";
				//_pilotGroup1 setCombatMode "YELLOW";

				_plane1 doTarget _target;
				_pilot1 doTarget _target;
				gunner _plane1 doTarget _target;

				(_plane1 turretUnit [0]) doTarget _target;
				(_plane1 turretUnit [1]) doTarget _target;

				// trigger script to cancel attack and collect garbage after x time
				[_cas_name, _target, _spawnkind, _plane1, _planeType, _fakeTarget] execVM MCC_path + "mcc\general_scripts\cas\clear_gunrun_target.sqf";

				waitUntil {(_plane1 distance _target) < _distEngage};


				_fire = [_plane1,_weapons,_turret,_target] call
				{
					_plane = _this select 0;
					_planeDriver = if (_this select 2) then {gunner _plane} else {driver _plane};
					_weapons = _this select 1;
					_duration = 20;
					_target = _this select 3;
					_time = time + _duration;
					waituntil
					{
						{
							if (_plane aimedAtTarget [_target] > 0.1) then {_planeDriver forceweaponfire _x};
						} foreach _weapons;
						sleep 0.1;
						time > _time || isnull _plane || ((_plane distance _target) < 50)
					};
				};

				_casApproach = false;
			};

			//clear_gunrun_target.sqf should have set the damage of target to 1 now
			[playerSide,'HQ'] sidechat format ["%1 is leaving the area", _cas_name];

			_plane1 doWatch objNull;
			(gunner _plane1) doWatch objNull;
			(_plane1 turretUnit [0]) doWatch objNull;
			(_plane1 turretUnit [1]) doWatch objNull;

			{ deleteWaypoint _x; } foreach waypoints _pilotGroup1;

			_pilotGroup1 setCombatMode "BLUE"; // Never fire
			//_pilotGroup1 setCombatMode "GREEN"; // Hold fire - Defend only
			_pilotGroup1 setSpeedMode "FULL";
			_pilotGroup1 setBehaviour "CARELESS";
			_plane1 disableAI "AUTOTARGET";
			_plane1 disableAI "TARGET";

			if ( _spawnkind == "Gun-run long") then
			{
				// make "away" the spawn position while plane is flying in that direction
				_away = _spawn;
			};

			sleep 3;

			//Fire some flares exiting the area
			_fire = [_plane1,[["CMFlareLauncher","burst"]]] spawn
			{
				_plane = _this select 0;
				_planeDriver = driver _plane;
				_weapons = _this select 1;
				_duration = 5;
				_time = time + _duration;
				waituntil
				{
					{
						_planeDriver forceweaponfire _x;
					} foreach _weapons;
					sleep 0.5;
					time > _time || isnull _plane
				};
			};

			{_x disableAI "AUTOTARGET"} forEach  crew _plane1;
			{_x disableAI "TARGET"} forEach  crew _plane1;

			sleep 0.1;
			_pilotGroup1 move _away;
			sleep 0.1;
			_pilot1 domove _away;
			sleep 0.1;

			_casMarker setMarkerDirLocal (direction _plane1);
			_casMarker setMarkerPosLocal _away;
			_casMarker setMarkertextLocal "CAS Exit";

			// move plane away to delete it
			if ( _typeOfAircraft == 1 ) then //plane
			{
				sleep 5;
				[_pilotGroup1, _pilot1, _plane1, _away, 150] spawn MCC_fnc_deletePlane;
			}
			else // chopper
			{
				sleep 3; // otherwise chopper will halt, climb, and continue
				[_pilotGroup1, _pilot1, _plane1, _away, 100] spawn MCC_fnc_deletePlane;
			};

			sleep 10;

			_distA = getPosATL _plane1;
			sleep 3;
			_distB = getPosATL _plane1;

			if ( (_distA distance _distB) < 10 ) then
			{
				// chopper got stuck and is hovering at same location, so trigger function again
				{ deleteWaypoint _x; } foreach waypoints _pilotGroup1;
				sleep 0.1;
				[_pilotGroup1, _pilot1, _plane1, _away, 100] spawn MCC_fnc_deletePlane;
			};

			waitUntil { sleep 2;!( alive _plane1 ) };
			deletemarkerlocal _casMarker;

			// clear invisible targets
			if (!IsNil "_fakeTarget") then {deleteVehicle _fakeTarget};
		};
	} else {
		//Lets Spawn a plane
		/*
		_plane1 			= [_planeType, _spawn, _pos, 150, false] call MCC_fnc_createPlane;		//Spawn plane 1
		_pilotGroup1		= group _plane1;
		_pilot1				= driver _plane1;


		_plane2 			= [_planeType, _spawn, _pos, 150, false] call MCC_fnc_createPlane;		//Spawn plane 2
		_pilotGroup2		= group _plane2;
		_pilot2				= driver _plane2;

		[_plane2] joinsilent _pilotGroup1;														//Join them together


		_wp = _pilotGroup1 addWaypoint [[_pos select 0, _pos select 1, 0], 0];	//Add WP
		_wp setWaypointStatements ["true", ""];
		_wp setWaypointSpeed "FULL";
		_wp setWaypointCompletionRadius 100;
		*/

		private ["_dir","_dis","_alt","_pitch","_speed","_duration","_planePos","_planeSide","_planeArray","_vectorDir","_velocity","_vectorUp","_planeCfg","_time"];
		_planeCfg = configfile >> "cfgvehicles" >> _planeType;
		_pos set [2,(_pos select 2) + getterrainheightasl _pos];
		_dir =[_spawn, _pos] call BIS_fnc_dirTo;
		_dis =  2500;
		_alt = 600;
		_pitch = atan (_alt / _dis);
		_speed = 400 / 3.6;
		_duration = ([0,0] distance [_dis,_alt]) / _speed;

		//--- Create plane
		_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
		_planePos set [2,(_pos select 2) + _alt];
		_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
		_planeArray = [_planePos,_dir,_planeType,_planeSide] call bis_fnc_spawnVehicle;
		_plane1 = _planeArray select 0;
		_plane1 setposasl _planePos;
		_pilotGroup1 = group _plane1;
		_pilot1		= driver _plane1;

		//--- Play radio
		[_plane1,"CuratorModuleCAS"] call bis_fnc_curatorSayMessage;

		//Set WP behaviour for flat bombing
		if (_spawnkind == "S&D") then	{
			systemChat "ok";
			_wp = _pilotGroup1 addWaypoint [[_pos select 0, _pos select 1, 0], 0];	//Add WP
			_wp setWaypointStatements ["true", ""];
			_wp setWaypointSpeed "FULL";
			_wp setWaypointCompletionRadius 100;

			_plane1 setcombatmode "RED";
			_wp setWaypointType "SAD";
			_wp setWaypointCombatMode "RED";

		}	else	{

			_plane1 move ([_pos,_dis,_dir] call bis_fnc_relpos);
			_plane1 disableai "move";
			_plane1 disableai "target";
			_plane1 disableai "autotarget";
			_plane1 setcombatmode "blue";


			_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
			_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
			_plane1 setvectordir _vectorDir;
			[_plane1,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
			_vectorUp = vectorup _plane1;

			[_plane1,_planePos,_pos,_velocity,_vectorDir,_vectorUp,_duration] spawn {

				params ["_plane1","_planePos","_pos","_velocity","_vectorDir","_vectorUp","_duration"];
				_time = time;
				private _gain = if (_plane1 isKindOf "helicopter") then {40} else {0};
				waituntil {
					//--- Set the plane approach vector
					_plane1 setVelocityTransformation [
						_planePos, [_pos select 0,_pos select 1,(_pos select 2) + 20 + _gain],
						_velocity, _velocity,
						_vectorDir,_vectorDir,
						_vectorUp, _vectorUp,
						(time - _time) / _duration
					];
					_plane1 setvelocity velocity _plane1;

					(_plane1 getVariable ["MCC_casDone",false]) || !(canMove _plane1) || ((position _plane1) select 2) < 100;
				};
			};
		};

		switch (_spawnkind) do
		{
			case "S&D":	//Seek and Destroy
			{
				 waitUntil {((_plane1 distance2D _pos) < 1500) || (!alive _plane1)};
				_pilotGroup1 setSpeedMode "FULL";
				_pilotGroup1 setCombatMode "RED";
				_pilotGroup1 setBehaviour "COMBAT";
				_plane1 enableAI "AUTOTARGET";
				sleep 120;
			};

			case "JDAM":	//JDAM Bomb
			{
			   waitUntil {((_plane1 distance2D _pos) < 500) || (!alive _plane1)};
			   _nul=[_pos, getpos _plane1,"Bo_GBU12_LGB",100,false,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf"
			};

			case "LGB":    //LGB
			{
				waitUntil {((_plane1 distance2D _pos) < 1000) || (!alive _plane1)};
				_lasertargets = nearestObjects[_pos,["LaserTarget"],1000];
				if (!isnull (_lasertargets select 0)) then {
					_pos = getpos (_lasertargets select 0);
					waitUntil {((_plane1 distance2D _pos) < 300) || (!alive _plane1)};
					_nul=[(_lasertargets select 0), getpos _plane1,"Bo_GBU12_LGB",100,false,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf"
				};
			};

			case "Bombing-run":	//Bombing run
			{
				private ["_offset"];
				waitUntil {((_plane1 distance2D _pos) < 600) || (!alive _plane1)};
				//Make the drop
				for [{_i=1},{_i<=_ammount*2},{_i=_i+1}] do
					{
						_offset = if (_i mod 2 == 0) then {4} else {-4};
						_bomb = "Bo_Mk82" createvehicle [getpos _plane1 select 0,getpos _plane1 select 1,3000]; 	//make the bomb
						_bomb setpos (_plane1 modelToWorld [_offset,-3,-6]);
						_bomb setdir getdir _plane1;
						_bomb setVectorUp (vectorup _plane1);
						_velocity = (velocity _plane1) apply {_x * 1.2};
						_velocity set [2,-30];
						_bomb setVelocity _velocity;

						[[[netid _bomb,_bomb], format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
						sleep 0.5;
					};
			};

			case "Rockets-run":	//Rockets run
			{
				waitUntil {((_plane1 distance2D _pos) < 500) || (!alive _plane1)};
				//Make the drop
				if (!alive _plane1) exitWith {};

				for [{_x=1},{_x<=_ammount*2},{_x=_x+1}] do
					{
						_nul=[[(_pos select 0)+50 - random 100,(_pos select 1)+50 - random 100,_pos select 2], getpos _plane1,"M_AT",200,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						[[[netid _plane1,_plane1], "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
						sleep 0.2;
					};

				sleep 1;
			};

			case "AT run":	//SnD Armor
			{
				waitUntil {((_plane1 distance2D _pos) < 600) || (!canMove _plane1)};
				_targets = nearestObjects [[_pos select 0,_pos select 1,0] ,["Car","Tank"],200];	//Find targets: cars or tanks
				_i = 0;

				{
					if (([side _x, side _plane1] call BIS_fnc_sideIsEnemy) && _i <= _ammount) then {
						_nul=[ _x, getpos _plane1,"M_PG_AT",200,true,""] execVM  MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						sleep 0.8;
						_nul=[ _x, getpos _plane1,"M_PG_AT",200,true,""] execVM  MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						_i = _i +1;
					};
				} forEach _targets;
			};

			case "AA run":	//SnD Air
			{
				_plane1 flyInHeight 150;
				waitUntil {((_plane1 distance2D _pos) < 600) || (!canMove _plane1)};
				_targets = nearestObjects [[_pos select 0,_pos select 1,0] ,["Helicopter","Plane"],1000];	//Find targets: cars or tanks
				_i = 0;
				{
					if (([side _x, side _plane1] call BIS_fnc_sideIsEnemy) && _i <= _ammount) then {
						_nul=[_x, getpos _plane1,"M_PG_AT",200,true,""] execVM  MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						sleep 0.8;
						_nul=[_x, getpos _plane1,"M_PG_AT",200,true,""] execVM  MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						_i = _i +1;
					};
				} forEach _targets;
			};

			case "CBU-97(ACE)":	//MCC_fnc_CBU-97
			{
				_plane1 flyInHeight 150;
				_plane1 addWeapon "ACE_CBU97_Bomblauncher";
				for [{_i=1},{_i<=_ammount},{_i=_i+1}] do
					{
						_plane1 addMagazine "ACE_CBU97";
					};
				_planepos = getpos _plane1;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 150]) < 700) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_plane1 Fire ["ACE_CBU97_Bomblauncher"];
						sleep 1;
					};
			};

			case "CBU-87(ACE)":	//MCC_fnc_CBU-AP
			{
				_plane1 addWeapon "ACE_CBU87_Bomblauncher";
				for [{_i=1},{_i<=_ammount},{_i=_i+1}] do
					{
						_plane1 addMagazine "ACE_CBU87";
					};
				_planepos = getpos _plane1;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 100]) < 800) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_plane1 Fire ["ACE_CBU87_Bomblauncher"];
						sleep 1;
					};
			};

			case "BLU-107(ACE)":	//BLU-107
			{
				_plane1 flyInHeight 200;
				_plane1 addWeapon "ACE_BLU107_Bomblauncher";
				for [{_i=1},{_i<=_ammount},{_i=_i+1}] do
					{
						_plane1 addMagazine "ACE_BLU107";
					};
				_planepos = getpos _plane1;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 150]) < 800) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_plane1 Fire ["ACE_BLU107_Bomblauncher"];
						sleep 0.5;
					};
			};

			case "SADARM":	//MCC_fnc_SADARM
			{
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 200) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_planepos = getpos _plane1;
						[_planepos, _pilot1] spawn MCC_fnc_SADARM;
						sleep 0.5 + random 0.5;
					};
			};

			case "CBU-Mines":	//MCC_fnc_CBU-Mines
			{
				CBU_type = MCC_CBU_MINES;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 200) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_planepos = getpos _plane1;
						_bomb = "CruiseMissile2" createvehicle [_planepos select 0,_planepos select 1,3000]; 	//make the bomb
						_bomb setpos [_planepos select 0,_planepos select 1,(_planepos select 2) -10];
						_bomb setdir getdir _plane1;
						_bomb setVelocity [((velocity vehicle _pilot1) select 0)/2, ((velocity vehicle _pilot1) select 1)/2,((velocity vehicle _pilot1) select 2)];
						[_bomb, CBU_type] spawn MCC_fnc_CBU;
						sleep 0.5 + random 0.5;
					};
			};

			case "CBU-WP(ACE)":	//MCC_fnc_CBU-Mines
			{
				CBU_type = MCC_CBU_WP;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 200) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_planepos = getpos _plane1;
						_bomb = "CruiseMissile2" createvehicle [_planepos select 0,_planepos select 1,3000]; 	//make the bomb
						_bomb setpos [_planepos select 0,_planepos select 1,(_planepos select 2) -10];
						_bomb setdir getdir _plane1;
						_bomb setVelocity [((velocity vehicle _pilot1) select 0)/2, ((velocity vehicle _pilot1) select 1)/2,((velocity vehicle _pilot1) select 2)];
						[_bomb, CBU_type] spawn MCC_fnc_CBU;
						sleep 0.5 + random 0.5;
					};
			};

			case "CBU-CS(ACE)":	//MCC_fnc_CBU-Mines
			{
				CBU_type = MCC_CBU_CS;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 200) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_planepos = getpos _plane1;
						_bomb = "CruiseMissile2" createvehicle [_planepos select 0,_planepos select 1,3000]; 	//make the bomb
						_bomb setpos [_planepos select 0,_planepos select 1,(_planepos select 2) -10];
						_bomb setdir getdir _plane1;
						_bomb setVelocity [((velocity vehicle _pilot1) select 0)/2, ((velocity vehicle _pilot1) select 1)/2,((velocity vehicle _pilot1) select 2)];
						[_bomb, CBU_type] spawn MCC_fnc_CBU;
						sleep 0.5 + random 0.5;
					};
			};

			case "Tactical MCC_NUKE(0.3k)":	//Tactical MCC_NUKE(0.3k)
			{
				_nukeType = "ACE_B61_03";
				[_plane1, _pos, _nukeType] spawn MCC_NUKE;
			};

			case "Tactical MCC_NUKE(1.5k)":	//Tactical MCC_NUKE(1.5k)
			{
				_nukeType = "ACE_B61_15";
				[_plane1, _pos, _nukeType] spawn MCC_NUKE;
			};

			case "Tactical MCC_NUKE(5.0k)":	//"Tactical MCC_NUKE(5.0k)"
			{
				_nukeType = "ACE_B61_50";
				[_plane1, _pos, _nukeType] spawn MCC_NUKE;
			};

			case "Air Burst(0.3k)":	//Tactical MCC_NUKE(0.3k) MCC_NUKE_AIR
			{
				_nukeType = "ACE_B61_03";
				[_plane1, _pos, _nukeType] spawn MCC_NUKE_AIR;
			};

			case "Air Burst(1.5k)":	//Tactical MCC_NUKE(1.5k) MCC_NUKE_AIR
			{
				_nukeType = "ACE_B61_15";
				[_plane1, _pos, _nukeType] spawn MCC_NUKE_AIR;
			};

			case "Air Burst(5.0k)":	//Tactical MCC_NUKE(5.0k) MCC_NUKE_AIR
			{
				_nukeType = "ACE_B61_50";
				[_plane1, _pos, _nukeType] spawn MCC_NUKE_AIR;
			}
		};

		_plane1 enableAI "move";
		_plane1 setVariable ["MCC_casDone",true];
		//Delete the plane when finished
		sleep 1;

		//Fire some flares exiting the area
		{
			_fire = [_x,[["CMFlareLauncher","burst"]]] spawn
			{
				_plane = _this select 0;
				_planeDriver = driver _plane;
				_weapons = _this select 1;
				_duration = 5;
				_time = time + _duration;
				waituntil
				{
					{
						_planeDriver forceweaponfire _x;
					} foreach _weapons;
					sleep 0.5;
					time > _time || isnull _plane
				};
			};
		} foreach [_plane1];

		[_pilotGroup1, _pilot1, _plane1, _away] call MCC_fnc_deletePlane;
		//[_pilotGroup2, _pilot2, _plane2, _away] call MCC_fnc_deletePlane;
	};
};

