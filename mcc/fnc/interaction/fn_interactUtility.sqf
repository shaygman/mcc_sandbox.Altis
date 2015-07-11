//==================================================================MCC_fnc_interactUtility==================================================================================
// Interaction with utility object
// Example: [_object] spawn MCC_fnc_interactUtility;
//=================================================================================================================================================================================
private ["_object","_array","_ok","_ctrl","_class","_displayname","_pic","_index","_item"];
disableSerialization;
_object 	= _this select 0;
if (vehicle player != player) exitWith {};

if (MCC_interactionKey_holding && !(_object getVariable ["MCC_isInteracted",false]) && (player distance  _object < 5) && !dialog) exitWith
{
	MCC_fnc_ManMenuClicked =
	{
		private ["_ctrl","_index","_ctrlData","_object","_objectAmmo"];
		disableSerialization;

		_ctrl 		= _this select 0;
		_index 		= _this select 1;
		_ctrlData	= _ctrl lbdata _index;

		_object = (player getVariable ["interactWith",[]]) select 0;
		_objectAmmo = _object getVariable ["ammoLeft",getNumber (configFile / "CfgVehicles" / typeof _object / "ammo")];
		if (_objectAmmo == 0) then {_objectAmmo = 200};
		closeDialog 0;

		switch (_ctrlData) do
		{
			case "resupply":
			{
				//Add magazines
				private ["_magazineCount","_magazineClass","_magazines","_trashHold","_weapon","_cost","_roleCount"];
				player playactionNow "putdown";
				{
					_weapon = _x;
					if (_weapon != "") then
					{
						_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
						_magazineClass = _magazines select (0 min (count _magazines - 1));
						_magazineCount = {_x == _magazineClass} count magazines player;
						_cost = getNumber(configFile >> "CfgMagazines" >> _magazineClass >> "mass");
						switch _foreachIndex do
						{
							case 0 : {_trashHold = 2};
							case 1 : {_trashHold = 2};
							case 2 : {if ((getText((configFile / "CfgWeapons" / _weapon / "cursor")) == "mg")) then {_trashHold = 4} else {_trashHold = 8}};
						};

						if (_magazineCount < _trashHold) then
						{
							for "_i" from _magazineCount to (_trashHold-1) do
							{
								player addMagazine _magazineClass;
								_objectAmmo = _objectAmmo - _cost;
								if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
							};
						};
					};
				} foreach [secondaryWeapon player,handgunWeapon player, primaryWeapon player];

				//Add FAIK
				private ["_bandage","_count"];
				if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
					_bandage = "MCC_bandage";
					_count = {_bandage == _x} count magazines player;
				} else {
					_bandage = if (MCC_isACE) then {"ACE_fieldDressing"} else {"FirstAidKit"};
					_count = {_bandage == _x} count items player;
				};

				_roleCount =  if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {11} else {1};

				for "_i" from _count to _roleCount do {
					if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
						player addMagazine _bandage} else {player addItem _bandage};
					_objectAmmo = _objectAmmo - 1;
				};

				//Add complex medical items
				if ((missionNamespace getVariable ["MCC_medicComplex",false]) || MCC_isACE) then {

					_bandage = if (missionNamespace getVariable ["MCC_medicComplex",false]) then {["MCC_epipen","MCC_salineBag"]} else {["ACE_epinephrine","ACE_morphine","ACE_bloodIV_250"]};

					_roleCount =  if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {6} else {0};

					{
						_item = _x;
						_count = {_item == _x} count (if (missionNamespace getVariable ["MCC_medicComplex",false]) then {magazines player} else {items player});
						for "_i" from _count to _roleCount do {
							if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
								player addMagazine _item} else {player addItem _item};
							_objectAmmo = _objectAmmo - 1;
						};
					} forEach _bandage;
				};

				//Add grenades
				private ["_grenades","_grnd"];
				_grenades = ["HandGrenade","SmokeShell"];

				{
					_grnd = _x;
					_count = {_grnd == _x} count magazines player;

					for "_i" from _count to 1 do {
						player addMagazine _grnd;
						_objectAmmo = _objectAmmo - 5;
					};
				} forEach _grenades;

				//Add satchels
				if (((getNumber(configFile >> "CfgVehicles" >> typeOf player >> "canDeactivateMines")) == 1) || ((player getvariable ["CP_role",""]) == "Specialist")) then {
					_bandage = "SatchelCharge_Remote_Mag";
					_count = {_bandage == _x} count magazines player;

					for "_i" from _count to 1 do {
						player addMagazine _bandage;
						_objectAmmo = _objectAmmo - 10;
					};
				};

				//Delete if done
				if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
				_object setVariable ["ammoLeft",_objectAmmo,true];
			};
		};
	};

	_array = [["resupply","Resupply",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];


	//Manage array
	_object setVariable ["MCC_isInteracted",true,true];
	_ok = createDialog "MCC_INTERACTION_MENU";
	waituntil {dialog};

	_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
	_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];
	_ctrl ctrlCommit 0;

	_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

	lbClear _ctrl;
	{
		_class			= _x select 0;
		_displayname 	= _x select 1;
		_pic 			= _x select 2;
		_index 			= _ctrl lbAdd _displayname;
		_ctrl lbSetPicture [_index, _pic];
		_ctrl lbSetData [_index, _class];
	} foreach _array;
	_ctrl lbSetCurSel 0;

	player setVariable ["interactWith",[_object]];
	_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_ManMenuClicked"];
	waituntil {!dialog};
	player setVariable ["MCC_interactionActive",false];
	_object setVariable ["MCC_isInteracted",false,true];
};

player setVariable ["MCC_interactionActive",false];