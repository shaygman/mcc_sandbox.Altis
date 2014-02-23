//Made by Shay_Gman (c) 03.13
#define MCC_TRAPS_TYPE 2007
#define MCC_TRAPS_OBJECT 2008
#define MCC_TRAPS_EXPLOSIN_SIZE 2009
#define MCC_TRAPS_EXPLOSIN_TYPE 2010
#define MCC_TRAPS_TARGET_FACTION 2011
#define MCC_TRAPS_JAMMABLE 2012
#define MCC_TRAPS_DISARM 2013
#define MCC_TRAPS_TRIGGER 2014
#define MCC_TRAPS_PROXIMITY 2015
#define MCC_TRAPS_AMBUSH 2016

private ["_type", "_comboBox", "_mccdialog", "_trapsArray"];


disableSerialization;
_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");	

_type = lbCurSel MCC_TRAPS_TYPE;

switch (_type) do		//Which trap do we want
		{
		   case 0:	
			{
				_trapsArray = MCC_ied_small;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,true];
				ctrlShow [MCC_TRAPS_JAMMABLE,true];
				ctrlShow [MCC_TRAPS_TRIGGER,true];
				ctrlShow [MCC_TRAPS_PROXIMITY,true];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 1:	
			{
				_trapsArray = MCC_ied_medium;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,true];
				ctrlShow [MCC_TRAPS_JAMMABLE,true];
				ctrlShow [MCC_TRAPS_TRIGGER,true];
				ctrlShow [MCC_TRAPS_PROXIMITY,true];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 2:	
			{
				_trapsArray = MCC_ied_wrecks;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,true];
				ctrlShow [MCC_TRAPS_JAMMABLE,true];
				ctrlShow [MCC_TRAPS_TRIGGER,true];
				ctrlShow [MCC_TRAPS_PROXIMITY,true];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 3:	
			{
				_trapsArray = MCC_ied_hidden; 
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,true];
				ctrlShow [MCC_TRAPS_JAMMABLE,true];
				ctrlShow [MCC_TRAPS_TRIGGER,true];
				ctrlShow [MCC_TRAPS_PROXIMITY,true];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 4:	
			{
				_trapsArray = MCC_ied_mine; 
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,false];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,false];
				ctrlShow [MCC_TRAPS_DISARM,false];
				ctrlShow [MCC_TRAPS_JAMMABLE,false];
				ctrlShow [MCC_TRAPS_TRIGGER,false];
				ctrlShow [MCC_TRAPS_PROXIMITY,false];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,false];
			};
			
			case 5:	
			{
				_trapsArray = U_AMMO;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,true];
				ctrlShow [MCC_TRAPS_JAMMABLE,true];
				ctrlShow [MCC_TRAPS_TRIGGER,true];
				ctrlShow [MCC_TRAPS_PROXIMITY,true];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 6:	
			{
				_trapsArray = U_GEN_CAR;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,true];
				ctrlShow [MCC_TRAPS_JAMMABLE,true];
				ctrlShow [MCC_TRAPS_TRIGGER,true];
				ctrlShow [MCC_TRAPS_PROXIMITY,true];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 7:	
			{
				_trapsArray = U_GEN_SOLDIER;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,false];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,false];
				ctrlShow [MCC_TRAPS_DISARM,false];
				ctrlShow [MCC_TRAPS_JAMMABLE,false];
				ctrlShow [MCC_TRAPS_TRIGGER,false];
				ctrlShow [MCC_TRAPS_PROXIMITY,false];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
			
			case 8:	
			{
				_trapsArray = U_GEN_SOLDIER;
				ctrlShow [MCC_TRAPS_EXPLOSIN_SIZE,true];
				ctrlShow [MCC_TRAPS_EXPLOSIN_TYPE,true];
				ctrlShow [MCC_TRAPS_DISARM,false];
				ctrlShow [MCC_TRAPS_JAMMABLE,false];
				ctrlShow [MCC_TRAPS_TRIGGER,false];
				ctrlShow [MCC_TRAPS_PROXIMITY,false];
				ctrlShow [MCC_TRAPS_TARGET_FACTION,true];
			};
		};
		
_comboBox = _mccdialog displayCtrl MCC_TRAPS_OBJECT;
lbClear _comboBox;		

if (_type<5) then	//if object
	{
		{
			_displayname = format ["%1",(_x select 0)];
			_index = _comboBox lbAdd _displayname;
		} foreach _trapsArray;
	} else	//If unit or vehicle
	{
		{
			_displayname = format ["%1",(_x select 3)select 0];	
			_index = _comboBox lbAdd _displayname;
			if !(_type in [7,8]) then {_comboBox lbsetpicture [_index, (_x select 3) select 1];};	//No pic for ammoboxes
		} foreach _trapsArray;
	};
	
_comboBox lbSetCurSel 0;
	