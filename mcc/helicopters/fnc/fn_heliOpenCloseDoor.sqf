/*==================================================================MCC_fnc_heliOpenCloseDoor=========================================================================================
	Animate closing or opening helicopters doors

	<IN>
		0:	OBJECT, the helicopter
		1:	BOOLEAN, True - open doors	False - close doors

	<OUT>
		NOTHING
==============================================================================================================================================================================*/
private ["_heli","_open","_animPhase"];

_heli= param [0,objNull,[objNull]];
_open = param [1,true,[true]];
_animPhase = if (_open) then {1} else {0};

if (isNull _heli) exitWith {};

{_heli animateDoor [_x,_animPhase]} forEach ["door_back_L","door_back_R","door_L","door_R","Door_6_source","Door_rear_source","CargoRamp_Open"];
