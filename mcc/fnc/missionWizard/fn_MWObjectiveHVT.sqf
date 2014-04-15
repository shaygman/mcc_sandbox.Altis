//======================================================MCC_fnc_MWObjectiveHVT=========================================================================================================
// Create an HVT objective
// Example:[_objPos,_isCQB,_alive] call MCC_fnc_MWObjectiveHVT; 
// _objPos = position, objectice position
//_isCQB = Boolean, true - for CQB areay false if it doesn't matters. 
//_alive = Boolean, true - catch him alive, False - kill him
// Return - nothing
//========================================================================================================================================================================================
private ["_objPos","_isCQB","_alive","_buildingPos","_spawnPos","_unitsArray","_faction","_type","_group","_side","_unit",
         "_building","_unitPlaced","_time","_array","_sidePlayer","_factionPlayer","_walking","_preciseMarkers"];

_objPos = _this select 0;
_isCQB = _this select 1;
_alive = _this select 2;
_side = _this select 3;
_faction = _this select 4;
_sidePlayer = _this select 5;
_factionPlayer = _this select 6;
_preciseMarkers = _this select 7;

MCC_MWcreateHostage =
	{
		private ["_side","_spawnPos","_group","_unit","_type","_init","_rank"];
		_side = _this select 0;
		_spawnPos = _this select 1;
		_type = _this select 2;
		
		_group = creategroup _side; 
		_rank = ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT"] select (floor random 3); 
		_unit = _group createUnit [_type select 0,_spawnPos,[],0.5,"NONE"];
		waituntil {alive _unit}; 
		_unit setrank _rank;
		_unit setBehaviour "SAFE";
		_unit setUnitPos "UP";
		_unit setpos _spawnPos;
		_unit setpos _spawnPos;
		removeallweapons _unit; 
		_init = format ["_this setcaptive true; _this allowFleeing 0;_this disableAI 'MOVE'; removeallweapons _this; _this switchmove 'AmovPercMstpSsurWnonDnon'; _this addaction ['Secure Hostage','%1mcc\general_scripts\hostages\hostage.sqf',[0],6,false,true]; dostop _this;",
						MCC_path
						];
		[[[netID _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
		_unit;
	};	



if (_isCQB) then
	{
		 _array = [_objPos, 100] call MCC_fnc_MWFindbuildingPos;
		 _building = _array select 0;
		 _buildingPos = _array select 1;
		 
		 if (isnil "_buildingPos") exitWith {debuglog "MCC MW - MWObjectiveHVT - No building pos foudn"}; 
				
		_unitPlaced = false; 
		_time = time; 
		 while {!_unitPlaced && (time <= (_time + 5))} do
		{
			_spawnPos	= _building buildingPos (floor random _buildingPos); 
			if (count (nearestObjects [_spawnPos, ["Man"], 1])<1) then		//No other unit in the spawn position?
			{ 		
				if (_alive) then 	
				{
					//Hostage
					_unitsArray	= [_factionPlayer ,"soldier"] call MCC_fnc_makeUnitsArray;		//Let's build the faction unit's array
					_type = _unitsArray call BIS_fnc_selectRandom;	
					_unit = [_sidePlayer,_spawnPos,_type] call MCC_MWcreateHostage;
					waituntil {alive _unit}; 
					[_unit,"Secure HVT",_preciseMarkers] call MCC_fnc_MWCreateTask; 
				}
				else
				{
					//HVT
					switch _side do	
						{
							case west: {_type =   MCC_MWHVT select 0};
							case east: {_type =   MCC_MWHVT select 1};
							case resistance:  {_type =   MCC_MWHVT select 2};
							default {_type =   MCC_MWHVT select 3};
						};
					_unit = [_spawnPos, _type, _sidePlayer,"",random 360] call MCC_fnc_ACSingle;
					waituntil {alive _unit}; 
					[_unit,"Kill HVT",_preciseMarkers] call MCC_fnc_MWCreateTask; 
				};
					
				_unitPlaced = true; 
				
				//Lets spawn some body guards
				[[getpos _unit,30,0,2,_faction,str _side],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
			};
		};
	}
	else
	{
		//Open area
		[_objPos, random 360, (MCC_MWHVTCamps call BIS_fnc_selectRandom)] call MCC_fnc_objectMapper;
		_group = creategroup _side;
		
		if (_alive) then 	
		{
			//Hostage
			
			//Let's build the faction unit's array
			_unitsArray	= [_factionPlayer ,"soldier"] call MCC_fnc_makeUnitsArray;		
			_type = _unitsArray call BIS_fnc_selectRandom;	
			
			//Find an empry spot
			_spawnPos = _objPos findEmptyPosition [0,100,(_type select 0)];
			_unit = [_sidePlayer,_spawnPos,_type] call MCC_MWcreateHostage;
			
			//Start Briefings
			waituntil {alive _unit}; 
			[_unit,"Secure HVT",_preciseMarkers] call MCC_fnc_MWCreateTask; 
			
			//Static Patrol
			_walking = false; 
		}
		else
		{
			//HVT
			switch _side do	
				{
					case west: {_type =   MCC_MWHVT select 0};
					case east: {_type =   MCC_MWHVT select 1};
					case resistance:  {_type =   MCC_MWHVT select 2};
					default {_type =   MCC_MWHVT select 3};
				};
				
			//Find an empry spot
			_spawnPos = _objPos findEmptyPosition [0,100,_type];	
			
			//walking HVT?
			_walking = if (random 1 < 0.5) then {true} else {false}; 
			
			if (_walking) then
			{
				_unit = _group createUnit [_type ,_spawnPos,[],0.5,"NONE"];
			}
			else
			{
				_unit = [_spawnPos, _type, _sidePlayer,"",random 360] call MCC_fnc_ACSingle;
			};
			
			//Start Briefings
			waituntil {alive _unit}; 
			[_unit,"Kill HVT",_preciseMarkers] call MCC_fnc_MWCreateTask; 
		};
				
		//Lets spawn some body guards
		_unitsArray 	= [_faction ,"soldier"] call MCC_fnc_makeUnitsArray;		//Let's build the faction unit's array
				
		for [{_i=0},{_i<3},{_i=_i+1}] do 
		{
			_type = _unitsArray select round (random 4); 	
			_spawnPos = (getpos _unit) findEmptyPosition [0,100,(_type select 0)]; 
			_unit = _group createUnit [_type select 0,_spawnPos,[],0.5,"NONE"];
			waituntil {alive _unit}; 
		};
		
		_group setFormDir (round(random 360));
		
		if (_walking) then
		{
			[_group, _spawnPos, 150] call BIS_fnc_taskPatrol;
		}
		else
		{
			[_group, _spawnPos] call bis_fnc_taskDefend;
		};
	}; 