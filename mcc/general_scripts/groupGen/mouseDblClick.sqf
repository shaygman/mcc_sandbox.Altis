//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_button","_posX","_posY","_shift","_ctrlKey","_alt","_mccdialog","_html","_comboBox","_displayname","_index"];
#define MCC_MINIMAP 9000

#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018

disableSerialization;
MCC_doubleClicked = true; 
_params = _this select 0;

_ctrl = _params select 0;
_button = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

//Define which control
_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");
if (isnil "MCC_GroupGenGroupSelected") then {MCC_GroupGenGroupSelected = []};
if ((_button == 0) && (count MCC_GroupGenGroupSelected > 0))  then 								//Close Group info control
{
	//worldPos
	MCC_ConsoleWPpos = _ctrl ctrlMapScreenToWorld [_posX,_posY];
	ctrlShow [510,false];
	
	//Reveal WP  Bckgr
	(_mccdialog displayctrl 510) ctrlSetPosition [_posX,_posY,0,0];	
	ctrlShow [510,true];
	(_mccdialog displayctrl 510) ctrlCommit 0;
	(_mccdialog displayctrl 510) ctrlSetPosition [_posX, _posY,0.189063 * safezoneW,0.219914 * safezoneH];
	(_mccdialog displayctrl 510) ctrlCommit 0.1;
	waituntil {ctrlCommitted (_mccdialog displayctrl 510)};
	
	//Fill WP types
	_comboBox = _mccdialog displayCtrl MCC_GroupGenWPCombo_IDC;		
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Move", "Destroy", "Get In", "Search & Destroy", "Join Group", "Join Group As Leader", "Get Out", "Cycle Waypoints", "Load", "Unload", "Troops Unload", "Hold", "Senetry"
			   ,"Guard","Support","Get In Nearest","Dismiss","Helicopter - Land","Helicopter - Get in","Artillery - Fire Mission"];
	_comboBox lbSetCurSel 0;
	
			
	//Fill WP  Formation
	_comboBox = _mccdialog displayCtrl MCC_GroupGenWPformationCombo_IDC;		
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["UNCHANGED", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
	_comboBox lbSetCurSel 0;
	
	
	//Fill WP  Speed
	_comboBox = _mccdialog displayCtrl MCC_GroupGenWPspeedCombo_IDC;		
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach  ["UNCHANGED", "LIMITED", "NORMAL", "FULL"];
	_comboBox lbSetCurSel 0;
	
		
	//Fill WP  Behavior
	_comboBox = _mccdialog displayCtrl MCC_GroupGenWPbehaviorCombo_IDC;		
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach   ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"];
	_comboBox lbSetCurSel 0;
};	

MCC_doubleClicked = false;				
