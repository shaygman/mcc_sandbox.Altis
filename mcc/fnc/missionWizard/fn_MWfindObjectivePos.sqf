//======================================================MCC_fnc_MWfindObjectivePos=========================================================================================================
// Find the mission Wizard's center
// Example:[_missionCenter,_isCQB,_minObjectivesDistance, _objFirstTime] call MCC_fnc_MWfindObjectivePos; 
// _missionCenter 			= position, from where to start looking.
//_isCQB 				= Boolean, true - for CQB areay false if it doesn't matters. 
//_minObjectivesDistance 	= integer, minimum distance between objectives
//_maxObjectivesDistance 	= integer, max distance between objectives
//_objFirstTime			= Boolean, if it is the first time then find objective close to the center
// Return - pos
//========================================================================================================================================================================================
private ["_missionCenter","_isCQB","_minObjectivesDistance","_positionFound","_maxObjectivesDistance","_newPos","_buildingsArray",
		 "_farEnough","_range","_flatPos","_buildingsArraySorted","_building","_isBuilding","_objFirstTime","_time"];

_missionCenter 			= _this select 0;
_isCQB 					= _this select 1;
_minObjectivesDistance 	= _this select 2;
_maxObjectivesDistance 	= _this select 3;
_objFirstTime 			= _this select 4;

_positionFound = false; 
_farEnough = false; 

//Lets find a pice of land
_time = time + 30; 
while {!_positionFound && time < _time} do
{
	//if it is the first time then find objective close to the center
	if !(_objFirstTime) then
		{
			_newPos = [[_missionCenter],["water","out"]] call BIS_fnc_randomPos; //first is whitelist second is blacklist, third is condition
		}
		else
		{
			_newPos = getpos _missionCenter;
		};
	
	{
		_range = (getMarkerPos _x) distance _newPos;
		if (_range > _minObjectivesDistance) then {_farEnough = true};
	} foreach MCC_MWObjectiveMarkers;
	
	if (_farEnough || (count MCC_MWObjectiveMarkers ==0)) then
	{
		if (_isCQB) then
		{
			_buildingsArray	= nearestObjects  [_newPos,["House","Ruins","Church","FuelStation","Strategic"],200];	//Let's find the buildings in the area
			
			if ((count _buildingsArray>1) && (!surfaceIsWater _newPos)) then 
				{
					_buildingsArraySorted = [_buildingsArray, [], { _newPos distance _x }, "ASCEND"] call BIS_fnc_sortBy;
					_isBuilding = ([getpos (_buildingsArraySorted select 0),100] call MCC_fnc_MWFindbuildingPos) select 0;
					if (!isnil "_isBuilding") then 
					{
						_newPos = getpos _isBuilding; 
						_positionFound = true;
					};
				};
		} 
		else
		{
			_flatPos = selectBestPlaces [_newPos, 200, "meadow", 1, 5];
			/*_flatPos =  _newPos isflatempty [
												20,							//--- Minimal distance from another object
												0,								//--- If 0, just check position. If >0, select new one
												0.3,							//--- Max gradient
												20,								//--- Gradient area
												0,								//--- 0 for restricted water, 2 for required water,
												false							//--- True if some water can be in 25m radius
											];*/
			//_flatPos = _newPos isFlatEmpty [2,0,0.3,1,1,true];
			if ((count _flatPos) != 0) then 
				{	
					_positionFound = true;
					_newPos =  [((_flatPos select 0) select 0) select 0, ((_flatPos select 0) select 0) select 1, 0];
				};
		};
			
		if (_positionFound) then
		{
			MCC_MWObjectiveMarkers set [count MCC_MWObjectiveMarkers, format ["Objective %1",count MCC_MWObjectiveMarkers]];
			publicVariable "MCC_MWObjectiveMarkers"; 
			createmarkerlocal [format ["Objective %1",count MCC_MWObjectiveMarkers],_newPos];
			format ["Objective %1",count MCC_MWObjectiveMarkers] setmarkertypelocal "mil_box";
			format ["Objective %1",count MCC_MWObjectiveMarkers] setMarkerTextLocal format ["Objective %1",count MCC_MWObjectiveMarkers];
			format ["Objective %1",count MCC_MWObjectiveMarkers] setmarkerColorlocal "ColorRed";
			format ["Objective %1",count MCC_MWObjectiveMarkers] setMarkerSizeLocal [0.3, 0.3];
		};
	};
}; 

if (time >= _time) then
	{
		diag_log "MCC: Mission Wizard Error: No mission objective's postion found, make a bigger zone"; 
		MCC_MWisGenerating = false;
		["MCC: Mission Wizard Error: No mission objective's postion found, make a bigger zone"] call bis_fnc_halt;
	};
	
_newPos;