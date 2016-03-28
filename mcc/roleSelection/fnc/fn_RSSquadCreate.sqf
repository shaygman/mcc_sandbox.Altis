/*==================================================================MCC_fnc_RSSquadCreate======================================================================================
// Create a new sqaud
	<IN>
		Nothing

	<OUT>
		Nothing
==============================================================================================================================================================================*/
private ["_name","_groups","_groupsNamesArray","_group","_groupName"];
#define CP_maxSquads 12

//close name edits
for "_i" from 500 to 515 do {
	((uiNamespace getVariable "CP_RESPAWNPANEL_IDD") displayCtrl (_i + 700)) ctrlShow false;
};

//Close units menu
((uiNamespace getVariable "CP_RESPAWNPANEL_IDD") displayCtrl 4343) ctrlShow false;


_groups	 = switch (player getVariable ["CP_side", playerside]) do {
				case east:{missionNamespace getVariable ["CP_eastGroups",[]]};
				case resistance:{missionNamespace getVariable ["CP_guarGroups",[]]};
				default {missionNamespace getVariable ["CP_westGroups",[]]};
			};

//is there room to make another squad
if ((count _groups) >= CP_maxSquads) exitWith {
	[9999,format ["Max number of squads reached %1/%2", count _groups, CP_maxSquads],3,true] spawn MCC_fnc_setIDCText;
};

_name = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliett","Kilo","Lima","Mike","November","Oscar","Papa"] select (count _groups);

//Create a new squad
_group = creategroup (player getVariable ["CP_side",  playerside]);
_null = [] call MCC_fnc_setGear;

[player] join _group;

switch (player getVariable ["CP_side",playerside]) do {
	case east:{
		CP_eastGroups pushBack [_group,_name];
		publicvariable "CP_eastGroups";
	};

	case resistance:{
		CP_guarGroups pushBack [_group,_name];
		publicvariable "CP_guarGroups";
	};

	case default {
		CP_westGroups pushBack [_group,_name];
		publicvariable "CP_westGroups";
	};
};

_group setVariable ["name",_name,true];
[9999,format ["Squad %1 Created", _name, _group],3,true] spawn MCC_fnc_setIDCText;