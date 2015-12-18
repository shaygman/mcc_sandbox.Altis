private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class","_side","_html","_zone","_markerlabel"];
// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000
#define MCC_FACTION 8008

#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022
#define MCC_GroupGenInfo_IDC 530

#define MCCSTOPCAPTURE 1014

#define MCC_UM_LIST 3069
#define MCC_UM_PIC 3070
#define MCC_UM_KICK 3076
#define MCC_UM_BAN 3077

disableSerialization;
MCC_mcc_screen = 2;	//Group gen for poping up the same menu again

//Clear old data
missionNamespace setVariable ["MCC_selectedUnits",[]];
missionNamespace setVariable ["MCC_GroupGenGroupSelected",[]];

uiNamespace setVariable ["MCC_groupGen_Dialog", _this select 0];

//Add delete button
(findDisplay groupGen_IDD) displayAddEventHandler ["KeyUp",format ["if (_this select 1 == 211) then {MCC_UMUnit = 3; null = [12] execVM '%1mcc\general_scripts\unitManage\um.sqf'};",MCC_path]];

//Assign as Curator on init
if (player != getAssignedCuratorUnit MCC_curator) then {[compile format ["objectFromNetId '%1' assignCurator MCC_curator;", netid player],"BIS_fnc_spawn",false,false] spawn BIS_fnc_MP};

//Track units if enabled
if (MCC_trackMarker) then
{
	MCC_trackMarkerHandler = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 9000) ctrladdeventhandler ["draw","_this call MCC_fnc_trackUnits;"];
};

//Hide GroupWP
ctrlShow [510,false];
ctrlShow [MCC_GroupGenInfo_IDC,false];

//Show zones
{str _x setMarkerAlphaLocal 0.4;(format["LABEL_%1",_x]) setMarkerAlphaLocal 1;} foreach MCC_zones_numbers;

//Hide admin buttons for no-admins
if !(serverCommandAvailable "#logout") then
{
	ctrlShow [MCC_UM_KICK,false];
	ctrlShow [MCC_UM_BAN,false];
};

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

if (MCC_GAIA_AC) then
{
	ctrlsettext [1015,"Ambient Warzone(on)"];
}
else
{
	ctrlsettext [1015,"Ambient Warzone(off)"];
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

_html = "<t color='#fefefe' size='1' shadow='1' align='center' underline='true'>HELP:</t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Scroll down this menu to get help. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Open 3D Editor: ALT + LMB on map. </t><br/><br/>";
_html = _html + "<t color='#fefefe' size='1' shadow='1' align='center' underline='true'>GROUPS: </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Assign Waypoint: Select a group and double Click on map. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Assign Quick Waypoint: Select groups hold Ctrl + double Click on map. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Groups' multi-select: Hold and drag on map. </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Group Info:  Righ Click on Group's icon. </t><br/><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Delete Selected Groups: Press the Delete button </t><br/><br/>";
_html = _html + "<t color='#fefefe' size='1' shadow='1' align='center' underline='true'>ZONES: </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Select Zone: Left Click on Zone's icon.</t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Move Zone: Click on Zone's icon and drag.</t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Resize Zone: Shift + click on Zone's icon and drag.</t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Rotate Zone: Ctrl + click on Zone's icon and rotate. </t><br/><br/>";
_html = _html + "<t color='#fefefe' size='1' shadow='1' align='center' underline='true'>IED: </t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Manual Detonate: Ctrl + Left mouse button on an IED icon.</t><br/>";
_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>* Sync IEDs: Drag a line between two IEDs while holding Shift + Left mouse button.</t><br/>";

_comboBox ctrlSetStructuredText parseText _html;

//Is it first time we around? Let's respawn the zone markers if they are available
if (isnil "MCCFirstOpenUI") then
{
	MCCFirstOpenUI = false;

	sleep 1;
	//Loose mission maker when DC move to after login
	if (!isnil "MCC_zones_numbers") then {[] call MCC_fnc_createMCCZones};
};

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

//Hide zones
{str _x setMarkerAlphaLocal 0;(format["LABEL_%1",_x]) setMarkerAlphaLocal 0;} foreach MCC_zones_numbers;

//------------------------------------------------------------------------------------------