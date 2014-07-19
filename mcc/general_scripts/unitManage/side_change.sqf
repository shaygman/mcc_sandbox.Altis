#define MCC_SANDBOX4_IDD 4000
#define MCC_UM_LIST 3069
disableSerialization;

private ["_type","_mccdialog", "_name", "_worldPos"];

MCC_UMunitsNames = [];
UMgroupNames = [];
MCC_UMstatus = _this select 0;

_mccdialog = findDisplay MCC_SANDBOX4_IDD;
_comboBox = _mccdialog displayCtrl MCC_UM_LIST;
lbClear _comboBox;
if (MCC_UMstatus == 0) then //player
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
			} else
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
	};
	
if (MCC_UMstatus == 1) then 	//East
	{	
		if (MCC_UMUnit==0) then 
			{
				{
				if (alive _x && side _x == east && !(isPlayer _x)) then	//Unit
					{
						_displayname =  format ["%1",typeOf (vehicle _x)];
						if ((_x != vehicle _x) && ((driver (vehicle _x))==_x)) then {_displayname = format ["%1 (Driver)",_displayname]};
						if ((_x != vehicle _x) && ((gunner (vehicle _x))==_x)) then {_displayname =  format ["%1 (Gunner)",_displayname]};
						if ((_x != vehicle _x) && ((commander (vehicle _x))==_x)) then {_displayname =  format ["%1 (Commander)",_displayname]};
						_comboBox lbAdd _displayname;
						MCC_UMunitsNames = MCC_UMunitsNames + [_x];
					};
				} forEach allUnits;
			} else
				{
					{
					if ((side (leader _x) == east) && !(isPlayer leader _x)) then	//group
						{
							_displayname =  format ["%1", _x];
							_comboBox lbAdd _displayname;
							UMgroupNames = UMgroupNames + [_x];
						};
					} forEach  allgroups;
				};
	};

if (MCC_UMstatus == 2) then 	//West
	{	
		if (MCC_UMUnit==0) then 
			{
				{
				if (alive _x && side _x == west && !(isPlayer _x)) then
					{
						_displayname =  format ["%1",typeOf (vehicle _x)];
						if ((_x != vehicle _x) && ((driver (vehicle _x))==_x)) then {_displayname = format ["%1 (Driver)",_displayname]};
						if ((_x != vehicle _x) && ((gunner (vehicle _x))==_x)) then {_displayname =  format ["%1 (Gunner)",_displayname]};
						if ((_x != vehicle _x) && ((commander (vehicle _x))==_x)) then {_displayname =  format ["%1 (Commander)",_displayname]};
						_comboBox lbAdd _displayname;
						MCC_UMunitsNames = MCC_UMunitsNames + [_x];
					};
				} forEach allUnits;
			} else
				{
					{
					if ((side (leader _x) == west) && !(isPlayer leader _x)) then	//group
						{
							_displayname =  format ["%1", _x];
							_comboBox lbAdd _displayname;
							UMgroupNames = UMgroupNames + [_x];
						};
					} forEach  allgroups;
				};
	};

if (MCC_UMstatus == 3) then 
	{	
		if (MCC_UMUnit==0) then 
			{
				{
				if (alive _x && side _x == resistance && !(isPlayer _x)) then
					{
						_displayname =  format ["%1",typeOf (vehicle _x)];
						if ((_x != vehicle _x) && ((driver (vehicle _x))==_x)) then {_displayname = format ["%1 (Driver)",_displayname]};
						if ((_x != vehicle _x) && ((gunner (vehicle _x))==_x)) then {_displayname =  format ["%1 (Gunner)",_displayname]};
						if ((_x != vehicle _x) && ((commander (vehicle _x))==_x)) then {_displayname =  format ["%1 (Commander)",_displayname]};
						_comboBox lbAdd _displayname;
						MCC_UMunitsNames = MCC_UMunitsNames + [_x];
					};
				} forEach allUnits;
			} else
				{
					{
					if ((side (leader _x) == resistance) && !(isPlayer leader _x)) then	//group
						{
							_displayname =  format ["%1", _x];
							_comboBox lbAdd _displayname;
							UMgroupNames = UMgroupNames + [_x];
						};
					} forEach  allgroups;
				};
	};	
_comboBox lbSetCurSel 0;
