//=====================================================MCC_fnc_getGroupIconData=================================================================================================
//get group icon depends on the group type and size
// IN <>
//		_group: group
// OUT <>
//		_markerColor: ARRAY - marker color in RGB
//		_groupName:	STRING - group name
//		_markerType: STRING - marker cfg name
//		_unitsSizeMarker: STRING - marker cfg name
//===============================================================================================================================================================================

private ["_side","_group","_markerColor","_markerInf","_markerRecon","_markerSupport","_markerAutonomous","_markerMech","_markerArmor","_markerAir","_markerNaval","_groupName","_unitsCount","_unitsSize","_markerType","_unitsSizeMarker"];
_group = param [0,grpNull,[grpNull,missionNamespace]];

if (isNull _group) exitWith {};

_side = side _group;
_markerColor = _side call bis_fnc_sidecolor;

switch (_side) do {
	case east: //East
	{
		_markerInf		= "o_inf";
		_markerRecon	= "o_recon";
		_markerSupport	= "o_support";
		_markerAutonomous = "o_uav";
		_markerMech		= "o_mech_inf";
		_markerArmor	= "o_armor";
		_markerAir		= "o_air";
		_markerNaval	= "o_naval";
	};

	case west: //West
	{
		_markerInf		= "b_inf";
		_markerRecon	= "b_recon";
		_markerSupport	= "b_support";
		_markerAutonomous = "b_uav";
		_markerMech		= "b_mech_inf";
		_markerArmor	= "b_armor";
		_markerAir		= "b_air";
		_markerNaval	= "b_naval";
	};

	case resistance: //Resistance
	{
		_markerInf		= "n_inf";
		_markerRecon	= "n_recon";
		_markerSupport	= "n_support";
		_markerAutonomous = "n_uav";
		_markerMech		= "n_mech_inf";
		_markerArmor	= "n_armor";
		_markerAir		= "n_air";
		_markerNaval	= "n_naval";
	};
	default
	{
		_markerInf		= "n_inf";
		_markerRecon	= "n_recon";
		_markerSupport	= "n_support";
		_markerAutonomous = "n_uav";
		_markerMech		= "n_mech_inf";
		_markerArmor	= "n_armor";
		_markerAir		= "n_air";
		_markerNaval	= "n_naval";
	};
};

_groupName = _group getVariable ["name",""];

if (_groupName == "") then	{_groupName = groupID _group};

_unitsCount = [_group] call MCC_fnc_countGroupHC;
_unitsSize = 0;

_markerType = nil;
if (_unitsCount select 0 > 0) then {_markerType = _markerInf; _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
if (_unitsCount select 1 > 0) then {_markerType = _markerMech; _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
if (_unitsCount select 2 > 0) then {_markerType = _markerArmor; _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
if (_unitsCount select 3 > 0) then {_markerType = _markerAir; _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
if (_unitsCount select 4 > 0) then {_markerType = _markerNaval; _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
if (_unitsCount select 5 > 0) then {_markerType = _markerRecon; _unitsSize = _unitsSize + (1*(_unitsCount select 5))};
if (_unitsCount select 6 > 0) then {_markerType = _markerSupport; _unitsSize = _unitsSize + (3*(_unitsCount select 6))};
if (_unitsCount select 7 > 0) then {_markerType = _markerAutonomous; _unitsSize = _unitsSize + (1*(_unitsCount select 7))};

if (isnil "_markerType") then
{
	_unitsCount = [group _leader] call MCC_fnc_countGroup;
	if (_unitsCount select 0 > 0) then {_markerType = _markerInf; _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
	if (_unitsCount select 1 > 0) then {_markerType = _markerMech; _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
	if (_unitsCount select 2 > 0) then {_markerType = _markerArmor; _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
	if (_unitsCount select 3 > 0) then {_markerType = _markerAir; _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
	if (_unitsCount select 4 > 0) then {_markerType = _markerNaval; _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
};

//How big is the squad
_unitsSize = floor (_unitsSize/4);
if (_unitsSize > 10) then {_unitsSize = 10};
_unitsSizeMarker = format ["group_%1",_unitsSize];

[_markerColor,_groupName,_markerType,_unitsSizeMarker]
