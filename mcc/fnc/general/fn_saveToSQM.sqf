//===================================================================MCC_fnc_saveToSQM=========================================================================================
// Save MCC's 3D editor placments in SQM file format and copy it to clipboard. 
// Example: [saveAll] call MCC_fnc_saveToSQM
// Params:
// 	saveAll:	Boolean, true -save all, false - save only MCC/Zeus objects
// Returns:
//     <Nothing>
//==============================================================================================================================================================================	
 private ["_arrayGroups","_triggersArray","_allItems","_simItems","_logicItems","_arrayVehicles","_mission","_br","_object","_side","_array","_pos","_count",
          "_seed","_newString","_finalString","_checkedGroups","_isKindofUnit","_saveAll"];
 
_saveAll = _this select 0;
_br = toString [0x0D, 0x0A];

_checkedGroups	= []; 
_arrayGroups 	= [];
_arrayVehicles 	= [];
_seed			= str (random 100000);

if (_saveAll) then
{
	_allItems		= allMissionObjects "All";
	_simItems		= allMissionObjects "WeaponHolderSimulated";
	_triggersArray 	= allMissionObjects "EmptyDetector";
	_logicItems		= allMissionObjects "logic";

	_allItems 		= _allItems - _simItems;
	_allItems 		= _allItems - _logicItems;
}
else
{
	_allItems		= curatorEditableObjects MCC_curator;
	_triggersArray 	= MCC_triggers;
};

//Sort the arrays
{
	if (((count units group _x) <=1) && !(_x getVariable ["mccIgnore",false])) then
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
			
			default 					  		{_arrayVehicles set [count _arrayVehicles, [_x,"EMPTY"]]};	//Others
		};
	}
	else
	{
		if (!(group _x in _checkedGroups) && !(_x getVariable ["mccIgnore",false]) && (alive _x)) then
		{
			_arrayGroups set [count _arrayGroups, [group _x,toupper (format ["%1",side _x])]];
			_checkedGroups set [count _checkedGroups, group _x]; 
		}
	};
} foreach _allItems;

_mission = "version=12;" + _br
		+ "class Mission" + _br
		+ "{" + _br
		+ "    addOns[] = {}; " + _br
		+ "    addOnsAuto[] = {}; " + _br 
		+ "    randomSeed = " + _seed + ";" + _br;
		
_mission = _mission 
+ 		  "    class Intel   " + _br 
+ 		  "    {             " + _br
+ format ["        resistanceWest=%1;", if (resistance getFriend west < 0.6) then {0} else {1}] + _br	
+ format ["        resistanceEast=%1;", if (resistance getFriend east < 0.6) then {0} else {1}] + _br
+ format ["        startWeather=%1;", overcast] + _br	
+ format ["        startFog=%1;", fog] + _br
+ format ["        startWind=%1;", windStr] + _br		
+ format ["        startWindDir=%1;", windDir] + _br	
+ format ["        startRain=%1;", rain] + _br	
+ format ["        startLightnings=%1;", lightnings] + _br
+ format ["        startWaves=%1;", waves] + _br	
+ format ["        startGust=%1;", gusts] + _br	
+ format ["        forecastWeather=%1;", overcast] + _br	
+ format ["        forecastWind=%1;", windStr] + _br
+ format ["        forecastWaves=%1;", waves] + _br	
+ 		  "        rainForced=1;" + _br
+ 		  "        lightningsForced=1;" + _br
+ 		  "        wavesForced=1;" + _br
+ 		  "        windForced=1;" + _br
+ format ["        year=%1;", Date select 0] + _br	
+ format ["        month=%1;", Date select 1] + _br
+ format ["        day=%1;", Date select 2] + _br	
+ format ["        hour=%1;", Date select 3] + _br	
+ format ["        minute=%1;", Date select 4] + _br
+ 		  "        startFogDecay=0.0049333;" + _br
+ 		  "        forecastFogDecay=0.0049333;" + _br	
+ 		  "    };           " + _br;



_mission = _mission		
		+ "    class Groups" + _br
		+ "    {" + _br
		+ format ["        items= %1;", count _arrayGroups] + _br;
 
//Groups
private ["_group","_groupCounter","_blackListVehicles","_refinedGroup"]; 
_count = 0;
_countID = 0;

if (count _arrayGroups > 0) then 
{
	{
		_group 	= _x select 0;
		_side 	= _x select 1;
		_blackListVehicles = []; 
		_refinedGroup = [];
		
		{
			_object = _x; 
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
				if (alive _object) then {_refinedGroup set [count _refinedGroup, _object]};
			};
		} foreach units _group; 
		
		_mission = _mission 
				 + format ["        class Item%1", _count] + _br
				 +         "        {" + _br
				 + format ["              side= ""%1"";", _side] + _br
				 +         "              class Vehicles" + _br
				 +         "              {" + _br
				 + format ["                   items=%1;", count _refinedGroup] + _br;
		
		_groupCounter = 0;
		{
			_object = _x; 
			_pos 	= getPos _object;
			
			
			
			_mission = _mission
						 + format ["                   class Item%1", _groupCounter] + _br
						 +         "                   {" + _br;
						 
			if (_object isKindOf "air" && ((getpos _object select 2)>10)) then
			{
				_mission = _mission			 
						 + 			"                      special=""FLY"";" + _br;
			};
						 
			_mission = _mission			 
						 + format ["                       position[]={%1,%3,%2};", _pos select 0, _pos select 1, _pos select 2] + _br
						 + format ["                       azimut=%1;", getDir _object] + _br
						 + format ["                       id=%1;", _countID] + _br
						 + format ["                       side= ""%1"";", _side] + _br
						 + format ["                       vehicle=""%1"";", typeof _object] + _br;
			
			if (count crew _object > 0) then
			{
				if (leader _group in crew _object) then 
				{
					_mission = _mission
							 +         "                       leader=1;" + _br;
							 
					if (count(group _object getvariable ["GAIA_ZONE_INTEND",[]])>0) then 
					{
						_newString = (_object getvariable ["vehicleinit",""]) + format [";group _this setVariable ['GAIA_ZONE_INTEND',%1];",group _object getvariable ["GAIA_ZONE_INTEND",[]]];
						_object setvariable ["vehicleinit",_newString];
					};
					
					if (group _object getvariable ["mcc_gaia_cache",false]) then 
					{
						_newString = (_object getvariable ["vehicleinit",""]) + "group _this setVariable ['mcc_gaia_cache',true];" ;
						_object setvariable ["vehicleinit",_newString];
					};
					
					if ((group _object getvariable ["MCC_GAIA_RESPAWN",0])>0) then 
					{
						_newString = (_object getvariable ["vehicleinit",""]) +  format [";group _this setVariable ['MCC_GAIA_RESPAWN',%1];",group _object getvariable ["MCC_GAIA_RESPAWN",0]];
						_object setvariable ["vehicleinit",_newString];
					};
				};
			}
			else
			{
				if (_object == leader _group) then 
				{
					_mission = _mission
							 +         "                       leader=1;" + _br;
							 
					if (count(_group getvariable ["GAIA_ZONE_INTEND",[]])>0) then 
					{
						_newString = (_object getvariable ["vehicleinit",""]) + format ["group _this setVariable ['GAIA_ZONE_INTEND',%1]",group _object getvariable ["GAIA_ZONE_INTEND",[]]];
						_object setvariable ["vehicleinit",_newString];
						player sidechat "string:" + _newString;
					};
					
					if (_group getvariable ["mcc_gaia_cache",false]) then 
					{
						_newString = (_object getvariable ["vehicleinit",""]) + "group _this setVariable ['mcc_gaia_cache',true]" ;
						_object setvariable ["vehicleinit",_newString];
					};
				};
			};
			
			if (locked _object == 2) then
			{
				_mission = _mission
							 +         "                      lock=""LOCKED"";" + _br;
			};
			
			_mission = _mission
						 + format ["                       rank=%1;",rank _object] + _br
						 + format ["                       skill=%1;",skill _object] + _br
						 + format ["                       health=%1;",1 - (damage _object)] + _br
						 + format ["                       fuel=%1;",fuel vehicle _object] + _br
						 + format ["                       offsetY=%1;", (getposATL _object) select 2] + _br;
						 
			if (!isnil {_object getvariable "vehicleinit"}) then 
			{
				//Set variable for sqm save
				_newString = [(_object getvariable "vehicleinit"), "_this", "this"] call MCC_fnc_replaceString;
				_finalString = [_newString, '"', "'"] call MCC_fnc_replaceString;
				
				_mission = _mission 
						+ format ["                       init=""%1"";", _finalString] + _br;
			};
			
			if (!isnil {_object getvariable "text"}) then 
			{
				_mission = _mission 
						+ format ["                       text=""%1"";", (_object getvariable "text")] + _br;
			};
			
			_mission = _mission 
						+         "                  };" + _br;
						
			_groupCounter = _groupCounter + 1;
			_countID = _countID + 1;
		} foreach _refinedGroup; 
				
		
		_mission = _mission                 
						+         "              };" + _br;
		
		
		private ["_wpCounter","_wp"];
		if ((count (waypoints _group) > 0) && (count (waypoints _group) > currentWaypoint _group)) then
		{
			_mission = _mission                 
						+         "     		 class Waypoints " + _br
						+         "     		     {            " + _br
						+  format ["     		         items=%1;",count (waypoints _group)] + _br;
			
			_wpCounter = 0;
			
			{
				_wp = _x;
				
				_mission = _mission
						+ format ["                   	class Item%1", _wpCounter] + _br
						+         "                   	{           " + _br
						+ format ["                       	position[]={%1,%3,%2};",(waypointPosition _wp) select 0, (waypointPosition _wp) select 1, (waypointPosition _wp) select 2] + _br
						+ format ["                       	type=""%1"";",waypointType _wp] + _br
						+ format ["                       	combatMode=""%1"";",waypointCombatMode _wp] + _br
						+ format ["                       	formation=""%1"";",waypointFormation  _wp] + _br
						+ format ["                       	speed=""%1"";",waypointSpeed _wp] + _br
						+ format ["                       	combat=""%1"";",waypointBehaviour _wp] + _br
						+         "                       	class Effects" + _br
						+         "                       	{" + _br
						+         "                       	};" + _br
						+ format ["                       	showWP=""%1"";",waypointShow _wp] + _br
						+         "                   	};           " + _br;
				_wpCounter = _wpCounter + 1; 
			} foreach (waypoints _group);
			
			_mission = _mission 
						+         "     		     };            " + _br;
		};
		
		_mission = _mission  
				 +         "         };" + _br;
				 
		_count = _count + 1;
	  
	} forEach _arrayGroups;

	_mission = _mission 
					+ "    };" + _br;
};

			
if ((count _arrayVehicles) > 0) then
{
	_mission = _mission 
				+ "    class Vehicles" + _br
				+ "    {" + _br
				+ format ["        items= %1;", count _arrayVehicles] + _br;
				
	_count = 0;

	{
		_object = _x select 0;
		_side 	= _x select 1;
		_pos = getPos _object;

		_mission = _mission 
				 + format ["        class Item%1", _count] + _br
				 +         "        {" + _br
				 + format ["             position[]={%1,%3,%2};", _pos select 0, _pos select 1, _pos select 2] + _br
				 + format ["             azimut=%1;", getDir _object] + _br
				 + format ["             id=%1;", _countID] + _br
				 + format ["             side= ""%1"";", _side] + _br
				 + format ["             vehicle=""%1"";", typeof _object] + _br
				 +         "             skill=0.6;" + _br
				 + format ["             offsetY=%1;", (getposATL _object) select 2] + _br;
				 
		if (!isnil {_object getvariable "vehicleinit"}) then 
		{
			_newString = [(_object getvariable "vehicleinit"), "_this", "this"] call MCC_fnc_replaceString;
			_finalString = [_newString, '"', "'"] call MCC_fnc_replaceString;
			
			_mission = _mission 
				 + format ["             init=""%1"";",_finalString] + _br;
		};
		
		if (!isnil {_object getvariable "text"}) then 
		{
			_mission = _mission 
				+ format ["              text=""%1"";", (_object getvariable "text")] + _br;
		};
			
		_mission = _mission 
				+         "        };" + _br;
		
		_count = _count + 1;
		_countID = _countID +1;
	  
	} forEach _arrayVehicles;

	_mission = _mission 
				+ "    };" + _br;

};

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

_mission = _mission 
		+ "};" + _br
		+ "class Intro {" + _br
		+ "    addOns[] = {}; " + _br
		+ "    addOnsAuto[] = {}; " + _br 
		+ "    randomSeed = " + _seed + ";" + _br
		+ "    class Intel {}; " + _br
		+ "};" + _br
		+ "class OutroWin {" + _br
		+ "    addOns[] = {}; " + _br
		+ "    addOnsAuto[] = {}; " + _br 
		+ "    randomSeed = " + _seed + ";" + _br
		+ "    class Intel {}; " + _br 
		+ "};" + _br
		+ "class OutroLoose {" + _br
		+ "    addOns[] = {}; " + _br
		+ "    addOnsAuto[] = {}; " + _br 
		+ "    randomSeed = " + _seed + ";" + _br
		+ "    class Intel {}; " + _br
		+ "};" + _br;
				  
copyToClipboard _mission;
player sidechat "Objects saved to clipboard as sqm file";
    
