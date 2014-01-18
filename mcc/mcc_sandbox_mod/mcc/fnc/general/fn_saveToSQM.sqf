//===================================================================MCC_fnc_saveToSQM=========================================================================================
// Save MCC's 3D editor placments in SQM file format and copy it to clipboard. 
// Example: [] call MCC_fnc_saveToSQM
// Params:
// 	<Nothing>
// Returns:
//     <Nothing>
//==============================================================================================================================================================================	
 private ["_arrayGroups","_arrayVehicles","_mission","_br","_object","_side","_array","_pos","_count","_seed"];
    
_br = toString [0x0D, 0x0A];

_arrayGroups 	= [];
_arrayVehicles 	= [];
_seed			= str (random 100000);
//Sort the arrays
{
	if (typeName _x == "ARRAY") then	//Vehicle
	{
		_arrayGroups set [count _arrayGroups, [_x select 0,toupper (format ["%1",side (_x select 0)])]];
	}
	else
	{
		switch (true) do
		{
			case (_x isKindOf "CAManBase")     : {_arrayGroups set [count _arrayGroups, [_x,toupper (format ["%1",side _x])]]};	//Man
			case (_x isKindOf "animal")  : {_arrayVehicles set [count _arrayVehicles, [_x,"AMBIENT LIFE"]]};	//Animal
			default 					   {_arrayVehicles set [count _arrayVehicles, [_x,"EMPTY"]]};	//Others
		};
	};
} foreach MCC_lastSpawn; 

_mission = "version=12;" + _br
		+ "class Mission" + _br
		+ "{" + _br
		+ "    addOns[] = {}; " + _br
		+ "    addOnsAuto[] = {}; " + _br 
		+ "    randomSeed = " + _seed + ";" + _br
		+ "    class Intel {}; " + _br 
		+ "    class Groups" + _br
		+ "    {" + _br
		+ format ["        items= %1;", count _arrayGroups] + _br;
 
//Groups
_count = 0;
{
	_object = _x select 0;
	_side 	= _x select 1;
	_pos = getPos _object;

	_mission = _mission 
			 + format ["        class Item%1", _count] + _br
			 +         "        {" + _br
			 + format ["              side= ""%1"";", _side] + _br
			 +         "              class Vehicles" + _br
			 +         "              {" + _br
			 +         "                   items=1;" + _br
			 +         "                   class Item0" + _br
			 +         "                   {" + _br
			 + format ["                       position[]={%1,%3,%2};", _pos select 0, _pos select 1, _pos select 2] + _br
			 + format ["                       azimut=%1;", getDir _object] + _br
			 + format ["                       id=%1;", _count] + _br
			 + format ["                       side= ""%1"";", _side] + _br
			 + format ["                       vehicle=""%1"";", typeof _object] + _br
			 +         "                       leader=1;" + _br
			 +         "                       skill=0.6;" + _br
			 + format ["                       offsetY=%1;", (getposATL _object) select 2] + _br;
			 
	if (!isnil {_object getvariable "vehicleinit"}) then 
	{
		_mission = _mission 
           	 + format ["                       init=%1;", str (_object getvariable "vehicleinit")] + _br;
	};
	
	_mission = _mission 
           	+         "                  };" + _br;
	
	_mission = _mission                 
			 +         "              };" + _br
			 +         "         };" + _br;

	_count = _count + 1;
  
} forEach _arrayGroups;

_mission = _mission 
		    + "    };" + _br
            + "    class Vehicles" + _br
		    + "    {" + _br
		    + format ["        items= %1;", count _arrayVehicles] + _br;
 //Vehicles
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
			 + format ["             id=%1;", _count] + _br
			 + format ["             side= ""%1"";", _side] + _br
			 + format ["             vehicle=""%1"";", typeof _object] + _br
			 +         "             skill=0.6;" + _br
			 + format ["             offsetY=%1;", (getposATL _object) select 2] + _br;
			 
	if (!isnil {_object getvariable "vehicleinit"}) then 
	{
	_mission = _mission 
           	 + format ["             init=""%1"";", _object getvariable "vehicleinit"] + _br;
	};
	
	_mission = _mission 
           	+         "          };" + _br;
	
	_count = _count + 1
  
} forEach _arrayVehicles;

_mission = _mission 
		+ "    };" + _br
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
    
