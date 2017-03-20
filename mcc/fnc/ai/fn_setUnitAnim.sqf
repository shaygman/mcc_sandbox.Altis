//==================================================================MCC_fnc_setUnitAnim===============================================================================================
//Sets units Animation - and return it to default after a while
// Example:[_npc, _anim, _switch, _time]  call MCC_fnc_setUnitAnim;
// <IN>
//	_npc:					Object- unit.
//	_anim:					String : animation name
//	_switch:				Boolean : true= switchMove false =PlayMoveNow
//	_time:					integer : time until anim canceled put 0 for no canceleation or -1 for constant move
//	_breakAnim				Boolean : break animation if the units in combat defualt false
// <OUT>
//		nothing
//===========================================================================================================================================================================
private["_anim","_npc","_switch","_time","_prevAnim","_t","_eh","_breakAnim"];
_npc 	= param [0,objNull,[objNull]];
_anim 	= param [1,"",[""]];
_switch = param [2,false,[false]];
_time 	= param [3,0,[0]];
_breakAnim  = param [4,false,[false]];

//if (!alive _npc || _npc != vehicle _npc || !(_npc iskindof "Man") || !(_npc getVariable ["MCC_animRunning",false])) exitwith{};
_npc setVariable ["MCC_animRunning",true];
_npc setVariable ["MCC_animRunningBreakAnim",_breakAnim];

_prevAnim = animationState _npc;

//Disable AI
if (!isPlayer _npc)  then {
	{_npc disableAI _x} forEach ["ANIM","FSM","MOVE"];
};

_npc switchMove "";

if (_switch) then {
	_npc switchMove _anim;
} else {
	_npc playMoveNow _anim;
};

switch (true) do
{
	//Timed cancelation
	case (_time > 0):
	{
		_t = time + _time;
		while {alive _npc && (_t > time)} do {sleep 0.1};
		_npc switchMove _prevAnim;
	};

	//Constant loop
	case (_time == -1):
	{
		_eh = _npc addEventHandler	[
			"AnimDone",
			{
				private["_npc","_anim"];

				_npc = param [0,objNull,[objNull]];
				_anim = param [1,"",[""]];

				if ((!alive _npc) ||
				    ((_npc getVariable ["MCC_animRunningBreakAnim",false]) && ((behaviour _npc == "COMBAT") || (_npc call BIS_fnc_enemyDetected)))
				   ) then {
				   	_npc removeEventHandler ["AnimDone", (_npc getVariable ["MCC_animDoneEH",0])];
					_npc switchMove "";
				} else {
					_npc switchMove _anim;
				};
			}
		];
		_npc setVariable ["MCC_animDoneEH",_eh];
	};
};

//Enable AI
if (!isPlayer _npc)  then {
	{_npc enableAI _x} forEach ["ANIM","FSM","MOVE"];
};

_npc setVariable ["MCC_animRunning",false];
