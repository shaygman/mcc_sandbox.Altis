//==================================================================MCC_fnc_interactUtility==================================================================================
// Interaction with utility object
// Example: [_object] spawn MCC_fnc_interactUtility;
//============================================================================================================================================================================
private ["_object","_array","_ok","_ctrl","_class","_displayname","_pic","_index","_item","_cfg","_objectClass"];
disableSerialization;
_object 	= _this select 0;
if (vehicle player != player) exitWith {};

if ((missionNamespace getVariable ["MCC_interactionKey_holding",false]) && !(_object getVariable ["MCC_isInteracted",false]) && (player distance  _object < 5) && !dialog) exitWith {
	_objectClass = typeof _object;
	_cfg = configFile >> "cfgVehicles" >> _objectClass;
	_array = [["closeDialog 0",format ["<t size='1' align='center' color='#ffffff'>%1</t>", getText(_cfg >> "displayName")],""]];


	//Resupply from ammo
	if (_objectClass in ["MCC_crateAmmo","Box_NATO_AmmoVeh_F"]) then {
		_array pushBack ["[player getVariable ['interactWith',objNull]] call MCC_fnc_resupply","Resupply",format ["%1data\IconAmmo.paa",MCC_path]];
	};

	//Break down MCC crates
	if (_objectClass in (missionNamespace getVariable ["MCC_logisticsCrates_TypesWest",[]])) then {
		_array pushBack ["[player getVariable ['interactWith',objNull]] call MCC_fnc_breakdown","Break Down",format ["%1data\IconAmmo.paa",MCC_path]];
		_array pushBack ["[player getVariable ['interactWith',objNull]] call MCC_fnc_dragObject","Drag",format ["%1data\iconDrag.paa",MCC_path]];
	};


	_object setVariable ["MCC_isInteracted",true,true];
	player setVariable ["interactWith",_object];

	if (count _array == 1) exitWith {player setVariable ["MCC_interactionActive",false]};

	[_array,0] call MCC_fnc_interactionsBuildInteractionUI;
	waituntil {dialog};
	waituntil {!dialog};
	player setVariable ["MCC_interactionActive",false];
	_object setVariable ["MCC_isInteracted",false,true];
};

player setVariable ["MCC_interactionActive",false];