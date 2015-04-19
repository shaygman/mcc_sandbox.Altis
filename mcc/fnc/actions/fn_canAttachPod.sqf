//==================================================================MCC_fnc_canAttachPod=========================================================================================
// Can we attach pod to this helicopter
// Example:[_object]  call MCC_fnc_canAttachPod;
// <IN>
//	_target:					Object- object.
//
// <OUT>
//		Boolean
//===========================================================================================================================================================================
private ["_player","_vehiclePlayer","_attachedCargo","_return"];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_vehiclePlayer = vehicle _player;
_attachedCargo = (ropeAttachedObjects _vehiclePlayer) select 0;

_return = if ((_vehiclePlayer isKindOf "O_Heli_Transport_04_F") && (_player == Driver _vehiclePlayer)&& isnull(_vehiclePlayer getVariable ["MCC_attachedPod",objnull]) && (!isnil "_attachedCargo")) then {
				if (_attachedCargo isKindOf "Pod_Heli_Transport_04_base_F") then {true} else {false};
			} else {false};

_return