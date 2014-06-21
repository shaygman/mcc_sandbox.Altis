//Made by Shay_Gman (c) 02.11
#define MCC3D_IDD 8000

#define MCC_UNIT_TYPE 8001
#define MCC_UNIT_CLASS 8002
#define MCC_PRESETS 8005

private ["_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index", "_spawn","_presets"];
disableSerialization;

_mccdialog = findDisplay MCC3D_IDD;	
_spawn = _this select 0; 
_type = lbCurSel MCC_UNIT_TYPE;
MCC_class_index = lbCurSel MCC_UNIT_TYPE;

//Which perset do we use?
_presets = [];
if (_type in [0]) then {_presets = mccPresetsUnits};
if (_type in [1,2,3,4,5,6]) then {_presets = mccPresetsVehicle}; 
if (_type > 7) then {_presets = mccPresetsObjects}; 

_comboBox = _mccdialog displayCtrl MCC_PRESETS;		//fill combobox Presets
lbClear _comboBox;
{
	_displayname = _x select 0;
	_comboBox lbAdd _displayname;
} foreach _presets;
_comboBox lbSetCurSel 0;

if (_type<=6) then 	//If not doc or object
	{
	switch (_type) do		//Which unit do we want
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

	_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
		lbClear _comboBox;
			{
				_displayname = format ["%1",(_x select 3) select 0];
				_index = _comboBox lbAdd _displayname;
				if (_type != 0) then {_comboBox lbsetpicture [_index, (_x select 3) select 1]};
			} foreach _groupArray;
		_comboBox lbSetCurSel 0;
	} else	{
	switch (_type) do		//Which unit do we want
		{
			case 7:	//DOC
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 3];
						_comboBox lbAdd _displayname;
					} foreach GEN_DOC1;
				_comboBox lbSetCurSel 0;
			};
			
			case 8:	//Ammo
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;	
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_AMMO;
				_comboBox lbSetCurSel 0;

			};
			
			case 9:	//Fortifications
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;	
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_FORT;
				_comboBox lbSetCurSel 0;
			};
			
			case 10:	//Dead Bodies
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_DEAD_BODIES;
				_comboBox lbSetCurSel 0;
			};
			
			case 11:	//Furniture
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_FURNITURE;
				_comboBox lbSetCurSel 0;
			};
			
			case 12:	//Market
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_MARKET;
				_comboBox lbSetCurSel 0;
			};
			
			case 13:	//Construction
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_MISC;
				_comboBox lbSetCurSel 0;
			};
			
			case 14:	//Sighns
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_SIGHNS;
				_comboBox lbSetCurSel 0;
			};
			
			case 15:	//Flags
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_FLAGS;
				_comboBox lbSetCurSel 0;
			};
			
			case 16:	//Warefare
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_MILITARY;
				_comboBox lbSetCurSel 0;
			};
			
			case 17:	//Small Items
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_SMALL_ITEMS;
				_comboBox lbSetCurSel 0;
			};
			
			case 18:	//Wrecks
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_WRECKS;
				_comboBox lbSetCurSel 0;
			};
			
			case 19:	//Submerged
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname =  format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_SUBMERGED;
				_comboBox lbSetCurSel 0;
			};
			
			case 20:	//Tents
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_TENTS;
				_comboBox lbSetCurSel 0;
			};
			
			case 21:	//Garbage
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];;
						_comboBox lbAdd _displayname;
					} foreach U_GARBAGE;
				_comboBox lbSetCurSel 0;
			};
			
			case 22:	//Lamps
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_LAMPS;
				_comboBox lbSetCurSel 0;
			};
			
			case 23:	//Containers
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_CONTAINER;
				_comboBox lbSetCurSel 0;
			};
			
			case 24:	//Helpers
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_HELPERS;
				_comboBox lbSetCurSel 0;
			};
			
			case 25:	//Training
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_TRAINING;
				_comboBox lbSetCurSel 0;
			};
			
			case 26:	//Mines
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_MINES;
				_comboBox lbSetCurSel 0;
			};
			
			case 27:	//Animals
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_ANIMALS;
						_comboBox lbSetCurSel 0;
					};
					
			case 28:	//S-Airport
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_AIRPORT;
						_comboBox lbSetCurSel 0;
					};
					
			case 29:	//S-Military
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_MILITARY;
						_comboBox lbSetCurSel 0;
					};
					
			case 30:	//S-Cultural
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_CULTURAL;
						_comboBox lbSetCurSel 0;
					};
					
			case 31:	//S-Walls
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_WALLS;
						_comboBox lbSetCurSel 0;
					};
					
			case 32:	//S-Infrasructures
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_INFRAS;
						_comboBox lbSetCurSel 0;
					};
					
			case 33:	//S-commercial
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_COMMERSIAL;
						_comboBox lbSetCurSel 0;
					};
					
			case 34:	//S-industrial
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_INDUSTRIAL;
						_comboBox lbSetCurSel 0;
					};
					
			case 35:	//S-Town
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_TOWN;
						_comboBox lbSetCurSel 0;
					};
					
			case 36:	//S-Village
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_VILLAGE;
						_comboBox lbSetCurSel 0;
					};
					
			case 37:	//S-Fences
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach S_FENCES;
						_comboBox lbSetCurSel 0;
					};
					
			case 38:	//S-General
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach U_STRUCTERS;
						_comboBox lbSetCurSel 0;
					};
					
			case 39:	//O_BACKPACKS
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_BACKPACKS;
						_comboBox lbSetCurSel 0;
					};
					
			case 40:	//O_INTEL
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_INTEL;
						_comboBox lbSetCurSel 0;
					};
					
			case 41:	//O_ITEMS
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_ITEMS;
						_comboBox lbSetCurSel 0;
					};
					
			case 42:	//O_HEADGEAR
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_HEADGEAR;
						_comboBox lbSetCurSel 0;
					};
					
			case 43:	//O_UNIFORMS
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_UNIFORMS;
						_comboBox lbSetCurSel 0;
					};
					
			case 44:	//O_VESTS
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_VESTS;
						_comboBox lbSetCurSel 0;
					};
					
			case 45:	//O_WEAPONSACCES
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_WEAPONSACCES;
						_comboBox lbSetCurSel 0;
					};
					
			case 46:	//O_WEAPONSHANDGUNS
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_WEAPONSHANDGUNS;
						_comboBox lbSetCurSel 0;
					};
			
			case 47:	//O_WEAPONSPRIMARY
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_WEAPONSPRIMARY;
						_comboBox lbSetCurSel 0;
					};
					
			case 48:	//O_WEAPONSSECONDARY
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_WEAPONSSECONDARY;
						_comboBox lbSetCurSel 0;
					};
					
			case 49:	//O_RESPWN
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_RESPWN;
						_comboBox lbSetCurSel 0;
					};
			
			case 50:	//O_SOUNDS
					{
						_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
						lbClear _comboBox;
							{
								_displayname = format ["%1",(_x select 3) select 0];
								_comboBox lbAdd _displayname;
							} foreach O_SOUNDS;
						_comboBox lbSetCurSel 0;
					};
					
		};
	};

	
					