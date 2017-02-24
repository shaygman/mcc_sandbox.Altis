//==================================================================MCC_fnc_disarmUnit===============================================================================================
//Disarm a unit and create a weapon holder
// Example:[_npc, _anim]  call MCC_fnc_disarmUnit;
// <IN>
//	_npc:					Object- unit.
//	_anim:					String or side, animation set after disarm leave "" for non
//
// <OUT>
//		Boolean
//===========================================================================================================================================================================
private["_anim","_npc","_wepHolder","_weapon","_weaponsNPC"];
_npc = param [0,objNull,[objNull]];
_anim = param [1,"",[""]];

if (!alive _npc || !canmove _npc || _npc != vehicle _npc || !(_npc iskindof "Man")) exitwith{};

if (MCC_isACE) then {
	[_npc, true] call ACE_captives_fnc_setSurrendered;
	_npc setVariable ["MCC_disarmed",true,true];
} else {
	_weaponsNPC = weapons _npc;
	_wepHolder = "Weapon_Empty" createVehicle getpos _npc;
	waituntil {!isnil "_wepHolder"};
	_wepHolder setpos getpos _npc;

	{
		_weapon = if (typeName _x == "STRING") then {_x} else {_x select 0};
		_npc action ["DropWeapon", _wepHolder, _weapon];
	} foreach _weaponsNPC;

	removeAllWeapons _npc;
	_npc disableAI "MOVE";
	_npc disableAI "AUTOTARGET";

	_npc setVariable ["MCC_disarmed",true,true];
	[[_npc, "Hold %1 to interact"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;

	if (_anim != "") then
	{
		_npc disableAI "ANIM";
		while {alive _npc && _npc getVariable ["MCC_disarmed",false]} do
		{
			if ((animationState _npc)!=_anim) then
			{
				_npc playMoveNow _anim;
			};
			sleep 1;
		};
		_npc enableAI "ANIM";
	};
};



true;


