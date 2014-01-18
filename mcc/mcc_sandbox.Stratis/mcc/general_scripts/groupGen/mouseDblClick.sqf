//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_button","_posX","_posY","_shift","_ctrlKey","_alt","_mccdialog","_html","_comboBox","_displayname","_index"];
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000

#define MCC_GroupGenInfoText_IDC 9013
#define MCC_GroupGenWPBckgr_IDC 9014
#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018
#define MCC_GroupGenWPAdd_IDC 9019
#define MCC_GroupGenWPReplace_IDC 9020
#define MCC_GroupGenWPClear_IDC 9021

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
_mccdialog = findDisplay groupGen_IDD;

if ((_button == 0) && (count MCC_GroupGenGroupSelected > 0))  then 								//Close Group info control
	{
		//worldPos
		MCC_ConsoleWPpos = _ctrl ctrlMapScreenToWorld [_posX,_posY];
		ctrlShow [MCC_GroupGenInfoText_IDC,false];
		
		//Reveal WP  Bckgr
		(_mccdialog displayctrl MCC_GroupGenWPBckgr_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPBckgr_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPBckgr_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPBckgr_IDC) ctrlSetPosition [_posX, _posY,0.15 * safezoneW,0.18 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPBckgr_IDC) ctrlCommit 0.1;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPBckgr_IDC)};
		_html = "<t font='puristaMedium' color='#818960' size='1' shadow='1' align='left' underline='true'>Waypoints:</t><br/>";
		//_html = _html + "<t color='#fefefe' size='0.9' shadow='1' align='left' underline='false'>Type: </t><br/>";
		(_mccdialog displayctrl MCC_GroupGenWPBckgr_IDC) ctrlSetStructuredText parseText _html;
		
		//Reveal WP  Combo
		(_mccdialog displayctrl MCC_GroupGenWPCombo_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPCombo_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPCombo_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPCombo_IDC) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.025 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPCombo_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPCombo_IDC)};
		
		//Fill WP types
		_comboBox = _mccdialog displayCtrl MCC_GroupGenWPCombo_IDC;		
		lbClear _comboBox;
		{
			_displayname =  _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["Move", "Destroy", "Get In", "Search & Destroy", "Join Group", "Join Group As Leader", "Get Out", "Cycle Waypoints", "Load", "Unload", "Troops Unload", "Hold", "Senetry"
				   ,"Guard","Support","Get In Nearest","Dismiss","Land","Land - Get in"];
		_comboBox lbSetCurSel 0;
		
		//Reveal WP  Formation Combo
		(_mccdialog displayctrl MCC_GroupGenWPformationCombo_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPformationCombo_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPformationCombo_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPformationCombo_IDC) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.057 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPformationCombo_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPformationCombo_IDC)};
		
		//Fill WP  Formation
		_comboBox = _mccdialog displayCtrl MCC_GroupGenWPformationCombo_IDC;		
		lbClear _comboBox;
		{
			_displayname =  _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["FORMATION: UNCHANGED", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
		_comboBox lbSetCurSel 0;
		
		//Reveal WP  Speed Combo
		(_mccdialog displayctrl MCC_GroupGenWPspeedCombo_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPspeedCombo_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPspeedCombo_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPspeedCombo_IDC) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.088 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPspeedCombo_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPspeedCombo_IDC)};
		
		//Fill WP  Speed
		_comboBox = _mccdialog displayCtrl MCC_GroupGenWPspeedCombo_IDC;		
		lbClear _comboBox;
		{
			_displayname =  _x;
			_index = _comboBox lbAdd _displayname;
		} foreach  ["SPEED: UNCHANGED", "LIMITED", "NORMAL", "FULL"];
		_comboBox lbSetCurSel 0;
		
		//Reveal WP  Behavior Combo
		(_mccdialog displayctrl MCC_GroupGenWPbehaviorCombo_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPbehaviorCombo_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPbehaviorCombo_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPbehaviorCombo_IDC) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.118 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPbehaviorCombo_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPbehaviorCombo_IDC)};
		
		//Fill WP  Behavior
		_comboBox = _mccdialog displayCtrl MCC_GroupGenWPbehaviorCombo_IDC;		
		lbClear _comboBox;
		{
			_displayname =  _x;
			_index = _comboBox lbAdd _displayname;
		} foreach   ["BEHAVIOR: UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"];
		_comboBox lbSetCurSel 0;
		
		//Reveal WP  Button - ADD
		(_mccdialog displayctrl MCC_GroupGenWPAdd_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPAdd_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPAdd_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPAdd_IDC) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.148 * safezoneH),0.045 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPAdd_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPAdd_IDC)};
		
		//Reveal WP  Button - REPLACE
		(_mccdialog displayctrl MCC_GroupGenWPReplace_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPReplace_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPReplace_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPReplace_IDC) ctrlSetPosition [_posX + (0.052 * safezoneW), _posY + (0.148 * safezoneH),0.045 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPReplace_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPReplace_IDC)};
		
		//Reveal WP  Button - CLEAR
		(_mccdialog displayctrl MCC_GroupGenWPClear_IDC) ctrlSetPosition [_posX,_posY,0,0];	
		ctrlShow [MCC_GroupGenWPClear_IDC,true];
		(_mccdialog displayctrl MCC_GroupGenWPClear_IDC) ctrlCommit 0;
		(_mccdialog displayctrl MCC_GroupGenWPClear_IDC) ctrlSetPosition [_posX + (0.099 * safezoneW), _posY + (0.148 * safezoneH),0.045 * safezoneW,0.03 * safezoneH];
		(_mccdialog displayctrl MCC_GroupGenWPClear_IDC) ctrlCommit 0;
		waituntil {ctrlCommitted (_mccdialog displayctrl MCC_GroupGenWPClear_IDC)};
	};	

MCC_doubleClicked = false;	
		
				
	
//hint format ["_ctrl: %1; _button: %2; _pos: %3, _shift: %4; _ctrl: %5; _alt: %6;",_ctrl,_button,[_posX,_posY],_shift,_ctrl,_alt]; 