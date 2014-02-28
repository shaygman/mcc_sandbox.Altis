//Made by Shay_Gman (c) 09.10
#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018


private ["_wp","_wpType","_groups","_wpFormation","_wpSpeed","_wpBehavior"];

_action 	= _this select 0; 
_wpType 	= lbCurSel MCC_GroupGenWPCombo_IDC; 
_groups		= []; 
_wpFormation = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"] select (lbCurSel MCC_GroupGenWPformationCombo_IDC); 
_wpSpeed =  ["UNCHANGED", "LIMITED", "NORMAL", "FULL"] select (lbCurSel MCC_GroupGenWPspeedCombo_IDC); 
_wpBehavior = ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"] select (lbCurSel MCC_GroupGenWPbehaviorCombo_IDC); 

{
	_groups set [count _groups, _x];
	//_x setVariable ["MCC_disableUPSMON",true,true];
	_x setVariable ["GAIA_ZONE_INTEND",[], true];
	_x setVariable ["MCC_canbecontrolled",false, true];
} foreach MCC_GroupGenGroupSelected;

//Call the server to handle WP
[[_action,MCC_ConsoleWPpos,[_wpType,"NO CHANGE",_wpFormation,_wpSpeed,_wpBehavior,"true","",0],_groups],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;	
	
ctrlShow [510,false];

