//======================================================MCC_fnc_nearestRoad=========================================================================================================
// Example:[_pos,_radius] call MCC_fnc_nearestRoad; 
/*
	Author: Nelson Duarte

	Description:
	Find the nearest road segment to certain position, within given radius

	Parameter(s):
	_this select 0:	ARRAY	- The center position
	_this select 1:	NUMBER	- The distance from center position
	_this select 2:	ARRAY	- List of blacklisted road objects
	
	Returns:
	OBJECT	- Nearest road object on success
	NULL	- If no road object is found within given radius
*/
private ["_position", "_radius", "_blacklisted"];
_position	= [_this, 0, [0, 0, 0], [[]]] call BIS_fnc_param;
_radius		= [_this, 1, 50, [0]] call BIS_fnc_param;
_blacklisted	= [_this, 2, [], [[]]] call BIS_fnc_param;

//Near roads
private "_nearRoads";
_nearRoads = _position nearRoads _radius;

//The return value
private ["_road","_nearRoadsFinalSorted"];
_road = objNull;
_nearRoadsFinalSorted = [];

//Are there any road segment within radius?
if (count _nearRoads > 0) then {
	//New list, excluding blacklisted road segments
	private "_nearRoadsFinal";
	_nearRoadsFinal = [];

	//Loop near roads and extract valid ones to new list, if blacklisted roads is not empty
	if (count _blacklisted > 0) then {
		{
			//The current road
			private "_current";
			_current = _x;
			
			//Is road blacklisted?
			if !(_current in _blacklisted) then {
				_nearRoadsFinal set [count _nearRoadsFinal, _current];
			};
		} forEach _nearRoads;
	} else {
		_nearRoadsFinal = _nearRoads;
	};
	
	//Make sure we have roads to process
	if (count _nearRoadsFinal > 0) then {
		//Order by nearest
		_nearRoadsFinalSorted = [_nearRoadsFinal, [], { _position distance _x }, "ASCEND"] call BIS_fnc_sortBy;

		//Nearest road
		_road = _nearRoadsFinalSorted select 0;
	};
};

//Return
_nearRoadsFinalSorted


				
		
