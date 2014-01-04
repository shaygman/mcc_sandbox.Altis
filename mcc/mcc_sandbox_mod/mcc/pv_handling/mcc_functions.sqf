//=============================================================================Functions=========================================================================
//======================================================BIS AdvHints function=========================================================================================================
// BIS AdvHints function.  Create a filling waiting bar 
// Example: _footer = [_min,_max] call BIS_AdvHints_createCountdownLine; 
// _min = integer, minimum value.
// _max = integer, maximum value.
//========================================================================================================================================================================================
BIS_AdvHints_createCountdownLine =		
{
	private ["_elapsed","_max","_line","_char","_i","_segments","_segmentsElapsed","_segmentsRemaining"];
	
	_elapsed = _this select 0;

	if (count(_this) > 1) then {
		_max = _this select 1;
	};	
	if isNil("_max") then {
		_max = 10;
	};

	//number of countdown segments
	_segments = 20;

	_segmentsElapsed = round(_elapsed/_max * _segments);
	_segmentsRemaining = _segments - _segmentsElapsed;

	if (_segmentsElapsed > _segments) then {
		_segmentsElapsed = _segments;
		_segmentsRemaining = 0;
	};
	
	_char = "|";
	
	_line = "<t color='#818960'>";

	for "_i" from 1 to _segmentsElapsed do 
	{
		_line = _line + _char;
	};
	_line = _line + "</t>";
	
	if (_segmentsRemaining > 0) then {
		_line = _line + "<t color='#000000'>";
		for "_i" from 1 to _segmentsRemaining do 
		{
			_line = _line + _char;
		};
		_line = _line + "</t>";
	};
	_line
};
//==================================================================IedFakeExplosion===============================================================================================
// Create a fake explosion, explosion dimiter will be decided by the _trapvolume
// Example: [_pos,_trapvolume] spawn IedFakeExplosion; 
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//=================================================================================================================================================================================
IedFakeExplosion = 	
	{
		private ["_pos", "_volume"];
		_pos = _this select 0;
		_volume = _this select 1; 
		switch (_volume) do
		{
		   case "small":	
			{ 
			   "SmallSecondary" createVehicle _pos;
			};
			
			case "medium":	
			{ 
			   "SmallSecondary" createVehicle _pos;
			};
			
			case "large":	
			{ 
			   "ShellBase" createVehicle _pos;
			};
		};
	};
//==================================================================IedDeadlyExplosion===============================================================================================
// Create a deadly explosion, explosion dimiter will be decided by the _trapvolume
// Example: [_pos,_trapvolume] spawn IedDeadlyExplosion; 
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//=================================================================================================================================================================================
IedDeadlyExplosion = 
	{
		private ["_pos", "_volume"];
		_pos = _this select 0;
		_volume = _this select 1; 
		switch (_volume) do
		{
		   case "small":	
			{ 
			   "SmallSecondary" createVehicle _pos;
			};
			
			case "medium":	
			{ 
			   "HelicopterExploSmall" createVehicle _pos;
			};
			
			case "large":	
			{ 
			   "HelicopterExploBig" createVehicle _pos;
			};
		};
	};
//==================================================================IedDisablingExplosion===============================================================================================
// Create a disabling explosion, explosion dimiter will be decided by the _trapvolume
//Disabling explosion will disable vehicles without harming the troops inside or  it will incapitate infantry
// Example: [_pos,_trapvolume] spawn IedDisablingExplosion; 
// _pos = position, center of the explosion.
// _trapvolume = string, "small", "medium", "large"
//==================================================================================================================================================================================
IedDisablingExplosion = 
	{
		private ["_pos", "_volume","_hitRadius","_killRadius","_targetUnits","_random","_shell"];
		_pos 	= _this select 0;
		_volume = _this select 1; 
		_random	= 0;
		switch (_volume) do
		{
		   case "small":	
			{ 
			   "SmallSecondary" createVehicle _pos;
			   _hitRadius 	= 20;
			   _killRadius	= 10;
			};
			
			case "medium":	
			{ 
			   "SmallSecondary" createVehicle _pos;
			    _hitRadius = 30;
				_killRadius	= 20;
			};
			
			case "large":	
			{ 
			   "SmallSecondary" createVehicle _pos;
			   _hitRadius = 50;
			   _killRadius	= 30;
			};
		};
		
		_targetUnits = _pos nearObjects _hitRadius;
		{
		_random = random 10;
		if(_x isKindOf "Man") then	{
			if (((_x distance _pos) < _killRadius) && (_random > 1))then	{
				if (ACEIsEnabled) then {[_x,0.65,true,10] call ace_w_setunitdam} else {_x setHit ["legs", 0.9];_x setdamage 0.7};		
				} else	{
						if (ACEIsEnabled) then {[_x,0.3,false,1] call ace_w_setunitdam} else {_x setdamage 0.4};
					}
		};
		
		if(_x isKindOf "Car") then
			{
				if (((_x distance _pos) < _killRadius) && (_random > 1))then	{
					_x setVariable ["ace_sys_vehicledamage_enable", false];					
					_x setdamage 0.7;
					[[2,compile format ["vehicle %1  setHit ['wheel_1_1_steering', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['wheel_2_1_steering', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['motor', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['glass1', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['glass2', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['glass3', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['glass4', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['glass5', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					[[2,compile format ["vehicle %1  setHit ['glass6', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					//[-2, {[_this,5,time,false,true] spawn BIS_Effects_Burn}, _x] call CBA_fnc_globalExecute;
				} else	{
							_x setVariable ["ace_sys_vehicledamage_enable", false];
							_x setdamage 0.4;
							[[2,compile format ["vehicle %1 setHit ['wheel_1_1_steering', 0.7]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['wheel_2_1_steering', 0.7]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['motor', 0.7]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['glass1', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['glass2', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['glass3', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['glass4', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['glass5', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
							[[2,compile format ["vehicle %1 setHit ['glass6', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						}
			};
				
		if(_x isKindOf "Tank") then
			{
				if (((_x distance _pos) < _killRadius) && (_random > 1))then	{
						_x setVariable ["ace_sys_vehicledamage_enable", false];					
						_x setdamage 0.7;
						[[2,compile format ["vehicle %1 setHit ['Ltrack', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						[[2,compile format ["vehicle %1 setHit ['Rtrack', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						[[2,compile format ["vehicle %1 setHit ['motor', 1]", _x]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						//[-2, {[_this,5,time,false,true] spawn BIS_Effects_Burn}, _x] call CBA_fnc_globalExecute;
					};
			};
		} forEach _targetUnits;
	};
//==================================================================MCC_fnc_drawLine===============================================================================================
// Draw a line on the map localy between two points
// Example: [MCC_pointA,MCC_pointB,MCC_IEDLineCount] call MCC_fnc_drawLine; 
// MCC_pointA = position, start position of the line
// MCC_pointB = position, end position of the line
// MCC_IEDLineCount = integer, uniq number, can't have two markers with the same number
//==================================================================================================================================================================================
MCC_fnc_drawLine = 
		{
		private ["_start", "_end", "_marker","_dist","_dir","_center","_lineMarkerName"];
		_start = _this select 0;
		_end = _this select 1;
		_marker = _this select 2;
		_lineMarkerName = format ["line_%1", _marker];
		_dist = _start distance _end;
		_dir = ((_end select 0) - (_start select 0)) atan2
		((_end select 1) - (_start select 1));

		_center = [(_start select 0) + ((sin _dir) * _dist / 2),
		(_start select 1) + ((cos _dir) * _dist / 2)];
		
		createMarkerLocal [_lineMarkerName, _center];
		_lineMarkerName setMarkerShapeLocal "RECTANGLE";
		_lineMarkerName setMarkerSizeLocal [0.5, _dist / 2];
		_lineMarkerName setMarkerColorLocal "ColorBlack";
		_lineMarkerName setMarkerDirLocal _dir;
		};
//==================================================================MCC_fnc_drawArrow===============================================================================================
// Draw an arrow on the map localy between two points
// Example: [MCC_pointA,MCC_pointB,arrowMarkerName,arrowType, arrowWidth,arrowColor,maxDist] call MCC_fnc_drawLine; 
// MCC_pointA = Position, start position of the line
// MCC_pointB = Position, end position of the line
// arrowMarkerName = Integer, uniq number, can't have two markers with the same number
//arrowType = String, type of arrow
//arrowWidth = Integer, width of the arrow
//arrowColor = String, arrow color
//maxDist = Integer, maximum marker distance. 
//Returns : marker name
//==================================================================================================================================================================================
MCC_fnc_drawArrow = 
		{
		private ["_start", "_end", "_marker","_dist","_dir","_center","_arrowType","_arrowWidth","_arrowColor","_arrowMarkerName","_maxDist"];
		_start 		= _this select 0;
		_end 		= _this select 1;
		_marker 	= _this select 2;
		_arrowType 	= _this select 3;
		_arrowWidth = _this select 4;
		_arrowColor = _this select 5;
		_maxDist	= _this select 6;
		
		_arrowMarkerName = format ["mccarrow_%1", _marker];
		
		_dist = _start distance _end;
		if (_dist>_maxDist) then {_dist = _maxDist};			//Max distance
		
		_dir = ((_end select 0) - (_start select 0)) atan2
		((_end select 1) - (_start select 1));

		_center = [(_start select 0) + ((sin _dir) * _dist / 2),
		(_start select 1) + ((cos _dir) * _dist / 2)];
		
		createMarkerLocal [_arrowMarkerName, _center];
		_arrowMarkerName setMarkerShapeLocal "RECTANGLE";
		_arrowMarkerName setMarkerType _arrowType;
		_arrowMarkerName setMarkerSizeLocal [_arrowWidth, _dist / 2];
		_arrowMarkerName setMarkerColorLocal _arrowColor;
		_arrowMarkerName setMarkerDirLocal _dir;
		_arrowMarkerName;
		};
//==================================================================FNC_MOBILE_RESPAWN===============================================================================================
// will move the respawn marker to the current position of the unit while the unit is alive, if the unit dead will move the marker to the prvious location
// Example:[_dummy, _respawnMarker, _respawnStart"] call FNC_MOBILE_RESPAWN; 
// _dummy = unit, the unit players will spawn in it. 
// _respawnMarker = string "RESPAWN_WEST", "RESPAWN_EAST", "RESPAWN_GUERRILA"
// _respawnStart = position, the default respawn point if the mobile one is destroyed.
//==================================================================================================================================================================================
FNC_MOBILE_RESPAWN = {
						private ["_dummy", "_respawnMarker", "_respawnStart","_safePos"];
						_dummy = _this select 0;
						_respawnMarker = _this select 1;
						_respawnStart = _this select 2;
						while {(Alive _dummy)} do
							{
								_safePos = [(getPos _dummy),1,10,1,0,900,0] call BIS_fnc_findSafePos;
								sleep 1;
								_respawnMarker setMarkerPos _safePos;
							};
						_respawnMarker setMarkerPos _respawnStart;
					};
//==================================================================FNC_BUILDING_POS_COUNT===============================================================================================
// return the ammount of indexed positions in a building
// Example:_buildingPos = _building call FNC_BUILDING_POS_COUNT;
// _building = building, the building to check for positions. 
// _buildingPos = integer, the ammount of indexed positions
//==================================================================================================================================================================================
FNC_BUILDING_POS_COUNT ={
							private ["_x"];
							_x = 0;
							while { format ["%1", _this buildingPos _x] != "[0,0,0]" } do	{_x = _x + 1};
							_x
						};
//==================================================================FNC_MAKE_UNITS_ARRAY===============================================================================================
// returns a unit array consist of all the units from the given function and simulation in format [_cfgclass,_vehicleDisplayName]
// Example:_unitsArray	= [_faction ,_sim, class] call FNC_MAKE_UNITS_ARRAY;
// faction = string, the faction to search in: "CIV" , "USMC", "INS", "CDF", "RU", "GUE" exc
// _sim = string, simulation type: "soldier", "car", "motorcycle", "tank", "helicopter", "airplane", "ship", "parachute"
// class = string, class type "men","car","ship","sumarine"
//==================================================================================================================================================================================
FNC_MAKE_UNITS_ARRAY =	{
						private ["_CfgVehicles","_i","_CfgVehicle","_simulation","_simTypesUnits","_idx","_faction",
						"_vehicleDisplayName","_cfgclass","_cfgFaction","_unitsArray","_vehicleClass","_vehicleClassUnit"];
						
						_faction			= (toLower(_this select 0));
						_simTypesUnits		= (toLower(_this select 1));
						_vehicleClassUnit 	= (toLower(_this select 2));
						_idx      			= 0;
						_CfgVehicles 		= configFile >> "CfgVehicles" ;
						_unitsArray			=[];
						
						for "_i" from 1 to (count _CfgVehicles - 1) do {
							_CfgVehicle = _CfgVehicles select _i;
							//Keep going when it is a public entry
							if (getNumber(_CfgVehicle >> "scope") == 2) then {
								_vehicleDisplayName 	= getText(_CfgVehicle >> "displayname");
								_vehicleDisplayName		= [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];
								_cfgclass 				= (configName (_CfgVehicle));  
								_cfgFaction 			= getText(_CfgVehicle >> "faction");
								_simulation 			= getText(_CfgVehicle >> "simulation");
								_vehicleClass			= getText(_CfgVehicle >> "vehicleClass");
								  
								if (toLower(_cfgFaction) == _faction) then {
									if (toLower(_simulation)== _simTypesUnits) then {
										if (toLower (_vehicleClass) == _vehicleClassUnit) then	{
											_unitsArray set[_idx,[_cfgclass,_vehicleDisplayName]];									
											_idx = _idx + 1;
											};
										};
								};
							};
						};
						_unitsArray
						};				
//==================================================================MCC_CreateAmmoDrop===============================================================================================
// drop an object from a plane and attach paracute to it, thanks to BIS
// Example:[_planepos, _spawnkind, _pilot] spawn MCC_CreateAmmoDrop;
// _planepos = position,  plane position
// _spawnkind = string, vehiclecClass to drop
// _pilot = plane's pilot
//==================================================================================================================================================================================
	MCC_CreateAmmoDrop=
			{
				private ["_pos","_spawnkind","_pilot","_para", "_drop","_dir","_sleep","_smoke"];
				_pos = _this select 0;
				_spawnkind = _this select 1;
				_pilot = _this select 2;
				_para = "ParachuteMediumWest" createVehicle [_pos select 0,_pos select 1,3000];
				_para setpos [_pos select 0,_pos select 1,(_pos select 2) -10];
				_drop = _spawnkind createVehicle [_pos select 0,_pos select 1,3000];
				_drop setdir random 360; 
				_para setdir random 360; 
				sleep 0.03;
				
				_drop attachTo [_para, [0,0,1]];
				_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
				sleep 0.03;

				// For some reason, this command is not always performing as it suppose to, therefore, we repeat it to make sure. (network lag?)
				_drop attachTo [_para, [0,0,1]];
				_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
				sleep 0.03;

				_drop attachTo [_para, [0,0,1]];
				_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
				sleep (0.05 + random 0.2);
				
				// If the Drop hits the ground, recreate it over ground
				_sleep = 0;
				while {((getpos _drop select 2) > 0.02) && _sleep < 180} do {sleep 0.5; _sleep = _sleep +1};	//Failsafe if stuck in the air
				_pos = position _drop;
				_dir = direction _para;
				detach _drop;
				deletevehicle _drop;
				_drop = _spawnkind createVehicle _pos;
				_drop setdir _dir;
				_drop setPos [_pos select 0, _pos select 1,0];
				_smoke = "SmokeShellBlue" createVehicle (getpos _drop);			//Mark the drop with smoke
			};

//==================================================================MCC_CBU===============================================================================================
// drop a bomb that explode to some skeets with paracute the explode to some kind of CBU
// Example: [_bomb, CBU_type] spawn MCC_CBU;
// _bomb = position,  bomb position
// CBU_type = string, MCC_CBU_MINES, MCC_CBU_WP, MCC_CBU_CS
//==================================================================================================================================================================================			
	MCC_CBU = 
		{
			private ["_bomb","_split", "_vel", "_x","_y","_type"];
			_bomb = _this select 0;
			_type = CBU_type;
			_vel = velocity _bomb;
			for [{_x = 1},{_x <= 4},{_x = _x+1}] do 
				{
					sleep 0.5;
					_para = "ParachuteC" createVehicle [getpos _bomb select 0,getpos _bomb select 1,3000];		//Make the bomb and the parachute
					_para setpos [getpos _bomb select 0,getpos _bomb select 1,(getpos _bomb select 2) -10];
					_skeet = "Barrel4" createvehicle [getpos _bomb select 0,getpos _bomb select 1,3000]; 
						for [{_y = 1},{_y <= 3},{_y = _y+1}] do 
								{
									_skeet attachTo [_para, [0,0,0]];
									_para setVelocity [(_vel select 0)/2, (_vel select 1)/2,(_vel select 2)/2];
									sleep 0.02;
								};
					[_skeet, _para] spawn _type;
				};
			_split = "HelicopterExploBig" createvehicle getpos _bomb; 
			deletevehicle _bomb;
		};
	
	MCC_CBU_EXPLOSION =
		{
			private ["_skeet","_para", "_split","_pos","_x"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 20},{_x = _x+1}] do 
				{
					sleep 0.1;
					_skeet = "g_30mm_he" createvehicle _pos; 
					_skeet setVelocity [30-(random 60),30-(random 60),-(random 30)]; 
				};
		};
	
	MCC_CBU_MINES =
		{
			private ["_skeet","_para", "_split","_pos","_x","_mine"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 20},{_x = _x+1}] do 
				{
					sleep 0.1;
					_mine = "Mine" createvehicle [(_pos select 0)+100-(random 200),(_pos select 1)+100-(random 200),0]; 
				};
		};
	
	MCC_CBU_WP =
		{
			private ["_skeet","_para", "_split","_pos","_x","_mine"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 10},{_x = _x+1}] do 
				{
					sleep 0.1;
					_skeet = "ACE_M34" createvehicle _pos; 
					_skeet setVelocity [30-(random 60),30-(random 60),-(random 30)]; 
				};
		};
	
	MCC_CBU_CS =
		{
			private ["_skeet","_para", "_split","_pos","_x","_mine"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 10},{_x = _x+1}] do 
				{
					sleep 0.1;
					_skeet = "ACE_M7A3" createvehicle _pos; 
					_skeet setVelocity [30-(random 60),30-(random 60),-(random 30)]; 
				};
		};
		
//==================================================================MCC_SADARM===============================================================================================
// drop a bomb that explode to some skeets that will search and destroy near by armor
// Example: [_planepos, _pilot] spawn MCC_SADARM;
// _planepos = position,  plane position
// _pilot = unit, plane's pilot
//===========================================================================================================================================================================
	MCC_SADARM = 
		{
			private ["_pos","_pilot","_para","_bomb","_split", "_targets", "_targetpos", "_x"];
			_pos = _this select 0;
			_pilot = _this select 1;
			
			_para = "ParachuteC" createVehicle [_pos select 0,_pos select 1,3000];		//Make the bomb and the parachute
			_para setpos [_pos select 0,_pos select 1,(_pos select 2) -10];
			_bomb = "CruiseMissile1" createvehicle [_pos select 0,_pos select 1,3000]; 
			for [{_x = 1},{_x <= 3},{_x = _x+1}] do 
				{
					_bomb attachTo [_para, [0,0,0]];
					_para setVelocity [((velocity vehicle _pilot) select 0)/2, ((velocity vehicle _pilot) select 1)/2,((velocity vehicle _pilot) select 2)/2];
					sleep 0.02;
				};
				
			WaitUntil{(getpos _bomb select 2) < 150};
			_targets = nearestObjects [getpos _bomb ,["Car","Tank"],200];	//Find targets: cars or tanks
			_targetpos = [];
			{_targetpos = _targetpos + [getPos _x]} forEach _targets;
			while{count _targetpos <= 6} do 								//If no targets make random pos
				{
					_targetpos = _targetpos + [[(getpos _bomb select 0)+100-(random 200), (getpos _bomb select 1)+100-(random 200), 0]];
				};
			
			WaitUntil{(getpos _bomb select 2) < 100};						//Make the Skeets
			_split = "HelicopterExploSmall" createvehicle getpos _bomb;	
			deletevehicle _bomb;
			deletevehicle _para;
			for [{_x = 0},{_x <= 6},{_x = _x+1}] do 
				{
				_bomb = "ARTY_SADARM_PROJO" createvehicle (_targetpos select _x);
				sleep 0.2;
				};
		};

//==================================================================MCC_CREATE_PLANE===============================================================================================
// create a flying plane from the given type and return the plane , pilot and group.
// Example: _plane,_pilotGroup,_pilot = [_planeType,  _spawn, _pos, _flyHight, _captive] call MCC_CREATE_PLANE;
// _planeType = string, vehicleClassName of the plane
// _spawn = position, position to spawn the plane
// _pos = position, waypoint for the plane
// _flyHight = integer, the fly hight for the plane
// _captive = boolean, true - to set the plane captive, false - for not. 
//===========================================================================================================================================================================			
	MCC_CREATE_PLANE =
		{
			private ["_i","_planeType", "_spawn", "_pos", "_flyHight", "_captive", "_pilotType","_pilotGroup",
					 "_turrets", "_heading", "_entry","_path","_unit","_plane","_side","_planeArray","_safepos"];
			
			_planeType = _this select 0;
			_spawn = _this select 1;
			_pos = _this select 2;
			_flyHight = _this select 3; //integer e.g. 100
			_captive = _this select 4; //true or false
			_heading = 180;

			_heading = [_spawn, _pos] call BIS_fnc_dirTo; //flying start direction
			if ( _heading < 0 ) then { _heading = (_heading + 360); };

			_side =  getNumber (configFile >> "CfgVehicles" >> _planeType >> "side");
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

			if (IsNil "_flyHight") then { _flyHight = 300; };
			_safepos     =[_spawn ,1,100,2,1,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
			_planeArray = [[_safepos select 0,_safepos select 1, _flyHight], _heading, _planeType, _side] call bis_fnc_spawnvehicle;
			
			_plane = _planeArray select 0;
			
			_plane flyInHeight _flyHight;
						
			if (IsNil "_captive") then { _captive = false; };
			_plane setcaptive _captive;
			
			// set marker on map
			[_plane, "B_AIR", _planeType, "ColorBlack", 99] execVM MCC_path + "mcc\general_scripts\cas\cas_marker.sqf";
			
			sleep 0.3;
			_plane
		};

//==================================================================MCC_DELETE_PLANE===============================================================================================
// set a plane to move to a location and delete it once it come closer then 800 meters 
// Example: [_pilotGroup, _pilot, _plane, _away] call MCC_DELETE_PLANE;
// _pilotGroup = group, the plane's pilot group
// _pilot = unit, the plane's pilot
// _plane = unit, the plane
// _away = position, waypoint for the plane
//===========================================================================================================================================================================						
	MCC_DELETE_PLANE =
		{
			private ["_pilotGroup", "_pilot", "_plane", "_away", "_flyInHeight", "_x"];
			
			_pilotGroup = _this select 0;
			_pilot = _this select 1;
			_plane = _this select 2;
			_away = _this select 3;
			_flyInHeight = _this select 4;
									
			{ deleteWaypoint _x; } foreach waypoints (group _plane);
			_plane setfuel 0.1;
			_pilotGroup setSpeedMode "FULL";
			_pilotGroup setCombatMode "BLUE";
			_pilotGroup setBehaviour "CARELESS";
			_plane disableAI "AUTOTARGET";
			if (IsNil "_flyInHeight") then { _flyInHeight = 300; };
			_plane flyInHeight _flyInHeight;
			
			if (isnil "_away") then {_away = [100,100,100]};
			_pilotGroup move _away;
			_pilot domove _away;
			
			// If plane is far away enough delete it			
			waituntil {sleep 1;((_plane distance _away) < 800) || (!alive _plane);};

			if (alive _plane) then {
				{deleteVehicle _x} forEach crew _plane + [_plane];
			};
		};
//==================================================================MCC_COUNT_GROUP===============================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group
// Example: [_group1] call MCC_COUNT_GROUP;
// _group1 = group, the group name
//===========================================================================================================================================================================	
	MCC_COUNT_GROUP =
		{
			private ["_group","_infantryCount","_vehicleCount","_tankCount","_airCount","_shipCount","_tempVehicles"];
			
			_group 			= _this select 0; 
			_infantryCount 	= 0;
			_vehicleCount	= 0;
			_tankCount		= 0;
			_airCount		= 0;
			_shipCount		= 0;
			_tempVehicles	= [];
			
			if (! isnil "_group") then {
				{
					if ((vehicle _x) != _x) then {
						if (!((vehicle _x) in _tempVehicles)) then {
							_tempVehicles set [count _tempVehicles, vehicle _x];
							if ((vehicle _x) iskindof "Car") then {_vehicleCount = _vehicleCount + 1};
							if ((vehicle _x) iskindof "Tank") then {_tankCount = _tankCount + 1};
							if ((vehicle _x) iskindof "Air") then {_airCount = _airCount + 1};
							if ((vehicle _x) iskindof "Boat") then {_shipCount = _shipCount + 1};
							};
						} else	{
							_infantryCount = _infantryCount + 1; 
							};
				} foreach units _group; 
				
				[_infantryCount,_vehicleCount,_tankCount,_airCount,_shipCount];
			};
		};
		
//==================================================================MCC_ARTY_BOMB===============================================================================================
// Create artillery strike with sounds on given spot
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_BOMB;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================	
MCC_ARTY_BOMB = 					//Regular bombs
	{
		private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i"];
		_pos					 = _this select 0; 
		_shelltype 			     = _this select 1; 
		_shellspread			 = _this select 2; 
		_nshell 				 = _this select 3; 
		_sound 					 = _this select 4; 
		
		for [{_i=0},{_i<_nshell},{_i=_i+1}] do
			{
				_shell = _shelltype createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), 100];
				_shell setVelocity [0, 0, -50];
				WaitUntil{(position _shell select 2)<35};
				if (_sound) then {[[[netid _shell,_shell],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
				sleep 4;
			};
	};
//==================================================================MCC_ARTY_BOMB_ALPHA===============================================================================================
// Create artillery strike with sounds on given spot
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_BOMB;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================	
MCC_ARTY_BOMB_ALPHA = 					//Regular bombs
	{
		private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i","_bomb","_bombpos"];
		_pos					 = _this select 0; 
		_shelltype 			     = _this select 1; 
		_shellspread			 = _this select 2; 
		_nshell 				 = _this select 3; 
		_sound 					 = _this select 4; 
		
		for [{_i=0},{_i<_nshell},{_i=_i+1}] do
			{
				_bomb = "GrenadeHand" createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), 100];
				WaitUntil{(position _bomb select 2)<35}; 
				if (_sound) then {[[[netid _bomb,_bomb],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
				WaitUntil{(position _bomb select 2)<3}; 
				_bombpos = position _bomb;
				deletevehicle _bomb;
				_shell = _shelltype createVehicle [(_bombpos select 0) ,(_bombpos select 1), (_bombpos select 2)];
				sleep 2;
			};
	};
//==================================================================MCC_ARTY_FLARE===============================================================================================
// Create artillery strike with sounds on given spot
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_FLARE;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================	
MCC_ARTY_FLARE = 					//Flares
	{
		private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i","_bomb","_bombpos"];
		_pos					 = _this select 0; 
		_shelltype 			     = _this select 1; 
		_shellspread			 = _this select 2; 
		_nshell 				 = _this select 3; 
		_sound 					 = _this select 4; 
		
		for [{_i=0},{_i<_nshell},{_i=_i+1}] do
			{
				_bomb = "GrenadeHand" createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), 300];
				WaitUntil{(position _bomb select 2)<250};
				if (_sound) then {[[[netid _bomb,_bomb],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
				WaitUntil{(position _bomb select 2)<220};
				_bombpos = position _bomb;
				deletevehicle _bomb;
				_bomb = "HelicopterExploSmall" createVehicle _bombpos;
				_shell = _shelltype createVehicle [_bombpos select 0,_bombpos select 1,(_bombpos select 2)+50];
				_shell setVelocity [(random 10) - (random 10), (random 10) - (random 10), -10];
				sleep 10;
			};
	};
//==================================================================MCC_ARTY_DPICM===============================================================================================
// Create DPICM artillery barage
// Example: [_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_DPICM;
// _pos = position. Point of impact
//_shelltype = string. Ammuination class name
//_shellspread = integer. Spread radius.
// _nshell = integer. Number of shells per burst
// _sound = boolean, True - for impact wistle sound
//===========================================================================================================================================================================			
MCC_ARTY_DPICM =
	{
		private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell", "_shell", "_i","_burst","_bombpos","_j","_disp","_hgt","_tr"];
		_pos					 = _this select 0; 
		_shelltype 			     = _this select 1; 
		_shellspread			 = _this select 2; 
		_nshell 				 = _this select 3; 
		_sound 					 = _this select 4; 
		_hgt = 200;
		
		for [{_i=0},{_i<_nshell},{_i=_i+1}] do
			{
				_shell = _shelltype createVehicle [(_pos select 0) + _shellspread - 2*(random _shellspread) ,(_pos select 1) + _shellspread - 2*(random _shellspread), _hgt];
				sleep 2; 
				if (_sound) then {[[[netid _shell,_shell],format["bon_Shell_In_v0%1",[1,2,3,4,5,6,7] select round random 6]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP}; 
				WaitUntil{(position _shell select 2)<100};
				_bombpos = getpos _shell;
				_burst = "HelicopterExploSmall" createVehicle _bombpos;
					sleep (0 + random 0.1);
				for "_j" from 1 to round 15 do
					{
					_disp = 40;
					_clusterb = "Mo_cluster_AP" createVehicle [(_bombpos select 0),(_bombpos select 1),(_bombpos select 2) + ((random 1) - (random 1))];
					_clusterb setVelocity [(random _disp) - (random _disp), (random _disp) - (random _disp), -50];
					
					/*
					_tr = "#particlesource" createVehicle getpos _clusterb;
					_tr setParticleRandom [0.2, [0.1, 0.1, 0.1], [0.1, 0.1, 0.1], 0.1, 0.2, [0, 0, 0, 0], 0.01, 0.01];
					_col = [[1,1,1,0.4], [1,1,1,0]];
					_tr setParticleParams [["A3\data_f\ParticleEffects\Universal\smoke.p3d", 16, 7, 48,1],"", "Billboard", 1, 4, [0, 0, 0],[0,0,0], 0.3, 1, 0.8, 0.75, [0.4],_col,[1],0.1,0.1,"","",_clusterb,random 360];    
					_tr setdropinterval 0.004; 
					
					_tr spawn {_tr = _this;sleep (1 + (random 0.5)); deletevehicle _tr};
					*/
					sleep (0.05 + random 0.05);
					};
			};
	};
	
//===================
// code borrowed from ace_sys_eject and modified for mcc
// usage: [] spawn MCC_SHOW_ALTIMETER;
// only work during parajump
MCC_SHOW_ALTIMETER = 
{	
	#define __dsp (uiNamespace getVariable "ACE_Altimeter_Halo_mcc")
	#define __ctrl_alt (__dsp displayCtrl 135)
	#define __ctrl_compass (__dsp displayCtrl 136)
	#define __ctrl_descent (__dsp displayCtrl 137)

	private ["_height","_descent"];

	2222 cutRsc ["ACE_Altimeter_Halo_mcc","PLAIN", 0];

	while { (alive player) && (ctrlShown __ctrl_alt) && (((getPosATL player) select 2) > 150) } do 
	{
		_height = round ((getPosASL player) select 2);
		_height = _height - (_height mod 5);
		_descent = -round ((velocity vehicle player) select 2);
		_descent = _descent - (_descent mod 2);
		__ctrl_alt ctrlSetText format["%1 m",ceil _height];
		__ctrl_compass ctrlSetText format ["%1",(round direction vehicle player)];
		__ctrl_descent ctrlSetText format ["%1",_descent];
		__ctrl_alt ctrlcommit 0;__ctrl_descent ctrlCommit 0; __ctrl_compass ctrlCommit 0;
		//hint format ["Alt: %1 m - Bearing: %2 - descent: %3",ceil _height, (round direction vehicle player), _descent];
		sleep 0.5;
	};
	
	// remove altimeter
	2222 cutFadeOut 1;
};
//==================================================================MCC_fnc_drawBox===============================================================================================
// Draw a box on the map localy between two points
// Example: [MCC_pointA,MCC_pointB,boxMarkerName,boxType,boxColor,maxDist] call MCC_fnc_drawBox; 
// MCC_pointA = Position, start position of the line
// MCC_pointB = Position, end position of the line
// boxMarkerName = Integer, uniq number, can't have two markers with the same number
//boxType = String, type of box
//boxWidth = Integer, width of the box
//boxColor = String, box color
//maxDist = Integer, maximum marker distance. 
//Returns : marker name
//==================================================================================================================================================================================
MCC_fnc_drawBox = 
		{
		private ["_start", "_end", "_markerName","_boxShape","_center","_boxType","_boxColor","_boxMarkerName","_hight","_width","_marker"];
		_start 		= _this select 0;
		_end 		= _this select 1;
		_markerName	= _this select 2;
		_boxShape 	= _this select 3;
		_boxColor 	= _this select 4;
		_boxType	= _this select 5;
		
		_boxMarkerName = format ["mccbox_%1", _markerName];
		
		_center = [(((_start select 0) + (_end select 0))/2),(((_start select 1) + (_end select 1))/2)];
		_width = abs ((_end select 1) - (_center select 1));  
		_hight = abs ((_end select 0) - (_center select 0)); 
		//hint format ["center: %1, hight: %2, width: %3",_center,_hight,_width];
		createMarkerLocal [_boxMarkerName, _center];
		_boxMarkerName setMarkerShapeLocal _boxShape;
		_boxMarkerName setMarkerSizeLocal [_hight,_width];
		_boxMarkerName setMarkerColorLocal _boxColor;
		_boxMarkerName setMarkerBrushLocal _boxType;
		_boxMarkerName;
		};
//==================================================================MCC_fnc_pipOpen===============================================================================================
// Do the transmitting feed animation
// Example: [_control] call MCC_fnc_pipOpen; 
// _control = control name
//==================================================================================================================================================================================
MCC_fnc_pipOpen = 
	{
		disableSerialization;
		private ["_control"];
		_control	= _this select 0;
		
		_control ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_12_ca.paa";
		uiSleep 0.03;
		_control ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_11_ca.paa";
		uiSleep 0.03;
		_control ctrlsettext "a3\ui_f\data\igui\rsctitles\static\feedstatic_10_ca.paa";
		uiSleep 0.03;

		// Display images
		for "_i" from 9 to 0 step - 1 do {
			_control ctrlsettext format["a3\ui_f\data\igui\rsctitles\static\feedstatic_0%1_ca.paa",_i];
			_control ctrlCommit 0;
			
			// 30 FPS
			uiSleep 0.03;
		};
	};
//==================================================================MCC_fnc_time2string===============================================================================================
// convert time to string
//==================================================================================================================================================================================
MCC_fnc_time2string =
{
	private["_num", "_string"];
	
	_num = _this select 0;
	_string = "";
	
	if (_num <= 9) then 
	{
		_string = format["0%1", _num];
	}
	else
	{
		_string = str _num;
	};
	
	_string;
};
//==================================================================MCC_fnc_time===============================================================================================
// convert time to string
//==============================================================================================================================================================================	
MCC_fnc_time =
{
	private ["_secTotal","_h","_m","_s","_string"];
	
	_secTotal = _this select 0;
	
	_s = [floor(_secTotal MOD 60)]call MCC_fnc_time2string;
	_m = [floor((_secTotal/60) MOD 60)]call MCC_fnc_time2string;
	_h = [floor((_secTotal/60/60) MOD 24)]call MCC_fnc_time2string;
	
	_string = format["%1:%2:%3", _h, _m, _s];
	
	_string;
};
//==================================================================MCC_fnc_setVehicleInit======================================================================================
// Sets vehicle init
// Example: [[[netID _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_init: string, the new init command (use _this instead of this)
//==============================================================================================================================================================================	
MCC_fnc_setVehicleInit = 
{
	private ["_unit","_unitinit"];
	
	_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
	_unitinit = _this select 1;
	//server sidechat format ["%1", _unitinit];
	_unit call compile format ["%1",_unitinit];
};

//==================================================================MCC_fnc_setVehicleName======================================================================================
// Sets vehicle name
// Example: [[[netid _unit,_unit], _name], "MCC_fnc_setVehicleName", true, true] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, vehicle we want to set its init. 
//	_name: string, the new name
//==============================================================================================================================================================================	

MCC_fnc_setVehicleName = 
{
	private ["_unit","_unitname"];
	
	_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
	_unitname = _this select 1;
	
	_unit setVehicleVarName _unitname;
	_unit call compile format ["%1=_This; PublicVariable ""%1""",_unitname];
};

//==================================================================MCC_fnc_setTime======================================================================================
// Setstime on all clients
// Example: [[year, month, day, hour, minute],"MCC_fnc_setTime",true,false] spawn BIS_fnc_MP;
//	year: number, YYYY
//	month: number, MM
//	day: number, DD
//	hour: number, HH
// 	minute: number, mm
//==============================================================================================================================================================================	

MCC_fnc_setTime = 
{
	private ["_time"];
	
	_time = _this select 0;
	setDate _time;
};

//==================================================================MCC_fnc_setWeather======================================================================================
// Sets weather  on all clients  - skip time by one hour to make the weather change
// Example: [[[ Overcast, WindForce, Waves, Rain, Lightnings,fog]],"MCC_fnc_setWeather",true,false] spawn BIS_fnc_MP;
// Params: 
//	Overcast: number, 0-1
//	WindForce: number, 0-1
//	Waves: number, 0-1
//	Rain: number, 0-1
//	Lightnings: number, 0-1
//	Fog: array, [fogValue, fogDecay, fogBase]
//==============================================================================================================================================================================	

MCC_fnc_setWeather = 
{
	private ["_weather"];
	
	_weather = _this select 0;
	0 setOvercast	(_weather select 0);
	0 setWindForce 	(_weather select 1);
	0 setWaves 		(_weather select 2);
	0 setRain 		(_weather select 3);
	0 setLightnings	(_weather select 4);
	if ((count _weather) > 5) then {0 setFog [(_weather select 5), 0.03,50]};
	skipTime 1;
	sleep 1;
	skipTime -1;
	simulWeatherSync;
};

//==================================================================MCC_fnc_globalSay3D======================================================================================
// Say sound on 3d on all clients
// Example: [[[netid _unit,_unit], _sound], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, sound's source
// 	_sound: string, sound define in config
//==============================================================================================================================================================================	

MCC_fnc_globalSay3D = 
{
	private ["_object","_sound"];
	
	_sound = _this select 1;
	_object = if(((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
	_object say3D _sound;
};

//==================================================================MCC_fnc_globalHint======================================================================================
// Broadcast a meesege on all clients
// Example: [[_hint],'MCC_fnc_globalHint',true,true] spawn BIS_fnc_MP;
// Params: 
//	_hint: string, messege to broadcast
//==============================================================================================================================================================================	

MCC_fnc_globalHint = 
{
	private ["_string"];
	
	_string = _this select 0;
	hint _string; 
};

//==================================================================MCC_fnc_globalExecute======================================================================================
// Global execute a command on selected clients or server
// Example: [[mode,code], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
// Params: 
//	mode: number, 0:clients only, 1: server only 2: all clients and server
//	code: code, code to be executed
//==============================================================================================================================================================================	
MCC_fnc_globalExecute = 
{
	private ["_code","_type"];
	
	_type 	= _this select 0;
	_code 	= _this select 1;

	switch (_type) do
		{
			case 0:	//clients
			{ 
				if (!isServer) then {call _code}; 
			};
			
			case 1:	//Server
			{ 
				if (isServer) then {call _code}; 
			};
			
			case 2:	//all
			{ 
				call _code; 
			};
		};
};

//==================================================================MCC_fnc_groupchat======================================================================================
// Send chat across MP
// Example: [[[netid _unit,_unit],_text,_local], "MCC_fnc_groupchat", true, false] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, brocadcasting unit
//	_text: string, text to broadcast
//	_local: bolean, false - all clients and server, true - only where the unit is local
//==============================================================================================================================================================================

MCC_fnc_groupchat =
{
	private ["_unit","_text","_local"];
	_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
	_text = _this select 1;
	_local = _this select 2;
	if (_local && !(local _unit) || (isDedicated)) exitWith {};
	_unit globalchat _text;
};

//==================================================================MCC_fnc_moveToPos======================================================================================
// move an object to a new location
// Example: [[[netid _unit,_unit],_pos], "MCC_fnc_moveToPos", true, false] spawn BIS_fnc_MP;
// Params: 
//	_unit: object, brocadcasting unit
//	_pos: array, position
//==============================================================================================================================================================================

MCC_fnc_moveToPos =
{
	private ["_unit","_pos"];
	_unit = if (((_this select 0) select 0) == "") then {(_this select 0) select 1} else {objectFromNetID ((_this select 0) select 0)};
	_pos = _this select 1;
	_unit setpos _pos;
};
