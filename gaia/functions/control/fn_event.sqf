private [];

_faction 						= "";
_NearestEnemyGroups = [];
_IsNight						= (((selectBestPlaces [position (player),2, "night", 1, 1]) select 0 select 1)>0.8);
_pos								= [];
_min								=  600;
_max								= 1200;
_grp				        = [] ;
_spawnGrp						= grpNull;
a= "";
b = [];

//What is the closest group of bad dude relative to the player?
_NearestEnemyGroups = [ allgroups
											, []
											,{leader _x distance player}
											,"ASCEND"
											,{(alive leader _X) and ((((side player) getFriend side _x)<0.6)) and (leader _x iskindof "man")}
											]call BIS_fnc_sortBy;
b = _NearestEnemyGroups;
//Did we find any enemy?

if (count(_NearestEnemyGroups)>0) then
 {
 	// I gues we rather hold events that are of the same faction we have nearby instead of total random
 	_faction = faction leader(_NearestEnemyGroups select 0);
 	_side		 = side leader(_NearestEnemyGroups select 0);
 	// Can be a water pos
 	_pos = [getPos player, _min, _max, 30, 1, 20, 0] call BIS_fnc_findSafePos;
 	rrr=_pos;
 	//Did we get the world centerpos? Fuck it....
 	//"soldier", "car", "motorcycle", "tank", "helicopter", "airplane", "ship"
 	_simu="";
 	if (
 			!((  (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")) distance _pos)==0)
 			and
 			!([_pos,_min] call GAIA_fnc_isNearPlayer)
 			and
 			(_pos distance player)> _min
 		 )
  then
 	{
 		if (surfaceIsWater _pos) then
 		{
 			
 			_simu = [["helicopter", "airplane", "ship"],[0.3,0.3,1]] call BIS_fnc_selectRandomWeighted; 			
 		}
 		else
 		{
 			
 			_simu = [["soldier", "car", "motorcycle", "tank", "helicopter", "airplane" ],[1,0.3,0.2,0.1,0.05,0.05]] call BIS_fnc_selectRandomWeighted;
 		};
		
		
		
		if (_simu == "soldier") then 
		{
			// Love the x simulation
			_unitarray= [_faction ,_simu,"men"] call MCC_fnc_makeUnitsArray;
			_unitarray = _unitarray + ( [_faction ,_simu+"x","men"] call MCC_fnc_makeUnitsArray);
			
			_amount = (floor random 5);
			_dude   = [];
			for [{_i=0}, {_i <  _amount}, {_i=_i+1}] do
			{
				_dude = _unitarray select (floor random (count _unitarray));
				_grp = _grp + [ (_dude  select 0)];
				fff= _grp;
				ggg= _dude;
				
			};
			_spawnGrp = [_pos, _side, _grp] call BIS_fnc_spawnGroup;
		}
		else
		{
				// Love the x simulation
			_unitarray= [_faction ,_simu] call MCC_fnc_makeUnitsArray;
			_unitarray = _unitarray + ( [_faction ,_simu+"x"] call MCC_fnc_makeUnitsArray);
			
			_dude = _unitarray select (floor random (count _unitarray));
			
			
			ggg= _dude;
			
			_spawnGrp = ([_pos, 200, (_dude  select 0), _side] call bis_fnc_spawnvehicle) select 2;
		};
		ccc= _simu;
		//hint format["%1 %2 %3", _pos, _side, _grp];
	 
	 zzz=_spawnGrp;
	 
	 if (count (units _spawnGrp)>0) then 
	 {
	 	
	
    ppp=[];
    
	 	[_spawnGrp, _pos, 200]call BIS_fnc_taskPatrol;
	 	ppp=_pos;
	 };
 		
 		
 		
 	};
 };




