//Made by Shay_Gman (c) 09.10
#define MCC_SANDBOX_IDD 1000

#define FACTIONCOMBO 1001
#define SPAWNTYPE 1002
#define SPAWNBRANCH 1003
#define SPAWNCLASS 1004

private ["_group", "_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index","_task"];
disableSerialization;

_task =_this select 0;
_mccdialog = findDisplay MCC_SANDBOX_IDD;	

if ((_task ==0) && (MCC_faction_index != lbCurSel FACTIONCOMBO)) then					//Change Faction
	{
	mcc_sidename = (U_FACTIONS select (lbCurSel FACTIONCOMBO)) select 1;
	mcc_faction = (U_FACTIONS select (lbCurSel FACTIONCOMBO)) select 2;
	MCC_faction_index = lbCurSel FACTIONCOMBO;
	[] call mcc_fnc_faction_choice;
	};
	
if ((_task ==1)&& (MCC_type_index != lbCurSel SPAWNTYPE)) then																	//Change Type
	{
	MCC_type_index = lbCurSel SPAWNTYPE;
	if ((lbCurSel SPAWNTYPE) == 1) then {						//	Group
	_comboBox = _mccdialog displayCtrl SPAWNBRANCH;		
		lbClear _comboBox;
		{
			_displayname = _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["Infantry", "Motorized", "Mechanized", "Armor", "Air", "SpecOps","Support", "Paratroopers", "Garrison"];
		_comboBox lbSetCurSel 0;
	};
	if ((lbCurSel SPAWNTYPE) == 0) then {						//Singles
			_comboBox = _mccdialog displayCtrl SPAWNBRANCH;		//fill combobox CFG unit
			lbClear _comboBox;
			{
				_displayname =  _x;
				_index = _comboBox lbAdd _displayname;
			} foreach ["Infantry", "Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship", "D.O.C", "Ammo", "Fortifications", "Dead Bodies", "Furnitures", 
						"Market", "Misc", "Signs", "Warfare", "Wrecks", "Buildings", "Ruins","Garbage","Lamps","Container","Small Items","Structures","Helpers","Training"];
			_comboBox lbSetCurSel 0; //MCC_class_index;	
			};
	};

if (_task ==2) then 											//Change Branch Units
	{
	_type = lbCurSel SPAWNTYPE;
	MCC_beanch_index = lbCurSel SPAWNBRANCH;
	
	if (_type == 0) then {										//Object
		if (lbCurSel SPAWNBRANCH<=6) then 	//If not doc or object
			{
			switch (lbCurSel SPAWNBRANCH) do		//Which unit do we want
					{
					   case 0:	//Infantry
						{
							_groupArray = U_GEN_SOLDIER;
						};
						
						case 1:	//Car
						{
							_groupArray = U_GEN_CAR;
						};
						
						case 2:	//Tank
						{
							_groupArray = U_GEN_TANK;
						};
						
						case 3:	//Motorcycle
						{
							_groupArray = U_GEN_MOTORCYCLE;
						};
						
						case 4:	//Helicopter
						{
							_groupArray = U_GEN_HELICOPTER;
						};
						
						case 5:	//Aircraft
						{
							_groupArray = U_GEN_AIRPLANE;
						};
						
						case 6:	//Ship
						{
							_groupArray = U_GEN_SHIP;
						};
					};

			_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_index = _comboBox lbAdd _displayname;
						_comboBox lbsetpicture [_index, (_x select 3) select 1];
					} foreach _groupArray;
				_comboBox lbSetCurSel 0;
			} else	{
			switch (lbCurSel SPAWNBRANCH) do		//Which unit do we want
				{
					case 7:	//DOC
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 3];
								_comboBox lbAdd _displayname;
							} foreach GEN_DOC1;
						_comboBox lbSetCurSel 0;
					};
					
					case 8:	//Ammo
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;	
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_AMMO;
						_comboBox lbSetCurSel 0;

					};
					
					case 9:	//Fortifications
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;	
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_FORT;
						_comboBox lbSetCurSel 0;
					};
					
					case 10:	//Dead Bodies
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_DEAD_BODIES;
						_comboBox lbSetCurSel 0;
					};
					
					case 11:	//Furniture
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_FURNITURE;
						_comboBox lbSetCurSel 0;
					};
					
					case 12:	//Market
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_MARKET;
						_comboBox lbSetCurSel 0;
					};
					
					case 13:	//Misc
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_MISC;
						_comboBox lbSetCurSel 0;
					};
					
					case 14:	//Sighns
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_SIGHNS;
						_comboBox lbSetCurSel 0;
					};
					
					case 15:	//Warefare
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_WARFARE;
						_comboBox lbSetCurSel 0;
					};
					
					case 16:	//Wrecks
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_WRECKS;
						_comboBox lbSetCurSel 0;
					};
					
					case 17:	//Houses
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_HOUSES;
						_comboBox lbSetCurSel 0;
					};
					
					case 18:	//Ruins
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_RUINS;
						_comboBox lbSetCurSel 0;
					};
					
					case 19:	//Garbage
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_GARBAGE;
						_comboBox lbSetCurSel 0;
					};
					
					case 20:	//Lamps
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_LAMPS;
						_comboBox lbSetCurSel 0;
					};
					
					case 21:	//Containers
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_CONTAINER;
						_comboBox lbSetCurSel 0;
					};
					
					case 22:	//Small Items
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_SMALL_ITEMS;
						_comboBox lbSetCurSel 0;
					};
					
					case 23:	//Structures
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_STRUCTERS;
						_comboBox lbSetCurSel 0;
					};
					
					case 24:	//Helpers
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_HELPERS;
						_comboBox lbSetCurSel 0;
					};
					
					case 25:	//Training
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",_x select 1];
								_comboBox lbAdd _displayname;
							} foreach U_TRAINING;
						_comboBox lbSetCurSel 0;
					};
				};
			};
		} else	{
			switch (lbCurSel SPAWNBRANCH) do		
						{
						   case 0:	//Infantry
							{
								_groupArray = GEN_INFANTRY;
							};
							
							case 1:	//Motorized
							{
								_groupArray = GEN_MOTORIZED;
							};
							
							case 2:	//Mechnized
							{
								_groupArray = GEN_MECHANIZED;
							};
							
							case 3:	//Armor
							{
								_groupArray = GEN_ARMOR;
							};
							
							case 4:	//Air
							{
								_groupArray = GEN_AIR;
							};
							
							case 5:	//SpecOps
							{
								_groupArray = GEN_SPECOPS;
							};
							
							case 6:	//Support
							{
								_groupArray = GEN_SUPPORT;
							};
						};
				if (lbCurSel SPAWNBRANCH ==7) exitWith 				//Paratroops
					{
					_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
					lbClear _comboBox;
						{
							_displayname =  _x;
							_comboBox lbAdd _displayname;
						} foreach ["Small", "Large"];
					_comboBox lbSetCurSel 0;
					}; 
					
				if (lbCurSel SPAWNBRANCH ==8) exitWith 				//Garrison
					{
					_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
					lbClear _comboBox;
						{
							_displayname =  _x;
							_comboBox lbAdd _displayname;
						} foreach ["Light", "Light With Vehicles","Heavy", "Heavy With Vehicles"];
					_comboBox lbSetCurSel 0;
					}; 
				
				_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 3];
						_comboBox lbAdd _displayname;
					} foreach _groupArray;
				_comboBox lbSetCurSel 0;
				
			};
	};
	

			
		
