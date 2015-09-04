//=================================================================MCC_fnc_rtsClearBuilding==============================================================================
//	Remove resources
//  Parameter(s):
//     _module: OBJECT the building to delete
//     _deleteModule: BOOLEAN should we delete the attached module
//==============================================================================================================================================================================
private ["_module","_deleteModule","_anchor"];
_module			= [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_deleteModule 	= [_this, 1, true, [true]] call BIS_fnc_param;

_anchor = _module getVariable ["mcc_construction_anchor",objNull];

{deletevehicle _x} foreach (attachedObjects _anchor);
deletevehicle _anchor;
if (_deleteModule) then
{
	deletevehicle _module;
};