disableSerialization;
private ["_vehicle1","_vehicle2","_vehicle3","_vehicle4","_vehicle5","_pos1","_pos2","_escrot","_escrotDriver",
		 "_faction","_vipclass","_vipcar","_x1","_y1","_x2","_y2","_group","_driver","_cargo1","_dummy","_cargoNum","_x","_pos"];


//diag_log str ["place_convoy START", _this];		 
		 
_vehicle1 = _this select 0; 		//get params
_vehicle2 = _this select 1; 
_vehicle3 = _this select 2;
_vehicle4 = _this select 3;
_vehicle5 = _this select 4;

_pos1 = _this select 5;
_pos2 = _this select 6;

_side = _this select 7;
_vipclass = _this select 8;
_vipcar = _this select 9;

_x1 = _pos1 select 0;
_y1 = _pos1 select 1;
_x2 = _pos2 select 0;
_y2 = _pos2 select 1;

_angle = (_x2 - _x1) atan2 (_y2 - _y1);			//define convoy heading
if (_angle < 0) then { _angle = 360 + _angle; };

switch (toLower _side) do	{
	case "west": {_side =  west; _escrot = MCCConvoyWestEscort; _escrotDriver = MCCConvoyWestDriver};
	case "east": {_side =  east;  _escrot = MCCConvoyEastEscort; _escrotDriver = MCCConvoyEastDriver};
	case "guer": {_side =  resistance;  _escrot = MCCConvoyGueEscort; _escrotDriver = MCCConvoyGueDriver};
	case "civ": {_side =  civilian;  _escrot = MCCConvoyCivEscort; _escrotDriver = MCCConvoyCivDriver};
	};
	
_group = creategroup _side;	

car1 = [[(_pos1 select 0),(_pos1 select 1)] , _angle, _vehicle1, _group] call BIS_fnc_spawnVehicle;
sleep 0.5;
_group setFormation "COLUMN";	
(car1 select 0) lockdriver true;
_pos = (car1 select 0) modelToWorld [0,-25,0];

sleep 0.05;

if !( isNil "_vehicle2" ) then
{ 
	car2 = [[_pos select 0, _pos select 1, 0] , getdir (car1 select 0), _vehicle2, _side] call BIS_fnc_spawnVehicle;
	(car2 select 0) setposatl (getpos (car2 select 0));
	(car2 select 0) lockdriver true;
	sleep 0.1;
	(car2 select 1) joinsilent (car1 select 2);
};

sleep 0.05;

if (_vipclass=="0") then
{ 
	if !( isNil "_vehicle3" ) then
	{ 
		_pos = (car1 select 0) modelToWorld [0,-50,0];
		car3 = [[_pos select 0, _pos select 1, 0]  , getdir (car1 select 0), _vehicle3, _side] call BIS_fnc_spawnVehicle;
		(car3 select 0) setposatl (getpos (car3 select 0));
		(car3 select 0) lockdriver true;
		sleep 0.1;
		(car3 select 1) joinsilent (car1 select 2);
	};
}
else 
{
	car3 = _vipcar createvehicle ((car1 select 0) modelToWorld [0,-50,0]);
	car3 setdir (getdir (car1 select 0)); 
	_driver = _group createUnit [_escrotDriver, _pos1, [], 0, "CORPORAL"];
	_driver assignAsDriver car3;
	_driver moveindriver car3;
	car3 lockdriver true;
	_cargoNum = car3 emptyPositions "cargo";
	
	for [{_x=1},{_x<_cargoNum-1},{_x=_x+1}] do 
	{
		_cargo1 = _group createUnit [_escrot, _pos1, [], 0, "CORPORAL"];
		_cargo1 assignAsCargo car3;
		_cargo1 MoveInCargo car3;
	};
	_dummy = _vipclass createunit [_pos1, _group,"this setcaptive true; this assignAsCargo car3;this MoveInCargo car3;_null = this addaction [""Secure HVT"",'"+MCC_path+"mcc\general_scripts\hostages\hostage.sqf',[0],6,true,false];
	removeAllWeapons this ;this allowFleeing 0;"];
	sleep 0.3;
	(units _group) joinsilent (car1 select 2);
};

sleep 0.05;

if !( isNil "_vehicle4" ) then
{ 
	_pos = (car1 select 0) modelToWorld [0,-75,0];
	car4 = [[_pos select 0, _pos select 1, 0] , getdir (car1 select 0), _vehicle4, _side] call BIS_fnc_spawnVehicle;
	(car4 select 0) setposatl (getpos (car4 select 0));
	(car4 select 0) lockdriver true;
	sleep 0.1;
	(car4 select 1) joinsilent (car1 select 2);
};
	
sleep 0.05;

if !( isNil "_vehicle5" ) then
{ 
	_pos = (car1 select 0) modelToWorld [0,-100,0];
	car5 = [[_pos select 0, _pos select 1, 0]  , getdir (car1 select 0), _vehicle5, _side] call BIS_fnc_spawnVehicle;
	(car5 select 0) setposatl (getpos (car5 select 0));
	(car5 select 0) lockdriver true;
	sleep 0.1;
	(car5 select 1) joinsilent (car1 select 2);
};

sleep 0.05;

//diag_log str ["place_convoy END"];
