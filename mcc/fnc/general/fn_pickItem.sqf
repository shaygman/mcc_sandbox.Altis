//==================================================================MCC_fnc_pickItem===============================================================================================
//  _objet = object (the picable object)
//==================================================================================================================================================================================
private["_object", "_action", "_displayName"];

_object = _this;
if (isnil "_object" || isnull _object) exitWith {}; 

_object enableSimulation false; 
_displayName = getText(configFile >> "CfgVehicles" >> typeof _object >> "displayname"); 
if (isnil "_action") then 
{
	_action = _object addaction [format ["<t color=""#CC0000"">Pick %1</t>",_displayName], MCC_path + "mcc\fnc\general\pickItem.sqf",[], 9,false, false, "","((vehicle _target) distance  (vehicle _this)) < 2"];
	call compile "MCC_pickItem= false";
	publicvariable "MCC_pickItem"; 
}; 