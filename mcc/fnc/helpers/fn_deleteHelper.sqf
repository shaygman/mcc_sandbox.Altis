//==================================================================MCC_fnc_deleteHelper=========================================================================================
// Delete ingame UI helper for interacted objects
//==============================================================================================================================================================================
private ["_object"];
_object = _this select 0;
if (isnil "_object") exitWith {};
if (isnull _object) exitWith {};

{
  if (typeOf _x == "UserTexture1m_F") then {deleteVehicle _x};
} forEach attachedObjects _object;
