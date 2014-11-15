#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD") 

private ["_ok","_key","_index","_commander"];
disableSerialization;		

_key = _this;
if (isnil "_key") then {_key = []};

//If we didn't came from the addAction
if (count _key > 4) then
{
	_index = _key select 4;
}
else
{
	_index = (_key select 3) select 4;
};

if (_index == 0) exitWith 
{
	if (str findDisplay 2994 != "No display") then 
	{
		while {dialog} do {closeDialog 0};
	}
	else
	{
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
				//Close Dialog
				if (dialog) exitWith
				{
					while {dialog} do {closeDialog 0};
				};
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
		
		MCC_mcc_screen = 0;
	};
};  

//Console
_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];
if ((_index == 1) && (_commander == getPlayerUID player) && MCC_allowConsole) exitWith 
{
	if (dialog) then 
	{
		while {dialog} do {closeDialog 0};
	}
	else
	{
		_null = [nil,nil,nil,[0]] execVM  format ["%1mcc\general_scripts\console\conoleOpenMenu.sqf",MCC_path];
	};
}; 

//Squad Dialog
if (_index == 2 && MCC_allowSquadDialog) exitWith 
{
	if (dialog) then 
	{
		
		if (str (CP_SQUADPANEL_IDD displayCtrl 0) != "No control") then {MCC_squadDialogOpen = false};
		while {dialog} do {closeDialog 0};
		
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

//SQL PDA
if (_index == 3 && ((count units player > 1) && (leader player == player)) && MCC_allowsqlPDA) exitWith 
{
	if (dialog) then 
	{
		while {dialog} do {closeDialog 0};
	}
	else
	{
		createDialog "MCC_SQLPDA";
	};
};