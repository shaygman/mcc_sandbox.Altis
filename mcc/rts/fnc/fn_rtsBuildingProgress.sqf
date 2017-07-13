/*================================================================MCC_fnc_rtsBuildingProgress==============================================================================
//	manage building progress
//  Parameter(s):
//     	_ctrl: CONTROL
//===================================================================================================================================================================*/
private ["_BuildTime","_obj","_res"];
_obj = _this select 0;
_res = param [1,[],[[]]];

_BuildTime = 5;
{
	if ((_x select 0)=="time") exitWith {_BuildTime = (_x select 1)};
} foreach _res;

if (((_obj getVariable ["mcc_constructionendTime",-30])+(_obj getVariable ["mcc_constructionStartTime",time])) > time) exitWith {[9989,"Another production is already in progress",5,true] call MCC_fnc_setIDCText;false};

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

_obj setVariable ["mcc_constructionendTime",_BuildTime,true];
_obj setVariable ["mcc_constructionStartTime",time,true];
sleep _BuildTime;

if (! alive (_obj getVariable ["mcc_construction_anchor",objNull])) exitWith {false};
true;