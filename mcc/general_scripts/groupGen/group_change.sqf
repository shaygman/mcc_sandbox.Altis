//Made by Shay_Gman (c) 09.10
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000

#define MCC_FACTION 8008
#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GGUNIT_TYPE 3012
#define MCC_GGUNIT_BEHAVIOR 3030
#define MCC_GroupGenCurrentGroup_IDD 9003
	
#define MCC_GroupGenInfoText_IDC 9013
#define MCC_GroupGenWPBckgr_IDC 9014
#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018
#define MCC_GroupGenWPAdd_IDC 9019
#define MCC_GroupGenWPReplace_IDC 9020
#define MCC_GroupGenWPClear_IDC 9021

#define MCC_GGListBoxIDC 3013
#define MCC_GGADDIDC 3014
#define MCC_GGCLEARIDC 3015
#define MCC_GGUNIT_EMPTY 3016
#define MCC_GGUNIT_EMPTYTITLE 3017
#define mcc_groupGen_CurrentgroupNameTittle_IDC 3018
#define mcc_groupGen_CurrentgroupNameText_IDC 3019
#define MCC_GGSAVE_GROUPIDC 3020
#define MCC_GGVREATE_IDC 3021

private ["_action", "_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index","_side","_group","_unit","_show"];
disableSerialization;

_action =_this select 0;	//What are we doing
_mccdialog = findDisplay groupGen_IDD;	

_show = if ((lbCurSel MCC_GGUNIT_TYPE)==0) then {true} else {false}; 

//Hide buttons
for "_x" from 3013 to 3015 step 1 do 
{
	ctrlShow [_x,_show];
};

for "_x" from 3018 to 3020 step 1 do 
{
	ctrlShow [_x,_show];
};
ctrlShow [MCC_GroupGenCurrentGroup_IDD,_show];

if (_show) then 
{
	(_mccdialog displayCtrl MCC_GGSAVE_GROUPIDC) ctrlSetTooltip "Save the group as a custom group";
	ctrlSetText [MCC_GGSAVE_GROUPIDC, "Save as Custom"];
}
else
{
	//Hide Create button for reinforcment/fortify
	if ((((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)) =="Reinforcement") || (((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)) =="Garrison")) then 
	{
		ctrlShow [MCC_GGVREATE_IDC,false];
	}
	else 
	{
		ctrlShow [MCC_GGVREATE_IDC,true];
	};
};

 

//Changing the group type
if (_action == 0) exitWIth 
{		
	//Groups
	if ((lbCurSel MCC_GGUNIT_TYPE) == 1) then 
	{			
		MCC_groupArray = [mcc_sidename,mcc_faction, ((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)),"LAND"] call mcc_make_array_grps;
		if (((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)) =="Reinforcement") exitWith 				//Paratroops
		{
			_comboBox = _mccdialog displayCtrl UNIT_CLASS;		
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
			
		if (((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)) =="Garrison") exitWith 				//Garrison
		{
			_comboBox = _mccdialog displayCtrl UNIT_CLASS;		
			lbClear _comboBox;
			{
				_displayname =  _x;
				_comboBox lbAdd _displayname;
			} foreach ["Light", "Light With Vehicles","Heavy", "Heavy With Vehicles"];
			_comboBox lbSetCurSel 0;
		}; 

		//Custom
		if (((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)) =="Custom") exitWith 				//Custom
		{
			//Show the control
			ctrlShow [MCC_GGSAVE_GROUPIDC, true];
			ctrlSetText [MCC_GGSAVE_GROUPIDC, "Delete Group"]; 
			(_mccdialog displayCtrl MCC_GGSAVE_GROUPIDC) ctrlSetTooltip "Delete the group from the custom groups"; 
			
			_comboBox = _mccdialog displayCtrl UNIT_CLASS;
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
		_comboBox = _mccdialog displayCtrl UNIT_CLASS;		
		lbClear _comboBox;
		{
			_displayname = format ["%1 (%2 Units)",_x select 3,_x select 4];
			_comboBox lbAdd _displayname;
		} foreach MCC_groupArray;
		_comboBox lbSetCurSel 0;
	}
	else
	{
		//Units
		_type = lbCurSel UNIT_TYPE;
		MCC_class_index = lbCurSel UNIT_TYPE;
		
		switch (_type) do		//Which unit do we want
			{
			   case 0:	//Infantry
				{
					_groupArray = U_GEN_SOLDIER;
					ctrlShow [MCC_GGUNIT_EMPTY,false];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,false];
				};
				
				case 1:	//Car
				{
					_groupArray = U_GEN_CAR;
					ctrlShow [MCC_GGUNIT_EMPTY,true];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,true];
				};
				
				case 2:	//Tank
				{
					_groupArray = U_GEN_TANK;
					ctrlShow [MCC_GGUNIT_EMPTY,true];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,true];
				};
				
				case 3:	//Motorcycle
				{
					_groupArray = U_GEN_MOTORCYCLE;
					ctrlShow [MCC_GGUNIT_EMPTY,true];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,true];
				};
				
				case 4:	//Helicopter
				{
					_groupArray = U_GEN_HELICOPTER;
					ctrlShow [MCC_GGUNIT_EMPTY,true];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,true];
				};
				
				case 5:	//Aircraft
				{
					_groupArray = U_GEN_AIRPLANE;
					ctrlShow [MCC_GGUNIT_EMPTY,true];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,true];
				};
				
				case 6:	//Ship
				{
					_groupArray = U_GEN_SHIP;
					ctrlShow [MCC_GGUNIT_EMPTY,true];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,true];
				};
				
				case 7:	//AMMO
				{
					_groupArray = U_AMMO;
					MCC_isEmpty = true; 
					ctrlShow [MCC_GGADDIDC,false];
					ctrlShow [MCC_GGUNIT_EMPTY,false];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,false];
				};
		};

		_comboBox = _mccdialog displayCtrl UNIT_CLASS;		
		lbClear _comboBox;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			if !(_type in [0,7]) then {_comboBox lbsetpicture [_index, (_x select 3) select 1]};
		} foreach _groupArray;
		_comboBox lbSetCurSel 0;
		};
};

//Building the array	
if (_action == 1) then 
{			
	_type = lbCurSel UNIT_TYPE;
	
	if (_type in [7,8,-1]) exitWith {hint "Cannot add static object to a group"};
	
	if ((lbCurSel UNIT_CLASS) == -1) exitWith {};
	
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
				
				case 7:	//AMMO
				{
					_groupArray = U_AMMO;
					ctrlShow [MCC_GGUNIT_EMPTY,false];
					ctrlShow [MCC_GGUNIT_EMPTYTITLE,false];
				};
		};
	_dummy = (_groupArray select (lbCurSel UNIT_CLASS)) select 1;
	
	//Reset MCC_groupGenCurrenGroupArray if it is not an array
	if (TypeName MCC_groupGenCurrenGroupArray != "ARRAY") then {MCC_groupGenCurrenGroupArray = []};
	
	MCC_groupGenCurrenGroupArray set[count MCC_groupGenCurrenGroupArray , _dummy];
};

//Clear the array	
if (_action == 2) then 
{			
	MCC_groupGenCurrenGroupArray = [];
};

//Units/Groups
if ((_action ==3)&& (MCC_type_index != lbCurSel MCC_GGUNIT_TYPE)) exitWIth																	//Change Type
{
	MCC_type_index = lbCurSel MCC_GGUNIT_TYPE;
	
	//Group
	if ((lbCurSel MCC_GGUNIT_TYPE) == 1) then 
	{						
	_comboBox = _mccdialog displayCtrl UNIT_TYPE;		
		lbClear _comboBox;
		{
			_displayname = _x select 1;
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_groupTypes;
		_comboBox lbSetCurSel 0;
	};
	
	//Singles
	if ((lbCurSel MCC_GGUNIT_TYPE) == 0) then 
	{					
		_comboBox = _mccdialog displayCtrl UNIT_TYPE;		//fill combobox CFG unit
		lbClear _comboBox;
		{
			_displayname =  _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["Infantry", "Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship", "Ammo"];
		_comboBox lbSetCurSel 0; //MCC_class_index;	
	};
};	

//Save/Delete  custom 
if (_action ==4) exitWIth
{
	private ["_groupArray","_groupToSave","_name","_nul"];
	
	//Delete
	if (ctrlText MCC_GGSAVE_GROUPIDC == "Delete Group") then
	{
		_comboBox = _mccdialog displayCtrl UNIT_CLASS;	
		if ((call compile (_comboBox lbData (lbCurSel UNIT_CLASS))) != -1) then
		{
			MCC_customGroupsSave set [(call compile (_comboBox lbData (lbCurSel UNIT_CLASS))),-1];
			MCC_customGroupsSave = MCC_customGroupsSave - [-1];
			profileNamespace setVariable ["MCC_customGroupsSave", MCC_customGroupsSave];
			saveProfileNamespace;
		};
		
		_nul = [0] execVM format ["%1mcc\general_scripts\groupGen\group_change.sqf",MCC_path];
	}
	else	//Save
	{
		_name = ctrlText mcc_groupGen_CurrentgroupNameText_IDC; 
		if (_name !="") then
		{
			_groupArray = []; 
			{
				_groupArray set [count _groupArray, _x]; 
			} foreach MCC_groupGenCurrenGroupArray;
			
			if (count _groupArray > 0) then
			{
				_groupToSave = [mcc_faction, "LAND", _groupArray , _name, count _groupArray];
				MCC_customGroupsSave set [count MCC_customGroupsSave, _groupToSave];
				profileNamespace setVariable ["MCC_customGroupsSave", MCC_customGroupsSave];
				
				systemchat "Custom group saved successfully"; 
			}; 
		}
		else 
		{
			systemchat "Give a name to your custom group first"; 
		};
	};
};
	
_comboBox = _mccdialog displayCtrl MCC_GroupGenCurrentGroup_IDD;		//Update units
lbClear _comboBox;
{
	if (!isNil "_x") then
	{
		_displayname = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
		_index = _comboBox lbAdd _displayname;
	};
} foreach MCC_groupGenCurrenGroupArray;
_comboBox lbSetCurSel 0;
	

	
					