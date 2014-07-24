#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD") 

private ["_ok","_key","_haveItem","_commander"];
disableSerialization;		//If we came from the addAction

_key = _this;
if (isnil "_key") then {_key = []};

if (count _key > 4) exitWith
{
	/*
	if (MCC_isMode) then 
	{
		_haveItem =  "MCC_Console" in (assignedItems player); 					<===== Absolute now MCC_console is assigned by commander
	}
	else 
	{
		_haveItem = "B_UavTerminal" in (assignedItems player);
	};
	*/ 
	
	if (((_key select 4) == 0) && (player getVariable ['MCC_allowed',false])) exitWith 
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
	
	_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];
	if (((_key select 4) == 1) && (_commander == getPlayerUID player)) exitWith 
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
	
	//Squad Dialog
	if ((_key select 4) == 2) exitWith 
	{
		if (dialog) then 
		{
			
			if (str (CP_SQUADPANEL_IDD displayCtrl 0) != "No control") then {MCC_squadDialogOpen = false};
			closeDialog 0;
			
			if !(isnil "CP_gearCam") then
			{
				detach CP_gearCam; 
				CP_gearCam cameraeffect ["Terminate","back"];
				camDestroy CP_gearCam;
				deleteVehicle CP_gearCam;
				CP_gearCam = nil; 
			};
		}
		else
		{
			while {dialog} do {closeDialog 0; sleep 0.01};
			MCC_squadDialogOpen = true;
			createDialog "CP_SQUADPANEL";
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