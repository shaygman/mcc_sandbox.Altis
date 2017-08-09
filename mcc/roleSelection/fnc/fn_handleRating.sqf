//==================================================================MCC_fnc_handleRating==================================================================================
// Handle xp for players when rating added
// Example: [player, rating] call MCC_fnc_handleRating
//========================================================================================================================================================================
private ["_rating","_role","_exp","_oldLevel","_level","_newLevel","_valor"];
/*
//No more then 500 exp per sec
_rating = (param [1, 0, [0]]) min 1000;
*/

//Seems like addrating doesn't call EH so lets take the time to do it manually
_rating = ((rating player)-(player getVariable ["MCC_playerRating",0])) max 0;
if (_rating <= 0) exitWith {};

player setVariable ["MCC_playerRating",rating player];

if (missionNamespace getVariable ["MCC_debug",false]) then {systemChat ("Player rating changed" + str _rating)};

//when player spawn he get xp no idea why
//if (missionNamespace getvariable ["CP_gainXPFirstTime",true]) exitWith {missionNamespace setvariable ["CP_gainXPFirstTime",false]};

//we are gaining level disregard any XP for now
if (missionNamespace getvariable ["MCC_isLevelingUp",false]) exitWith {};

if (MCC_debug) then {systemchat format ["rating add: %1", _rating]};
_valor = if (vehicle player == player) then {floor (_rating/2)} else {floor (_rating/4)};
player setVariable ["MCC_valorPoints",(player getVariable ["MCC_valorPoints",50]) + _valor,true];

_role = player getvariable ["CP_role",""];
if (_role =="") exitWith {};

_exp = call compile format  ["%1Level select 1",_role];


if (isnil "_exp") exitWith {};

if (_exp < 0) then {_exp = 0};
if (MCC_debug) then {systemchat format ["rating: %1", _exp]};

_oldLevel = call compile format  ["%1Level select 0",_role];

_exp = (_exp + _rating);
_level =[floor(_exp/CP_XPperLevel)+1 ,_exp];

_newLevel = _level select 0;

 if (_oldLevel < _newLevel) then {
 	missionNamespace setVariable ["MCC_isLevelingUp",true];
	[_newLevel] call MCC_fnc_unlock;
	_oldLevel = _newLevel;
	missionNamespace setVariable ["MCC_isLevelingUp",false];
	player setVariable ["CP_roleLevel",_newLevel,true];
 };

if (MCC_debug) then {systemchat format ["level: %1",_level]};

missionNameSpace setVariable [format ["%1Level",_role], _level];
[[format ["%1Level",_role], player, _level, "ARRAY"], "MCC_fnc_setVariable", false, false] spawn BIS_fnc_MP;

_rating