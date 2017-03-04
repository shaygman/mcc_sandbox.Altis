private ["_pos", "_units", "_spawn","_away","_plane","_pilot","_wp","_UMUnit","_isHalo","_flightHight","_unitsArray","_unit","_chockArray","_heliClass","_pod","_fnc_findVehicles"];
_pos 		= _this select 0;
_units 		= _this select 1;
_UMUnit		= _this select 2;
_isHalo		= param [3,0,[0]];
_spawn		= _this select 4;
_away		= _this select 5;

if (count _units == 0) exitWith {};


_flightHight = switch (_isHalo) do
				{
					case 1:{400};
					case 2:{4000};
					default{300};
				};

_spawn set [2,(_spawn select 2) + _flightHight];
_away set [2,(_away select 2) + _flightHight];
_unitsArray	= [];
_chockArray = [];

//units
if (_UMUnit==0) then {
	{
		_unitsArray pushBack _x;
		if (count _unitsArray >= 12) then {
			_chockArray pushBack _unitsArray;
			_unitsArray	= [];
		};
	} foreach _units;
} else {
	{
		{
			_unitsArray pushBack _x;
			if (count _unitsArray >= 12) then {
				_chockArray  pushBack _unitsArray;
				_unitsArray	= [];
			};
		} foreach (units _x);
	} foreach _units;
};

systemChat str _isHalo;

_heliClass = if (_isHalo == 1) then  {"O_Heli_Transport_04_F"} else {
				switch (true) do
				{
					case (side (_units select 0) == east && (isClass(configFile >> "CfgVehicles" >> "O_T_VTOL_02_infantry_F"))):{"O_T_VTOL_02_infantry_F"};

					case (side (_units select 0) == west && (isClass(configFile >> "CfgVehicles" >> "B_T_VTOL_01_infantry_F"))):{"B_T_VTOL_01_infantry_F"};

					default{"I_Heli_Transport_02_F"};
				};
			};


//Add the last chock even if it isn't full
_chockArray pushBack _unitsArray;

_fnc_findVehicles = {
	params ["_choke","_classA","_classB"];
	//Try to find an helicopter from the faction
	private ["_minSpaces","_vehiclesTypesArray","_availableSpaces","_newHeliClassesArray","_totalSeats","_crewSeats","_faction","_return"];
	_minSpaces = count (_chockArray select 0);
	_faction = faction ((_chockArray select 0) select 0);
	_return = "";
	_vehiclesTypesArray = [_faction,"helicopterrtd","air"] call MCC_fnc_makeUnitsArray;
	if (count _vehiclesTypesArray < 2) then {
		_vehiclesTypesArray = [_faction,"helicopterrtd"] call MCC_fnc_makeUnitsArray;
	};

	_vehiclesTypesArray = _vehiclesTypesArray + ([_faction,"helicopterX"] call MCC_fnc_makeUnitsArray);

	_newHeliClassesArray = [];

	for "_i" from 0 to (count _vehiclesTypesArray)-1 step 1 do {
		_vehicleClass = (_vehiclesTypesArray select _i) select 0;
	    _availableSpaces = [_vehicleClass, "allCargo"] call MCC_fnc_crewCount;

		//if enogh cargo space add it
		if ( _availableSpaces >= _minSpaces) then {
			_newHeliClassesArray pushBack [_availableSpaces, _vehicleClass]
		};
	};

	if (count _newHeliClassesArray > 0) then {
		_newHeliClassesArray sort true;
		_return = (_newHeliClassesArray select 0) select 1;
	};

	_return
};

if (_isHalo == 0) then  {
	_class = [_chockArray,"airplane","airplaneX"] call _fnc_findVehicles;
	if (_class != "") then {
		_heliClass = _class;
	} else {
		_class = [_chockArray,"helicopterrtd","helicopterX"] call _fnc_findVehicles;
		if (_class != "") then {
			_heliClass = _class;
		};
	};
};

{
	_unitsArray = _x;

	//Spawn plane 1
	_plane = [_heliClass, _spawn, _pos, _flightHight,true,civilian] call MCC_fnc_createPlane;

	_pilot = driver _plane;

	if (_isHalo == 1) then {
		if (side (_units select 0) != east) then {
			_null = _plane execVM "\a3\Air_F_Heli\Heli_Transport_04\Scripts\Heli_Transport_04_basic_black.sqf";
		};

		_pod = "Land_Pod_Heli_Transport_04_bench_F" createVehicle [0,0,0];
		_pod attachto [_plane,[0,0,-1.2]];
		_plane setVariable ["MCC_attachedPod",_pod,true];

		[_pod,_plane] spawn {
			private ["_pod","_vehicle"];
			_pod 		= _this select 0;
			_vehicle 	= _this select 1;
			while {!(isNull attachedTo _pod) && alive _pod} do {if !(alive _vehicle) then {_pod setDammage 1;detach _pod};sleep 0.5};
		};
	} else {
		if (_heliClass == "I_Heli_Transport_02_F") then {
			switch (side (_units select 0)) do
			{
				case east:
				{
					_plane setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
					_plane setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
					_plane setObjectTextureGlobal [2,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
				};

				case west:
				{
					_plane setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
					_plane setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
					_plane setObjectTextureGlobal [2,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
				};
			};
		};

		_plane lock true;
	};


	//Set plane variables
	_plane flyInHeight _flightHight;
	_plane setVariable ["MCCJumperNumber",-1,true];																		//Number of unit to jump
	_plane setVariable ["MCCisHALO",_isHalo,true];
	_plane setVariable ["MCCjumpReady",false,true];																		//Are we ready on the ramp
	MCC_planeNameCount = MCC_planeNameCount + 1;


	for "_x" from 0 to (count _unitsArray -1) step 1 do {
		_unit = _unitsArray select _x;
		_null = [_plane, _unit,_x] remoteExec ["MCC_fnc_realParadropPlayer", _unit];
		waitUntil {_unit in crew _plane};
	};



	//Set waypoint
	_wp = (group _plane) addWaypoint [_away, 0];	//Add WP
	_wp setWaypointStatements ["true", ""];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointCombatMode "BLUE";
	_wp setWaypointCompletionRadius 200;
	_plane flyInHeight _flightHight;

	[_plane, _pos, _flightHight, _pilot, _away, _isHalo] spawn {
		params ["_plane","_pos","_flightHight","_pilot","_away","_isHalo"];

		//Make them stand on the deck
		while {((_plane distance2d _pos) > 800) && (alive _plane)} do {sleep 1};

		//Ready for the jump
		_plane setVariable ["MCCjumpReady",true,true];

		[_plane,true] spawn MCC_fnc_heliOpenCloseDoor;

		sleep 5;

		if (_isHalo ==1) then {
			_plane call MCC_fnc_releasePod;
		} else {
			_plane setVariable ["MCCJumperNumber",0,true];
		};

		[group _pilot, _pilot, _plane, _away] spawn MCC_fnc_deletePlane;
	};

	sleep 5;
} foreach _chockArray;