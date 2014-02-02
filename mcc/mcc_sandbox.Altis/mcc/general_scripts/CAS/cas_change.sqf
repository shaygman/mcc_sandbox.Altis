//Made by Shay_Gman (c) 09.10
#define ExtrasDialog_IDD 2998

#define AIRDROP_CLASS 5508
#define AIRDROP_TYPE 5509 
#define AIRDROP_ITEMS 5510 

private ["_action", "_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_dummy"];
disableSerialization;

_action =_this select 0;
_mccdialog = findDisplay ExtrasDialog_IDD;	

if (_action==0) then 
	{
	_type = lbCurSel AIRDROP_CLASS;
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
			
			case 3:	//Ammo 
			{
				_groupArray = U_AMMO;
			};
			
			case 4:	//Ace ammo
			{
				_groupArray = U_ACE_AMMO;
			};
		};
		
	_comboBox = _mccdialog displayCtrl AIRDROP_TYPE;		
	lbClear _comboBox;
	if (_type<3) then 
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
	
if (_action==1) then 
	{	
	_type = lbCurSel AIRDROP_CLASS;
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
			
			case 3:	//Ammo 
			{
				_groupArray = U_AMMO;
			};
			
			case 4:	//Ace ammo
			{
				_groupArray = U_ACE_AMMO;
			};
		};
	_dummy = (_groupArray select (lbCurSel AIRDROP_TYPE)) select 1;
	MCC_airDropArray set[count MCC_airDropArray , _dummy];
	_comboBox = _mccdialog displayCtrl AIRDROP_ITEMS;		//added objects
	lbClear _comboBox;
		{
			_displayname = _x;
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_airDropArray;
		_comboBox lbSetCurSel 0;
	};
	
if (_action==2) then 
	{	
	MCC_airDropArray = [];
	_comboBox = _mccdialog displayCtrl AIRDROP_ITEMS;		//added objects
	lbClear _comboBox;
	};
