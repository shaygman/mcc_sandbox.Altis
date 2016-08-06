/*==================================================================MCC_fnc_RSSquadjoin=================================================================================
// Handles player joining a squad
	<IN>
		_this select 0:			STRING group NetID

	<OUT>
		BOOLEAN	success
=======================================================================================================================================================================*/
private ["_group","_netID","_null","_succeed","_groupName"];
_netID = param [0,"",[""]];
_groupName = param [1,"",[""]];
_idc = param [2,0,[0]];

#define CP_maxUnits 10

_group = groupFromNetId _netID;
_succeed = false;

//close name edits
for "_i" from 500 to 515 do {
	((uiNamespace getVariable "CP_RESPAWNPANEL_IDD") displayCtrl (_i + 700)) ctrlShow false;
};

//Close units menu
((uiNamespace getVariable "CP_RESPAWNPANEL_IDD") displayCtrl 4343) ctrlShow false;

if (isnull _group) then	{
	_group = createGroup playerside;
	waituntil {!isnil "_group"};
	_group setVariable ["MCC_CPGroup",true,true];
	_group setVariable ["name",_groupName,true];
	 switch (player getVariable ["CP_side", playerside]) do	{
		case west: {
			CP_westGroups set [_idc,[_group,_groupName]];
			publicVariable "CP_westGroups";
		};
		case east: {
			CP_eastGroups set [_idc,[_activeGroup,(CP_activeGroup select 1)]];
			publicVariable "CP_eastGroups";
		};
		case resistance: {
			CP_guarGroups set [_idc,[_activeGroup,(CP_activeGroup select 1)]];
			publicVariable "CP_guarGroups";
		};
	};
};

if (missionNamespace getVariable ["CP_activated",false]) then {
	if (toLower (player getvariable ["CP_role","na"]) != "rifleman") then {
		_null = [] call MCC_fnc_setGear;
	};

	if (count units _group < CP_maxUnits) then {
		_succeed = true;
	};
} else {
	_succeed = true;
};

if (_succeed) then {
	if !(_group getVariable ["locked",false]) then {
		[player] join _group;

		//group leader spawn
		if ((missionNamespace getVariable ["MCC_respawnOnGroupLeader",false]) && !(leader player in ([player] call BIS_fnc_getRespawnPositions))) then {
			[player, grpNull] call BIS_fnc_addRespawnPosition;
		};

	} else {
		_succeed = false;
	};
};

_succeed