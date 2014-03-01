private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class","_side"];
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

//-------------------------------Players managment--------------------------------------------------------------------------------------------------------------
MCC_UMunitsNames = [];
UMgroupNames = [];
_comboBox = _mccdialog displayCtrl MCC_UM_LIST;
lbClear _comboBox;
if (MCC_UMstatus == 0) then //player
	{
		if (MCC_UMUnit==0) then 
			{
				{
				if ((isPlayer _x) && (alive _x)) then	//unit
					{
						_displayname = name _x;
						_comboBox lbAdd _displayname;
						MCC_UMunitsNames = MCC_UMunitsNames + [_x];
					};
				} forEach  allUnits;
			} else
				{
					{
					if (isPlayer (leader _x)) then	//group
						{
							_displayname =  format ["%1", _x];
							_comboBox lbAdd _displayname;
							UMgroupNames = UMgroupNames + [_x];
						};
					} forEach  allgroups;
				};
	};

switch (MCC_UMstatus) do
{
	case 1:		
	{
		_side =east;
	};
	
	case 2:		
	{
		_side =west;
	};
	
	case 3:		
	{
		_side =resistance;
	};
	
	default
	{
		_side =civilian;
	}; 
};

if (MCC_UMUnit==0) then 
{
	{
		if (alive _x && side _x == _side && !(isPlayer _x)) then	//Unit
		{
			_displayname = getText (configfile >> "CfgVehicles" >> typeOf (vehicle _x)  >> "displayName"); 
			if ((_x != vehicle _x) && ((driver (vehicle _x))==_x)) then {_displayname = format ["%1 (Driver)",_displayname]};
			if ((_x != vehicle _x) && ((gunner (vehicle _x))==_x)) then {_displayname =  format ["%1 (Gunner)",_displayname]};
			if ((_x != vehicle _x) && ((commander (vehicle _x))==_x)) then {_displayname =  format ["%1 (Commander)",_displayname]};
			_comboBox lbAdd _displayname;
			MCC_UMunitsNames = MCC_UMunitsNames + [_x];
		};
	} forEach allUnits;
} 
else
{
	{
		if ((side (leader _x) == _side) && !(isPlayer leader _x)) then	//group
		{
			_displayname =  format ["%1", _x];
			_comboBox lbAdd _displayname;
			UMgroupNames = UMgroupNames + [_x];
		};
	} forEach  allgroups;
};
	
_comboBox lbSetCurSel 0;
	
	
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