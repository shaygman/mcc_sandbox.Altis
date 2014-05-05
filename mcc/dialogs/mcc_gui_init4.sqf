#define MCC_SANDBOX4_IDD 4000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054
#define MCCSTOPCAPTURE 1014
#define FACTIONCOMBO 1001
#define MCCZONENUMBER 1023
#define MCC_ZONE_LOC 1026
#define MCCDELETEBRUSH 1030

#define MCC_AIRDROPTYPE 1031
#define MCC_airdropClass 1032
#define MCC_airdropArray 1033

#define MCC_UM_LIST 3069

private ["_mccdialog","_comboBox","_displayname","_it","_x","_vehicleDisplayName","_side"];
disableSerialization;

ctrlEnable [MAIN,false]; //Disable switching menus till the init is done
ctrlEnable [MENU2,false];
ctrlEnable [MENU3,false];
ctrlEnable [MENU4,false];
ctrlEnable [MENU5,false];
if (!MCC_capture_state) then { ctrlEnable [MCCSTOPCAPTURE,false];};

_mccdialog = findDisplay MCC_SANDBOX4_IDD;

_comboBox = _mccdialog displayCtrl MCCZONENUMBER; //fill combobox zone's numbers
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_zones_numbers;
	_comboBox lbSetCurSel MCC_zone_index;

_comboBox = _mccdialog displayCtrl MCC_ZONE_LOC;		//fill zone locations
	lbClear _comboBox;
	{
		_displayname = _x select 0;
		_comboBox lbAdd _displayname;
	} foreach MCC_ZoneLocation;
	_comboBox lbSetCurSel mcc_hc;	//MCC_ZoneLocation_index;	

_comboBox = _mccdialog displayCtrl FACTIONCOMBO;		//fill combobox CFG factions
	lbClear _comboBox;
	{
		_displayname = format ["%1(%2)",_x select 0,_x select 1];
		_comboBox lbAdd _displayname;
	} foreach U_FACTIONS;
	_comboBox lbSetCurSel MCC_faction_index;
	
_comboBox = _mccdialog displayCtrl MCCDELETEBRUSH;		//Delete Brush
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["All","All Units", "Man", "Car", "Tank", "Air", "ReammoBox","Markers"];
	_comboBox lbSetCurSel 0;
	
_comboBox = _mccdialog displayCtrl MCC_AIRDROPTYPE;		//Airdrop Type
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Vehicles", "Tracked", "Motorcycles", "Ships", "Ammo"];
	_comboBox lbSetCurSel 0;
	
_comboBox = _mccdialog displayCtrl MCC_airdropArray;		//Airdrop Current Airdrop
	lbClear _comboBox;
	{
		if (!isnil "_x") then
			{
				_displayname = getText(configFile >> "CfgVehicles" >> _x >> "displayname") ;
				_comboBox lbAdd _displayname;
			};
	} foreach MCC_airDropArray;
	_comboBox lbSetCurSel 0;

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
	
ctrlEnable [MAIN,true]; //Enable switching menus
ctrlEnable [MENU2,true];
ctrlEnable [MENU3,true];
ctrlEnable [MENU4,false];
ctrlEnable [MENU5,true];

