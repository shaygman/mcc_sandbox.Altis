//==================================================================MCC_fnc_handleRating======================================================================================
// Handle xp for players when rating added
// Example: [player, rating] call MCC_fnc_addRating
//==============================================================================================================================================================================
private ["_rating","_role","_exp","_oldLevel","_level","_newLevel"];
//No more then 500 exp per sec
_rating = ([_this, 1, 0, [0]] call BIS_fnc_param) min 1000;

if (_rating <= 0) exitWith {};

//when player spawn he get xp no idea why
if (missionNamespace getvariable ["CP_gainXPFirstTime",true]) exitWith {missionNamespace setvariable ["CP_gainXPFirstTime",false]};

if (CP_debug) then {systemchat format ["rating add: %1", _rating]};

_role = player getvariable ["CP_role",""];
if (_role =="") exitWith {};

_exp = call compile format  ["%1Level select 1",_role];


if (isnil "_exp") exitWith {};

if (_exp < 0) then {_exp = 0};
if (CP_debug) then {systemchat format ["rating: %1", _exp]};

_oldLevel = call compile format  ["%1Level select 0",_role];

_exp = (_exp + _rating);
_level =[floor(_exp/CP_XPperLevel)+1 ,_exp];

_newLevel = _level select 0;

 if (_oldLevel < _newLevel) then {
	[_newLevel] call MCC_fnc_unlock;
	_oldLevel = _newLevel;
 };

if (CP_debug) then {systemchat format ["level: %1",_level]};

missionNameSpace setVariable [format ["%1Level",_role], _level];
[[format ["%1Level",_role], player, _level, "ARRAY"], "MCC_fnc_setVariable", false, false] spawn BIS_fnc_MP;

