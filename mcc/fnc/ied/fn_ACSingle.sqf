//================================================================MCC_fnc_ACSingle======================================================================================
// Create a an armed civilian at the given position
// Example: [_pos,_trapkind,_iedside,_iedMarkerName,_iedDir] spawn MCC_fnc_ACSingle;
// <in>: 	_pos 			= position, where to plae the unit
// 		_trapkind 		= string, unit's vehicle class
//		_iedside 			= side, which side will trigger the armed civilian
//		_iedMarkerName 	= string, marker name leave "" for no marker
//		_iedDir 			=integer, direction the unit will be facing
//		_static 			=integer, should he move around or just stand there
// <out>	unit, object
//=================================================================================================================================================================
private ["_pos", "_trapkind","_iedside", "_iedMarkerName","_group", "_sb", "_iedDir","_init","_rank","_static"];

_pos 			= _this select 0;
_trapkind 		= _this select 1;
_iedside		= _this select 2;
_iedMarkerName 	= _this select 3;
_iedDir 		= _this select 4;
_static			= if (count _this > 5) then {_this select 5} else {false};

if (count _this > 5) then {_static	=  true};

if (MCC_debug) then {systemchat str _iedside};

_rank = ["SERGEANT","LIEUTENANT","CAPTAIN"] select (floor random 3);
_group = creategroup civilian;
_sb = _group createunit [_trapkind, _pos, [], 0, "NONE"];
_sb setVariable ["static",_static,true];
_sb setVariable ["MCC_IEDtype","ac",true];

MCC_tempName = format ["MCC_objectUnits_%1", ["MCC_objectUnitsCounter",1] call bis_fnc_counter];

_sb setpos _pos;
_sb setdir _iedDir;
_sb setrank _rank;
_group setformdir _iedDir;

_init = FORMAT [";%2 = _this;[_this, '%1',25] spawn MCC_fnc_manageAC;"
				,_iedside
				,MCC_tempName
				];

[[[netid _sb,_sb], _init], "MCC_fnc_setVehicleInit", false, false] spawn BIS_fnc_MP;

{_x addCuratorEditableObjects [[_sb],false]} forEach allCurators;

_sb;