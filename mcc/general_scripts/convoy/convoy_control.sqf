// =========================================================================================================
//  Convoy  control
//  Version: 1.6
//  Author: DTM2801
// =========================================================================================================
// - to tweak the behaviour change the distance (example: _dist > 80) or forcespeed (example: forceSpeed 0).
//
// example using only controlscript with vehicles and named on the map: 	
// veh1:	first vehicle nothing
// veh2:	null = [veh2,veh1,false] execVM "convoy_control.sqf";
// veh3: 	null = [veh3,veh2,false] execVM "convoy_control.sqf";
// veh4:	null = [veh4,veh3,false] execVM "convoy_control.sqf";
// and so on
// to enable/disable debug change option 3 to true/false
// =========================================================================================================

private ["_units", "_convoy1", "_convoy2", "_debug", "_unit1", "_unit2", "_dist","_count","_c","_convoyArray"];

_convoyArray	= _this select 0;
_c 				= _this select 1;
_count 			= count _convoyArray;
_convoy1 			= objNull;
_convoy2 			= objNull; 
_convoy1 = _convoyArray select _c; 
_convoy2 = _convoyArray select (_c - 1); 

_debug = _this select 2;

_units = [];
_units = _units + [_convoy1, _convoy2];
_unit1 = _units select 0;
_unit2 = _units select 1;

while {alive _unit1 && alive _unit2} do {
	_dist = (_unit1 distance _unit2);
	if (_dist > 50) then {_unit2 forceSpeed 0; if (_debug) then {hintsilent format ["%1 waiting for %2",_unit2,_unit1]};};
	if (_dist < 45) then {_unit2 forceSpeed 2; if (_debug) then {hintsilent format ["%1 front slowding down 2",_unit2]};};
	if (_dist < 40) then {_unit2 forceSpeed 5; if (_debug) then {hintsilent format ["%1 front slowing down 4",_unit2]};};
	// preffered distance
	if (_dist < 35) then {_unit1 forceSpeed 8;_unit2 forceSpeed 8; if (_debug) then {hintsilent format ["%1 & %2 \nin formation",_unit1,_unit2]};};
	if (_dist < 30) then {_unit1 forceSpeed 8;_unit2 forceSpeed 8; if (_debug) then {hintsilent format ["%1 & %2 \nin formation",_unit1,_unit2]};};
	// ----------------------------------
	if (_dist < 25) then {_unit1 forceSpeed 5; if (_debug) then {hintsilent format ["%1 back slowing down 4",_unit1]};};
	if (_dist < 20) then {_unit1 forceSpeed 2; if (_debug) then {hintsilent format ["%1 back slowing down 2",_unit1]};};
	if (_dist < 15) then {_unit1 forceSpeed 0; if (_debug) then {hintsilent format ["%1 waiting for %2 to move",_unit1,_unit2]};};

	if (_debug) then {_unit1 sidechat format ["dist %1, to front %2",_dist,_unit2];};
	sleep .5;
	};
	//failsafe
	if (alive _unit1) then {_unit1 forcespeed -1; if (_debug) then {hintsilent format ["%1 gone, %2 without control",_unit1,_unit2]};};
	if (alive _unit2) then {_unit2 forcespeed -1; if (_debug) then {hintsilent format ["%1 gone, %2 without control",_unit2,_unit1]};};