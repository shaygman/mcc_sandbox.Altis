/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskDefend
//change by spirit 11-3-2014 for specific purposes of gaia

Description:
	A function for a group to defend a parsed location. Groups will mount nearby static machine guns, and bunker in nearby buildings. They may also patrol the radius unless otherwise specified.

Parameters:
	- Group (Group or Object)

Optional:
	- Position (XYZ, Object, Location or Group)
	- Defend Radius (Scalar)
	- Building Size Threshold (Integer, default 2)
	- Can patrol (boolean)

Example:
    (begin example)
	[this] call CBA_fnc_taskDefend
    (end)

Returns:
	Nil

Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_group","_position","_radius","_threshold"];
_group = (_this select 0) ;
_position = (_this select 1);
_radius = if (count _this > 2) then {_this select 2} else {50};
_threshold = 1;

_group enableattack false;

private ["_count", "_list", "_list2", "_units", "_i"];
//_statics = [_position, vehicles, _radius, {(_x iskindof "StaticWeapon") && {(_x emptypositions "Gunner" > 0)}}] call CBA_fnc_getnearest;
_statics = [(nearestObjects [_position,["StaticWeapon"], _radius]), {(_x iskindof "StaticWeapon") && (isnull(assignedGunner (_x))) && {[(position _x),_zone] CALL fnc_posisinmarker} && {(_x emptypositions "Gunner" > 0)}}] call BIS_fnc_conditionalSelect;
//[(position PLAYER),"1"] CALL FNC_POSISINMARKER
//_buildings = _position nearObjects ["building",_radius];
_buildings = [(_position nearObjects ["building",_radius]), {[(position _x),_zone] CALL fnc_posisinmarker}] call BIS_fnc_conditionalSelect;
_units = units _group;
_count = count _units;


_zone	 = (((_group) getVariable ["GAIA_zone_intend",[]])select 0);

if !(isnil("_Zone")) then
{
		{
			if (str(_x buildingpos _threshold) == "[0,0,0]") then {_buildings = _buildings - [_x]};
		} foreach _buildings;
		_i = 0;
		{
			_count = (count _statics) - 1;
			if (_count > -1) then {
				[_x] join grpNull;
				_x assignasgunner (_statics select _count);
				_statics resize _count;
				[_x] ordergetin true;
				_i = _i + 1;
			} else {
				if (count _buildings > 0) then {
					private ["_building","_p","_array"];
					_building = _buildings call BIS_fnc_selectRandom;
					_array = _building getvariable "CBA_taskDefend_positions";
					if (isnil "_array") then {
						private "_k"; _k = 0;
						_building setvariable ["CBA_taskDefend_positions",[]];
						while {str(_building buildingpos _k) != "[0,0,0]"} do {
							_building setvariable ["CBA_taskDefend_positions",(_building getvariable "CBA_taskDefend_positions") + [_k]];
							_k = _k + 1;
						};
						_array = _building getvariable "CBA_taskDefend_positions";
					};
					if (count _array > 0) then {
						_p = (_building getvariable "CBA_taskDefend_positions") call BIS_fnc_selectRandom;
						_array = _array - [_p];
						if (count _array == 0) then {
							_buildings = _buildings - [_building];
							_building setvariable ["CBA_taskDefend_positions",nil];
						};
						_building setvariable ["CBA_taskDefend_positions",_array];
						[_x,_building buildingpos _p] spawn {
							if (surfaceIsWater (_this select 1)) exitwith {};
							(_this select 0) domove (_this select 1);
							(_this select 0) setSpeedMode "FULL";
							sleep 5;
							waituntil {unitready (_this select 0)};
							(_this select 0) disableai "move";
							dostop _this;
							waituntil {not (unitready (_this select 0))};
							(_this select 0) enableai "move";
						};
						_i = _i + 1;
					};
				};
			};
		} foreach _units;
		{
			_x setvariable ["CBA_taskDefend_positions",nil];
		} foreach _buildings;

};
