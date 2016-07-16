//Made by Shay_Gman (c) 10.13
#define MCC_AIRDROPTYPECONTROL 1031
#define MCC_AIRDROPCLASSCONTROL 1032
#define MCC_AIRDROPARRAYCONTROL 1033

private ["_action", "_type", "_comboBox", "_mccdialog","_displayname","_dummy","_index","_insertionType","_fn_refresh"];
disableSerialization;

_action =_this select 0;
_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");

_fn_refresh = {
	#define MCC_AIRDROPTYPECONTROL 1031
	#define MCC_AIRDROPCLASSCONTROL 1032
	#define MCC_AIRDROPARRAYCONTROL 1033
	private ["_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index","_newGroupArray"];
	disableSerialization;

	_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");
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
	_newGroupArray = [];
	//if slingload show only sligloadable vehicles
	if ((missionNamespace getVariable ["MCC_airdropIsParachute",0]) == 1) then {
		private ["_maxMass","_vehicleClass","_dummyObject"];
		_maxMass = if (isClass (configFile >> "CfgPatches" >> "A3_Air_F_Heli_Heli_Transport_03")) then {
			switch (toLower mcc_sidename) do {
			    case "east": {12000};
			    case "west": {10000};
			    default {4000};
			};
		} else {4000};

		for "_i" from 0 to (count _groupArray)-1 do {
			if (typeName (_groupArray select _i) == "ARRAY") then {
				_vehicleClass = (_groupArray select _i) select 1;
				if (count (getArray(configFile >> "CfgVehicles" >> _vehicleClass >> "slingLoadCargoMemoryPoints")) > 0) then {
					_dummyObject = _vehicleClass createVehicleLocal [0,0,500];
					waitUntil {!isNull _dummyObject};
					if (getMass _dummyObject < _maxMass) then {_newGroupArray pushBack  (_groupArray select _i)};
					deletevehicle _dummyObject;
				};
			};
		};
	} else {
		_newGroupArray = _groupArray;
	};

	_comboBox = _mccdialog displayCtrl MCC_AIRDROPCLASSCONTROL;
	lbClear _comboBox;
	if (_type<4) then
	{
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
			_comboBox lbSetData [_index, (_x select 1)];
		} foreach _newGroupArray;
	} else
	{
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_comboBox lbAdd _displayname;
			_comboBox lbSetData [_foreachIndex, (_x select 1)];
		} foreach _newGroupArray;
	};
	_comboBox lbSetCurSel 0;
};

if (_action==0) exitWith 		//Refresh list
{
	call _fn_refresh;
};

if (_action==1) exitWith 		//Add airdrop to list
{
	_index = lbCurSel MCC_AIRDROPCLASSCONTROL;
	if (_index == -1) exitWith {};

	_dummy = lbData [MCC_AIRDROPCLASSCONTROL,_index];
	MCC_airDropArray set [count MCC_airDropArray , _dummy];

	_comboBox = _mccdialog displayCtrl MCC_AIRDROPARRAYCONTROL;		//added objects
	lbClear _comboBox;
	{
		_displayname = getText(configFile >> "CfgVehicles" >> _x >> "displayname") ;
		_comboBox lbAdd _displayname;
	} foreach MCC_airDropArray;
	_comboBox lbSetCurSel 0;
};

if (_action==2) exitWith 				//Clear Airdrop
{
	MCC_airDropArray = [];
	_comboBox = _mccdialog displayCtrl MCC_AIRDROPARRAYCONTROL;		//added objects
	lbClear _comboBox;
};

if (_action==3) exitWith 				//Changed insertion
{
	_insertionType = _this select 1;

	if (_insertionType == 0) then {

		//parachute
		missionNamespace setVariable ["MCC_airdropIsParachute",0];
		for "_i" from 1033 to 1036 do {ctrlshow [_i, true]};
	} else {

		//Slingload
		missionNamespace setVariable ["MCC_airdropIsParachute",1];
		for "_i" from 1033 to 1036 do {ctrlshow [_i, false]};
	};

	call _fn_refresh;
};
