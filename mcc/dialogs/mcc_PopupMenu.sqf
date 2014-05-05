private ["_ok","_key"];
disableSerialization;		//If we came from the addAction

_key = _this;
if (isnil "_key") then {_key = []};

if (count _key > 4) exitWith
{
	if (((_key select 4) in actionKeys "User2") && (player getVariable ['MCC_allowed',false])) exitWith 
	{
		if (str findDisplay 2994 != "No display") then 
		{
			closeDialog 0;
		}
		else
		{
			MCC_mcc_screen = 0;
			_null = [] execVM MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf";
		};
	};  
	
	if ((_key select 4) in actionKeys "User3") exitWith 
	{
		if (dialog) then 
		{
			closeDialog 0;
		}
		else
		{
			_null = [nil,nil,nil,[0]] execVM  format ["%1mcc\general_scripts\console\conoleOpenMenu.sqf",MCC_path];
		};
	}; 
};



closeDialog 0;
waituntil {!dialog};

if (name player != mcc_missionMaker) then 
{
	MCC_mcc_screen = 0;
}
else
{	
	if (MCC_mcc_screen == 0) then {MCC_mcc_screen = 2}; 
};


switch (MCC_mcc_screen) do
{
	case 0:
	{
		_ok = createDialog "mcc_loginDialog";
		if !(_ok) exitWith { hint "createDialog failed" };
	};
	case 1:
	{ 
		_ok = createDialog "MCC3D_Dialog";
		if !(_ok) exitWith { hint "createDialog failed" };
	};
	case 2:
	{
		_ok = createDialog "mcc_groupGen";
		if !(_ok) exitWith { hint "createDialog failed" };
	};
	case 3:
	{
		_ok = createDialog "MCCMWDialog";
		if !(_ok) exitWith { hint "createDialog failed" };
	};
};