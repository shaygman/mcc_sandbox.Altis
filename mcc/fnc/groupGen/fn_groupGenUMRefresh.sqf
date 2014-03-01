//===================================================================MCC_fnc_groupGenUMRefresh=========================================================================================
// Refresh the group gen units lists
// Example:[] call MCC_fnc_groupGenUMRefresh
//==============================================================================================================================================================================	
#define MCC_UM_LIST 3069
disableSerialization;

private ["_side","_mccdialog", "_name", "_worldPos"];

MCC_UMunitsNames = [];
UMgroupNames = [];

_mccdialog =  (uiNamespace getVariable "MCC_groupGen_Dialog");
_comboBox = _mccdialog displayCtrl MCC_UM_LIST;
lbClear _comboBox;

if (MCC_UMstatus == 0) exitWith //player
{
	if (MCC_UMUnit==0) then 
	{
		{
			if ((isPlayer _x) && (alive _x)) then	//unit
			{
				_displayname = name _x;
				_comboBox lbAdd _displayname;
				MCC_UMunitsNames = MCC_UMunitsNames + [_x];
			};
		} forEach  allUnits;
	} 
	else
	{
		{
			if (isPlayer (leader _x)) then	//group
			{
				_displayname =  format ["%1", _x];
				_comboBox lbAdd _displayname;
				UMgroupNames = UMgroupNames + [_x];
			};
		} forEach  allgroups;
	};
	_comboBox lbSetCurSel 0;
};

_side = switch (MCC_UMstatus) do
		{
			case 1: {east};
			case 2: {west};			
			case 3: {resistance};
			case 4: {civilian};
		};
		
if (MCC_UMUnit==0) then 
{
	{
		if (alive _x && side _x == _side && !(isPlayer _x)) then	//Unit
		{
			_displayname =  format ["%1",typeOf (vehicle _x)];
			if ((_x != vehicle _x) && ((driver (vehicle _x))==_x)) then {_displayname = format ["%1 (Driver)",_displayname]};
			if ((_x != vehicle _x) && ((gunner (vehicle _x))==_x)) then {_displayname =  format ["%1 (Gunner)",_displayname]};
			if ((_x != vehicle _x) && ((commander (vehicle _x))==_x)) then {_displayname =  format ["%1 (Commander)",_displayname]};
			_comboBox lbAdd _displayname;
			MCC_UMunitsNames = MCC_UMunitsNames + [_x];
		};
	} forEach allUnits;
} 
else
{
	{
		if ((side (leader _x) == _side) && !(isPlayer leader _x)) then	//group
		{
			_displayname =  format ["%1", _x];
			_comboBox lbAdd _displayname;
			UMgroupNames = UMgroupNames + [_x];
		};
	} forEach  allgroups;
};
_comboBox lbSetCurSel 0;
