//==================================================================MCC_fnc_setUnitAnim===============================================================================================
//Sets units Animation - and return it to default after a while
// Example:[_npc, _anim, _switch, _time]  call MCC_fnc_setUnitAnim;
// <IN>
//	_npc:					Object- unit.
//	_anim:					String : animation name
//	_switch:					Boolean : true= switchMove false =PlayMoveNow
//	_time:					integer : time until anim canceled put 0 for no canceleation or -1 for constant move
//
// <OUT>
//		nothing
//===========================================================================================================================================================================
private["_anim","_npc","_switch","_time","_prevAnim","_t"];
_npc 	= _this select 0;
_anim 	= _this select 1;
_switch = _this select 2;
_time 	= _this select 3;

//if (!alive _npc || _npc != vehicle _npc || !(_npc iskindof "Man") || !(_npc getVariable ["MCC_animRunning",false])) exitwith{};
_npc setVariable ["MCC_animRunning",true];

_prevAnim = animationState _npc;
_npc switchMove "";

if (_switch) then
{
	_npc switchMove _anim;
}
else
{
	_npc playMoveNow _anim;
};

if (_time > 0) then
{
	_t = 0;
	while {alive _npc && (_t < _time)} do {sleep 0.1; _t = _t +0.1};
	_npc switchMove _prevAnim;
};

if (_time == -1) then
{
	_npc DisableAI "ANIM";
	_npc switchMove _anim;
	while {alive _npc && (animationState _npc == _anim)} do {sleep 1};
	_npc switchMove "";
	_npc enableAI "ANIM";
};
_npc setVariable ["MCC_animRunning",false];