//======================================================MCC_fnc_findMarkers=========================================================================================================
// bring all markers names around a sepcific position with the given radius
// Example:[_pos,_radius._filter] call MCC_fnc_findMarkers;
// _pos: POSITION where to start the search
// _radius: INTEGER, radius to search
// _filter: STRIGN, return only markers with this string in thier name
//	<RETURM>
//		MARKERS ARRAY
//========================================================================================================================================================================================
private ["_pos","_radius","_filter","_return"];
_pos = param [0, [0,0,0], [[]]];
_radius = param [1, 200, [0]];
_filter = param [2, "", [""]];
_return = [];
if (count _pos > 0) then {
	{
		if (markerPos _x distance2D _pos <= _radius) then {
			if (_filter != "") then {
				if ([_filter, _x] call BIS_fnc_inString) then {
					_return pushBack _x;
				};
			} else {
				_return pushBack _x;
			};
		};
	} forEach allMapMarkers;
};

_return
