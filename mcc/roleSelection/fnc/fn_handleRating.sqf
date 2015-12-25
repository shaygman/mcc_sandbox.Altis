//==================================================================MCC_fnc_handleRating======================================================================================
// Handle xp for players when rating added
// Example: [player, rating] call MCC_fnc_handleRating
//==============================================================================================================================================================================
private ["_rating","_role","_exp","_oldLevel","_level","_newLevel"];
/*
//No more then 500 exp per sec
_rating = (param [1, 0, [0]]) min 1000;
*/

//Seems like addrating doesn't call EH so lets take the time to do it manually
_rating = rating player;
if (_rating <= 0) exitWith {};

player addrating (_rating*-1);

//when player spawn he get xp no idea why
if (missionNamespace getvariable ["CP_gainXPFirstTime",true]) exitWith {missionNamespace setvariable ["CP_gainXPFirstTime",false]};

if (CP_debug) then {systemchat format ["rating add: %1", _rating]};
player setVariable ["MCC_valorPoints",(player getVariable ["MCC_valorPoints",50])+(_rating/2),true];

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

_rating