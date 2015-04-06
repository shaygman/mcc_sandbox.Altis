//=================================================================MCC_fnc_CheckBuildings==============================================================================
//	Check if we have the selected building in the side base
//  Parameter(s):
//     _req: ARRAY
//     _center: POSITION OR OBJECT
//     _radius: INTEGER
//
//	OUT <BOOLEAN>
//==============================================================================================================================================================================
private ["_req","_center","_radius","_available","_facility","_var","_level","_buildings","_pos"];
//Let see what we already built
_req =  [_this,0,missionnamespace,[missionnamespace,"",[]]] call bis_fnc_param;
_center =  [_this,1,missionnamespace,[missionnamespace,objNull,[]]] call bis_fnc_param;
_radius =  [_this,2,missionnamespace,[missionnamespace,0]] call bis_fnc_param;

_pos = if (typeName _center == "OBJECT") then {getpos _center} else {_center};
_buildings = _pos nearEntities [["logic"], _radius];

_available = true;

_facility = [];
{
	_var = _x getVariable ["mcc_constructionItemType",""];
	_level = _x getVariable ["mcc_constructionItemTypeLevel",1];
	if (_var != "" && !(isNull attachedTo _x)) then
	{
		_facility pushBack [_var,_level];
	};
} foreach _buildings;

_var   = _x select 0;
_level = _x select 1;

if (({(_x select 0) == _var && (_x select 1) >= _level}count _facility)<=0) then {_available = false};

_available