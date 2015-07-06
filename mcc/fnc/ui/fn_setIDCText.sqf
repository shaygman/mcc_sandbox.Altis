//==================================================================MCC_fnc_setIDCText=====================================================================================
// [_idc,_txt,_time,_sound] call MCC_fnc_setIDCText
//	<IN>
//	_idc		INTEGER - IDC number
//	_txt		STRING	- Text to show
//	_time		INTEGER - time untill fade -1 to never
//	_sound		BOOLEAN - true for sound
//==============================================================================================================================================================
private ["_idc","_txt","_time","_sound"];
disableSerialization;
_idc =  [_this, 0, -1, [0]] call BIS_fnc_param;
_txt =  [_this, 1, "", [""]] call BIS_fnc_param;
_time =  [_this, 2, -1, [0]] call BIS_fnc_param;
_sound =  [_this, 3, false, [false]] call BIS_fnc_param;

if (_idc == -1 || _txt == "") exitWith {};

if (_sound) then {playSound "communicationMenuItemAdded"};
ctrlSetText [_idc,_txt];

if (_time !=-1) then {
	sleep _time;
	ctrlSetText [_idc,""];
};
