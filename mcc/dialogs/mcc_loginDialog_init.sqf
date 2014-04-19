private ["_mccdialog","_comboBox","_displayname","_it","_x","_index"];
disableSerialization;
MCC_GUI1initDone = false; 

#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007

#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022

//Mission Maker
ctrlSetText [MCCMISSIONMAKERNAME, format["%1",mcc_missionmaker]];

//----------------------------------------------------------Client Side settings----------------------------------------------------------------------------
_mccdialog = finddisplay 2990;

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
_comboBox lbSetCurSel ((round ((viewdistance)/500)) - 2); // set viewdistance index to current vd

sleep 1; 
MCC_GUI1initDone = true; 

//-------------------------------------------------FPS Loop  -----------------------------
while {(str (finddisplay 2990) != "no display")} do 
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