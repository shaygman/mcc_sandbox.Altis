//Initialize
#define MCC_MWPlayersIDC 6001
#define MCC_MWATMinesIDC 6002
#define MCC_MWAPMinesIDC 6003
#define MCC_MWStealthIDC 6004
#define MCC_MWReinforcementIDC 6005
#define MCC_MWDifficultyIDC 6006
#define MCC_MWObjective1IDC 6007
#define MCC_MWObjective2IDC 6008
#define MCC_MWObjective3IDC 6009
#define MCC_MWVehiclesIDC 6010
#define MCC_MWArmorIDC 6011
#define MCC_MWIEDIDC 6012
#define MCC_MWSBIDC 6013
#define MCC_MWArmedCiviliansIDC 6014
#define MCC_MWCQBIDC 6015
#define MCC_MWRoadBlocksIDC 6016
#define MCC_MWWeatherComboIDC 6017

#define FACTIONCOMBO 1001

private ["_missionCenter","_missionCenterTrigger","_playersNumber","_difficulty","_totalEnemyUnits","_isCQB","_objType","_objArray","_check","_objFirstTime",
         "_minObjectivesDistance","_objPos","_timeStart","_side","_faction","_sidePlayer","_factionPlayer","_obj1","_obj2","_obj3","_pos","_center",
		 "_armor","_vehicles","_stealth","_roadPositions","_script_handler","_isIED","_isAS","_spawnbehavior","_isRoadblocks","_objectives","_isCiv","_weatherChange"];

//Get params
_playersNumber 		= (lbCurSel MCC_MWPlayersIDC) + 1;
_difficulty 		= (lbCurSel MCC_MWDifficultyIDC+1)*3;		//each player == 3 enemy players multiply by difficulty
_stealth 			= if ((lbCurSel MCC_MWStealthIDC)==0) then {false} else {true};
_isIED 				= if (lbCurSel MCC_MWIEDIDC == 0) then {false} else {true};
_isSB 				= if (lbCurSel MCC_MWSBIDC == 0) then {false} else {true};
_isAS				= if (lbCurSel MCC_MWArmedCiviliansIDC == 0) then {false} else {true};
_isRoadblocks		= if (lbCurSel MCC_MWRoadBlocksIDC == 0) then {false} else {true};
_armor 				= if ((lbCurSel MCC_MWArmorIDC)==0) then {false} else {true};
_vehicles 			= if ((lbCurSel MCC_MWVehiclesIDC)==0) then {false} else {true};
_weatherChange		= if ((lbCurSel MCC_MWWeatherComboIDC)==0) then {true} else {false};

//CQB
switch (lbCurSel MCC_MWCQBIDC) do	
	{
		case 0: 
		{
			_isCQB 	=  false;
			_isCiv	=  false;
		};
		
		case 1: 
		{
			_isCQB 	=  true;
			_isCiv	=  false;
		};
		
		case 2: 
		{
			_isCQB 	=  true;
			_isCiv	=  true;
		};
	};
	
//Objectives
_obj1 				= MCC_MWMissionType select (lbCurSel MCC_MWObjective1IDC);
_obj2 				= MCC_MWMissionType select (lbCurSel MCC_MWObjective2IDC);
_obj3 				= MCC_MWMissionType select (lbCurSel MCC_MWObjective3IDC);

//Player parmas
_sidePlayer 		= side player;
_side				= mcc_sidename; 
_pos 				= getpos player;

_totalEnemyUnits 		= if ((_playersNumber * _difficulty)>10) then {(_playersNumber * _difficulty)} else {10};
_objArray			 	= ["Secure HVT","Kill HVT","Destory Object","Pick Intel","Clear Area","Disarm IED"]; 
_minObjectivesDistance 	= if (_isCQB) then {100} else {200};
_maxObjectivesDistance 	= (_minObjectivesDistance*2) + (10*_playersNumber);


//What side and faction are we fighting here,
switch (toLower _side) do	
	{
		case "west": {_side =  west};
		case "east": {_side =  east};
		case "gue": {_side =  resistance};
		case "civ": {_side =  civilian};
	};
	
//What faction are we fighiting?
_faction = getText (configFile >> "CfgVehicles" >> (U_GEN_SOLDIER select 0 select 1) >> "faction");
if (isnil "_faction") exitWith {hint "Faction doesn't have any units in it";diag_log "MCC MW: Faction is empty"};

//Build the faction's unitsArrays. 
_check = [] call MCC_fnc_MWCreateUnitsArray;
waituntil {_check};	
	
if (MW_debug) then {player sidechat format ["Total enemy's units: %1", _totalEnemyUnits]};
diag_log format ["MCC Mission Wizard total enemy Count = %1", _totalEnemyUnits];

//Check if faction has groups in it if not exit
if (count MCC_MWGroupArrayMen == 0) exitWith
{
	player sidechat "MCC: Mission Wizard Error: No group available in the selected enemy faction"; 
	diag_log "MCC: Mission Wizard Error: No group available in the selected enemy faction"; 
};

//--------------------------------------------------------------Create a ceneter trigger --------------------------------------------------------------------------
[] call BIS_fnc_worldArea;

//First time? Let's map the island
if (isnil "MCC_MWcityLocations") then
{
	MCC_MWcityLocations     = [_pos,1000000,"city"] call MCC_fnc_MWbuildLocations;
	MCC_MWmilitaryLocations = [_pos,1000000,"mil"] call MCC_fnc_MWbuildLocations;
	MCC_MWhillsLocations 	= [_pos,1000000,"hill"] call MCC_fnc_MWbuildLocations;
	MCC_MWnatureLocations 	= [_pos,1000000,"nature"] call MCC_fnc_MWbuildLocations;
	MCC_MWmarineLocations	= [_pos,1000000,"marine"] call MCC_fnc_MWbuildLocations;
	publicvariable "MCC_MWcityLocations";
	publicvariable "MCC_MWmilitaryLocations";
	publicvariable "MCC_MWhillsLocations";
	publicvariable "MCC_MWnatureLocations";
	publicvariable "MCC_MWmarineLocations";
	sleep 2; //Give some time for the values to get to the server
};

//Find out if the map have locations in it. 
MCC_MWBasedLocations = if ((count MCC_MWcityLocations)>2) then {true} else {false};

//Find mission center
_center = [_pos,2000,_isCQB,MCC_MWBasedLocations] call MCC_fnc_MWFindMissionCenter;
_missionCenter = _center select 0; 

_missionCenterTrigger = createtrigger ["emptydetector",_missionCenter];
_missionCenterTrigger settriggerarea [_maxObjectivesDistance*3,_maxObjectivesDistance*3,0,false];
MCC_MWmissionsCenter set [count MCC_MWmissionsCenter, _missionCenterTrigger]; 
publicvariable "MCC_MWmissionsCenter"; 

diag_log format ["MCC Mission Wizard center = %1", _missionCenter];

//Create the marker

[[1, "ColorRed",  [_maxObjectivesDistance*3.5,_maxObjectivesDistance*3.5], "ELLIPSE", "FDiagonal", "Empty", FORMAT ["MCCMW_operationMarker_%1",["MCCMW_operationMarker",1] call bis_fnc_counter], _missionCenter],"MCC_fnc_makeMarker",true,false] spawn BIS_fnc_MP;





_objectives = [];
_objFirstTime = true; 
//---------------------------------------------------------------------------Let's build objectives-------------------------------------------------------------------------
for [{_x = 1},{_x <=3},{_x = _x+1}] do		
{
	_objType = call compile format ["_obj%1",_x];
	if (_objType != "None") then 
	{
		MCC_MWObjectivesNames = nil; 
		if (_objType == "Random") then {_objType = _objArray select (floor random count _objArray)};
		_objPos = nil; 
		_timeStart = time; 
		while {isnil "_objPos" && (time < _timeStart +5)} do 
			{
				_objPos = [_missionCenterTrigger,_isCQB,_minObjectivesDistance,_maxObjectivesDistance,_objFirstTime] call MCC_fnc_MWfindObjectivePos; 
			};
		if (isnil "_objPos") then 
			{
				_objPos = [_missionCenter,_isCQB,0,1500,_objFirstTime] call MCC_fnc_MWfindObjectivePos; 
			}; 
			
		//Not the first objective we can get away from the center
		_objFirstTime = false;
		
		switch (_objType) do
		{
		   case "Secure HVT":		
			{
				//Change faction because we are dealing with a hostage and not an enemy
				if ((random 1)>0.5) then {_factionPlayer = faction player; _sidePlayer = side player} else {_factionPlayer = "CIV_F"; _sidePlayer = civilian};
				
				//Spawn a hostage on the server
				[[_objPos, _isCQB, true, _side, _faction, _sidePlayer, _factionPlayer], "MCC_fnc_MWObjectiveHVT", false, true] call BIS_fnc_MP;
			};
			
		  case "Kill HVT":		
			{
				[[_objPos, _isCQB, false, _side, _faction, _sidePlayer, faction player], "MCC_fnc_MWObjectiveHVT", false, true] call BIS_fnc_MP;
			};
			
		  case "Destory Object":		
			{
				[[_objPos, _isCQB, _side, _faction], "MCC_fnc_MWObjectiveDestroy", false, true] call BIS_fnc_MP;
			};
			
		  case "Pick Intel":		
			{
				[[_objPos, _isCQB, _side, _faction], "MCC_fnc_MWObjectiveIntel", false, true] call BIS_fnc_MP;
			};
			
		 case "Clear Area":		
			{
				[[_objPos, _isCQB,_side, _faction,_sidePlayer], "MCC_fnc_MWObjectiveClear", false, true] call BIS_fnc_MP;
			};
			
		 case "Disarm IED":		
			{
				[[_objPos, _isCQB,_side, _faction,_sidePlayer], "MCC_fnc_MWObjectiveDisable", false, true] call BIS_fnc_MP;
			};
		};
		
		//Stealth mission
		if (_stealth) then
		{
			private ["_activate","_cond"];
			switch (_sidePlayer) do	
				{
					case west: {_activate =  "WEST"; _cond = "WEST D"};
					case east: {_activate =  "EAST"; _cond = "EAST D"};
					case resistance: {_activate =  "GUER"; _cond = "GUER D"};
					case civilian: {_activate =  "CIV"; _cond = "CIV D"};
				};
			[["", _objPos, 100, 100, _activate, _cond,"AlarmSfx",false],"MCC_fnc_MusicTrigger",true,false] spawn BIS_fnc_MP;
		};
		
		sleep 1;
		//Lets create a zone
		_zoneNumber =["MCCMW_zone",1] call bis_fnc_counter; 
		
		//Create Zone
		_script_handler = [_zoneNumber,_objPos,_maxObjectivesDistance] call MCC_fnc_MWUpdateZone; 
		waituntil {_script_handler}; 

		//Spawn some Infantry groups
		_spawnbehavior	= ["NOFOLLOW","bisd"] call BIS_fnc_selectRandom; 
		_unitPlaced = [(_totalEnemyUnits*0.2),_zoneNumber,_spawnbehavior] call MCC_fnc_MWSpawnInfantry; 
		if (MW_debug) then {diag_log format ["Total enemy's infantry Spawned in zone%1: %2", _zoneNumber,_unitPlaced]};
		
		// Is CQB
		if (_isCQB) then 
		{
			[[_objPos,(_maxObjectivesDistance*0.5),0,(_totalEnemyUnits*0.004),_faction,str _side],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
		}; 
		
		// Is _isCiv
		if (_isCiv) then 
		{
			[[_objPos,(_maxObjectivesDistance*0.5),1,(_totalEnemyUnits*0.004),"CIV_F","CIV"],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
		};
		
				
		//Suicide Bombers
		private ["_name","_objectType","_unitsArray","_pos"];
		_unitsArray 	= ["CIV_F","soldier"] call MCC_fnc_makeUnitsArray;		//Let's build the faction unit's array	
		
		if (_isSB) then 
		{
			for [{_i = 0},{_i <=(_totalEnemyUnits/10)},{_i = _i+1}] do		
			{
				if (random 1 >0.5) then
				{
					//Name the bomber.
					_name = format ["SBObject_%1", ["SBObject_",1] call bis_fnc_counter]; 
					_objectType = (_unitsArray call BIS_fnc_selectRandom) select 0;
					_pos = [[[_objPos,(_maxObjectivesDistance*0.7)]],["water","out"],{true}] call BIS_fnc_randomPos;
					
					[[_pos,_objectType,"large",floor (random 2),_sidePlayer,_name],"MCC_fnc_SBSingle",false,false] spawn BIS_fnc_MP;
						
					//Debug
					if (MW_debug) then 
						{
							private ["_marker","_name"]; 
							_name = FORMAT ["SBMarker_%1", ["SBMarker_",1] call bis_fnc_counter]; 
							_marker = createMarkerLocal[_name, _pos];
							_marker setMarkerTypeLocal "mil_dot";
							_marker setMarkerColorLocal "ColorOrange";		
							_marker setMarkerSizeLocal[0.4, 0.4]; 
							_marker setMarkerTextLocal "SB"; 
						};
				};
			};
		};	

		//Armed Civilans
		if (_isAS) then 
		{
			for [{_i = 0},{_i <=(_totalEnemyUnits/10)},{_i = _i+1}] do		
			{
				if (random 1 >0.5) then
				{
					//Name the AC.
					_name = format ["ACObject_%1", ["ACObject_",1] call bis_fnc_counter]; 
					_objectType = (_unitsArray call BIS_fnc_selectRandom) select 0;
					_pos = [[[_objPos,(_maxObjectivesDistance*0.7)]],["water","out"],{true}] call BIS_fnc_randomPos;

					[[_pos,_objectType,_sidePlayer,_name,random 360],"MCC_fnc_ACSingle",false,false] spawn BIS_fnc_MP;
						
					//Debug
					if (MW_debug) then 
						{
							private ["_marker","_name"]; 
							_name = FORMAT ["ACMarker_%1", ["ACMarker_",1] call bis_fnc_counter]; 
							_marker = createMarkerLocal[_name, _pos];
							_marker setMarkerTypeLocal "mil_dot";
							_marker setMarkerColorLocal "ColorOrange";		
							_marker setMarkerSizeLocal[0.4, 0.4]; 
							_marker setMarkerTextLocal "AC"; 
						};
				};
			};
		};
		
		//IEDs
		if (_isIED) then 
		{
			_roadPositions = [_objPos,(_maxObjectivesDistance*0.7)] call MCC_fnc_findRoadsLeadingZone;
			if (count _roadPositions >0) then
			{
				{
					if (random 1 > 0.7) then 
					{
						
						//Name the ied.
						_name = format ["IEDObject_%1", ["IEDObject_",1] call bis_fnc_counter]; 
						
						//Care or hidden?
						if (random 1 < 0.3) then
						{
							_unitsArray 	= ["CIV_F","carx"] call MCC_fnc_makeUnitsArray;
							_objectType = (_unitsArray call BIS_fnc_selectRandom) select 0;	
						} 
						else
						{
							_objectType = MCC_MWIED call BIS_fnc_selectRandom;
						}; 

						[[_x modeltoworld [3,2,0],_objectType,"large",floor (random 2),2,0,0,((random 25) + 15),_sidePlayer,_name,random 360,[],_side],"MCC_fnc_trapSingle",false,false] spawn BIS_fnc_MP;
					
						//Debug
						if (MW_debug) then 
							{
								private ["_marker","_name"]; 
								_name = FORMAT ["iedMarker_%1", ["iedMarker_",1] call bis_fnc_counter]; 
								_marker = createMarkerLocal[_name, getpos _x];
								_marker setMarkerTypeLocal "mil_dot";
								_marker setMarkerColorLocal "ColorOrange";		
								_marker setMarkerSizeLocal[0.4, 0.4]; 
								_marker setMarkerTextLocal "IED"; 
							};
						
					}; 
				} foreach _roadPositions;
			};
		};
	
		waituntil {!isnil "MCC_MWObjectivesNames"};
		_objectives set [count _objectives, MCC_MWObjectivesNames]; 
	};
};



//-----------------------------------------------------------------------------Main zone-----------------------------------------------------------------------------------------------
private ["_zoneNumber","_unitPlaced","_safepos"];

//Let'screate the main zone and placing units
_zoneNumber =["MCCMW_zone",1] call bis_fnc_counter; 

//Create Zone
_script_handler = [_zoneNumber,_missionCenter,_maxObjectivesDistance*3.5] call MCC_fnc_MWUpdateZone; 
waituntil {_script_handler}; 

//Spawn some Infantry groups
_spawnbehavior	= ["MOVE","MOVE","MOVE","NOFOLLOW"] call BIS_fnc_selectRandom; 
_unitPlaced = [(_totalEnemyUnits*0.3),_zoneNumber,_spawnbehavior] call MCC_fnc_MWSpawnInfantry; 
if (MW_debug) then {diag_log format ["Total enemy's infantry Spawned in main zone: %1", _unitPlaced]};

//Vehicles
if (_vehicles) then
{
	_unitPlaced = [(_totalEnemyUnits*0.3),_zoneNumber,MCC_MWGroupArrayCar,MCC_MWunitsArrayCar,15,25,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//Armor
if (_armor) then
{
	_unitPlaced = [(_totalEnemyUnits*0.3),_zoneNumber,MCC_MWGroupArrayArmored,MCC_MWunitsArrayArmored,30,50,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Armor Spawned in main zone: %1", _unitPlaced]};
};

//Support
if (_vehicles && (random 1 > 0.5)) then
{
	_unitPlaced = [(_totalEnemyUnits*0.3),_zoneNumber,MCC_MWGroupArraySupport,MCC_MWunitsArraySupport,15,25,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Support Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//Static
if (random 1 > 0.5) then
{
	_unitPlaced = [(_totalEnemyUnits*0.15),_zoneNumber,MCC_MWGroupArrayStatic,MCC_MWunitsArrayStatic,10,20,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Support Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//Ship
_safepos =[_missionCenter ,1,(_maxObjectivesDistance*3.5),2,2,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos; //Check if they are water
if (str _safepos != "[-500,-500,0]") then
{
	_unitPlaced = [(_totalEnemyUnits*0.15),_zoneNumber,MCC_MWGroupArrayShip,MCC_MWunitsArrayShip,15,25,"WATER"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Ships Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//CheckPoints
if (_isRoadblocks) then
{
	_roadPositions = [_missionCenter,(_maxObjectivesDistance*2.5)] call MCC_fnc_findRoadsLeadingZone;
	if (count _roadPositions >0) then
	{
		private ["_roadConnectedTo","_connectedRoad","_dir"]; 
		{
			if (random 1 > 0.5) then 
			{
				_roadConnectedTo 	= roadsConnectedTo _x;
				_connectedRoad 		= _roadConnectedTo select 0;
				if (!isnil "_connectedRoad") then
				{
					_dir			 	= [_x, _connectedRoad] call BIS_fnc_DirTo;
					_pos				= getpos _x; 
					
					if (isnil "_dir") then {_dir = 0}; 
					
					//If no buildings around
					if ((nearestBuilding _pos) distance _pos >30) then
					{
						[[_pos, _dir, _faction, _side],"MCC_fnc_buildRoadblock",false,false] spawn BIS_fnc_MP;
					};
				};
			}; 
		} foreach _roadPositions;
	}; 
};

//IEDs
if (_isIED) then 
{
	private ["_name","_objectType","_iedpos","_iedX","_iedY","_groupArray"];
	_roadPositions = [_missionCenter,(_maxObjectivesDistance*2)] call MCC_fnc_findRoadsLeadingZone;
	if (count _roadPositions >0) then
	{
		_unitsArray 	= ["CIV_F","carx"] call MCC_fnc_makeUnitsArray;
		{
			if (random 1 > 0.5) then 
			{
				
				//Name the ied.
				_name = format ["IEDObject_%1", ["IEDObject_",1] call bis_fnc_counter]; 
				
				//Care or hidden?
				if (random 1 < 0.3) then
				{
					_objectType = (_unitsArray call BIS_fnc_selectRandom) select 0;	
				} 
				else
				{
					_objectType = MCC_MWIED call BIS_fnc_selectRandom;
				}; 
				
				//Find road direction
				_roadConnectedTo 	= roadsConnectedTo _x;
				_connectedRoad 		= _roadConnectedTo select 0;
				_dir			 	= [_x, _connectedRoad] call BIS_fnc_DirTo;
				
				
				//Let's not place it on road but to the side of the road. 
				_iedX = 4;
				_iedY = 0; 
				_iedpos = _x modeltoworld [_iedX,_iedY,0];
				
				while {isOnRoad _iedpos} do
				{
					_iedX = _iedX + 1;
					_iedY = _iedY + 1; 
					_iedpos = _x modeltoworld [_iedX,_iedY,0];
				}; 
				
				//Ambush Group 
				_groupArray = if (count MCC_MWGroupArrayMenRecon > 0) then 
				{
					if (random 1 > 0.5) then {MCC_MWGroupArrayMenRecon} else {MCC_MWGroupArrayMen};
				} 
				else 
				{
					MCC_MWGroupArrayMen
				};
				
				//Spawn the IED
				[[_iedpos,_objectType,"large",floor (random 2),2,0,0,((random 25) + 15),_sidePlayer,_name,_dir,_groupArray,_side],"MCC_fnc_trapSingle",false,false] spawn BIS_fnc_MP;
			
				//Debug
				if (MW_debug) then 
					{
						private ["_marker","_name"]; 
						_name = FORMAT ["iedMarker_%1", ["iedMarker_",1] call bis_fnc_counter]; 
						_marker = createMarkerLocal[_name, _iedpos];
						_marker setMarkerTypeLocal "mil_dot";
						_marker setMarkerColorLocal "ColorOrange";		
						_marker setMarkerSizeLocal[0.4, 0.4]; 
						_marker setMarkerTextLocal "IED"; 
					};
				
			}; 
		} foreach _roadPositions;
	};
};	



MCC_MWMissions set [count MCC_MWMissions, _objectives]; 
publicVariable "MCC_MWMissions";

if (_weatherChange) then
{
	//------------------- Time ---------------------------------------------------------------------------------
	private ["_hour"];
	if (_stealth) then
	{
		_hour = if (random 1 > 0.5) then {floor (random 5)} else {floor ((random 3)+20)};
	}
	else
	{
		_hour = floor (random 24);
	}; 

	MCC_date	= date;
	MCC_date	= [(MCC_date select 0) + floor (random 10 - random 10), floor ((random 12)+1)  ,  floor ((random 28)+1), _hour,  floor (random 60)];
	publicVariable "MCC_date";
		
	[[MCC_date],"MCC_fnc_setTime",true,false] call BIS_fnc_MP;


	//------------------- Weather ---------------------------------------------------------------------------------
	MCC_Overcast	= random 1; 
	MCC_WindForce 	= random 1; 
	MCC_Waves 		= random 1; 
	MCC_Rain 		= random 1; 
	MCC_Lightnings	= random 1; 
	MCC_Fog 		= (random 1)/5; 
	publicVariable "MCC_Overcast";
	publicVariable "MCC_WindForce";
	publicVariable "MCC_Waves";
	publicVariable "MCC_Rain";
	publicVariable "MCC_Lightnings";
	publicVariable "MCC_Fog";

	[[[MCC_Overcast, MCC_WindForce, MCC_Waves, MCC_Rain, MCC_Lightnings, MCC_Fog]],"MCC_fnc_setWeather",true,false] call BIS_fnc_MP;
};			
			
			
// ------------------  CREATE BRIEFINGS --------------------------------------------------------------------------
private ["_night","_factionName","_music","_missionName1","_missionName2","_html","_control","_tempText"];
_missionName1 = ["Desert","Oversized","Rogueish","Smouldering","Cold","Flaring","Furious","Silver","Vengeance","Yellow","Red","Blue","White","Gold","Dark","Broken",
                 "Morbid","Flying","Living","Swift","Evil","Fallen","False","Solitary","Broken","Alpha","Bravo","Charlie","Delta","echo","Foxtrot"] call BIS_fnc_selectRandom; 
_missionName2 = ["Storm","lightning","Rain","Thunder","Tornado","Hurricane","Flood","Dragonfly","Ocelot","Cobra","Fiend","Father","Horse","Thorn",
                 "Urgency","Snake","Serpent","Famine","Cage","Contempt","Priest","Stranger","Dagger","One","Two","Three","zero","Arrow"] call BIS_fnc_selectRandom; 

_night = if ((date select 3)>19 || (date select 3)<6) then {true} else {false}; 
_factionName = getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName");

//Location
if ((_center select 1) != "") then
{
	_tempText = ["Attack On","The Battle For","Assault On","The Fight For"] call BIS_fnc_selectRandom; 
	_html = format ["<t size='1.1' color='#a8e748' underline='true' align='center'>Operation: </t><t size='1.1' color='#a8e748' underline='false' align='center'>%1 %2. %3 %4</t>",toupper _missionName1,toupper _missionName2,_tempText,(_center select 1)];
}
else
{
	_html = format ["<t size='1.1' color='#a8e748' underline='true' align='center'>Operation: </t><t size='1.1' color='#a8e748' underline='false' align='center'>%1 %2.</t>",toupper _missionName1,toupper _missionName2];
};

//General
_tempText = ["presence in the area has been increasing.","have established a foothold in the area","forces are active in the area"] call BIS_fnc_selectRandom; 
_html = _html + format ["<br/><br/><t size='0.8' color='#E2EEE0'>%1 %2.</t>",_factionName,_tempText];

//_isCQB
if (_isCQB) then
{
	_tempText = ["They have taken positions inside buildings","They are using civilians' buildings to fortify themselves"] call BIS_fnc_selectRandom; 
	_html = _html + format ["<t size='0.8' color='#E2EEE0'> %1.</t>",_tempText];
};

_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>HQ informs us of infantry presences</t>",_factionName];

//_vehicles
if (_vehicles) then
{
	_html = _html + format ["<t size='0.8' color='#E2EEE0'>as well as %1's technicals or soft vehicles operating in the OP.</t>",_factionName];
};

//_armor
if (_armor) then
{
	_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>Be aware that apparently there are some %1's armored vehicles or even MBT operating in the OP.</t>",_factionName];
};

//_isRoadblocks
if (_isRoadblocks) then
{
	_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>%1 forces have established hasty checkpoints on some of the roads leading in and out of the area.</t>",_factionName];
};



//_isIED
if (_isIED || _isSB) then
{
	_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>Be aware and keep an eye on for anything that might look suspicious as we do believe that %1 will use IEDs or even suicide attacks. </t>",_factionName];
};

//_isAS
if (_isAS) then
{
	_html = _html + format ["<t size='0.8' color='#E2EEE0'>The local civilains support %1 so keep an eye for any strange civilians behavior but keep civilans' casualties to minimum as the brass don't want unnecessary attention</t>",_factionName];
};

//_stealth
if (_stealth) then
{
	_html = _html +"<br/><t size='0.8' color='#E2EEE0'>This is an undercover operation behind enemy lines. Expect enemy reinforcement incase he will become aware of your presence</t>";
};

_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>Go over your objectives, gear up and get ready.<br/>Mission is a go!</t>",_factionName];


_music = ["LeadTrack01a_F","LeadTrack02_F","LeadTrack03_F","LeadTrack04a_F","LeadTrack05_F","LeadTrack06_F","AmbientTrack03_F","BackgroundTrack03_F","BackgroundTrack01_F",
           "BackgroundTrack01a_F","BackgroundTrack02_F","LeadTrack01_F_EPA","LeadTrack02_F_EPA","EventTrack01_F_EPA","EventTrack01a_F_EPA","EventTrack03_F_EPA"] call BIS_fnc_selectRandom; 
[[2,compile format ["playMusic '%1'",_music]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;

//move that into client side
[[_missionCenter,_objectives,overcast,_night,1,_html], "MCC_fnc_MWopenBriefing", true, false] spawn BIS_fnc_MP;