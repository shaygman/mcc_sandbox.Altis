//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_button","_posX","_posY","_shift","_ctrlKey","_alt","_mccdialog","_html","_comboBox","_displayname","_index","_3dCommander"];
#define mcc_playerConsole_IDD 2993
#define mcc_playerConsole2_IDD 5000
#define mcc_playerConsole3_IDD 5010

#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_CONSOLEINFOUAVCONTROL 9162

#define MCC_CONSOLEWPBCKGR 9157
#define MCC_CONSOLEWPCOMBO 9158
#define MCC_CONSOLEWPFORMATIONCOMBO 9166
#define MCC_CONSOLEWPSPEEDCOMBO 9167
#define MCC_CONSOLEWPBEHAVIORCOMBO 9168

#define MCC_CONSOLEWPADD 	9159
#define MCC_CONSOLEWPREPLACE 9160
#define MCC_CONSOLEWPCLEAR 9161

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

//is 3d commander online?
_3dCommander = !(isnull (uiNamespace getVariable ["MCC_LOGISTICS_BASE_BUILD",displayNull]));

//Define which control
if (MCC_Console1Open) then {_mccdialog = findDisplay mcc_playerConsole_IDD};
if (MCC_Console2Open) then {_mccdialog = findDisplay mcc_playerConsole2_IDD};
if (MCC_Console3Open) then {_mccdialog = findDisplay mcc_playerConsole3_IDD};

//Close Group info control
if ((_button == 0) && (count (missionNamespace getVariable ["MCC_ConsoleGroupSelected",[]]) > 0) && !_ctrlKey && !_3dCommander)  then {
	//worldPos
	MCC_ConsoleWPpos = _ctrl ctrlMapScreenToWorld [_posX,_posY];
	ctrlShow [MCC_CONSOLEINFOTEXT,false];
	ctrlShow [MCC_CONSOLEINFOLIVEFEED,false];
	ctrlShow [MCC_CONSOLEINFOUAVCONTROL,false];

	//Reveal WP  Bckgr
	(_mccdialog displayctrl MCC_CONSOLEWPBCKGR) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPBCKGR,true];
	(_mccdialog displayctrl MCC_CONSOLEWPBCKGR) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPBCKGR) ctrlSetPosition [_posX, _posY,0.15 * safezoneW,0.18 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPBCKGR) ctrlCommit 0.1;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPBCKGR)};
	_html = "<t font='puristaMedium' color='#818960' size='1' shadow='1' align='left' underline='true'>Waypoints:</t><br/>";
	//_html = _html + "<t color='#fefefe' size='0.9' shadow='1' align='left' underline='false'>Type: </t><br/>";
	(_mccdialog displayctrl MCC_CONSOLEWPBCKGR) ctrlSetStructuredText parseText _html;

	//Reveal WP  Combo
	(_mccdialog displayctrl MCC_CONSOLEWPCOMBO) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPCOMBO,true];
	(_mccdialog displayctrl MCC_CONSOLEWPCOMBO) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPCOMBO) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.025 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPCOMBO) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPCOMBO)};

	//Fill WP types
	_comboBox = _mccdialog displayCtrl MCC_CONSOLEWPCOMBO;
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Move", "Destroy", "Get In", "Search & Destroy", "Join Group", "Join Group As Leader", "Get Out", "Cycle Waypoints", "Load", "Unload", "Troops Unload", "Hold", "Senetry"
			   ,"Guard","Support","Get In Nearest","Dismiss","Helicopter - Land","Helicopter - Get in","Artillery - Fire Mission","Loiter"];
	_comboBox lbSetCurSel 0;

	//Reveal WP  Formation Combo
	(_mccdialog displayctrl MCC_CONSOLEWPFORMATIONCOMBO) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPFORMATIONCOMBO,true];
	(_mccdialog displayctrl MCC_CONSOLEWPFORMATIONCOMBO) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPFORMATIONCOMBO) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.057 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPFORMATIONCOMBO) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPFORMATIONCOMBO)};

	//Fill WP  Formation
	_comboBox = _mccdialog displayCtrl MCC_CONSOLEWPFORMATIONCOMBO;
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
	_comboBox lbSetCurSel 0;

	//Reveal WP  Speed Combo
	(_mccdialog displayctrl MCC_CONSOLEWPSPEEDCOMBO) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPSPEEDCOMBO,true];
	(_mccdialog displayctrl MCC_CONSOLEWPSPEEDCOMBO) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPSPEEDCOMBO) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.088 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPSPEEDCOMBO) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPSPEEDCOMBO)};

	//Fill WP  Speed
	_comboBox = _mccdialog displayCtrl MCC_CONSOLEWPSPEEDCOMBO;
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach  ["UNCHANGED", "LIMITED", "NORMAL", "FULL"];
	_comboBox lbSetCurSel 0;

	//Reveal WP  Behavior Combo
	(_mccdialog displayctrl MCC_CONSOLEWPBEHAVIORCOMBO) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPBEHAVIORCOMBO,true];
	(_mccdialog displayctrl MCC_CONSOLEWPBEHAVIORCOMBO) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPBEHAVIORCOMBO) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.118 * safezoneH),0.14 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPBEHAVIORCOMBO) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPBEHAVIORCOMBO)};

	//Fill WP  Behavior
	_comboBox = _mccdialog displayCtrl MCC_CONSOLEWPBEHAVIORCOMBO;
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach   ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"];
	_comboBox lbSetCurSel 0;

	//Reveal WP  Button - ADD
	(_mccdialog displayctrl MCC_CONSOLEWPADD) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPADD,true];
	(_mccdialog displayctrl MCC_CONSOLEWPADD) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPADD) ctrlSetPosition [_posX + (0.005 * safezoneW), _posY + (0.148 * safezoneH),0.045 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPADD) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPADD)};

	//Reveal WP  Button - REPLACE
	(_mccdialog displayctrl MCC_CONSOLEWPREPLACE) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPREPLACE,true];
	(_mccdialog displayctrl MCC_CONSOLEWPREPLACE) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPREPLACE) ctrlSetPosition [_posX + (0.052 * safezoneW), _posY + (0.148 * safezoneH),0.045 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPREPLACE) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPREPLACE)};

	//Reveal WP  Button - CLEAR
	(_mccdialog displayctrl MCC_CONSOLEWPCLEAR) ctrlSetPosition [_posX,_posY,0,0];
	ctrlShow [MCC_CONSOLEWPCLEAR,true];
	(_mccdialog displayctrl MCC_CONSOLEWPCLEAR) ctrlCommit 0;
	(_mccdialog displayctrl MCC_CONSOLEWPCLEAR) ctrlSetPosition [_posX + (0.099 * safezoneW), _posY + (0.148 * safezoneH),0.045 * safezoneW,0.03 * safezoneH];
	(_mccdialog displayctrl MCC_CONSOLEWPCLEAR) ctrlCommit 0;
	waituntil {ctrlCommitted (_mccdialog displayctrl MCC_CONSOLEWPCLEAR)};
};

if (_3dCommander) then {
	private ["_cam","_hight","_pos"];
	_cam = missionNamespace getVariable ["MCC_CONST_CAM",objNull];
	if !(isNull _cam) then {
		_hight = (getpos _cam) select 2;
		_pos = _ctrl ctrlmapscreentoworld [_posX,_posY];
		_pos set [2,_hight];
		MCC_CONST_CAM setpos _pos;
	};
};

MCC_doubleClicked = false;