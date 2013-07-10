//Made by Shay_Gman (c) 02.11
#define MCC3D_IDD 8000

#define MCC_UNIT_TYPE 8001
#define MCC_UNIT_CLASS 8002

private ["_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index", "_spawn"];
disableSerialization;

_mccdialog = findDisplay MCC3D_IDD;	
_spawn = _this select 0; 
_type = lbCurSel MCC_UNIT_TYPE;
MCC_class_index = lbCurSel MCC_UNIT_TYPE;

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
				_comboBox lbsetpicture [_index, (_x select 3) select 1];
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
			
			case 13:	//Misc
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
			
			case 15:	//Warefare
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_WARFARE;
				_comboBox lbSetCurSel 0;
			};
			
			case 16:	//Wrecks
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",(_x select 3) select 0];
						_comboBox lbAdd _displayname;
					} foreach U_WRECKS;
				_comboBox lbSetCurSel 0;
			};
			
			case 17:	//Houses
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_HOUSES;
				_comboBox lbSetCurSel 0;
			};
			
			case 18:	//Ruins
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_RUINS;
				_comboBox lbSetCurSel 0;
			};
			
			case 19:	//Garbage
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_GARBAGE;
				_comboBox lbSetCurSel 0;
			};
			
			case 20:	//Lamps
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_LAMPS;
				_comboBox lbSetCurSel 0;
			};
			
			case 21:	//Containers
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_CONTAINER;
				_comboBox lbSetCurSel 0;
			};
			
			case 22:	//Small Items
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_SMALL_ITEMS;
				_comboBox lbSetCurSel 0;
			};
			
			case 23:	//Structures
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_STRUCTERS;
				_comboBox lbSetCurSel 0;
			};
			
			case 24:	//Helpers
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_HELPERS;
				_comboBox lbSetCurSel 0;
			};
			
			case 25:	//Training
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_TRAINING;
				_comboBox lbSetCurSel 0;
			};
			
			case 26:	//Mines
			{
				_comboBox = _mccdialog displayCtrl MCC_UNIT_CLASS;		
				lbClear _comboBox;
					{
						_displayname = format ["%1",_x select 1];
						_comboBox lbAdd _displayname;
					} foreach U_MINES;
				_comboBox lbSetCurSel 0;
			};
		};
	};

	
					