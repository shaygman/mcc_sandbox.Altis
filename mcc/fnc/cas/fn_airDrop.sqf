//========================================================MCC_fnc_airDrop =========================================
//  Parameter(s):
//     	0: _ammount - 	integer
//     	1: spawnkind: 	ARRAY of STRING  - CAS type class Gun-run short","Gun-run long","Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)
//		2: _pos:		POSITION - cas target pos
//		3: _planeType:	STRING plane vehicle class for CAS or "west","east","guer","civ","logic" for airdrop
//		4: _spawn		POSITION: plane spawn pos
//		5: _away		POSITION: plane despawn pos
//		6: _isParachute	BOOLEAN: <optional> true - if it is air supply or false if it is slingload
//		CAS Script by Shay_gman 08.01.12
//==============================================================================================================================================================================

private ["_ammount", "_spawnkind", "_pos", "_spawn", "_away", "_pilot1", "_pilotGroup1", "_wp", "_wp2", "_plane1", "_planepos",
		"_planeType", "_planeAltitude", "_target", "_fakeTarget", "_lasertargets", "_nukeType", "_bomb2", "_cas_name", "_poswp", "_distA","_distB", "_nul",
		"_loop","_x","_wp","_plane2","_pilot2","_pilotGroup2","_typeOfAircraft", "_distStart", "_distEngage", "_targetList", "_startTime", "_casMarker", "_casApproach","_isParachute","_planeClasss","_isHeliDLC","_object","_sling"];

_ammount				= _this select 0;
_spawnkind				= _this select 1 select 0;
_pos					= _this select 2;
_planeType				= _this select 3 select 0;
_spawn					= _this select 4;
_away					= _this select 5;
_isParachute			= if (count _this > 6) then {_this select 6} else {false};

//=====================================================

//start the drop
if (tolower _planeType in ["west","east","guer","civ","logic"]) then 		//If it's an airdrop
{
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
	if !(_isParachute) then {
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
			MCC_curator addCuratorEditableObjects [[_object],false];
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

		for [{_x=0},{_x < count _spawnkind},{_x=_x+1}] do
		{
			_planepos = getpos _plane1;
			[_planepos, _spawnkind select _x, _pilot1] spawn MCC_fnc_CreateAmmoDrop;
			sleep 3 + random 3;
		};

		{_plane1 animateDoor [_x, 0]} foreach ["CargoRamp_Open"];
	}
}
else
{
	//Case CAS
	if (_spawnkind in ["Gun-run short","Gun-run long","Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)"]) then
	{
		if (_spawnkind in ["Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)"]) then
		{
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
				case "Gun-run (Zeus)":					//east
				{
					_casType = 0;
				};

				case "Rockets-run (Zeus)":					//west
				{
					_casType = 1;
				};

				case "CAS-run (Zeus)":					//GUR
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
		}
		else
		{
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
	}
	else
	{
		//Lets Spawn a plane
		_plane1 			= [_planeType, _spawn, _pos, 150, false] call MCC_fnc_createPlane;		//Spawn plane 1
		_pilotGroup1		= group _plane1;
		_pilot1				= driver _plane1;

		_plane2 			= [_planeType, _spawn, _pos, 150, false] call MCC_fnc_createPlane;		//Spawn plane 2
		_pilotGroup2		= group _plane2;
		_pilot2				= driver _plane2;

		[_plane2] joinsilent _pilotGroup1;														//Join them together

		_wp = _pilotGroup1 addWaypoint [[_pos select 0, _pos select 1, 0], 0];	//Add WP
		_wp setWaypointStatements ["true", ""];
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointCompletionRadius 100;

		if (_spawnkind == "SnD") then	{			//Set WP behaviour
			_wp setWaypointType "SAD";
			_wp setWaypointCombatMode "RED";
			}	else	{
				_wp setWaypointType "MOVE";
				_wp setWaypointCombatMode "BLUE";
				};

		switch (_spawnkind) do
		{
			case "SnD":	//Seek and Destroy
			{
				 waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 2000) || (!alive _plane1)};
				_pilotGroup1 setSpeedMode "FULL";
				_pilotGroup1 setCombatMode "RED";
				_pilotGroup1 setBehaviour "COMBAT";
				_plane1 enableAI "AUTOTARGET";
				sleep 120;
			};

			case "JDAM":	//JDAM Bomb
			{
			   waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 500) || (!alive _plane1)};
			   _nul=[_pos, getpos _plane1,"Bo_GBU12_LGB",100,false,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf"
			};

			case "LGB":    //LGB
			{
				waitUntil {((_plane1 distance _pos) < 1000) || (!alive _plane1)};
				_lasertargets = nearestObjects[_pos,["LaserTarget"],1000];
				if (!isnull (_lasertargets select 0)) then
					{
					_pos = getpos (_lasertargets select 0);
					waitUntil {((_plane1 distance[_pos select 0, _pos select 1, 200]) < 300) || (!alive _plane1)};
					_nul=[(_lasertargets select 0), getpos _plane1,"Bo_GBU12_LGB",100,false,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf"
					};
			};

			case "Bombing-run":	//Bombing run
			{
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 500) || (!alive _plane1)};
				//Make the drop
				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_bomb = "Bo_Mk82" createvehicle [getpos _plane1 select 0,getpos _plane1 select 1,3000]; 	//make the bomb
						_bomb setpos [getpos _plane1 select 0,(getpos _plane1 select 1)-4,(getpos _plane1 select 2) -2];
						_bomb setdir getdir _plane1;
						[[[netid _bomb,_bomb], format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
						sleep 0.25;
						_bomb setVelocity [((velocity vehicle _pilot1) select 0)/3, ((velocity vehicle _pilot1) select 1)/3,-30];
						_bomb2 = "Bo_Mk82" createvehicle [getpos _plane1 select 0,getpos _plane1 select 1,3000]; 	//make the bomb
						_bomb2 setpos [getpos _plane1 select 0,(getpos _plane1 select 1)+4,(getpos _plane1 select 2) -2];
						_bomb2 setdir getdir _plane1;
						_bomb2 setVelocity [((velocity vehicle _pilot1) select 0)/3, ((velocity vehicle _pilot1) select 1)/3,-30];
						[[[netid _bomb2,_bomb2], format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
						sleep 0.25;
					};
			};

			case "Rockets-run":	//Rockets run
			{
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 800) || (!alive _plane1)};
				//Make the drop
				if (!alive _plane1) exitWith {};

				for [{_x=1},{_x<=_ammount},{_x=_x+1}] do
					{
						_nul=[[(_pos select 0)+50 - random 100,(_pos select 1)+50 - random 100,_pos select 2], getpos _plane1,"M_AT",200,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						[[[netid _plane1,_plane1], "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
						sleep 0.6;
						_nul=[[(_pos select 0)+50 - random 100,(_pos select 1)+50 - random 100,_pos select 2], getpos _plane1,"M_AT",200,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						[[[netid _plane1,_plane1], "missileLunch"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
						sleep 0.6;
					};
			};

			case "AT run":	//SnD Armor
			{
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 800) || (!alive _plane1)};
				_targets = nearestObjects [[_pos select 0,_pos select 1,0] ,["Car","Tank"],200];	//Find targets: cars or tanks
				_x = 0;
				_loop = true;
				while {_loop} do {
					if (_x<count _targets && _x < _ammount) then {
						_nul=[_targets select _x, getpos _plane1,"M_PG_AT",200,true,""] execVM  MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						sleep 1;
						_x = _x +1;
						} else {_loop = false};
					};
			};

			case "AA run":	//SnD Air
			{
				_plane1 flyInHeight 150;
				waitUntil {((_plane1 distance [_pos select 0, _pos select 1, 200]) < 1500) || (!alive _plane1)};
				_targets = nearestObjects [[_pos select 0,_pos select 1,0] ,["Helicopter","Plane"],1000];	//Find targets: cars or tanks
				_x = 0;
				_loop = true;
				while {_loop} do {
					if (_x<count _targets && _x < _ammount) then {
						_nul=[_targets select _x, getpos _plane1,"M_PG_AT",200,true,""] execVM  MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf";
						sleep 1;
						_x = _x +1;
						} else {_loop = false};
					};
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
		} foreach [_plane1,_plane2];

		[_pilotGroup1, _pilot1, _plane1, _away] call MCC_fnc_deletePlane;
		[_pilotGroup2, _pilot2, _plane2, _away] call MCC_fnc_deletePlane;
	};
};

