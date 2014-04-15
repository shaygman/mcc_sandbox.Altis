#define FACTIONCOMBO 1001
#define MCC_MWPlayersIDC 6001
#define MCC_MWATMinesIDC 6002
#define MCC_MWAPMinesIDC 6003
#define MCC_MWStealthIDC 6004
#define MCC_MWReinforcementIDC 6005
#define MCC_MWDifficultyIDC 6006
#define MCC_MWObjective1IDC 6007
#define MCC_MWObjective2IDC 6008
#define MCC_MWObjective3IDC 6009
#define MCC_MWVehiclesIDC 6010
#define MCC_MWArmorIDC 6011
#define MCC_MWIEDIDC 6012
#define MCC_MWSBIDC 6013
#define MCC_MWArmedCiviliansIDC 6014
#define MCC_MWCQBIDC 6015
#define MCC_MWRoadBlocksIDC 6016
#define MCC_MWWeatherComboIDC 6017
#define MCC_MCC_MWAreaComboIDC 6018
#define MCC_MWDebugComboIDC 6019
#define MCC_MWPreciseMarkersComboIDC 6020
#define MCC_MWArtilleryIDC 6021

private ["_mccdialog","_comboBox","_displayname"];
disableSerialization;

uiNamespace setVariable ["MCC_MWDialog", _this select 0];
_mccdialog = _this select 0;

MCC_mcc_screen = 3; 
_comboBox = _mccdialog displayCtrl FACTIONCOMBO;		//fill combobox CFG factions
	lbClear _comboBox;
	{
		_displayname = format ["%1(%2)",_x select 0,_x select 1];
		_comboBox lbAdd _displayname;
	} foreach U_FACTIONS;
	_comboBox lbSetCurSel MCC_faction_index;

//------------------------------------------- ZONES --------------------------------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl 1023; //fill combobox zone's numbers
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_zones_numbers;
_comboBox lbSetCurSel MCC_zone_index;
	
//==========================       Mission Wizard ===============================================
_comboBox = _mccdialog displayCtrl MCC_MWPlayersIDC;		
lbClear _comboBox;
for [{_x = 1},{_x <= MCC_MWmaxPlayers},{_x = _x+1}] do	
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	};
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWStealthIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;

_comboBox = _mccdialog displayCtrl MCC_MWPreciseMarkersComboIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["Yes","No"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWReinforcementIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes - Aerial","Yes - Motorized","Yes - Random"];
_comboBox lbSetCurSel 3;

_comboBox = _mccdialog displayCtrl MCC_MWArtilleryIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Mortars","Self Propelled Artillery","Random"];
_comboBox lbSetCurSel 3;
	
_comboBox = _mccdialog displayCtrl MCC_MWDifficultyIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach MCC_MWDifficulty;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWObjective1IDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach MCC_MWMissionType;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWObjective2IDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach MCC_MWMissionType;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWObjective3IDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach MCC_MWMissionType;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWVehiclesIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;

_comboBox = _mccdialog displayCtrl MCC_MWArmorIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;

_comboBox = _mccdialog displayCtrl MCC_MWDebugComboIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MWIEDIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;

_comboBox = _mccdialog displayCtrl MCC_MWSBIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;

_comboBox = _mccdialog displayCtrl MCC_MWArmedCiviliansIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;

_comboBox = _mccdialog displayCtrl MCC_MWCQBIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes Without Civilians","Yes With Civilians","Random"];
_comboBox lbSetCurSel 3;

_comboBox = _mccdialog displayCtrl MCC_MWRoadBlocksIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["No","Yes","Random"];
_comboBox lbSetCurSel 2;


_comboBox = _mccdialog displayCtrl MCC_MWWeatherComboIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["Change","Don't change"];
_comboBox lbSetCurSel 1;

_comboBox = _mccdialog displayCtrl MCC_MCC_MWAreaComboIDC;		
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["Whole map","Current zone"];
_comboBox lbSetCurSel 0;