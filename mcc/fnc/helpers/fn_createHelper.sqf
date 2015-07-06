//==================================================================MCC_fnc_createHelper=======================================================================================
// Create ingame UI helper for interacted objects
//===============================================================================================================================================================================
private ["_object","_text"];
_object = _this select 0;
_text	= _this select 1;

if (isnil "_object") exitWith {};
if (isnull _object || !isServer) exitWith {};

_helper = "UserTexture1m_F" createVehicle [0,0,0];
_helper attachto [_object,[0,0,1]];
_helper setVariable ["MCC_helperText",_text,true];

while {alive _object} do {sleep 2};
deletevehicle _helper;
