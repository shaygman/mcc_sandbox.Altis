//==================================================================MCC_fnc_setUnitPos===============================================================================================
//Sets units pos - "Down","Up","Middle"
// Example:[_npc, _pos]  call MCC_fnc_setUnitPos;
// <IN>
//	_npc:					Object- unit.
//	_pos:					String : "DOWN" "UP" "MIDDLE" "AUTO"
//
// <OUT>
//		nothing
//===========================================================================================================================================================================	
private["_pos","_npc"];	
_npc = _this select 0;
_pos = _this select 1;	

sleep 0.5;
if (!alive _npc || _npc != vehicle _npc || !(_npc iskindof "Man")) exitwith{};
_npc enableAI "ANIM";
_npc setUnitPos _pos;
