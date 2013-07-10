#define MCC_SANDBOX3_IDD 3000
#define MCC_UAV_TYPE 3069
disableSerialization;
private ["_dlg","_type","_size","_zoneY","_activate","_cond","_angle","_shape","_text","_pos","_nul","_triggerSelected"];

_dlg = findDisplay MCC_SANDBOX3_IDD;
_type = (MCC_uavSiteArray select (lbCurSel MCC_UAV_TYPE)) select 1;

switch (_type) do
{
   case 0:	//Console's UAV
	{ 
		hint "click on the map to set the UAV"; 
		MCC_consoleUAVposClicked = false;
		onMapSingleClick " 	MCC_consoleUAVpos = _pos; 
							MCC_consoleUAVposClicked = true;
							onMapSingleClick """";";
		waituntil {MCC_consoleUAVposClicked}; 
		if (MCC_capture_state) then	{
			MCC_capture_var = MCC_capture_var + FORMAT ['
					MCC_consoleUAVpos = %1;
					MCC_uavConsoleUp = true;
					publicVariable "MCC_uavConsoleUp"; 
					publicVariable "MCC_consoleUAVpos"; 
					[[2, {["CommunicationMenuItemAdded",["UAV Online","%2data\UAV_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					'
					,MCC_consoleUAVpos
					,MCC_path
					];
			hint "UAV Captured";
			} else {
			[[2, {["CommunicationMenuItemAdded",["UAV Online",MCC_path +"data\UAV_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			hint "Console's UAV is now enabled"; 
			MCC_uavConsoleUp = true;
			publicVariable "MCC_uavConsoleUp"; 
			publicVariable "MCC_consoleUAVpos"; 
			};
	};
	
	 case 1:	//Console's UAV
	{ 
		hint "click on the map to set the UAV"; 
		MCC_consoleUAVposClicked = false;
		onMapSingleClick " 	MCC_consoleUAVpos = _pos; 
							MCC_consoleUAVposClicked = true;
							onMapSingleClick """";";
		waituntil {MCC_consoleUAVposClicked}; 
		if (MCC_capture_state) then	{
			MCC_capture_var = MCC_capture_var + FORMAT ['
					MCC_consoleUAVpos = %1;
					MCC_uavConsoleUp = true;
					MCC_ConsoleUAVmissiles = 4;
					publicVariable "MCC_uavConsoleUp"; 
					publicVariable "MCC_consoleUAVpos"; 
					publicVariable "MCC_ConsoleUAVmissiles"; 
					[[2, {["CommunicationMenuItemAdded",["Predator UAV Online","%2data\UAV_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					'
					,MCC_consoleUAVpos
					,MCC_path
					];
			hint "UAV Captured";
			} else {
				[[2,{["CommunicationMenuItemAdded",["Predator UAV Online",MCC_path +"data\UAV_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
				hint "Console's Predator UAV is now enabled"; 
				MCC_uavConsoleUp = true;
				MCC_ConsoleUAVmissiles = 4; 
				publicVariable "MCC_uavConsoleUp";
				publicVariable "MCC_ConsoleUAVmissiles"; 
				publicVariable "MCC_consoleUAVpos";
				};
	};
	
	 case 2:	//Console's AC-130
	{ 
		hint "click on the map to spawn AC-130"; 
		MCC_consoleUAVposClicked = false;
		onMapSingleClick " 	MCC_consoleACpos = _pos; 
							MCC_consoleUAVposClicked = true;
							onMapSingleClick """";";
		waituntil {MCC_consoleUAVposClicked}; 
		if (MCC_capture_state) then	{
			MCC_capture_var = MCC_capture_var + FORMAT ['
					MCC_consoleACpos = %1;
					MCC_ACConsoleUp = true;
					publicVariable "MCC_ACConsoleUp"; 
					publicVariable "MCC_consoleACpos"; 
					[[2, {["CommunicationMenuItemAdded",["AC-130 Entered the scene","%2data\AC130_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					'
					,MCC_consoleACpos
					,MCC_path
					];
			hint "AC-130 Captured";
			} else {
				[[2, {["CommunicationMenuItemAdded",["AC-130 Entered the scene",MCC_path +"data\AC130_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
				hint "AC-130 Spooky is airborn";
				MCC_ACConsoleUp = true;
				publicVariable "MCC_ACConsoleUp";
				publicVariable "MCC_consoleACpos"; 	
			};
	};
};