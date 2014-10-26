/*
				Origal idea by : ***		ARMA3Alpha AMBIENT COMBAT SCRIPT v2.5 - by SPUn / lostvar	***
				Rewritten by 	 : Spirit, MCC GAIA functionality.
				
			Creates ambient combat around defined objects/units with multiple customizable features.
			
		Calling the script:
		
				default: 	nul = [] execVM "LV\ambientCombat.sqf";
		
								
	Parameters:
		

					
*/








if (isServer) then
{
	private ["_minRange,_maxRange"];

  _all 				= ["Airport","CityCenter","FlatAreaCity","FlatAreaCitySmall","NameCity","NameCityCapital","NameVillage","BorderCrossing","Strategic","StrongpointArea","Hill","Mount","RockArea","ViewPoint","NameMarine","Flag","FlatArea","Name","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
	_maxRange 			   = MCC_GAIA_AC_MAXRANGE;	 
	_minRange 				 = _maxRange - 200;
	_timeDelay				 = 5;	 
	_groupAmount 			 = 0;
	
	_sideRatios 			 = [0,0,0]; 
	_syncedUnit 			 = [];
	_InRange					 = false;
	_skills 					 = "default";
	_communication 		 = 1;	 
	_dissapearDistance = _maxRange+200;
	_customInit 			 = nil;	 
	_patrolType 			 = 1;	
	_mp 							 = true;
	_IndepUnits 			 = 0;
	_WestUnits				 = 0;
	_EastUnits				 = 0;
	_TotInRangeWUnits  = 0;
	_TotInRangeEUnits  = 0;
	_TotInRangeIUnits  = 0;
	_TotUnits					 = 0;
	_TotInRangeUnits   = 0;
	_centerPos				 = [];
	_GrpUnit					 = [];
	_ActiveZone				 = "";
	_grp							 = grpNull;
	_spawnpos				   = [];
	_NearestEnemyGroups= [];
	_NearestFriendlyGroups = [];
	_player						 = objNull;
	_LastPosPlayer		 = [];
	_time							 = time;
	
	_FactionsWest = [];
	_FactionsEast = [];
	_FactionsIndep= [];
			while{true}do
			{
				
				_MarkersDeleted = false;
				while {!(MCC_GAIA_AC)} do 
				{
    			sleep 10;
    			
  				if !_MarkersDeleted then 
  				{
		  				if (count(playableUnits)>0) then
		  				 	{_player = playableUnits select 0;}
		  				else
		  				  {_player = player};
		  				  
		    			
		    			
		    			{
		    					    deleteMarker (str(_x));
		    			} foreach nearestLocations [_player, _all, 300000];
		    	 _MarkersDeleted = true;
		    	};
				};
				
				sleep _timeDelay;
				
				_syncedUnit = call GAIA_fnc_GetPlayers;
			
				_groupAmount = (((count(playableUnits))max 1)*6) min MCC_GAIA_AC_MAXGROUPS;
				
				// Remove out of range and out of heart groups
			
				
				if (
							(({(_x getVariable ["GAIA_AMBIENT",false]) } count allgroups) < _groupAmount)
							and
							MCC_GAIA_AC
							and
							(count(_syncedUnit)>0)
					 )
				then
				{
					
					
						//Maximum ambient is 6 groups per player with a max of 35. 
						_groupAmount = (((count(playableUnits))max 1)*6) min MCC_GAIA_AC_MAXGROUPS;
						_spotValid = false;
						_attempt   = 0;
						
						while{!_spotValid}do
						{
							
							
							
							_player		 = (_syncedUnit call BIS_fnc_selectRandom);
								//Set the visuals
				
							if ((_player getVariable ["MCC_AMBIENT_ZONE","none"])=="none") then
								{
									_player setvariable ["MCC_AMBIENT_ZONE",str(MCC_GAIA_AMBIENT_ZONE_RESERVED+1)];
									_mrknm = (_player getVariable ["MCC_AMBIENT_ZONE","none"]);
									_mrk 	 = createMarkerLocal [_mrknm, position _player ];
									_mrk setMarkerShapeLocal "RECTANGLE";
									_mrk setMarkerSize [_maxRange, _maxRange];
									_mrk setMarkerAlpha 0;
									
								}
								else
								{
									(_player getVariable ["MCC_AMBIENT_ZONE","none"]) setMarkerPos getpos _player;
								};
							
							_centerPos  = position _player;			
							_ActiveZone = (_player getVariable ["MCC_AMBIENT_ZONE","none"]);				
			
							 
							 //_spawnPos = getpos(( [(nearestObjects [_centerPos, ["house"], 1000]),{_x distance _centerPos>800}] call BIS_fnc_conditionalSelect) call BIS_fnc_selectRandom);
							//_spawnPos = [(_centerPos select 0) + (sin _dir) * _range, (_centerPos select 1) + (cos _dir) * _range, 0];
							_LastPosPlayer =(_player getVariable ["MCC_AMBIENT_PLAYER_POS",[]]);
							if (
										//Only try to predict if we have any clue where this player was before.
										(count(_LastPosPlayer)>0) 
										&&
										//We tried to predict 3 times with absolute failing. Stop doing that!!!
										_attempt<4
								 )
							then
							{
								//If he had not moved then there is no use to predict is it, einstein?
								if ((_LastPosPlayer distance  _player)>3) then
									{
										//Figure out where the dude goes.
										_dir = [_LastPosPlayer,position _player ] call BIS_fnc_dirTo;
										_spawnpos = [_player, _maxrange, _dir] call BIS_fnc_relPos;
					
										
										
					
			
									}
									else
									{_spawnpos =[getPos _player, _minRange, _maxRange, 30, 1, 20, 0] call BIS_fnc_findSafePos;};
							}
							else
							{
							_spawnpos =[getPos _player, _minRange, _maxRange, 30, 1, 20, 0] call BIS_fnc_findSafePos;
							};
							
							
							
							
							//Result check
						 	if (
						 			// We did not get the world centerposition (no position found)
						 			!((  (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")) distance _spawnPos)==0)
						 			and
						 			//The spawn position is not within minimum range of any player
						 			!([_spawnPos,_minRange] call GAIA_fnc_isNearPlayer)		 				
						 			
						 			 
						 		 )
							then
							{_spotValid = true;};
							
							//Are we in a marker?
							//We dont want ambient to spawn when inside GAIA zones. The mission maker is doing stuff.
							{
								if([_spawnPos,str _x] call GAIA_fnc_IsInMarker)exitWith
								{_spotValid = false;};
							}forEach ([MCC_zones_numbers, { _x <1000}] call BIS_fnc_conditionalSelect);
								
							if !(_spotvalid) then {_attempt=_attempt+1;};
						};
			
						//Update the position of the player 
						_player setvariable ["MCC_AMBIENT_PLAYER_POS",position _Player];
						
			
						_NearestW   	= objNull;
						_NearestI   	= objNull;
						_NearestE   	= objNull;
			
						
						
							
							{
								if (
											//The dude is alive
											alive _x 
											&& 
											// He is a human 
											_x isKindOf "man" 
											&& 
											// He is not part of the Ambient Combat
											!(group _x getVariable ["GAIA_AMBIENT",false])
											&&
											// He is not a player
											!(isplayer _x)
											&&
											count((group _x) getVariable ["GAIA_ZONE_INTEND",[]])>0
											
											
											
										) 
								then 
								{
									  
									_unit			 = _x;					
									switch (side _x) do
									{
								    case west: 					{ if !((faction _x) in _FactionsWest) then {_FactionsWest=_FactionsWest+ [(faction _x)]};};     			    
										case east: 					{ if !((faction _x) in _FactionsEast) then {_FactionsEast=_FactionsEast+ [(faction _x)]};};     
								    case independent	: {if !((faction _x) in _FactionsIndep) then {_FactionsIndep=_FactionsIndep+ [(faction _x)]};};     					    					 					    					 
									};
							 	};
							 	
							} foreach allUnits;
							
							
							
							
						_DoStuff = true;
						
						_sideRatios = [(position _player)] call GAIA_fnc_getsideratio;
						
					
						if ((_sideRatios distance [0,0,0])==0) then
							{
								
								_sideRatios = [0,0,0];
								_DoStuff    = false;
							};
							
					//hint format ["%1 ratio: %2 total: %3 disttot %4",[ _FactionsWest,_FactionsEast, _FactionsIndep],_sideRatios,_totunits,_distTot];
							
				
					if _DoStuff then
					{
						
						_grp =[_sideRatios,[ _FactionsWest,_FactionsEast, _FactionsIndep],_spawnpos] call GAIA_fnc_SpawnGroup;
						
							
					};
				};
			};
};