private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class","_side","_html"];
// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000
#define MCC_FACTION 8008

#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022
#define MCC_GroupGenInfoText_IDC 9013

#define MCCSTOPCAPTURE 1014

#define MCC_UM_LIST 3069
#define MCC_UM_PIC 3070

disableSerialization;
MCC_mcc_screen = 2;	//Group gen for poping up the same menu again

uiNamespace setVariable ["MCC_groupGen_Dialog", _this select 0];

//Hide GroupWP
ctrlShow [510,false];
ctrlShow [9013,false];

for "_i" from 500 to 518 step 1 do 
{
	((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl _i) ctrlShow false;		
};

if (CP_activated) then
{
	ctrlsettext [520,"Disable Roles"];
}
else
{
	ctrlsettext [520,"Enable Roles"];
}; 
//Capture 
if (!MCC_capture_state) then { ctrlEnable [MCCSTOPCAPTURE,false];};

//Respawn
if (!MCC_enable_respawn) then {((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 2) ctrlEnable false};

//Mission Maker
ctrlSetText [MCCMISSIONMAKERNAME, format["%1",mcc_missionmaker]];

_mccdialog = findDisplay groupGen_IDD;

_comboBox = _mccdialog displayCtrl MCC_FACTION; //fill combobox CFG factions
lbClear _comboBox;
{
	_displayname = format ["%1(%2)",_x select 0,_x select 1];
	_comboBox lbAdd _displayname;
} foreach U_FACTIONS;
_comboBox lbSetCurSel MCC_faction_index;

//-------------------------------------------- GAIA --------------------------------------------------------------------------------------------------
_comboBox =((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 1);		
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_index = _comboBox lbAdd _displayname;
} foreach MCC_GAIA_spawn_behaviors;
_comboBox lbSetCurSel 0;

//------------------------------------------- ZONES --------------------------------------------------------------------------------------------------
_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 1023); //fill combobox zone's numbers
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_zones_numbers;
_comboBox lbSetCurSel MCC_zone_index;

//------------------------------------------- Tooltip --------------------------------------------------------------------------------------------------
_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 303); //fill combobox zone's numbers

_html = "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Open 3D Editor: ALT + LMB on map. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Assign Waypoint: Select a group and double Click on map. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Groups' multi-select: Hold and drag on map. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Group Info: Righ Click on Group icon. </t>";
		
_comboBox ctrlSetStructuredText parseText _html;	
//----------------------------------------------------------- GROUPs ----------------------------------------------------------------------------
	
[] spawn MCC_fnc_groupGenRefresh; 	

//-------------------------------------------------FPS Loop  -----------------------------
while {(str (finddisplay groupGen_IDD) != "no display")} do 
{
	MCC_clientFPS  = round(diag_fps);
	ctrlSetText [MCCCLIENTFPS, format["%1",MCC_clientFPS]];
	
	if (isnil "mcc_fps_running") then {mcc_fps_running = false}; 
	if !(mcc_fps_running) then 
	{
		[[1],"MCC_fnc_FPS",true,false] spawn BIS_fnc_MP;
		sleep 0.5;
	};
		
	if !( MCC_isHC ) then 
	{		
		ctrlSetText [MCCSERVERFPS, format["%1",MCC_serverFPS]];
	}
	else 
	{
		ctrlSetText [MCCSERVERFPS, format[" %1 - HC FPS: %2", MCC_serverFPS, MCC_hcFPS]];
	};
	sleep 1;
};
//------------------------------------------------------------------------------------------