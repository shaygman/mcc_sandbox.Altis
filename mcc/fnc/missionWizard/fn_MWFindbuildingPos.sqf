//======================================================MCC_fnc_MWFindbuildingPos=========================================================================================================
// <in> 	pos - position to start scanning
//		_radius - radius to start scaning
// <out> array - all buildingpos of the first building it found
//========================================================================================================================================================================================
private ["_objPos","_radius","_buildingsArray","_building","_buildingPos","_Selectedbuilding","_buildingsArraySorted"];

_objPos = _this select 0;
_radius = _this select 1;

_buildingsArray = nil; 
_Selectedbuilding = nil; 
_SelectedbuildingPos = nil; 

while {isnil "_Selectedbuilding" || isnil "_SelectedbuildingPos"} do 
{
	_buildingsArray	= nearestObjects  [_objPos,["House","Ruins","Church","FuelStation","Strategic"],_radius];	//Let's find the buildings in the area
	_radius = _radius + 50; 	//increase by 50 meters in nothing is found. 
	sleep 0.01; 

	_buildingsArraySorted = [_buildingsArray, [], { _objPos distance _x }, "ASCEND"] call BIS_fnc_sortBy;
	if (!isnil "_buildingsArray") then
	{
		for [{_y=0},{_y < count _buildingsArraySorted},{_y=_y+1}] do 
		{
			_building = _buildingsArraySorted select _y;
			_buildingPos = _building call MCC_fnc_buildingPosCount;
			if (_buildingPos > 3) exitwith		//If the building have an interrior positions
			{							
				_Selectedbuilding	 = _building;
				_SelectedbuildingPos = _buildingPos;
			};
		};
	};
	sleep 0.01;
};

[_Selectedbuilding,_SelectedbuildingPos];