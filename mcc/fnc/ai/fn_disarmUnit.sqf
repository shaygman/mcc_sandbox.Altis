//==================================================================MCC_fnc_disarmUnit===============================================================================================
//Disarm a unit and create a weapon holder
// Example:[_npc, _pos]  call MCC_fnc_disarmUnit;
// <IN>
//	_npc:					Object- unit.
//	anim:					String or side, animation set after disarm leave "" for non
//
// <OUT>
//		Boolean 
//===========================================================================================================================================================================	
private["_pos","_npc","_wepHolder"];	
_npc = _this select 0;
_pos = _this select 1;	

if (!alive _npc || !canmove _npc || _npc != vehicle _npc || !(_npc iskindof "Man")) exitwith{};

_wepHolder = "GroundWeaponHolder" createVehicle position _npc;
_wepHolder setpos(_npc modeltoWorld [1,0,0]);

{
	_npc action ["DropWeapon",_wepHolder, _x];
	waituntil {!(_x in (weapons _npc))};
} foreach (weapons _npc);

sleep 1;
removeAllweapons _npc;
_npc disableAI "MOVE";
_npc disableAI "AUTOTARGET";

_npc setVariable ["MCC_disarmed",true,true];

if (_pos != "") then
{
	_npc disableAI "ANIM"; 
	while {alive _npc && _npc getVariable ["MCC_disarmed",false]} do
	{
		if ((animationState _npc)!=_pos) then
		{
			[[[_npc,_pos],{(_this select 0) playMove (_this select 1)}],"BIS_fnc_spawn", true, false] spawn BIS_fnc_MP;
		};
		sleep 1; 
	};
	_npc enableAI "ANIM"; 
};

true;


