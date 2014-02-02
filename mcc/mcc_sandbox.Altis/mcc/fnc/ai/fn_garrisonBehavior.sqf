//==================================================================MCC_fnc_garrisonBehavior===============================================================================================
//Make garrison units patroling from house to house
// Example: [_group, static] spawn MCC_fnc_garrisonBehavior;
// _group = object. unit
//static = boolean. true if it should be static false if not
//===========================================================================================================================================================================	
private ["_group", "_static","_buildingsArray","_buildingscount","_buildingPos","_wp","_spawnPos","_building","_leader","_time"];
_group					 = _this select 0; 
_static 			     = _this select 1; 

sleep (random 240);
if (isnil "_group") exitWith {};

_leader = leader _group;
if (!alive _leader) exitWith {};

if (( behaviour _leader) != "COMBAT") then
{
	if (!_static) then
	{
		
		_buildingsArray	= nearestObjects  [_leader,["House","Ruins","Church","FuelStation","Strategic"],50];	//Let's find the buildings in the area
		_buildingscount	= count _buildingsArray;
		if (_buildingscount < 1) exitwith {hint "No buildings found"};	//No available buildings? stop the script!
		
		_building = _buildingsArray call BIS_fnc_selectRandom;
		_buildingPos = _building call MCC_fnc_buildingPosCount;
		if (_buildingPos > 0) then	
		{	//If the building have an interrior positions
			_spawnPos	= _building buildingPos (floor (random _buildingPos)); 
			if (count (nearestObjects [_spawnPos, ["Man"], 1])<1) then	
			{
				if (alive _leader && canmove _leader) then
				{
					_leader domove _spawnPos; 	
					_time = time + 120;			
					waitUntil {moveToCompleted _leader or moveToFailed _leader or !alive _leader or _time < time};
				};
		
				//Make them stand
				{
					_x setUnitPos "UP";
				} foreach units _group;
				
				//Look somewhere randomly
				_group setFormDir (round(random 360));
			};
		};
	}; 
};

if (alive (leader _group)) then
{
	_static = if (random 1 > 0.1) then {true} else {false};
	[_group, _static] call MCC_fnc_garrisonBehavior;
};