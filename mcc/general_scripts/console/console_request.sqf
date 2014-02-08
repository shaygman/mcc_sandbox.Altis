// By: Shay_gman
// Version: 1.1 (May 2012)
#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104

disableSerialization;
private ["_type","_mccdialog","_comboBox","_counter","_displayname","_index"];
_type = _this select 0;
_mccdialog = findDisplay mcc_playerConsole_IDD;

switch (_type) do
	{
	   case 0:		//AirDrop 
		{
			if (count MCC_ConsoleAirdropArray > 0) then {
				MCC_spawnkind = [((MCC_ConsoleAirdropArray select (lbCurSel MCC_ConsoleAirdropAvailableTextBox_IDD)) select 0) select 0];
				MCC_planeType = [str (side player)];
				
				MCC_ConsoleAirdropArray set  [lbCurSel MCC_ConsoleAirdropAvailableTextBox_IDD,-1];	//Remove the action we just used
				MCC_ConsoleAirdropArray = MCC_ConsoleAirdropArray - [-1];
				
				_comboBox = _mccdialog displayCtrl MCC_ConsoleAirdropAvailableTextBox_IDD;			//fill list box for Airdrop Types
				lbClear _comboBox;
				_counter = 0; 
				{
					_counter = _counter + 1;
					_displayname = format ["%1: ",_counter];
					{
						_displayname = format ["%1, %2",_displayname, getText(configFile >> "CfgVehicles" >> _x >> "displayname")];
					} foreach ((_x select 0) select 0);
					_index = _comboBox lbAdd _displayname;
				} foreach MCC_ConsoleAirdropArray;
				_comboBox lbSetCurSel 0;
				
				hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
				MCC_CASrequestMarker = true;
			};
		};
		
	    case 1:		//CAS 
		{
			if (count MCC_CASConsoleArray > 0) then {
				MCC_spawnkind	= [((MCC_CASConsoleArray select (lbCurSel MCC_ConsoleCASAvailableTextBox_IDD)) select 0) select 0];
				MCC_planeType 	= [((MCC_CASConsoleArray select (lbCurSel MCC_ConsoleCASAvailableTextBox_IDD)) select 1) select 0];
				
				MCC_CASConsoleArray set  [lbCurSel MCC_ConsoleCASAvailableTextBox_IDD,-1];					//Remove the action we just used
				MCC_CASConsoleArray = MCC_CASConsoleArray - [-1];
				
				_comboBox = _mccdialog displayCtrl MCC_ConsoleCASAvailableTextBox_IDD;		//fill list box for CAS Types
				lbClear _comboBox;
				{
					_planeName = getText (configFile >> "CfgVehicles" >> (_x  select 1) select 0>> "displayname");
					_displayname = format ["CAS:%1, Plane:%2",(_x  select 0) select 0,_planeName];
					_index = _comboBox lbAdd _displayname;
				} foreach MCC_CASConsoleArray;
				_comboBox lbSetCurSel 0;
				
				hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
				MCC_CASrequestMarker = true;
			};
		};
	};



