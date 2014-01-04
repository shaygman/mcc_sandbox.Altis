//Made by Shay_Gman (c) 09.10

private ["_pos","_unitsArray","_counter","_unitClass","_side","_group","_unit","_type","_unitType","_name","_safepos","_leader","_loc","_waterSpawn"];

_pos = _this select 0; 
_unitsArray = _this select 1;
_counter = _this select 2;
_loc = _this select 3;
if (surfaceIsWater _pos) then {_waterSpawn = 2} else {_waterSpawn = 0}; 
if ( ( (isServer) && ( (_loc == 0) || !(MCC_isHC) ) ) || ( (MCC_isLocalHC) && (_loc == 1) ) ) then 
{
	_unitClass = (_unitsArray select 0) select 0;
	_unitType = (_unitsArray select 0) select 1;
	
	diag_log format ["%1 - spawning Groep Editor objects [%2]", time, _unitClass];

	_side =  getNumber (configFile >> "CfgVehicles" >> _unitClass >> "side");
	switch (_side) do	{
		case 0:					//east
			{ 
				_side = east;
			};
			
		case 1:					//west
			{ 
				_side = west;
			};
			
		case 2:					//GUR
			{ 
				_side = resistance;
			};
			
		case 3:					//Civilian
			{ 
				_side = civilian;
			};
		};


	_group = creategroup _side;			//Make the group
	_name = format ["MCC_customGroup%1",_counter];	
	for [{_x=0},{_x < (count _unitsArray)},{_x=_x+1}] do {	
		_unitClass = (_unitsArray select _x) select 0;
		_unitType = (_unitsArray select _x) select 1;
		
		switch (_unitType) do	{			//Spawn the group
			case 0:					
				{ 
					_unit = _group createUnit [_unitClass,_pos, [], 0, "FORM"];
				};
				
			case 1:					
				{ 
					_safepos  =[_pos,1,100,2,_waterSpawn,100,0] call BIS_fnc_findSafePos;
					_unit = [[_safepos select 0,_safepos select 1,0], 0, _unitClass, _group] call BIS_fnc_spawnVehicle;
				};
			case 2:					
				{ 
					_safepos  =[_pos,1,100,2,_waterSpawn,100,0] call BIS_fnc_findSafePos;
					_unit = [[_safepos select 0,_safepos select 1,300], 0, _unitClass, _group] call BIS_fnc_spawnVehicle;
				};
			};
		};
		
	_leader = leader _group; 
	call compile (_name + " = _leader"); 
	publicVariable _name;
};