//=================================================================MCC_fnc_baseOpenConstMenu==============================================================================
//	What happened when clicking on a base's building action
//  Parameter(s):
//     _center: POSITION
//     _radius: INTEGER
//==============================================================================================================================================================================
private ["_disp","_buildings","_center","_radius","_ctrl","_availableActions","_res","_constType",
	         "_pic","_available","_facility","_req","_var","_level","_resToCheck"];
disableSerialization;

_center = _this select 0;
_radius = _this select 1;
_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

//what can we build
_buildings = _center nearEntities [["logic"], _radius];

//filter not needed buildings
for "_i" from 0 to (count _buildings)-1 do
{
	if (((_buildings select _i) getVariable ["mcc_constructionItemType",""]) == "") then {_buildings set [_i,-1]};
};

_buildings = _buildings - [-1];

//Let see what we already built
_facility = [];
{
	_var = _x getVariable ["mcc_constructionItemType",""];
	_level = _x getVariable ["mcc_constructionItemTypeLevel",1];
	if (_var != "" && !(isNull attachedTo _x)) then
	{
		_facility pushBack [_var,_level];
	};
} foreach _buildings;

//Hide upgrades
for "_i" from 160 to 163 do
{
	(_disp displayCtrl _i) ctrlShow false;
};

//Hide actions
for "_i" from 101 to 112 do
{
	(_disp displayCtrl _i) ctrlShow false;
};