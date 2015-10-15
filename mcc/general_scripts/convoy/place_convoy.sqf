disableSerialization;
private ["_vehicleArray","_vehicleClass","_pos1","_pos2","_escrot","_escrotDriver","_hvtCar","_vipclass","_vipcar","_x1","_y1","_x2","_y2","_group","_cargo","_unit","_cargoNum","_pos","_convoyArray","_vehicle","_x","_var"];

_vehicleArray = [];
for "_i" from 0 to 4 do {
	_var = _this select _i;
	if !(isNil "_var") then {_vehicleArray pushBack _var}
};

_pos1 = _this select 5;
_pos2 = _this select 6;

_side = _this select 7;
_vipclass = _this select 8;
_vipcar = _this select 9;

_x1 = _pos1 select 0;
_y1 = _pos1 select 1;
_x2 = _pos2 select 0;
_y2 = _pos2 select 1;

_convoyArray = [];

_angle = (_x2 - _x1) atan2 (_y2 - _y1);			//define convoy heading
if (_angle < 0) then { _angle = 360 + _angle; };

switch (toLower _side) do {
	case "west": {_side =  west; _escrot = MCCConvoyWestEscort; _escrotDriver = MCCConvoyWestDriver};
	case "east": {_side =  east;  _escrot = MCCConvoyEastEscort; _escrotDriver = MCCConvoyEastDriver};
	case "guer": {_side =  resistance;  _escrot = MCCConvoyGueEscort; _escrotDriver = MCCConvoyGueDriver};
	case "civ": {_side =  civilian;  _escrot = MCCConvoyCivEscort; _escrotDriver = MCCConvoyCivDriver};
};

//Spawn group
_group = creategroup _side;
_group setFormation "COLUMN";

_pos = _pos1;
{
	_vehicleClass = _x;
	if (!isNil "_vehicleClass") then {
		//_angle = if (count _convoyArray > _foreachindex) then {getdir (_convoyArray select (_foreachindex -1))} else {_angle};
		_vehicle = ([_pos , _angle, _vehicleClass, _group] call BIS_fnc_spawnVehicle) select 0;
		_group setFormation "COLUMN";
		//_vehicle setposatl (getpos _vehicle);
		_vehicle lockdriver true;
		_pos = _vehicle modelToWorld [0,-25,0];
		MCC_curator addCuratorEditableObjects [[_vehicle],true];
		_convoyArray pushBack _vehicle;
	};
} forEach _vehicleArray;


//Hnadle HVT
if (_vipclass != "0") then {
	_hvtCar = _convoyArray select floor ((count _convoyArray)/2);

	//switch cars
	if (_vipcar != "") then {

		private ["_driver","_hvtCarNew","_index"];
		_index = _convoyArray find _hvtCar;
		_pos = getpos _hvtCar;
		_angle = getdir _hvtCar;
		_driver = driver _hvtCar;

		_hvtCarNew = _vipcar createVehicle _pos1;
		unassignVehicle _driver;
		waitUntil {vehicle _driver == _driver};

		_driver assignAsDriver _hvtCarNew;
		_driver moveInDriver _hvtCarNew;

		{deleteVehicle _x} forEach crew _hvtCar;
		deleteVehicle _hvtCar;

		_hvtCar = _hvtCarNew;
		_hvtCar setpos _pos;
		_hvtCar setdir _angle;
		_convoyArray set [_index,_hvtCar];
		MCC_curator addCuratorEditableObjects [[_hvtCar],true];
	};

	_cargoNum = _hvtCar emptyPositions "cargo";
	_group = group driver _hvtCar;

	for "_i" from 1 to (_cargoNum-1) do {
		_cargo = _group createUnit [_escrot, _pos1, [], 0, "CORPORAL"];
		_cargo assignAsCargo _hvtCar;
		_cargo MoveInCargo _hvtCar;
	};

	sleep 1;

	_unit = _group createUnit [_vipclass, _pos2, [], 0, "FORM"];
	_unit setCaptive true;
	removeallweapons _unit;

	sleep 1;

	_unit assignAsCargo _hvtCar;
	_unit MoveInCargo _hvtCar;

	if (MCC_isACE) then {
	 	[_unit, true] call ACE_captives_fnc_setHandcuffed;
	} else {
		_unit setVariable ["MCC_disarmed",true,true];
	};



	{MCC_curator addCuratorEditableObjects [[_x],false]} foreach (units _group);
};

missionNamespace setVariable ["MCC_convoyVehicles",_convoyArray];
publicVariable "MCC_convoyVehicles";