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
			_displayname = _x select 1;
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_groupTypes;
		_comboBox lbSetCurSel 0;
	};
	if ((lbCurSel SPAWNTYPE) == 0) then {						//Singles
			_comboBox = _mccdialog displayCtrl SPAWNBRANCH;		//fill combobox CFG unit
			lbClear _comboBox;
			{
				_displayname =  _x;
				_index = _comboBox lbAdd _displayname;
			} foreach ["Infantry", "Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship", "D.O.C", "Ammo", "Fortifications", "Dead Bodies", "Furniture", 
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
						if (lbCurSel SPAWNBRANCH != 0) then {_comboBox lbsetpicture [_index, (_x select 3) select 1]};
					} foreach _groupArray;
				_comboBox lbSetCurSel 0;
			} else	{
			switch (lbCurSel SPAWNBRANCH) do		//Which unit do we want
				{
					case 7:	//DOC
					{_comboBox = _mccdialog displayCtrl SPAWNCLASS;	
							
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
					
					case 13:	//Construction
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
					
					case 15:	//Flags
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_FLAGS;
						_comboBox lbSetCurSel 0;
					};
					
					case 16:	//Warefare
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_MILITARY;
						_comboBox lbSetCurSel 0;
					};
					
					case 17:	//Small Items
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_SMALL_ITEMS;
						_comboBox lbSetCurSel 0;
					};
					
					case 18:	//Wrecks
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_WRECKS;
						_comboBox lbSetCurSel 0;
					};
					
					case 19:	//Submerged
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname =  format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_SUBMERGED;
						_comboBox lbSetCurSel 0;
					};
					
					case 20:	//Tents
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_TENTS;
						_comboBox lbSetCurSel 0;
					};
					
					case 21:	//Garbage
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_GARBAGE;
						_comboBox lbSetCurSel 0;
					};
					
					case 22:	//Lamps
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_LAMPS;
						_comboBox lbSetCurSel 0;
					};
					
					case 23:	//Containers
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_CONTAINER;
						_comboBox lbSetCurSel 0;
					};
					
					case 24:	//Structures
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_STRUCTERS;
						_comboBox lbSetCurSel 0;
					};
					
					case 25:	//Helpers
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_HELPERS;
						_comboBox lbSetCurSel 0;
					};
					
					case 26:	//Training
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_TRAINING;
						_comboBox lbSetCurSel 0;
					};
					
					case 27:	//Animals
					{
						_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_ANIMALS;
						_comboBox lbSetCurSel 0;
					};
				};
			};
		} else	{
			MCC_groupArray = [mcc_sidename,mcc_faction, ((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)),"LAND"] call mcc_make_array_grps;
				if (((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)) =="Reinforcement") exitWith 				//Paratroops
					{
					_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
					lbClear _comboBox;
						{
							_displayname =  _x;
							_comboBox lbAdd _displayname;
						} foreach [
									"paradrop: small - Spec-Ops ", "paradrop: medium - QRF", "paradrop: large - Airborne", 
									"drop-off: small - Spec-Ops ", "drop-off: medium - QRF", "drop-off: large - Airborne",
									"fast-rope: small - Spec-Ops ", "fast-rope: medium - QRF", "fast-rope: large - Airborne",
									"Motorized: Small","Motorized: Medium","Motorized: Large"
								];
					_comboBox lbSetCurSel 0;
					}; 
					
				if (((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)) =="Garrison") exitWith 				//Garrison
					{
					_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
					lbClear _comboBox;
						{
							_displayname =  _x;
							_comboBox lbAdd _displayname;
						} foreach ["Light", "Light With Vehicles","Heavy", "Heavy With Vehicles"];
					_comboBox lbSetCurSel 0;
					}; 
				
				//Custom
				if (((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)) =="Custom") exitWith 				//Custom
					{
					_comboBox = _mccdialog displayCtrl SPAWNCLASS;
					lbClear _comboBox;
					private "_counter";
					_counter = 0;
						{
							if (MCC_faction == (_x select 0)) then
							{
								_displayname =  format ["%1 (%2 Units)",_x select 3,_x select 4]; 
								_comboBox lbAdd _displayname;
								_comboBox lbSetData [_counter, str _foreachIndex];
								_counter = _counter + 1;
							};
						} foreach MCC_customGroupsSave;
					_comboBox lbSetCurSel 0;
					};
					
				//Default	
				_comboBox = _mccdialog displayCtrl SPAWNCLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1 (%2 Units)",_x select 3,_x select 4];
						_comboBox lbAdd _displayname;
					} foreach MCC_groupArray;
				_comboBox lbSetCurSel 0;
				
			};
	};
	

			
		
