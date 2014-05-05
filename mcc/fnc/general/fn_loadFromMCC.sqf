//===================================================================MCC_fnc_loadFromMCC=========================================================================================
// Load MCC's placments to a variable
// Example: [] call MCC_fnc_loadFromMCC
// Params:
// 	MCC_output
// Returns:
//     <Nothing>
//==============================================================================================================================================================================	
 private ["_arrayGroups","_arrayVehicles","_objectData","_side","_array","_pos","_newString","_finalString","_isKindofUnit","_vehicle","_unitData",
          "_allCuratorObjectives","_class","_group","_indecator","_tempArray","_arrayWeather","_arrayTime"];

 _input 				= _this;
_allCuratorObjectives 	= _input select 0;
_arrayGroups 			= _input select 1;
_arrayVehicles 			= _input select 2;
_arrayWeather 			= _input select 3;
_arrayTime 				= _input select 4;


//Groups
if (count _arrayGroups > 0) then 
{
	{		
		_indecator 	= _x; 

		_side 		= _indecator select 0;
		
		switch (toLower _side) do	
			{
				case "west": {_side =  west};
				case "east": {_side =  east};
				case "guer": {_side =  resistance};
				case "civ": {_side =  civilian};
			};
			
		_group 		= createGroup _side;

		{
			_objectData = _x; 
			
			if ((_objectData select 0) isKindOf "CAManBase") then
			{
				_vehicle = _group createUnit [_objectData select 0, _objectData select 1, [], 0 ,_objectData select 10];
				MCC_curator addCuratorEditableObjects [[_vehicle],false];				
			}
			else
			{
				if (((_objectData select 0) isKindOf "Air") && (((_objectData select 1) select 2) < 5)) then
				{
					_vehicle = createvehicle [(_objectData select 0),(_objectData select 1),[],0,"none"]; 
					_crew = [_vehicle, _group] call BIS_fnc_spawnCrew;
					MCC_curator addCuratorEditableObjects [[_vehicle],false];
				}
				else
				{
					_vehicle = ([(_objectData select 1), (_objectData select 2),(_objectData select 0), _group] call bis_fnc_spawnvehicle) select 0;
					MCC_curator addCuratorEditableObjects [[_vehicle],true];
				};
			};
			
			//TempArray [class, pos, dir, rank, skill, damage, fuel, init,leader, locked,  fly];
			
			_vehicle setpos (_objectData select 1);
			_vehicle setDir (_objectData select 2);
			_vehicle setRank (_objectData select 3);
			_vehicle setSkill (_objectData select 4);
			_vehicle setdamage (_objectData select 5);
			_vehicle setfuel (_objectData select 6);
			
			if (_objectData select 7 != "") then
			{
				_vehicle setVariable ["vehicleinit",(_objectData select 7),true]; 
				[[[netID _vehicle,_vehicle], _objectData select 7], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
			};
			
			if (_objectData select 8) then
			{
				_group selectLeader _vehicle;
			};
			
			if (_objectData select 9) then
			{
				_vehicle lock 2;
			};
		} foreach (_indecator select 2); 
		

		private ["_wp","_newWP","_wayPoints","_variables"];
		
		if (count _indecator > 3) then
		{
			_wayPoints = _indecator select 3;
			{
				_wp = _x;
				
				_newWP = _group addWaypoint [_wp select 0, 30,_foreachIndex];
				_newWP setwaypointCombatMode (_wp select 1);
				_newWP setwaypointFormation (_wp select 2);
				_newWP setwaypointSpeed (_wp select 3);
				_newWP setwaypointBehaviour (_wp select 4);
				_newWP setwaypointType (_wp select 5);
			} foreach _wayPoints;
		};
		
		_variables = _indecator select 1;
		if (count _variables > 0) then
		{
			if (count (_indecator select 1) > 0) then
			{
				_variables = _indecator select 1;
				{				
					_group setVariable [(_x select 0),(_x select 1),true]
				} foreach _variables; 
			};
		};
	} forEach _arrayGroups;
};
 

if ((count _arrayVehicles) > 0) then
{
	{
		_objectData = _x;
		_side 	= _objectData select 0;
		_class	= _objectData select 1;
		_pos	= _objectData select 2;
		_group = createGroup sidelogic;
		
		if (tolower _side == "empty") then
		{
			_vehicle = createvehicle [_class,_pos,[],0,"none"]; 
		}
		else
		{
			_vehicle = _group createUnit [_class, _pos, [], 0, "NONE"];
		};	 
		
		MCC_curator addCuratorEditableObjects [[_vehicle],false];
		_vehicle setpos _pos;
		_vehicle setDir (_objectData select 3);
		
		if (_objectData select 4 != "") then
		{
			_vehicle setVariable ["vehicleinit",(_objectData select 4),true]; 
			[[[netID _vehicle,_vehicle], (_objectData select 4)], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
		};
		
	} forEach _arrayVehicles;
}; 
 
if ((count _allCuratorObjectives) > 0) then
{
	
	{ 
		private ["_sector","_areas","_size","_trigger","_attachedUnit"]; 
		_objectData = _x;
		_pos = _objectData select 1;
		_class = _objectData select 0; 
		_side = [_objectData select 3, "CIV", "civilian"] call MCC_fnc_replaceString;
		_side = [_side, "GUER", "resistance"] call MCC_fnc_replaceString; 
		_group = createGroup sidelogic;
				
		switch (true) do
		{
			case (_class in ["ModuleObjectiveAttackDefend_F","ModuleObjectiveSector_F"]): 
			{
				_vehicle =  _group createunit [_class, _pos,[],0.5,"NONE"]; 
				_vehicle setvariable ["name", _objectData select 2];
				
				if (_class == "ModuleObjectiveAttackDefend_F") then 
				{
					_vehicle setvariable ["RscAttributeOwners2", call compile _side];
				}
				else
				{
					_vehicle setvariable ["RscAttributeOwners", call compile _side];
				};
				
				_vehicle setvariable ["updated",true];
				sleep 1; 
				
				//--- Set desired size
				_size = _objectData select 4;
				_sector = _vehicle getvariable ["sector",objnull];
				_areas = _sector getvariable ["areas",[]];
				if (count _areas > 0) then 
				{
					_trigger = _areas select 0;
					_trigger settriggerarea [_size,_size,0,false];
					_trigger setvariable ["pos",[0,0,0],true];
					_sector setvariable ["size",_size,true];
				};
				_vehicle setvariable ["updated",false];
			};
			
			case ("ModuleObjective_F"): 
			{
				_attachedUnit = _objectData select 2;
				if (typeName (_attachedUnit) == "STRING" ) then {while {isnil _attachedUnit} do {sleep 0.2}};

				_vehicle =  _group createunit ["ModuleObjective_F", _pos,[],0.5,"NONE"]; 
				_vehicle setvariable ["RscAttributeOwners",call compile _side]; 
				if (typeName _attachedUnit == "STRING" ) then {_vehicle setvariable ["bis_fnc_curatorAttachObject_object",call compile _attachedUnit]};
				
				_vehicle setvariable ["RscAttributeTaskState",_objectData select 4];
				_vehicle setvariable ["RscAttributeTaskDestination",_objectData select 5];
				[_vehicle,"RscAttributeTaskDescription",_objectData select 6] call bis_fnc_setServerVariable;
			};
			
			case (_class in ["ModuleObjectiveGetIn_F","ModuleObjectiveMove_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F"]): 
			{
				_attachedUnit = _objectData select 2;
				if (typeName (_attachedUnit) == "STRING" ) then {while {isnil _attachedUnit} do {sleep 0.2}};

				_vehicle =  _group createunit [_class, _pos,[],0.5,"NONE"]; 
				_vehicle setvariable ["RscAttributeOwners",call compile _side]; 
				if (typeName _attachedUnit == "STRING" ) then {_vehicle setvariable ["bis_fnc_curatorAttachObject_object",call compile _attachedUnit]};
				[_vehicle,"RscAttributeTaskDescription",_objectData select 4] call bis_fnc_setServerVariable;
			};
		};
		
		MCC_curator addCuratorEditableObjects [[_vehicle],false]; 
		_vehicle setvariable ["updated",true];
		
	} foreach _allCuratorObjectives;
};


//Weather
MCC_Overcast 	= _arrayWeather select 0;
MCC_WindForce 	= _arrayWeather select 1;
MCC_Waves 		= _arrayWeather select 2;
MCC_Rain 		= _arrayWeather select 3;
MCC_Lightnings	= _arrayWeather select 4;
MCC_Fog 		= _arrayWeather select 5;

publicVariable "MCC_Overcast";
publicVariable "MCC_WindForce";
publicVariable "MCC_Waves";
publicVariable "MCC_Rain";
publicVariable "MCC_Lightnings";
publicVariable "MCC_Fog";

[[[MCC_Overcast,MCC_WindForce,MCC_Waves,MCC_Rain,MCC_Lightnings,MCC_Fog]],"MCC_fnc_setWeather",true,false] spawn BIS_fnc_MP;

//Time
MCC_date = [_arrayTime select 0, _arrayTime select 1, _arrayTime select 2, _arrayTime select 3, _arrayTime select 4];
publicVariable "MCC_date";
[[MCC_date],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;

//Mission Name
private "_name";
_name = _arrayTime select 5;
missionnamespace setvariable ["bis_fnc_moduleMissionName_name",_name];
publicvariable "bis_fnc_moduleMissionName_name";
[true,"bis_fnc_moduleMissionName"] call bis_fnc_mp;


    


