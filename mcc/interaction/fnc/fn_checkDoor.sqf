//==================================================================MCC_fnc_checkDoor=========================================================================================
// give info if the door is locked
// Example:[_object]  call MCC_fnc_checkDoor;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<Nothing>
//===========================================================================================================================================================================
private ["_object","_str","_typeOfSelected","_return"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_MIROR ["MineDetector","MCC_videoProbe"]
#define MCC_LOCKPICK ["ToolKit","AGM_DefusalKit","MCC_multiTool","ACE_DefusalKit","ACE_key_lockpick"]

_object = _this select 0;

private ["_door","_animation","_phase","_closed"];
_tempArray = [_object]  call MCC_fnc_isDoor;
_door = _tempArray select 0;
_animation = _tempArray select 1;
_phase = _tempArray select 2;
_closed = _tempArray select 3;

if (_door == "") exitWith {};

_object animate [_animation, 0.1];
sleep 0.1;
_object animate [_animation, 0];

_object setVariable [format ["bis_disabled_%1_info",_door],true];
hint (if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then {"Unlocked"} else {"Locked"});
