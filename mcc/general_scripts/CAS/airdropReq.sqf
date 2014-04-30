//Made by Shay_Gman (c) 10.13
#define MCC_AIRDROPTYPECONTROL 1031
#define MCC_AIRDROPCLASSCONTROL 1032
#define MCC_AIRDROPARRAYCONTROL 1033

private ["_action", "_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_dummy","_index"];
disableSerialization;

_action =_this select 0;
_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");	

if (_action==0) then 		//Refresh list
	{
	_type = lbCurSel MCC_AIRDROPTYPECONTROL;
	if (_type == -1) exitWith {}; 
	switch (_type) do		//Which unit do we want
		{
		   case 0:	//Car
			{
				_groupArray = U_GEN_CAR;
			};
			
			case 1:	//Track
			{
				_groupArray = U_GEN_TANK;
			};
			
			case 2:	//Motorcycle
			{
				_groupArray = U_GEN_MOTORCYCLE;
			};
			
			case 3:	//Ship 
			{
				_groupArray = U_GEN_SHIP;
			};
			
			case 4:	//Ammo
			{
				_groupArray = U_AMMO;
			};
		};
		
	_comboBox = _mccdialog displayCtrl MCC_AIRDROPCLASSCONTROL;		
	lbClear _comboBox;
	if (_type<4) then 
		{
			{
				_displayname = format ["%1",(_x select 3) select 0];
				_index = _comboBox lbAdd _displayname;
				_comboBox lbsetpicture [_index, (_x select 3) select 1];
			} foreach _groupArray;
		} else
		{
			{
				_displayname = format ["%1",(_x select 3) select 0];
				_comboBox lbAdd _displayname;
			} foreach _groupArray;
		};
	_comboBox lbSetCurSel 0;
	};
	
if (_action==1) then 		//Add airdrop to list
	{	
	_type = lbCurSel MCC_AIRDROPTYPECONTROL;
	if (_type == -1) exitWith {}; 
	switch (_type) do		//Which unit do we want
		{
		   case 0:	//Car
			{
				_groupArray = U_GEN_CAR;
			};
			
			case 1:	//Track
			{
				_groupArray = U_GEN_TANK;
			};
			
			case 2:	//Motorcycle
			{
				_groupArray = U_GEN_MOTORCYCLE;
			};
			
			case 3:	//Ship 
			{
				_groupArray = U_GEN_SHIP;
			};
			
			case 4:	//Ammo
			{
				_groupArray = U_AMMO;
			};
		};
	_index = lbCurSel MCC_AIRDROPCLASSCONTROL;
	if (_index == -1) exitWith {}; 
	
	_dummy = (_groupArray select _index) select 1;
	MCC_airDropArray set[count MCC_airDropArray , _dummy];
	
	_comboBox = _mccdialog displayCtrl MCC_AIRDROPARRAYCONTROL;		//added objects
	lbClear _comboBox;
		{
			_displayname = getText(configFile >> "CfgVehicles" >> _x >> "displayname") ;
			_comboBox lbAdd _displayname;
		} foreach MCC_airDropArray;
		_comboBox lbSetCurSel 0;
	};
	
if (_action==2) then 				//Clear Airdrop
	{	
	MCC_airDropArray = [];
	_comboBox = _mccdialog displayCtrl MCC_AIRDROPARRAYCONTROL;		//added objects
	lbClear _comboBox;
	};
