//===================================================================MCC_fnc_evacMove======================================================================================
// Move a vehicle across to WP
// Example:[[[wp1,wp2,wp3], flyInHight, insertion, [netid vehicle,vehicle],assignedCargo  _evac],"MCC_fnc_evacMove",true,false] spawn BIS_fnc_MP;
// Params:
// 	[wp1,wp2,wp3]: array, waypoint positions
// 	flyInHight: number, if evac is a chopper flight hight, set to 5000 for land or sea vehicle
//	insertion: number, for vehicles: 0 - engine on, 1 - engine off. For helicopters: 0 - engine on, 1 - engine off, 2 - hover, 3 - Helocasting, 4 - Smoke, 5 - Fast Rope
//	vehicle: object, the evac vehicle
//==============================================================================================================================================================================
private["_heli", "_route", "_endpos", "_height", "_landing ", "_pilot", "_i", "_j", "_pos", "_dist", "_distold", "_angh", "_dir","_startPos","_class",
		"_accel", "_speed", "_steps", "_inipos", "_offset","_nearSmokes","_wp","_wp2","_distance","_relDirHor","_velocityX","_velocityY","_cargoUnits"];

_route         = _this select 0;
_height        = _this select 1;
_landing       = _this select 2;
_heli          = _this select 3;

if (typeName _heli == typeName []) then {
	 _heli = if (isMultiplayer) then {objectFromNetId (_heli select 0)} else {(_heli select 1)};
};

_cargoUnits	   = [];
{
	_class = tolower (_x select 1);
	if (_class == "cargo" || (_class == "turret" && (_x select 4))) then
	{
		_cargoUnits pushBack (_x select 0);
	};
} foreach (fullCrew _heli);

if (!local _heli) exitWith {hint "vehicle must be local";};

if (_height == 5000) then //We got a vehicle
{
	for [{_j = 0},{_j < count _route},{_j = _j + 1}] do
	{
		if ((getText(configFile >> "CfgVehicles" >> typeOf _heli  >> "simulation")) == "submarinex") then {_heli swimInDepth -4};
		_pos = _route select _j;
		_wp = (group driver _heli) addWaypoint [_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "CARELESS";

		_wp2 = (group gunner _heli) addWaypoint [_pos, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointCombatMode "YELLOW";
		_wp2 setWaypointSpeed "FULL";
		_wp2 setWaypointBehaviour "COMBAT";
	};
	if (_landing == 1) then {_wp setWaypointStatements ["true", " driver (vehicle this) action ['ENGINEOFF', (vehicle this)];"]};
}
else
{
	// First of all chopper gets its indicated flying height for the route
	_pilot = driver _heli;
	_heli setfuel 1;
	_heli flyinHeight _height;
	_heli setVariable ["wp_complete", false];

	_startPos = _heli getVariable"MCC_evacStartPos";

	for [{_j = 0},{_j < count _route},{_j = _j + 1}] do
	{
		_pos = _route select _j;
		_wp = (group driver _heli) addWaypoint [_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "CARELESS";

		_wp2 = (group gunner _heli) addWaypoint [_pos, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointCombatMode "YELLOW";
		_wp2 setWaypointSpeed "FULL";
		_wp2 setWaypointBehaviour "COMBAT"
	};

	_wp setWaypointCompletionRadius 10;
	_wp setWaypointStatements ["true", " (vehicle this) setVariable ['wp_complete', true];"];

	_heli setSpeedMode "FULL";
	while {!(_heli getVariable "wp_complete")} do {sleep 1};

	[_heli,true] spawn MCC_fnc_heliOpenCloseDoor;

	switch (_landing) do		//Which insertion do we want
	{
		case 0:			//Free Landing engine on
		{
			_heli land "GET IN";
		};

		case 1:			//Free Landing engine off
		{
			_heli land "LAND";
		};

		case 2:			//Hover
		{
			_heli flyinHeight _height;
		};

		case 3:			//Helocasting
		{
			//while {(_heli distance _pos)>55} do {_pilot doMove _pos; sleep 5;};
			while {((getposasl _heli) select 2) > 8} do {_heli flyinHeight 3; sleep 1};
			_heli globalChat "Golf 1 in position, clear for helocasting";

			{
				[_x] spawn
					{
						private "_unit";
						_unit = _this select 0;

						if (isMultiplayer) then
						{
							 [compile format ["unassignVehicle objectFromNetID '%1'; objectFromNetID '%1' action ['eject', vehicle objectFromNetID '%1']", netID _unit], "BIS_fnc_spawn", _unit, false] spawn BIS_fnc_MP;
						}
						else
						{
							unassignVehicle _unit;
							_unit action ["eject", vehicle _unit];
						};
					};

				sleep ( 1 + ((random 6)/10) );
			} foreach _cargoUnits;
		};

		case 4:			//Smoke signal
		{
			_heli globalChat "Waiting for smoke signal to land";
			_nearSmokes = [];
			while {(count _nearSmokes < 1)} do
			{
				_nearSmokes = (getPos _heli) nearObjects ["SmokeShell", 300];
				sleep 1;
				if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
			};

			_endpos = getPosASL (_nearSmokes select 0);
			_endpos = _endpos vectorAdd [0,0,_height];
			[_heli,_endpos] call MCC_fnc_heliPreciseLanding;

			_heli setVelocity [0,0,0];
			_heli flyinHeight 2;
		};

		case 5:			//Fast-rope
		{
			private ["_rope","_actualRopes","_ropes","_zc","_attachPoint"];
			_actualRopes = [];

			switch (typeOf _heli) do
			{
				case "B_Heli_Light_01_F":
				{
					_ropes = [[0.6,0.5,0],[-0.8,0.5,0]];
				};

				case "B_Heli_Transport_01_F":
				{
					_ropes = [[-1.11,2.5,0],[1.11,2.5,0]];
				};

				case "I_Heli_Transport_02_F":
				{
					_ropes = [[1,-5,0],[-1,-5,0]];
				};

				case "O_Heli_Attack_02_F":
				{
					_ropes = [[1.35,1.35,0],[-1.45,1.35,0]];
				};

				case "O_Heli_Light_02_F":
				{
					_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
				};

				case "I_Heli_light_03_F":
				{
					_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
				};

				case "O_Heli_Transport_04_covered_F":
				{
					_ropes = [[1,-4,-1],[-1,-4,-1]];
				};

				case "B_Heli_Transport_03_F":
				{
					_ropes = [[1,-4,-1],[-1,-4,-1]];
				};

				case "I_Heli_light_03_unarmed_F":
				{
					_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
				};

				default
				{
					_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
				};
			};
			_pos = (AGLToASL _pos) vectorAdd [0,0,_height];
			[_heli, _pos] call MCC_fnc_heliPreciseLanding;

			_heli setVelocity [0,0,0]; velocity
			sleep 0.1;
			_heli flyInHeight 20;
			sleep 4;

			_heli globalChat "Golf 1 in position, get ready for fast rope";
			waitUntil { sleep 1; (abs(speed _heli) < 0.5)  || !alive _heli || !alive (driver _heli)};
			if (!alive _heli || !alive (driver _heli)) exitWith {};

			[_heli,true] spawn MCC_fnc_heliOpenCloseDoor;

			{
				_rope = ropeCreate [_heli, _x,55,[10]];
				_actualRopes pushBack _rope;
				/*
				_rope = createVehicle ["land_rope_f", [0,0,0], [], 0, "CAN_COLLIDE"];
				sleep 0.3;
				_rope allowDamage false;
				_rope disableCollisionWith _heli;
				_actualRopes set [count _actualRopes, _rope];
				_rope setdir (getdir _heli);
				_rope attachto [_heli, _x];
				*/
				sleep 0.5;
			} forEach _ropes;

			sleep 1+ random 2;


			{
				_rope = _actualRopes select (_forEachIndex % 2);

				[[_x, _rope],"MCC_fnc_fastRopeLocal",_x,false] spawn BIS_fnc_MP;

				sleep ( 1 + ((random 6)/10) );
			} foreach _cargoUnits;

			//make sure all AI cargo has left the chopper - give 4 seconds for last unit to slide down the rope
			_timeOut = time + 10;
			waitUntil { sleep 1; (count (assignedCargo _heli) == 0) || (time > _timeOut)  || (!alive _heli) || (!alive (driver _heli))};
			sleep 3;

			// drop the ropes and delete them
			{
				_attachPoint = _ropes select _forEachIndex;
				_zc = -22;
				while { _zc > -50 } do
				{
					_x attachTo [_heli, [_attachPoint select 0 , _attachPoint select 1,_zc]];
					_zc = _zc - 2;
					sleep 0.1;
				};
				deletevehicle _x;
				/*
				ropeUnwind [ _x, 3, 0];
				_attachPoint = _ropes select _forEachIndex;
				_zc = -22;
				while { _zc > -50 } do
				{
					_x attachTo [_heli, [_attachPoint select 0 , _attachPoint select 1,_zc]];
					_zc = _zc - 2;
					sleep 0.1;
				};
				deletevehicle _x;
				*/
			} foreach _actualRopes;
		};

		case 6:			//Precise Landing
		{
			_pos = (AGLToASL _pos) vectorAdd [0,0,_height];
			[_heli, _pos] call MCC_fnc_heliPreciseLanding;
			_heli setVelocity [0,0,0];

			sleep 0.1;
			_heli flyInHeight 1;
			sleep 2;

			[_heli,true] spawn MCC_fnc_heliOpenCloseDoor;

			_timeOut = time + 10;
			waitUntil { sleep 1; (count (assignedCargo _heli) == 0) || (time > _timeOut)  || (!alive _heli) || (!alive (driver _heli))};
			sleep 3;
		};
	};

	//Close doors
	[_heli,false] spawn MCC_fnc_heliOpenCloseDoor;

	//Do we have a return trip
	if (count _cargoUnits > 0) then
	{
		private ["_crew","_empty"];
		_timeOut = time + 30;
		waitUntil
		{
			sleep 1;
			_crew = crew _heli;
			_empty = true;

			{
				if (vehicle _x == _heli) exitWith {_empty = false};
			} foreach _cargoUnits;

			_empty || (time > _timeOut)  || (!alive _heli) || (!alive (driver _heli));
		};

		if (_empty && (!isnil "_startPos")) then
		{
			[[[_startPos], _height, 1, [netid _heli,_heli]],"MCC_fnc_evacMove",_heli,false] spawn BIS_fnc_MP;
		};
	};
};