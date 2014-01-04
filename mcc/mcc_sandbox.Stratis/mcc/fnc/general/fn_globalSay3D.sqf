//==================================================================MCC_fnc_globalSay3D======================================================================================
// Say sound on 3d on all clients
// Example: [[[netid _unit,_unit], _sound], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, sound's source
// 	_sound: string, sound define in config
//==============================================================================================================================================================================	
private ["_object","_sound"];

_sound = _this select 1;
_object = if(((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
_object say3D _sound;
