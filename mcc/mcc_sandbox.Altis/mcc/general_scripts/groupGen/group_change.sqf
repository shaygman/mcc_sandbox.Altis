//Made by Shay_Gman (c) 09.10
#define groupGen_IDD 2994

#define UNIT_TYPE 3010
#define UNIT_CLASS 3011

#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GroupGenWPType_IDD 9004
#define MCC_GroupGenWPConbatMode_IDD 9005
#define MCC_GroupGenWPFormation_IDD 9006
#define MCC_GroupGenWPSpeed_IDD 9007
#define MCC_GroupGenWPBehavior_IDD 9008
#define MCC_GroupGenWPStatement_IDD 9009
#define MCC_GroupGenGroups_IDD 9010

private ["_action", "_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index","_unitType","_side","_group","_unit"];
disableSerialization;

_action =_this select 0;	//What are we doing

_mccdialog = findDisplay groupGen_IDD;	

if (_action == 0) then {		//Changing the group type
	_type = lbCurSel UNIT_TYPE;
	MCC_class_index = lbCurSel UNIT_TYPE;
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

	_comboBox = _mccdialog displayCtrl UNIT_CLASS;		
		lbClear _comboBox;
			{
				_displayname = format ["%1",(_x select 3) select 0];
				_index = _comboBox lbAdd _displayname;
				if (_type != 0) then {_comboBox lbsetpicture [_index, (_x select 3) select 1]};
			} foreach _groupArray;
		_comboBox lbSetCurSel 0;
	};
	
if (_action == 1) then {			//Building the array
	_type = lbCurSel UNIT_TYPE;
	switch (_type) do		//Which unit do we want
		{
		   case 0:	//Infantry
				{
					_groupArray = U_GEN_SOLDIER;
					_unitType = 0;	//Man
				};
				
				case 1:	//Car
				{
					_groupArray = U_GEN_CAR;
					_unitType = 1;	//Vehicle
				};
				
				case 2:	//Tank
				{
					_groupArray = U_GEN_TANK;
					_unitType = 1;	//Vehicle
				};
				
				case 3:	//Motorcycle
				{
					_groupArray = U_GEN_MOTORCYCLE;
					_unitType = 1;	//Vehicle
				};
				
				case 4:	//Helicopter
				{
					_groupArray = U_GEN_HELICOPTER;
					_unitType = 2;	//Vehicle
				};
				
				case 5:	//Aircraft
				{
					_groupArray = U_GEN_AIRPLANE;
					_unitType = 2;	//Vehicle
				};
				
				case 6:	//Ship
				{
					_groupArray = U_GEN_SHIP;
					_unitType = 1;	//Vehicle
				};
		};
	_dummy = (_groupArray select (lbCurSel UNIT_CLASS)) select 1;
	MCC_groupGenCurrenGroupArray set[count MCC_groupGenCurrenGroupArray , [_dummy,_unitType]];
	};
	
if (_action == 2) then {			//Clear the array
	MCC_groupGenCurrenGroupArray = [];
	};
	

_comboBox = _mccdialog displayCtrl MCC_GroupGenCurrentGroup_IDD;		//Update units
lbClear _comboBox;
	{
		_displayname = getText (configFile >> "cfgVehicles" >> (_x select 0) >> "displayName");
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_groupGenCurrenGroupArray;
	_comboBox lbSetCurSel 0;
	

	
					