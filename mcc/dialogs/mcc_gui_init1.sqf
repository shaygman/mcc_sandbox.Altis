#define MCC_SANDBOX_IDD 1000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054

#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007

#define MCCSTOPCAPTURE 1014
#define MCCSTARTWEST 1015
#define MCCSTARTEAST 1016
#define MCCSTARTGUAR 1017
#define MCCSTARTCIV 1018

#define MCCENABLECP 1027

private ["_mccdialog","_comboBox","_displayname","_it","_x","_index"];
disableSerialization;
MCC_GUI1initDone = false; 
 
ctrlEnable [MAIN,false]; //Disable switching menus till the init is done
ctrlEnable [MENU2,false];
ctrlEnable [MENU3,false];
ctrlEnable [MENU4,false];
ctrlEnable [MENU5,false];

if (CP_activated) then {ctrlenable [MCCENABLECP,false]};

_mccdialog = findDisplay MCC_SANDBOX_IDD;

if (!MCC_capture_state) then { ctrlEnable [MCCSTOPCAPTURE,false];};


//----------------------------------------------------------Client Side settings----------------------------------------------------------------------------

_comboBox = _mccdialog displayCtrl MCCGRASSDENSITY;		//fill combobox Grass
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_grass_array;
_comboBox lbSetCurSel MCC_grass_index;

_comboBox = _mccdialog displayCtrl MCCVIEWDISTANCE;		//fill combobox View distance
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_view_array;
_comboBox lbSetCurSel ((round ((viewdistance)/1000)) - 1); // set viewdistance index to current vd

if (mcc_missionmaker == (name player)) then
 { 
	ctrlEnable [MAIN,false]; //Enable switching menus 
	ctrlEnable [MENU2,true];
	ctrlEnable [MENU3,true];
	ctrlEnable [MENU4,true];
	ctrlEnable [MENU5,true];
 };
 
if (MCCFirstOpenUI) then //First Lunch
{
	MCCFirstOpenUI = false; 
	closeDialog 0;
	[0] execVM "mcc\dialogs\mcc_PopupMenu2.sqf"
};

MCC_GUI1initDone = true; 

