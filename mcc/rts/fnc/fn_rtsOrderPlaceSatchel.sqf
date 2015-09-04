//=================================================================MCC_fnc_rtsOrderPlaceSatchel==============================================================================
//	Order land
//  Parameter(s):
//     _ctrl: CONTROL
//==============================================================================================================================================================================
private ["_group","_pos","_statment","_leader"];
_res = param [1, [], [[]]];

if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_pos = uiNamespace getVariable ["MCC_rtsMenuLeftClickXYpos",[0,0]];
_group = MCC_ConsoleGroupSelected select 0;

if !(vehicle leader _group isKindOf "man") exitWith {"not a man unit"};

[9989,"Left click to place",5,true] spawn MCC_fnc_setIDCText;

waitUntil {str (uiNamespace getVariable ["MCC_rtsMenuLeftClickXYpos",[0,0]]) != str _pos};
_pos = screenToWorld (uiNamespace getVariable ["MCC_rtsMenuLeftClickXYpos",[0,0]]);

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

_leader = leader _group;

_statment = {
	_pos = _this select 0;
	_leader = _this select 1;

	_prepos = getpos _leader;
	_leader domove _pos;
	waitUntil {!(alive _leader) || _leader distance _pos < 6};
	if (!alive _leader) exitWith {};
	_mine = createMine ['SatchelCharge_F',getpos _leader, [], 0];
	_leader domove _prepos;
	_mine spawn {sleep 30; _this setDamage 1};
};

[[[_pos, _leader], _statment], "BIS_fnc_spawn", _leader, false] call BIS_fnc_MP;