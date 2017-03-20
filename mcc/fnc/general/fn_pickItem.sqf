//======================================================MCC_fnc_pickItem===============================================================================================
//  _objet = object (the picable object)
//==============================================================================================================================================================
#define MCC_INTEL_ICON	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"

private["_object", "_action", "_displayName","_isMode","_path"];

_object = _this;
if (isnil "_object" || isnull _object) exitWith {};

_object enableSimulation false;
_displayName = getText(configFile >> "CfgVehicles" >> typeof _object >> "displayname");
_isMode = isClass (configFile >> "CfgPatches" >> "mcc_sandbox");	//check if MCC is mod version

_path = if (_isMode) then {"\mcc_sandbox_mod\"} else {""};

/*
_action = _object addaction [format ["<t color=""#CC0000"">Pick %1</t>",_displayName], _path + "mcc\fnc\general\pickItem.sqf",[], 9,false, false, "","((vehicle _target) distance  (vehicle _this)) < 2"];
*/

_action = [
		 _object,
		 if (_object isKindOf "man") then {format ["Interrogate %1",_displayName]} else {format ["Search %1",_displayName]},
		 MCC_INTEL_ICON,
		 MCC_INTEL_ICON,
		 "(alive _target) && (_target distance _this < 5)",
		 "(alive _target) && (_target distance _this < 5)",
		 {},
		 {},
		 compile format ["0 = _this execVM '%1mcc\fnc\general\pickItem.sqf';",_path],
		 {},
		 [],
		 3,
		 10,
		 true,
		 false
		] call bis_fnc_holdActionAdd;

missionNamespace setVariable ["MCC_pickItem",sideLogic];
publicvariable "MCC_pickItem";