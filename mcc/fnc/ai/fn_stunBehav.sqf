//==================================================================MCC_fnc_stunBehav===============================================================================================
// Play unit stun behavior
// Example:[_unit, _time]  call MCC_fnc_stunBehav;
// <IN>
//	_unit:					Object- unit.
//	_time:					integer : how long should the unit remain stunned
//
// <OUT>
//		nothing
//===========================================================================================================================================================================	
private["_pos","_unit","_dammage"];	
_unit 		= _this select 0;
_time 		= _this select 1;	
_dammage	= getDammage _unit;

if ((_unit getVariable ["MCC_Stunned", false]) || !local _unit) exitWith {};
_unit setVariable ["MCC_Stunned", true,true];

_unit disableAI "AUTOTARGET";
_unit switchmove "acts_CrouchingCoveringRifle01"; 
_t = 0;
while {alive _unit && !(_unit getVariable ["MCC_disarmed",false])} do 
{
	sleep 0.1;
	_t = _t + 0.1;
	if (_t > _time || (getDammage _unit > _dammage) || (_unit getVariable ["MCC_disarmed",false])) exitWith {[[[_unit,""],{(_this select 0) switchmove (_this select 1)}],"BIS_fnc_spawn", true, false] spawn BIS_fnc_MP;};
};

[[[_unit,""],{(_this select 0) switchmove (_this select 1)}],"BIS_fnc_spawn", true, false] spawn BIS_fnc_MP;
_unit enableAI "AUTOTARGET";
_unit setVariable ["MCC_Stunned", false,true]; 