/*==================================================================MCC_fnc_RSSquadLock======================================================================================
// Lock sqaud
	<IN>
		_this select 0:			STRING group NetID

	<OUT>
==============================================================================================================================================================================*/
private ["_group","_groups"];
_idc = param [0,0,[0]];

_groups	 = switch (player getVariable ["CP_side", playerside]) do {
				case east:{missionNamespace getVariable ["CP_eastGroups",[]]};
				case resistance:{missionNamespace getVariable ["CP_guarGroups",[]]};
				default {missionNamespace getVariable ["CP_westGroups",[]]};
			};

_group = (_groups select _idc) select 0;
if (player != leader _group) exitWith {};
_group setVariable ["locked",!(_group getVariable ["locked",false]),true];