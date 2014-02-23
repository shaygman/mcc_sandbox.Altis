/*  Select a random position from an area defined by a marker.
    In		: [marker, goal]
    Out		: [position]
    
    By Spirit, 7-1-2014
    
*/

private 
["_area"
,"_blist"
,"_pos"
,"_iswater"
,"_found"
,"_fPos"
,"_goal"
,"_minimum"
,"_best_effort"
];

_area  				= _this select 0;
_goal  				= _this select 1;
_side					= _this select 2;
//_blist 				= if (count _this > 2) then {_this select 2} else {[]};
_pos 					= [];
_fpos 				= [];
_best_effort 	= [];




_shape = _area call fnc_getMarkerShape;


// STart with the highest cost ever, before we know the cost (so we dont stop)
_minimum   	= 10000;
_best 			= -1000;

// Limited loop so the script won't get stuck
// Also the minimum is set in the formula (later), so we go to maximum 50 tries to the best shot or if we beat our miminum.
for [{_i = 0}, {((_i<50) and (_best<_minimum))or (_i<10)}, {_i = _i + 1}] do 

{
	// Rectangle or Ellipse marker given?
	// Get a position from the found shaped marker

	if (_shape in ["SQUARE","RECTANGLE"]) then 

		{
				 _pos = _area call fnc_getPosFromRectangle;
		}

		else 
		{
	      _pos = _area call fnc_getPosFromEllipse;				
		};
		
		_SRange = 90;
		
		//Scan the terrain
		_topArr = [_pos,1] call fnc_ScanTerrain;

		// Return the values of terrain
		_sUrban 	= _topArr select 0;
		_sForest 	= _topArr select 1;
		_sHills 	= _topArr select 2;
		_sFlat 		= _topArr select 3;
		_sSea 		= _topArr select 4;
		_sGr 			= _topArr select 5;

		//Make them comparable
		_sUrban 	= round (_sUrban*100);
		_sForest 	= round (_sForest*100);
		_sHills 	= round (_sHills*100);
		_sFlat 		= round (_sFlat*100);
		_sSea 		= round (_sSea*100);
		_sGr 			= round _sGr;
		_sRoads 	= count (_pos nearRoads _SRange);
		

		//Calculate on formula's if this is a suitable 
		switch (_goal) do
			{
			case ("INF_URBAN_ROADS") 					: {_minimum=040;_found =_sUrban 	+ _sRoads 	- _sForest		- _sSea 		- _sHills		-	_sFlat;};			
			case ("INF_HILLS_FLAT_FOREST") 		: {_minimum=030;_found =_sHills		+ _sFlat 		+ _sForest 		- _sRoads		-	_sSea			- _sUrban;};			
			case ("INF_URBAN_FOREST")					: {_minimum=020;_found =_sUrban 	+ _sForest	- _sFlat 			-	_sSea 		- _sHills		-	_sRoads;};			
			case ("VEH_HILLS_ROAD_FLAT")		 	: {_minimum=060;_found =_sHills  	+ _sRoads		- _sSea 			- _sForest	- _sUrban		+	_sFlat;};			
			case ("VEH_HILLS_FOREST_FLAT")		: {_minimum=050;_found =_sHills  	- _sRoads		- _sSea 			+ _sForest	- _sUrban		+	_sFlat;};				
			case ("VEH_URBAN_FOREST") 				: {_minimum=020;_found =_sForest 	- _sRoads		- _sSea 			-	_sHills		+ _sUrban		-	_sFlat;};			
			case ("ARM_HILLS_FLAT")					 	: {_minimum=020;_found =_sHills  	- _sRoads		- _sSea 			- _sForest	- _sUrban		+	_sFlat;};			
			case ("ARM_FOREST") 							: {_minimum=005;_found =_sForest 	- _sRoads		- _sSea 			-	_sHills		- _sUrban		-	_sFlat;};			
			case ("AIR")										 	: {_minimum=000;_found =_sUrban 	+ _sRoads 	+ _sForest		+ _sSea 		+ _sHills		+	_sFlat;};	
			case ("FOREST")										: {_minimum=005;_found =_sForest 	- _sUrban		- _sFlat 			-	_sSea 		- _sHills		-	_sRoads;};			
			case ("HILLS")										: {_minimum=005;_found =_sHills 	- _sUrban		- _sFlat 			-	_sSea 		- _sForest	-	_sRoads;};			
			case ("URBAN")										: {_minimum=005;_found =_sUrban		-	_sHills		- _sFlat 			-	_sSea 		- _sForest	-	_sRoads;};			
			case ("FLAT")											: {_minimum=005;_found =_sFlat   	- _sUrban		- _sHills 		-	_sSea 		- _sForest	-	_sRoads;};			
			case ("ROAD") 										: {_minimum=010;_found =_sRoads;};						
			case ("WATER") 										: {_minimum=100;_found =_sSea - _sUrban - _sForest - _sFlat;};			
			};	
		//final checks
		//If we are road depending then make sure we are ON road (good is not good enough).
		if ((_goal == "VEH_HILLS_ROAD_FLAT" or _goal == "ROAD")and (_found>_best )) then 
		{
			_roadlist = _pos nearRoads 60;
			if (count(_roadlist)>0) then
				{_pos = position (_roadlist select 0);_found=_minimum;  }		
		};	

		//Non road depending check
		if (!isonroad _pos) then
		{ 
			if ((_goal == "VEH_HILLS_ROAD_FLAT" or _goal == "VEH_HILLS_FOREST_FLAT" or _goal == "ARM_HILLS_FLAT" ) and (_found>_best ) ) then 
				//Make sure the vehicle actualy fits (NOT within 3 meter of objects)
				{
						//Maybe Findsafepos fails, so remember the old one
						//Also somehow Findsafepos comes with absurd out of map positions, so guard it to check if in Area.
						_oldpos 	 = _pos;
						_pos = [_pos, 0,40, 12, 0, 60 * (pi / 180), 0]call BIS_fnc_findSafePos; 
						if (count(_pos)==0 or !([_pos,_side] call fnc_isBlacklisted)) then
							{_pos = _oldpos};
				};
		};	
		
		//if ((_goal != "AIR" AND _goal != "WATER") and (surfaceiswater _pos )) then
			//This wont be good for land dudes, so ignore this one
		//		{_found= -10000;};
		//Since we basicly take "best chance" its good to check the most important one, water.		
		if ( (surfaceiswater _pos) and _goal!="WATER" and _goal!="AIR") then
			//This wont be good for land dudes, so ignore this one
			{_found= -10000;};
		if ((_goal == "WATER") and !(surfaceiswater _pos )  ) then
			//If we look for water, then dry surface wont do it
			{_found= -10000;};
			
		
		//If we have blacklist and the found pos is better then the best so far then....
		if (_found>_best ) then 
		{
		//If we find nothing in the end, then forget about blacklist. 
		_best_effort = _pos;
	  // Check each blacklist marker
	  if ([_pos,_side] call fnc_isBlacklisted) exitwith 
				{
		  		_found= -10000;
				};	  
		};
		
		
		//If we make it up here then this position is actualy the best we got so far. 
		if (_found>_best ) then
	   	{
				_best = _found;
				_Fpos = _pos;			
			};		

};

//We failed? Go back to best effort (be advised, it may still be empty!)
if (count(_fPos) == 0) then
	{_fPos = _best_effort;};


// Return position
_Fpos