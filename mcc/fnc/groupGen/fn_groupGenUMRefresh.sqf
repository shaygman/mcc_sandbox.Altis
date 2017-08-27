//===================================================================MCC_fnc_groupGenUMRefresh=========================================================================================
// Refresh the group gen units lists
// Example:[] call MCC_fnc_groupGenUMRefresh
//==============================================================================================================================================================================
#define MCC_UM_LIST 3069
disableSerialization;

private ["_mccdialog", "_name", "_worldPos","_group","_index"];

//If we are messing with the list do not refresh
if (isnil "MCC_UMFocus") then {MCC_UMFocus = false};
if (MCC_UMFocus) exitWith {};

MCC_UMunitsNames = [];
UMgroupNames = [];

_mccdialog =  (uiNamespace getVariable "MCC_groupGen_Dialog");
_comboBox = _mccdialog displayCtrl MCC_UM_LIST;
lbClear _comboBox;

if (("players" in MCC_groupGenGroupStatus) && (count MCC_groupGenGroupStatus == 1)) exitWith //player
{
	if (MCC_UMUnit==0) then
	{
		{
			if (alive _x) then	//unit
			{
				_displayname = format ["(Player) - %1",name _x];
				_index = lbAdd [MCC_UM_LIST,_displayname];
				MCC_UMunitsNames = MCC_UMunitsNames + [_x];
			};
		} forEach (allPlayers - entities "HeadlessClient_F");
	}
	else
	{
		{
			if (isPlayer (leader _x)) then	//group
			{
				_displayname = format ["(Players) - %1",_x];
				_index = lbAdd [MCC_UM_LIST,_displayname];
				UMgroupNames = UMgroupNames + [_x];
			};
		} forEach  allgroups;
	};
};

if (isnil "MCC_GroupGenGroupSelected") exitWith {};

if (MCC_UMUnit==0) then
{
	{
		_group = _x;
		{
			if (alive _x && side _x in MCC_groupGenGroupStatus) then	//Unit
			{
				_displayname = if (isPlayer _x) then
								{
									format ["(Player) - %1",name _x];
								}
								else
								{
									getText (configFile >> "cfgVehicles" >> typeof (vehicle _x) >> "displayName");
								};

				if ((_x != vehicle _x) && ((driver (vehicle _x))==_x)) then {_displayname = format ["%1 (Driver)",_displayname]};
				if ((_x != vehicle _x) && ((gunner (vehicle _x))==_x)) then {_displayname =  format ["%1 (Gunner)",_displayname]};
				if ((_x != vehicle _x) && ((commander (vehicle _x))==_x)) then {_displayname =  format ["%1 (Commander)",_displayname]};
				_index = lbAdd [MCC_UM_LIST,_displayname];
				MCC_UMunitsNames = MCC_UMunitsNames + [_x];
			};
		} forEach units _group;
	} foreach MCC_GroupGenGroupSelected;
}
else
{
	{
		if (side (leader _x) in MCC_groupGenGroupStatus) then	//group
		{
			_displayname =  format ["%1", _x];
			if (isPlayer leader _x) then {_displayname = format ["(Players) - %1",_displayname]};
			_index = lbAdd [MCC_UM_LIST,_displayname];
			UMgroupNames = UMgroupNames + [_x];
		};
	} forEach  MCC_GroupGenGroupSelected;
};

