
private ["_group","_groupUnits","_waypointNo","_startingWPNo","_pos","_placeHolder","_sel","_xGroup","_homeBuild","_occupied"];
_group = _this select 0;
_groupUnits = _this select 1;
_waypointNo = currentWaypoint _group;

while {({alive _x} count _groupUnits) >= 1 && (_group getVariable ["Garrisoning",true])} do
{
	_waypointNo = currentWaypoint _group;
	_startingWPNo = _group getVariable ["GarrisonWPNo",_waypointNo];

	if (_startingWPNo != _waypointNo) then
	{
		_group setVariable ["Garrisoning",false];
	};
	sleep 1;
};

_pos = getWPPos [_group,_startingWPNo];
_placeHolder = [];

if ((count (units _group)) == 1) then
{
	_sel = ((units _group) select 0);
	if !(_sel in _groupUnits) then
	{
		_placeHolder set [0,_sel];
	};
};

sleep 1;

{
	_xGroup = group _x;
	if (_xGroup != _group) then
	{
		[_x] joinSilent _group;
	};
	
	_homeBuild = _x getVariable ["homebuild",objNull];
	
	if !(isNull _homeBuild) then
	{
		_occupied = _homeBuild getVariable ["occupied",true];
		
		if (_occupied) then
		{
			_homeBuild setVariable ["occupied",false];
		}
	};
	
	_x setVariable ["forcedspeed",-1];
	_x forceSpeed -1;
	_x doMove _pos;
} foreach _groupUnits;

if ((count _placeHolder) != 0) then
{
	_placeholder joinsilent grpNull;
	deleteVehicle (_placeholder select 0);
};

_group setCurrentWaypoint [_group,_waypointNo];
leader _group setSpeedMode "NORMAL";
_group setFormation "WEDGE";
leader _group setBehaviour "AWARE";
