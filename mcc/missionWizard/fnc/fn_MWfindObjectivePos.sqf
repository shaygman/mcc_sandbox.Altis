//======================================================MCC_fnc_MWfindObjectivePos===============================================================================================
// Find the mission Wizard's center
// Example:[_missionCenter,_isCQB,_minObjectivesDistance, _objFirstTime] call MCC_fnc_MWfindObjectivePos;
// _missionCenter 			= position, from where to start looking.
//_isCQB 				= Boolean, true - for CQB areay false if it doesn't matters.
//_minObjectivesDistance 	= integer, minimum distance between objectives
// Return - pos
//===============================================================================================================================================================================
private ["_missionCenter","_isCQB","_minObjectivesDistance","_positionFound","_buildingsArray","_farEnough","_range","_flatPos","_buildingsArraySorted","_building","_isBuilding","_availablePos","_time"];

_missionCenter 			= _this select 0;
_isCQB 					= _this select 1;
_minObjectivesDistance 	= _this select 2;

_positionFound = false;
_farEnough = false;
_range = 100;
_availablePos = [];

//Lets find a pice of land
_time = time + 60;

//if it is the first time then find objective close to the center
while {(count _availablePos) == 0 && time < _time} do {
	_range = _range + 100;
	_availablePos = selectBestPlaces [_missionCenter, _range, "2*meadow + hills", 5, 5];

	if (count _availablePos > 0) then {
		_availablePos = (_availablePos select 0) select 0;
		_availablePos set [2,0];

		//are we far enough from all other objectives
		_farEnough = {(getMarkerPos _x) distance2d _availablePos <= (_minObjectivesDistance*0.8)} count MCC_MWObjectiveMarkers == 0;

		if !(_farEnough) then {_availablePos = []};
	};

	sleep 0.01;
};

//systemChat format ["found position: %1, have time: %2, farenough: %3",(count _availablePos) > 0, time < _time,_farEnough];
if (count _availablePos == 0) exitWith {
	diag_log "MCC: Mission Wizard Error: No mission objective's postion found, make a bigger zone";
	MCC_MWisGenerating = false;
	["MCC: Mission Wizard Error: No mission objective's postion found, make a bigger zone"] call bis_fnc_halt;
};

if (_farEnough || (count MCC_MWObjectiveMarkers == 0)) then {
	if (_isCQB) then {
		_buildingsArray	= nearestObjects  [_availablePos,["House","Ruins","Church","FuelStation","Strategic"],200];	//Let's find the buildings in the area

		if ((count _buildingsArray>1) && (!surfaceIsWater _availablePos)) then {
			_buildingsArraySorted = [_buildingsArray, [], { _availablePos distance _x }, "ASCEND"] call BIS_fnc_sortBy;
			_isBuilding = ([getpos (_buildingsArraySorted select 0),100] call MCC_fnc_MWFindbuildingPos) select 0;
			if (!isnil "_isBuilding") then {
				_availablePos = getpos _isBuilding;
				_positionFound = true;
			};
		};
	} else {
		_positionFound = true;
	};

	if (_positionFound) then {
		private _markerName = format ["Objective_%1",count MCC_MWObjectiveMarkers];
		MCC_MWObjectiveMarkers pushBack _markerName;
		publicVariable "MCC_MWObjectiveMarkers";
		createmarkerlocal [_markerName,_availablePos];
		_markerName setmarkertypelocal "mil_box";
		_markerName setMarkerTextLocal _markerName;
		_markerName setmarkerColorlocal "ColorRed";
		_markerName setMarkerSizeLocal [0.3, 0.3];
		_markerName setMarkerAlphaLocal 0.2;
	};
};

if !(_positionFound) then {
	diag_log "MCC: Mission Wizard Error: No mission objective's postion found, make a bigger zone";
	MCC_MWisGenerating = false;
	["MCC: Mission Wizard Error: No mission objective's postion found, make a bigger zone"] call bis_fnc_halt;
};

_availablePos;