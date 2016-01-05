//==================================================================MCC_fnc_checkDoor=========================================================================================
// give info if the door is locked
// Example:[_object]  call MCC_fnc_checkDoor;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<Nothing>
//===========================================================================================================================================================================
private ["_object","_door","_str","_animation","_door","_typeOfSelected","_return"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool","ACE_DefusalKit","ACE_key_lockpick"]
#define MCC_ARMA2MAPS ["takistan","zargabad","chernarus","utes"]

_object = _this select 0;

_door = [_object]  call MCC_fnc_isDoor;
if (_door == "") exitWith {};

if (tolower worldName in MCC_ARMA2MAPS) then {
	_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
	_animation = "dvere"+_str;
} else {
	_animation = _door + "_rot";
};

_object animate [_animation, 0.1];
sleep 0.1;
_object animate [_animation, 0];

_object setVariable [format ["bis_disabled_%1_info",_door],true];
hint (if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then {"Unlocked"} else {"Locked"});
