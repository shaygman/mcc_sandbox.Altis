/*
				Origal idea by : ***		ARMA3Alpha AMBIENT COMBAT SCRIPT v2.5 - by SPUn / lostvar	***
				Rewritten by 	 : Spirit, MCC GAIA functionality.
				
			Creates ambient combat around defined objects/units with multiple customizable features.
			
		Calling the script:
		
				default: 	nul = [] execVM "LV\ambientCombat.sqf";
		
								
	Parameters:
		

					
*/
if (!isServer)exitWith{};

// Take it easy as long as the show has not started.
while {!(MCC_GAIA_AMBIANT_COMBAT)} do 
{
    sleep 5;
};

private ["_minRange,_maxRange"];

_minRange 				 = MCC_GAIA_AMBIENT_minRange;	 
_maxRange 			   = MCC_GAIA_AMBIENT_maxRange;	 

_timeDelay				 = 5;	 
_groupAmount 			 = 20;
_ScanUnitRange		 = 2500;
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
_simu							 = "";
_spawnpos				   = [];
_NearestEnemyGroups= [];
_NearestFriendlyGroups = [];
_grp							 = grpNull;
_player						 = objNull;
_LastPosPlayer		 = [];
_roads						 = [];







while{true}do
{
	
	sleep _timeDelay;
	
	_syncedUnit = call GAIA_fnc_GetPlayers;
	// Remove out of range and out of heart groups
	{
		_delete = true;
		_grp    = _x;
		if (_grp getVariable ["GAIA_AMBIENT",false]) then
		{
			{
				if ([position _x,_dissapearDistance] call GAIA_fnc_isNearPlayer) exitWith {_delete = false;};					
			} forEach (units _grp);
			if _delete then 
			{
				//Delete all shit
				{deleteVehicle _x; sleep 0.3} foreach ([_grp] call  BIS_fnc_groupVehicles);
				{ deleteVehicle _x;sleep 0.3 }forEach units _grp;
				deletegroup _grp;
			};
		};
	}forEach allgroups;
	
	if (
				(({(_x getVariable ["GAIA_AMBIENT",false]) } count allgroups) < _groupAmount)
				and
				MCC_GAIA_AMBIANT_COMBAT
				and
				(count(_syncedUnit)>0)
		 )
	then
	{
		
		
			
			_groupAmount = ((count(playableUnits))max 1)*7;
			_spotValid = false;
			_attempt   = 0;
			
			while{!_spotValid}do
			{
				
				
				
				_player		 = (_syncedUnit call BIS_fnc_selectRandom);
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
					if ((_LastPosPlayer distance  _player)>30) then
						{
							//Figure out where the dude goes.
							_dir = [_LastPosPlayer,position _player ] call BIS_fnc_dirTo;
							_spawnpos = [_player, _maxrange, _dir] call BIS_fnc_relPos;
							_mrknm = format["%1",_spawnpos];
							_mrk 	 = createMarkerLocal [_mrknm, _spawnpos ];
							_mrk setMarkerShapeLocal "RECTANGLE";
							_mrk setMarkerSize [10, 10];
							
							hint "we tried to predit";
							sleep 1;

						}
						else
						{_spawnpos =[getPos _player, _minRange, _maxRange, 30, 1, 20, 0] call BIS_fnc_findSafePos;};
				}
				else
				{
				_spawnpos =[getPos _player, _minRange, _maxRange, 30, 1, 20, 0] call BIS_fnc_findSafePos;
				};
				
				_avoidArray = MCC_GAIA_ZONES_EAST + MCC_GAIA_ZONES_WEST + MCC_GAIA_ZONES_EAST + MCC_GAIA_ZONES_INDEP;
				
				
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
				{
					if([_spawnPos,_x] call GAIA_fnc_IsInMarker)exitWith
					{_spotValid = false;};
				}forEach ([_avoidArray, {parseNumber _x <1000}] call BIS_fnc_conditionalSelect);
					
				if !(_spotvalid) then {hint "we failed a pos!";sleep 1;_attempt=_attempt+1;};
			};

			//Update the position of the player 
			_player setvariable ["MCC_AMBIENT_PLAYER_POS",position _Player];
			
			_FactionsWest = [];
			_FactionsEast = [];
			_FactionsIndep= [];
			_NearestW   	= objNull;
			_NearestI   	= objNull;
			_NearestE   	= objNull;
			_DistW				= 0;
			_DistE			  = 0;
			_DistI				= 0;
			_distTot			= 0;
			_ratioW				= 0;
			_ratioE				= 0;
			_ratioI				= 0;
			
			
				
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
				
				

				_distW = [west,position _player,true] call GAIA_fnc_getDistanceToClosestZone;
				_distE = [east,position _player,true] call GAIA_fnc_getDistanceToClosestZone;
				_distI = [independent,position _player,true] call GAIA_fnc_getDistanceToClosestZone;
						
				if (_distw==99999) then {_distw=0};
				if (_diste==99999) then {_diste=0};
				if (_disti==99999) then {_disti=0};
						
				_distTot= 	_distI+_distE+_distW;
				
				if (_distw>0 && _distw!=_distTot) then {_distw  =   _distTot - _distW;};
				if (_diste>0 && _diste!=_distTot) then {_diste  =   _distTot - _Diste;};
				if (_disti>0 && _disti!=_distTot) then {_disti  =   _disttot - _Disti;};
				
				if (_disttot>0) then
				{
					_distTot= 	_distI+_distE+_distW;
					_ratioe = (_diste/_disttot);
					_ratioW = (_distw/_disttot);
					_ratioi = (_disti/_disttot);				
					_sideRatios = [_ratioW,_ratioe,_ratioi ];
					_min 				= [_sideratios,0]call BIS_fnc_findExtreme;
					_max 				= [_sideratios,1]call BIS_fnc_findExtreme;
					
					
					// Do the ownership thingy's, driving me titnuts here.Help my math! :)
					//We have 2 sides (max)
					if (
								((_max > 0.6) and _min==0) 										
						 )
					then
					{
						_i=0;
						{
							if (_x!=_max) then {_sideRatios set [_i,0];};
							_i=_i+1;
						} foreach _sideRatios;
					};
					
					//We have 3 side
					if (
								((_max > 0.36) and _min>0) 
						 )
					then
					{
						_i=0;
						{
							if (_x==_max) then {_sideRatios set [_i,_max+_min];};
							if (_x==_min) then {_sideRatios set [_i,0];};
							_i=_i+1;
						} foreach _sideRatios;
					};
					_dostuff 		= true;
					
				}
				else
				{
					
					_sideRatios = [0,0,0];
					_DoStuff    = false;
				};
		hint format ["%1 ratio: %2 total: %3 disttot %4",[ _FactionsWest,_FactionsEast, _FactionsIndep],_sideRatios,_totunits,_distTot];
				
	
		if _DoStuff then
		{
				_sideNr		= [[0,1,2],_sideRatios] call BIS_fnc_selectRandomweighted;
				_side     = ([west,east,independent] select _sideNr);
				_faction  = ([ _FactionsWest,_FactionsEast, _FactionsIndep] select _sideNr) call BIS_fnc_selectRandom;
				
								
			 	// Can be a water pos
			 	
			 	//Did we get the world centerpos? Fuck it....
			 	//"soldier", "car", "motorcycle", "tank", "helicopter", "airplane", "ship"

			 		if (surfaceIsWater _spawnPos) then
			 		{
			 			
			 			_simu = [["helicopter", "airplane", "ship"],[0.01,0.01,1]] call BIS_fnc_selectRandomWeighted; 			
			 		}
			 		else
			 		{
			 			
			 			_simu = [["soldier", "car", "motorcycle", "tank"],[1,0.4,0.05,0.01]] call BIS_fnc_selectRandomWeighted;
			 		};
					
					if (!(isOnRoad _spawnpos) and (_simu in ["soldier", "car","motorcycle","tank"])) then
							{
								_roads = _spawnpos nearRoads 100;
								if (count(_roads)>0) then
									{_spawnpos = position(_roads call BIS_fnc_selectRandom);};
							};
					
					if (_simu == "soldier") then 
					{
						// Love the x simulation
						_unitarray= [_faction ,_simu,"men"] call MCC_fnc_makeUnitsArray;
						_unitarray = _unitarray + ( [_faction ,_simu+"x","men"] call MCC_fnc_makeUnitsArray);
						
						_amount = (floor random 10) max 3;
						_dude   = [];
						_GrpUnit= [];
						for [{_i=0}, {_i <  _amount}, {_i=_i+1}] do
						{
							_dude = _unitarray select (floor random (count _unitarray));
							
							_GrpUnit = _GrpUnit + [ (_dude  select 0)];
							
							
						};
						_grp = [_spawnPos, _side, _GrpUnit] call BIS_fnc_spawnGroup;
						( _grp) setVariable ["GAIA_ZONE_INTEND",[_ActiveZone, (["MOVE","NOFOLLOW","FORTIFY"]call BIS_fnc_selectRandom)], true];
						
					}
					else
					{
							// Love the x simulation
						_unitarray= [_faction ,_simu] call MCC_fnc_makeUnitsArray;
						_unitarray = _unitarray + ( [_faction ,_simu+"x"] call MCC_fnc_makeUnitsArray);
						
						
						
						if (count(_unitarray)>0) then
						{
							_dude = _unitarray select (floor random (count _unitarray));					
							_grp = ([_spawnPos, 200, (_dude  select 0), _side] call bis_fnc_spawnvehicle) select 2;
							( _grp) setVariable ["GAIA_ZONE_INTEND",[_ActiveZone, (["MOVE","NOFOLLOW"]call BIS_fnc_selectRandom)], true];
						};
					};	
				  ( _grp) setVariable ["GAIA_AMBIENT",true, false];
	
				
		};
	};
};
