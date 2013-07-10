private ["_mccdialog","_comboBox","_displayname","_pic", "_index","_planeName","_counter","_type",
		 "_insetionArray","_control"];
// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000
#define MCC_MINIMAP 9000

#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104
#define MCC_ConsoleEvacTypeText_IDD 9103

disableSerialization;
MCC_Console1Open = true;
MCC_Console2Open = false;
MCC_Console3Open = false;
MCC_Console4Open = false;

_mccdialog = findDisplay mcc_playerConsole_IDD;

//--------------------------------------------------Evac-------------------------------------------------------------------------------	
if (count MCC_evacVehicles > 0) then	{
	_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacTypeText_IDD;		//fill combobox type
	lbClear _comboBox;
	{
		if (alive _x) then	{
			_vehicleDisplayName 	= getText(configFile >> "CfgVehicles" >> typeof _x >> "displayname");
			_displayname 			= format ["%1, %2",_x,_vehicleDisplayName];
			_index 					= _comboBox lbAdd _displayname;
		} else {
			_displayname 			= "N/A";
			_index 					= _comboBox lbAdd _displayname;
			};
	} foreach MCC_evacVehicles;
	_comboBox lbSetCurSel MCC_evacVehicles_index;
	
	_type = MCC_evacVehicles select (lbCurSel MCC_ConsoleEvacTypeText_IDD);
	ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,false];
	_insetionArray = ["Move (engine on)","Move (engine off)"];	
	
	if (_type iskindof "helicopter") then {									//Case we choose aircrft
		ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,true];
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal"];
		_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacFlyHightComboBox_IDD;		//fill combobox Fly in Hight
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x  select 0];
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_evacFlyInHight_array;
		_comboBox lbSetCurSel 0;
	};
	
		_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacApproachComboBox_IDD;		//fill combobox Approach
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach _insetionArray;
	_comboBox lbSetCurSel 0;
};

//----------------------------------------------CAS--------------------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_ConsoleCASAvailableTextBox_IDD;		//fill list box for CAS Types
lbClear _comboBox;
{
	_planeName = getText (configFile >> "CfgVehicles" >> (_x  select 1) select 0>> "displayname");
	_displayname = format ["CAS:%1, Plane:%2",(_x  select 0) select 0,_planeName];
	_index = _comboBox lbAdd _displayname;
} foreach MCC_CASConsoleArray;
_comboBox lbSetCurSel 0;

//----------------------------------------------Airdrop--------------------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_ConsoleAirdropAvailableTextBox_IDD;		//fill list box for Airdrop Types
lbClear _comboBox;
_counter = 1; 
{
	_displayname = format ["%1: %2",_counter,(_x select 0) select 0];
	_index = _comboBox lbAdd _displayname;
	_counter = _counter + 1; 
} foreach MCC_ConsoleAirdropArray;
_comboBox lbSetCurSel 0;