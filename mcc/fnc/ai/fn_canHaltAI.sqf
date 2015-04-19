//==================================================================MCC_fnc_canHaltAI===========================================================================================
// Can an AI unit be halted by a player
// Example:[_target]  call MCC_fnc_canHaltAI;
// <IN>
//	_target:					Object- unit.
//
// <OUT>
//		Boolean
//===========================================================================================================================================================================
private["_target"];
_target		= _this select 0;

if (MCC_isACE) then {
	if (((side _target != civilian && (side _target getFriend  side player)>0.6)) || isPlayer _target || (_target getVariable ["ACE_captives_isSurrendering",false]) || (_target getVariable ["ACE_captives_isHandcuffed",false]) || !(alive _target) || (captive _target)) then {false} else {true};
} else {
	if (((side _target != civilian && (side _target getFriend  side player)>0.6)) || isPlayer _target || (_target getVariable ["MCC_neutralize",false]) || (_target getVariable ["MCC_disarmed",false]) || !(alive _target) || (captive _target)) then {false} else {true};
};
