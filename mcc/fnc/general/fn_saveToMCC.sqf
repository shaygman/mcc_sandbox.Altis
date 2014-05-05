//===================================================================MCC_fnc_saveToMCC=========================================================================================
// Save MCC's placments to a variable
// Example: [] call MCC_fnc_saveToMCC
// Params:
// 	<Nothing>
// Returns:
//     <Nothing>
//==============================================================================================================================================================================	
 private ["_arrayGroups","_triggersArray","_allItems","_arrayVehicles","_object","_side","_array","_pos","_newString","_finalString","_checkedGroups","_isKindofUnit","_allGroupsOutput",
		  "_curatorObjectives","_allCuratorObjectives","_logics","_init"];
 
_checkedGroups	= []; 
_arrayGroups 	= [];
_arrayVehicles 	= [];

_allItems		= curatorEditableObjects MCC_curator;
_triggersArray 	= MCC_triggers;
_allGroupsOutput = []; 
_allVehiclesOutput = [];
MCC_output = ""; 
_logics = allMissionObjects "logic"; 

//Curator objectives
_curatorObjectives = [];
{
	if (typeOf _x in ["ModuleObjectiveAttackDefend_F","ModuleObjectiveSector_F","ModuleObjective_F","ModuleObjectiveGetIn_F","ModuleObjectiveMove_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F"]) then
	{
		_curatorObjectives set [count _curatorObjectives, _x]; 
	};
} foreach _logics; 

_logics = _logics - _curatorObjectives;

//Sort the arrays
{
	if ((((count units group _x) <=1) || (_x in _logics))&& !(_x getVariable ["mccIgnore",false])) then
	{
		_isKindofUnit = if ((_x isKindOf "CAManBase") || (_x isKindOf "car") || (_x isKindOf "tank") || (_x isKindOf "air") || (_x isKindOf "StaticWeapon") || (_x isKindOf "ship")) then {true} else {false};
		
		switch (true) do
		{
			case (_isKindofUnit)     	: 
			{
				if ((((count units group _x) ==1) || (_x isKindOf "CAManBase")) && !(group _x in _checkedGroups)) then
				{
					_arrayGroups set [count _arrayGroups, [group _x,toupper (format ["%1",side _x])]];
					_checkedGroups set [count _checkedGroups, group _x]; 
				}
				else
				{
					if !(_x isKindOf "CAManBase") then {_arrayVehicles set [count _arrayVehicles, [_x,"EMPTY"]]};
				};
			};	
			
			//Animal
			case (_x isKindOf "animal")  		: 
			{
				if !(typeOf _x in ["Snake_random_F","Rabbit_F"]) then 
				{
					_arrayVehicles set [count _arrayVehicles, [_x,"AMBIENT LIFE"]];
				};
			};
			
			//Logic
			case (_x in _logics)  		: 
			{
				_arrayVehicles set [count _arrayVehicles, [_x,"LOGIC"]];
			};
			
			//Others
			default 
			{
				if !(typeOf _x in ["ModuleObjectiveAttackDefend_F","ModuleObjectiveSector_F","ModuleObjective_F","ModuleObjectiveGetIn_F","ModuleObjectiveMove_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F"]) then
				{
					_arrayVehicles set [count _arrayVehicles, [_x,"EMPTY"]];
				};
			};	
		};
	}
	else
	{
		if (!(group _x in _checkedGroups) && !(_x getVariable ["mccIgnore",false]) && (alive _x) && !(typeOf _x in ["ModuleObjectiveAttackDefend_F","ModuleObjectiveSector_F","ModuleObjective_F","ModuleObjectiveGetIn_F","ModuleObjectiveMove_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F"])) then
		{
			_arrayGroups set [count _arrayGroups, [group _x,toupper (format ["%1",side _x])]];
			_checkedGroups set [count _checkedGroups, group _x]; 
		}
	};
} foreach _allItems;


//Objectives
MCC_output = MCC_output + "[[";

if (count _curatorObjectives > 0) then
{
	private ["_attachedUnitInit","_attachedUnit","_newName","_class"];
	_allCuratorObjectives = [];
	_tempArray =[];
	
	{
		_class = typeOf _x;
		
		if (_class in ["ModuleObjective_F","ModuleObjectiveGetIn_F","ModuleObjectiveMove_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F"]) then
		{
			_attachedUnit = _x getvariable ["bis_fnc_curatorAttachObject_object",objnull];
				
				if (!isnull _attachedUnit) then
				{
					_attachedUnitInit = _attachedUnit getvariable ["vehicleinit",""]; 
					_newName = format ["MCC_objectUnits_%1", ["MCC_objectUnitsCounter",1] call bis_fnc_counter];
					_init = format [";%1 = _this;", _newName];
					_attachedUnit setVariable ["vehicleinit",_attachedUnitInit + _init]; 
				}
				else
				{
					_newName = -1; 
				};
		};
		
		switch (true) do
		{
			case (_class in ["ModuleObjectiveAttackDefend_F"]): 
			{
				_tempArray = ["ModuleObjectiveAttackDefend_F",getpos _x, _x getVariable ["name",""],str (_x getvariable ["RscAttributeOwners2",[[],[]]]), ((_x getvariable "sector") getvariable "size")];
			};
			
			case (_class in ["ModuleObjectiveSector_F"]): 
			{
				_tempArray = ["ModuleObjectiveSector_F",getpos _x, _x getVariable ["name",""],str (_x getvariable ["RscAttributeOwners",[]]), ((_x getvariable "sector") getvariable "size")];
			};
			
			case (_class in ["ModuleObjective_F"]): 
			{
				_tempArray = ["ModuleObjective_F", getpos _x, _newName, str (_x getvariable ["RscAttributeOwners",[]]) ,_x getvariable ["RscAttributeTaskState","created"], _x getvariable ["RscAttributeTaskDestination",0],[_x,"RscAttributeTaskDescription",["","", ""]] call bis_fnc_getServerVariable];
			};
			
			case (_class in ["ModuleObjectiveGetIn_F","ModuleObjectiveMove_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F"]): 
			{
				_tempArray = [_class, getpos _x,_newName, str (_x getvariable ["RscAttributeOwners",[]]),[_x,"RscAttributeTaskDescription",["","", ""]] call bis_fnc_getServerVariable];
			};
		};
		
		MCC_output = MCC_output + format ["%1",_tempArray];
		
		if (_foreachIndex < (count _curatorObjectives)-1) then
		{
			MCC_output = MCC_output + ",";
		};
	} foreach _curatorObjectives;
};

MCC_output = MCC_output + "],[";

//Groups
private ["_group","_blackListVehicles","_refinedGroup","_tempArray","_groupArrayGeneral","_groupArrayUnits"]; 

{
	_group 	= _x select 0;
	_side 	= _x select 1;
	if (!isnil "_group" && !isnull _group) then 
	{
		_groupArrayGeneral = [_side, [["GAIA_ZONE_INTEND",_group getVariable ["GAIA_ZONE_INTEND",[]]],["mcc_gaia_cache", _group getVariable ["mcc_gaia_cache",false]],["MCC_GAIA_RESPAWN", _group getVariable ["MCC_GAIA_RESPAWN",0]]]]; 
		_blackListVehicles = []; 
		_refinedGroup = [];
		
		
		
		{
			_object = _x; 
			if !(isplayer _object) then
			{
				if ((vehicle _object != _object) && (alive vehicle _object))  then
				{
					if !(vehicle _object in _blackListVehicles) then
					{
						_refinedGroup set [count _refinedGroup, vehicle _object];
						_blackListVehicles set [count _blackListVehicles, vehicle _object];
					};
				}
				else
				{
					if (alive _object && !(_object in _blackListVehicles)) then {_refinedGroup set [count _refinedGroup, _object]};
				};
			};
		} foreach units _group; 
		
		//TempArray [class, pos, dir, rank, skill, damage, fuel, init,leader, locked,  fly];
		_groupArrayUnits = [];
		{
			_object = _x; 
			_pos 	= getPos _object;
			_tempArray = [typeof _object, _pos, getDir _object, rank _object,skill _object, damage _object, fuel vehicle _object,_object getvariable ["vehicleinit",""]];

			if (count crew _object > 0) then
			{
				if (leader _group in crew _object) then 
				{
					_tempArray set [count _tempArray, true]; 
				}
				else
				{
					_tempArray set [count _tempArray, false]; 
				};
			}
			else
			{
				if (_object == leader _group) then 
				{
					_tempArray set [count _tempArray, true]; 
				}
				else
				{
					_tempArray set [count _tempArray, false]; 
				};
			};
			
			if (locked _object == 2) then
			{
				_tempArray set [count _tempArray, true]; 
			}
			else
			{
				_tempArray set [count _tempArray, false]; 
			};
						 
			
			if (_object isKindOf "air" && ((getpos _object select 2)>10)) then
			{
				_tempArray set [count _tempArray, "FLY"];
			}
			else
			{
				_tempArray set [count _tempArray, "NONE"];
			};
						
			_groupArrayUnits set [count _groupArrayUnits, _tempArray];
		} foreach _refinedGroup; 
		
		_groupArrayGeneral set [count _groupArrayGeneral, _groupArrayUnits];
		
		private ["_wpArray","_wp"];
		if ((count (waypoints _group) > 0) && (count (waypoints _group) > currentWaypoint _group)) then
		{
			_wpArray = [];

			{
				_wp = _x;
				
				_wpArray set [count _wpArray ,[waypointPosition _wp, waypointCombatMode _wp, waypointFormation  _wp, waypointSpeed _wp, waypointBehaviour _wp, waypointType _wp]]; 
			} foreach (waypoints _group);
			
			_groupArrayGeneral set [count _groupArrayGeneral, _wpArray];
		};
		
		_allGroupsOutput set [count _allGroupsOutput, _groupArrayGeneral];
		MCC_output = MCC_output + format ["%1",_groupArrayGeneral];
		
		if (_foreachIndex < (count _arrayGroups)-1) then
		{
			MCC_output = MCC_output + ",";
		};
	};
} forEach _arrayGroups;

MCC_output = MCC_output 
	+ "],[";



if ((count _arrayVehicles) > 0) then
{
	{
		_object = _x select 0;
		_side 	= _x select 1;
		_pos 	= getPos _object;
		_type 	= typeof _object;
		_init 	= _object getvariable ["vehicleinit",""];
		
		if (!isnil "_type") then
		{
			_tempArray = [_side, _type, _pos, getDir _object, _init];
			MCC_output = MCC_output + format ["%1",_tempArray];
		};
		
		if (_foreachIndex < (count _arrayVehicles)-1) then
		{
			MCC_output = MCC_output + ",";
		};
	  
	} forEach _arrayVehicles;
};

MCC_output = MCC_output + "]";

//Save Weather
MCC_output = MCC_output + ",";
_tempArray = [overcast, windStr, waves, rain, lightnings, fog];
MCC_output = MCC_output + format ["%1",_tempArray];

//Save Time
MCC_output = MCC_output + ",";
_tempArray = [Date select 0, Date select 1, Date select 2, Date select 3, Date select 4, missionnamespace getvariable ["bis_fnc_moduleMissionName_name",""]];
MCC_output = MCC_output + format ["%1",_tempArray];
			
//End File
MCC_output = MCC_output + "];";	


copyToClipboard MCC_output;
player sidechat "Objects saved";

MCC_output
/*			


if (count _triggersArray >0) then
{
	_mission = _mission 
				+ 		  "    class Sensors   " + _br 
				+ 		  "    {             " + _br
				+ format ["        items= %1;", count _triggersArray] + _br;
	
	
	_count = 0;

	{
		_object = if (_saveAll) then {_x} else {_x select 1};
		_pos = getPos _object;
		_newString = (triggerStatements _object);
		_mission = _mission 
				+ format ["        class Item%1", _count] + _br
				+         "        {" + _br
				+ format ["             position[]={%1,%3,%2};", _pos select 0, _pos select 1, _pos select 2] + _br
				+ format ["             a=%1;", (triggerArea  _object) select 0] + _br
				+ format ["             b=%1;", (triggerArea  _object) select 1] + _br
				+ format ["             angle=%1;", (triggerArea  _object) select 2] + _br
				+ format ["             rectangular=%1;",if ((triggerArea  _object) select 3) then {1} else {0}] + _br
				+ format ["             activationBy=""%1"";",((triggerActivation _object) select 0)] + _br
				+ format ["             timeoutMin=%1;",((triggerTimeout _object) select 0)] + _br
				+ format ["             timeoutMid=%1;",((triggerTimeout _object) select 1)] + _br
				+ format ["             timeoutMax=%1;",((triggerTimeout _object) select 2)] + _br
				+ format ["             type=""%1"";",((triggerActivation _object) select 1)] + _br
				+         "             age=""UNKNOWN"";" + _br
				+ format ["             text=""%1"";", triggerText _object] + _br
				+ format ["             expCond=""%1"";", [_newString select 0, '"', "'"] call MCC_fnc_replaceString] + _br
				+ format ["             expActiv=""%1"";", [_newString select 1, '"', "'"] call MCC_fnc_replaceString] + _br
				+ format ["             expDesactiv=""%1"";",[_newString select 2, '"', "'"] call MCC_fnc_replaceString] + _br;
				 
			 
		if (!isnil {_object getvariable "text"}) then 
		{
			_mission = _mission 
				+ format ["             name=""%1"";", (_object getvariable "text")] + _br;
		};
			
		_mission = _mission 
				+         "             class Effects" + _br
				+         "             {" + _br
				+         "             };" + _br
				+         "        };" + _br;
		
		_count = _count + 1;
 
	} forEach _triggersArray;
	
	_mission = _mission 
				+ 		  "    };             " + _br
};

if (count allMapMarkers > 0) then
{		
	private ["_marker","_markerCounter"]; 
	
	_markerCounter = 0;
	_mission = _mission                 
					+         "     		 class Markers" + _br
					+         "     		     {            " + _br
					+  format ["     		         items=%1;",count allMapMarkers] + _br;
					
	{
		_marker = _x;

		_mission = _mission
					+ format ["                   	  class Item%1", _markerCounter] + _br
					+         "                   	  {           " + _br
					+ format ["                       	  position[]={%1,%3,%2};",(markerPos _marker) select 0, (markerPos _marker) select 1, (markerPos _marker) select 2] + _br
					+ format ["                       	  name=""%1"";",_marker] + _br
					+ format ["                       	  text=""%1"";",markerText _marker] + _br
					+ format ["                       	  markerType=""%1"";",markerShape _marker] + _br
					+ format ["                       	  type=""%1"";",markerType  _marker] + _br
					+ format ["                       	  colorName=""%1"";",markerColor   _marker] + _br
					+ format ["                       	  a=%1;",(markerSize _marker) select 0] + _br
					+ format ["                       	  b=%1;",(markerSize _marker) select 1] + _br
					+ format ["                       	  angle=%1;",markerDir  _marker] + _br
					+         "                   	  };" + _br;
				
		_markerCounter = _markerCounter + 1; 
	} foreach allMapMarkers;
	
	_mission = _mission 
					+         "					};" + _br;
};



	
				  

    
