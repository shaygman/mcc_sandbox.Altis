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
#define MCC_MCC_MWAreaComboIDC 6018
#define MCC_MWDebugComboIDC 6019
#define MCC_MWPreciseMarkersComboIDC 6020
#define MCC_MWArtilleryIDC 6021

#define FACTIONCOMBO 1001

private ["_missionCenter","_missionCenterTrigger","_playersNumber","_difficulty","_totalEnemyUnits","_isCQB","_objType","_objArray","_check","_objFirstTime",
         "_minObjectivesDistance","_objPos","_timeStart","_side","_faction","_sidePlayer","_factionPlayer","_obj1","_obj2","_obj3","_pos","_center","_wholeMap",
		 "_armor","_vehicles","_stealth","_roadPositions","_script_handler","_isIED","_isAS","_spawnbehavior","_isRoadblocks","_objectives","_isCiv","_weatherChange",
		 "_preciseMarkers","_reinforcement","_artillery"];

if (isnil "MCC_MWisGenerating") then {MCC_MWisGenerating = false}; 
MCC_mcc_screen = 2;
if (MCC_MWisGenerating) exitWith {player sideChat "MCC is now generating a mission please try again later"}; 
MCC_MWisGenerating = true;

//Get params
_playersNumber 		= (lbCurSel MCC_MWPlayersIDC) + 1;
_difficulty 		= (lbCurSel MCC_MWDifficultyIDC+1)*1.5;		//each player == 3 enemy players multiply by difficulty
_stealth 			= if ((lbCurSel MCC_MWStealthIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWStealthIDC)==0) then {false} else {true};
						}; 
						
_isIED 				= if ((lbCurSel MCC_MWIEDIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWIEDIDC)==0) then {false} else {true};
						}; 
						
_isSB 				= if ((lbCurSel MCC_MWSBIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWSBIDC)==0) then {false} else {true};
						};
						
_isAS				= if ((lbCurSel MCC_MWArmedCiviliansIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWArmedCiviliansIDC)==0) then {false} else {true};
						}; 
						
_isRoadblocks		= if ((lbCurSel MCC_MWRoadBlocksIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWRoadBlocksIDC)==0) then {false} else {true};
						}; 
						
_armor 				= if ((lbCurSel MCC_MWArmorIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWArmorIDC)==0) then {false} else {true};
						}; 
						
_vehicles 			= if ((lbCurSel MCC_MWVehiclesIDC)==3) then
						{
							[true,false] call BIS_fnc_selectRandom;
						}
						else
						{
							if ((lbCurSel MCC_MWVehiclesIDC)==0) then {false} else {true};
						};
						
_weatherChange		= if ((lbCurSel MCC_MWWeatherComboIDC)==0) then {true} else {false};
_wholeMap			= if ((lbCurSel MCC_MCC_MWAreaComboIDC)==0) then {true} else {false};
MW_debug			= if ((lbCurSel MCC_MWDebugComboIDC)==0) then {false} else {true};
_preciseMarkers		= if ((lbCurSel MCC_MWPreciseMarkersComboIDC)==0) then {true} else {false};
_reinforcement		= (lbCurSel MCC_MWReinforcementIDC);
_artillery			= (lbCurSel MCC_MWArtilleryIDC);

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
		
		case 3: 
		{
			_isCQB 	=  [true,false] call BIS_fnc_selectRandom;
			_isCiv	=  [true,false] call BIS_fnc_selectRandom;
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

_totalEnemyUnits 		= if ((_playersNumber * _difficulty)>10) then {(_playersNumber * _difficulty)} else {20};
_objArray			 	= ["Secure HVT","Kill HVT","Destroy Object","Aquire Intel","Clear Area","Disarm IED"]; 
_minObjectivesDistance 	= if (_isCQB) then {100} else {200};
_maxObjectivesDistance 	= (_minObjectivesDistance*1.5) + (10*_playersNumber);


//What side and faction are we fighting here,
switch (toLower _side) do	
{
	case "west": {_side =  west};
	case "east": {_side =  east};
	case "guer": {_side =  resistance};
	case "civ": {_side =  civilian};
};
	
//What faction are we fighiting?
_faction = getText (configFile >> "CfgVehicles" >> (U_GEN_SOLDIER select 0 select 1) >> "faction");
if (isnil "_faction") exitWith 
{
	diag_log "MCC MW: Faction is empty";
	MCC_MWisGenerating = false;
	["MCC: Mission Wizard Error: Faction doesn't have any units in it"] call bis_fnc_halt;
};

//Build the faction's unitsArrays and send it to the server. 
_check = [] call MCC_fnc_MWCreateUnitsArray;
waituntil {_check};	

//Send user custom groups to the server
MCC_customGroupsSaveMW = [];
{
	if (_faction == (_x select 0)) then
	{
		MCC_customGroupsSaveMW set [count MCC_customGroupsSaveMW, [_x select 3,_x select 4,_x select 2]]; 
	};
} foreach MCC_customGroupsSave;	

publicVariableServer "MCC_customGroupsSaveMW";

if (MW_debug) then {player sidechat format ["Total enemy's units: %1", _totalEnemyUnits]};
diag_log format ["MCC Mission Wizard total enemy Count = %1", _totalEnemyUnits];

//Check if faction has groups in it if not exit
if (count MCC_MWGroupArrayMen == 0) exitWith
{
	diag_log "MCC: Mission Wizard Error: No group available in the selected enemy faction"; 
	MCC_MWisGenerating = false;
	["MCC: Mission Wizard Error: No group available in the selected enemy faction"] call bis_fnc_halt;
};

//------------------------------------------------------------- Here we go  Create loading text----------------------------------------------------------------
while {dialog} do {closedialog 0; sleep 0.2}; 
[] spawn 
	{
		private ["_string","_footer"]; 
		while {MCC_MWisGenerating} do 
		{
			for [{_x=1},{_x<=10},{_x=_x+1}]  do //Create progress bar
			{
				_footer = [_x,10] call MCC_fnc_countDownLine;
				//add header
				_string = "<t color='#E2EEE0' size='0.85' shadow='0' align='center'>" + "Building A Mission <br/>Please Wait" + "</t><br/><br/>";
				//add _footer
				_string = _string + "<t color='#E2EEE0' size='0.85' shadow='0' align='center'>" + _footer + "</t>";
				sleep 0.1; 
				[_string,0,0.2,0.5,0,0,4] spawn BIS_fnc_dynamicText;
			};
		};
	};

//-------------- Whole map or zone locations?
if (_wholeMap) then
{
	//--------------------------------------------------------------Create a ceneter trigger --------------------------------------------------------------------------
	private ["_worldPath","_mapSize","_mapCenter"]; 
	
	if (isnil "hsim_worldArea") then 
	{
		_worldPath = configfile >> "cfgworlds" >> worldname;
		_mapSize = getnumber (_worldPath >> "mapSize");
		if (_mapSize == 0) then 
		{
			diag_log FORMAT ["MCC: Mission Wizard Error: mapSize param not defined for '%1'",worldname];
			MCC_MWisGenerating = false;
			["mapSize param not defined for '%1'",worldname] call bis_fnc_halt;
		};
		
		_mapSize = _mapSize / 2;

		_mapCenter = [
			_mapSize,
			_mapSize
		];

		hsim_worldArea = createtrigger ["emptydetector",_mapCenter];
		hsim_worldArea settriggerarea [_mapSize,_mapSize,0,true];
	};
	MWMissionArea = hsim_worldArea;
	
	//First time? Let's map the island
	if (isnil "MCC_MWcityLocations") then
	{
		MCC_MWcityLocations     = [getpos MWMissionArea,1000000,"city"] call MCC_fnc_MWbuildLocations;
		MCC_MWmilitaryLocations = [getpos MWMissionArea,1000000,"mil"] call MCC_fnc_MWbuildLocations;
		MCC_MWhillsLocations 	= [getpos MWMissionArea,1000000,"hill"] call MCC_fnc_MWbuildLocations;
		MCC_MWnatureLocations 	= [getpos MWMissionArea,1000000,"nature"] call MCC_fnc_MWbuildLocations;
		MCC_MWmarineLocations	= [getpos MWMissionArea,1000000,"marine"] call MCC_fnc_MWbuildLocations;
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
	_center = [getpos MWMissionArea,2000,_isCQB,MCC_MWBasedLocations] call MCC_fnc_MWFindMissionCenter;
	if (isNil "_center") exitWith 
	{
		diag_log "MCC: Mission Wizard Error: Can't find mission center"; 
		MCC_MWisGenerating = false;
		["MCC: Mission Wizard Error: Can't find mission center try building your mission in a zone"] call bis_fnc_halt;
	}; 

	_missionCenter = _center select 0; 
}
else
{
	//--------------------------------------------------------------Create a ceneter trigger --------------------------------------------------------------------------
	if (count mcc_zone_markposition == 0) exitWith 
	{
		diag_log "MCC: Mission Wizard Error: Create a zone first"; 
		MCC_MWisGenerating = false;
		["MCC: Mission Wizard Error: Create a zone first"] call bis_fnc_halt;
	};
	
	MWMissionArea = createtrigger ["emptydetector",mcc_zone_markposition];
	MWMissionArea settriggerarea [mcc_zone_marker_X,mcc_zone_marker_Y,0,true];
	hsim_worldArea = MWMissionArea;
	
	private "_radius";
	_radius = (mcc_zone_marker_X + mcc_zone_marker_Y)/2;
	//Let's map the area
	MCC_MWcityLocations     = [getpos MWMissionArea,_radius,"city"] call MCC_fnc_MWbuildLocations;
	MCC_MWmilitaryLocations = [getpos MWMissionArea,_radius,"mil"] call MCC_fnc_MWbuildLocations;
	MCC_MWhillsLocations 	= [getpos MWMissionArea,_radius,"hill"] call MCC_fnc_MWbuildLocations;
	MCC_MWnatureLocations 	= [getpos MWMissionArea,_radius,"nature"] call MCC_fnc_MWbuildLocations;
	MCC_MWmarineLocations	= [getpos MWMissionArea,_radius,"marine"] call MCC_fnc_MWbuildLocations;
	publicvariable "MCC_MWcityLocations";
	publicvariable "MCC_MWmilitaryLocations";
	publicvariable "MCC_MWhillsLocations";
	publicvariable "MCC_MWnatureLocations";
	publicvariable "MCC_MWmarineLocations";
	sleep 2; //Give some time for the values to get to the server

	//Find out if the map have locations in it. 
	MCC_MWBasedLocations = if (_isCQB) then 
							{
								if ((count MCC_MWcityLocations)>1 || (count MCC_MWmilitaryLocations)>1) then {true} else {false};
							}
							else
							{
								if ((count MCC_MWhillsLocations)>1 || (count MCC_MWnatureLocations)>1) then {true} else {false};
							};
	
	//Find mission center
	_center = [getpos MWMissionArea,_radius,_isCQB,MCC_MWBasedLocations] call MCC_fnc_MWFindMissionCenter;
	
	if (isNil "_center") exitWith 
	{
		player sidechat "MCC: Mission Wizard Error: Can't find mission center try building your mission in a zone"; 
		diag_log "MCC: Mission Wizard Error: Can't find mission center"; 
		MCC_MWisGenerating = false;
	}; 

	_missionCenter = _center select 0; 
};

_missionCenterTrigger = createtrigger ["emptydetector",_missionCenter];
_missionCenterTrigger settriggerarea [_maxObjectivesDistance*2.5,_maxObjectivesDistance*2.5,0,false];
MCC_MWmissionsCenter set [count MCC_MWmissionsCenter, _missionCenterTrigger]; 
publicvariable "MCC_MWmissionsCenter"; 

diag_log format ["MCC Mission Wizard center = %1", _missionCenter];

//Create the marker
[1, "ColorRed",[_maxObjectivesDistance*3,_maxObjectivesDistance*3], "ELLIPSE", "Border", "Empty", FORMAT ["MCCMW_operationMarker_%1",["MCCMW_operationMarker",1] call bis_fnc_counter], _missionCenter] call MCC_fnc_makeMarker;





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
		
		if (isnil "_objPos") exitWith
		{
			player sidechat "MCC: Mission Wizard Error: Can't find good objective's position try again"; 
			diag_log "MCC: Mission Wizard Error: Can't find good objective's position try again"; 
			MCC_MWisGenerating = false;
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
				[[_objPos, _isCQB, true, _side, _faction, _sidePlayer, _factionPlayer,_preciseMarkers], "MCC_fnc_MWObjectiveHVT", false, false] call BIS_fnc_MP;
			};
			
		  case "Kill HVT":		
			{
				[[_objPos, _isCQB, false, _side, _faction, _sidePlayer, faction player,_preciseMarkers], "MCC_fnc_MWObjectiveHVT", false, false] call BIS_fnc_MP;
			};
			
		  case "Destroy Object":		
			{
				[[_objPos, _isCQB, _side, _faction,_preciseMarkers], "MCC_fnc_MWObjectiveDestroy", false, false] call BIS_fnc_MP;
			};
			
		  case "Aquire Intel":		
			{
				[[_objPos, _isCQB, _side, _faction,_preciseMarkers], "MCC_fnc_MWObjectiveIntel", false, false] call BIS_fnc_MP;
			};
			
		 case "Clear Area":		
			{
				[[_objPos, _isCQB,_side, _faction,_sidePlayer,_preciseMarkers], "MCC_fnc_MWObjectiveClear", false, false] call BIS_fnc_MP;
			};
			
		 case "Disarm IED":		
			{
				[[_objPos, _isCQB,_side, _faction,_sidePlayer,_preciseMarkers], "MCC_fnc_MWObjectiveDisable", false, false] call BIS_fnc_MP;
			};
		};
		
		//Stealth mission
		if (_stealth) then
		{
			private ["_activate","_cond","_alarm"];
			switch (_sidePlayer) do	
				{
					case west: {_activate =  "WEST"; _cond = "WEST D"};
					case east: {_activate =  "EAST"; _cond = "EAST D"};
					case resistance: {_activate =  "GUER"; _cond = "GUER D"};
					case civilian: {_activate =  "CIV"; _cond = "CIV D"};
				};
			_alarm = "Land_Loudspeakers_F" createVehicle ([_objPos,1,100,10,0,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos);
			[["", getpos _alarm, 100, 100, _activate, _cond,"AlarmSfx",false],"MCC_fnc_MusicTrigger",true,false] spawn BIS_fnc_MP;
		};
		
		sleep 1;
		
		waituntil {!isnil "MCC_MWObjectivesNames"};
		_objPos = MCC_MWObjectivesNames select 0;
		
		//Lets create a zone
		_zoneNumber =["MCCZoneCounter",1] call bis_fnc_counter; 
		_script_handler = [_zoneNumber,_objPos,_maxObjectivesDistance] call MCC_fnc_MWUpdateZone; 
		waituntil {_script_handler}; 

		//Spawn some Infantry groups
		_spawnbehavior	= ["NOFOLLOW","bisd"] call BIS_fnc_selectRandom; 
		_unitPlaced = [(_totalEnemyUnits*0.2),_zoneNumber,_spawnbehavior] call MCC_fnc_MWSpawnInfantry; 
		if (MW_debug) then {diag_log format ["Total enemy's infantry Spawned in zone%1: %2", _zoneNumber,_unitPlaced]};
		
		// Is CQB
		if (_isCQB) then 
		{
			[[_objPos,(_maxObjectivesDistance*0.5),0,(_totalEnemyUnits*0.008),_faction,str _side],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
		}; 
		
		// Is _isCiv
		if (_isCiv) then 
		{
			[[_objPos,(_maxObjectivesDistance*0.5),1,(_totalEnemyUnits*0.008),"CIV_F","CIV"],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
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
	/*
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
						
						//Car or hidden?
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
	*/
		_objectives set [count _objectives, MCC_MWObjectivesNames]; 
	};
};



//-----------------------------------------------------------------------------Main zone-----------------------------------------------------------------------------------------------
private ["_zoneNumber","_unitPlaced","_safepos","_factor"];

//Let'screate the main zone and placing units
_zoneNumber =["MCCZoneCounter",1] call bis_fnc_counter; 

//Create Zone
_script_handler = [_zoneNumber,_missionCenter,_maxObjectivesDistance*2.5] call MCC_fnc_MWUpdateZone; 
waituntil {_script_handler}; 

//Spawn some Infantry groups
_spawnbehavior	= ["MOVE","MOVE","MOVE","NOFOLLOW"] call BIS_fnc_selectRandom; 
_factor = if (_isCQB) then {0.3} else {0.6}; 
_unitPlaced = [(_totalEnemyUnits * _factor),_zoneNumber,_spawnbehavior] call MCC_fnc_MWSpawnInfantry; 
if (MW_debug) then {diag_log format ["Total enemy's infantry Spawned in main zone: %1", _unitPlaced]};

//Vehicles
if (_vehicles) then
{
	_unitPlaced = [(_totalEnemyUnits*0.6),_zoneNumber,MCC_MWGroupArrayCar,MCC_MWunitsArrayCar,5,15,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//Armor
if (_armor) then
{
	_unitPlaced = [(_totalEnemyUnits*0.4),_zoneNumber,MCC_MWGroupArrayArmored,MCC_MWunitsArrayArmored,10,30,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Armor Spawned in main zone: %1", _unitPlaced]};
};

//Support
if (_vehicles && (random 1 > 0.5)) then
{
	_unitPlaced = [(_totalEnemyUnits*0.3),_zoneNumber,MCC_MWGroupArraySupport,MCC_MWunitsArraySupport,10,30,"LAND"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Support Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//Artillery
if (_artillery != 0) then
{
	[[(_totalEnemyUnits*0.2),_missionCenter,_maxObjectivesDistance,MCC_MWunitsArrayStatic,5,10,_side,_artillery,_zoneNumber],"MCC_fnc_MWSpawnStatic",false,false] spawn BIS_fnc_MP;
	if (MW_debug) then {diag_log "Enemy's Artillery Spawned in main zone"};
};

//Static
if (random 1 > 0.3) then
{
	[[(_totalEnemyUnits*0.2),_missionCenter,_maxObjectivesDistance,MCC_MWunitsArrayStatic,4,8,_side,999,_zoneNumber],"MCC_fnc_MWSpawnStatic",false,false] spawn BIS_fnc_MP;
	if (MW_debug) then {diag_log "Enemy's Static Weapons Spawned in main zone"};
};

//Ship
_safepos =[_missionCenter ,1,(_maxObjectivesDistance*3.5),2,2,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos; //Check if they are water
if (str _safepos != "[-500,-500,0]") then
{
	_unitPlaced = [(_totalEnemyUnits*0.2),_zoneNumber,MCC_MWGroupArrayShip,MCC_MWunitsArrayShip,5,15,"WATER"] call MCC_fnc_MWSpawnVehicles;
	if (MW_debug) then {diag_log format ["Total enemy's Ships Vehicles Spawned in main zone: %1", _unitPlaced]};
};

//CheckPoints
if (_isRoadblocks) then
{
	_roadPositions = [_missionCenter,(_maxObjectivesDistance*1.7)] call MCC_fnc_findRoadsLeadingZone;
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
	_roadPositions = [_missionCenter,(_maxObjectivesDistance*1.3)] call MCC_fnc_findRoadsLeadingZone;
	if (count _roadPositions >0) then
	{
		_unitsArray 	= ["CIV_F","carx"] call MCC_fnc_makeUnitsArray;
		{
			if (random 1 > 0.3) then 
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
				[[_iedpos,_objectType,"large",floor (random 2),2,false,0,((random 25) + 15),_sidePlayer,_name,_dir,_groupArray,_side],"MCC_fnc_trapSingle",false,false] spawn BIS_fnc_MP;
			
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

//Reinforcment
if (_reinforcement in [1,2,3]) then 
{
	private ["_cond","_end"];
	_cond = [0.3];
	_end = [0,0,0,0,0,0,0,1,1,1,2] call BIS_fnc_selectRandom; 
	for "_x" from 1 to _end step 1 do 
	{
		_cond set [_x, (_cond select (_x-1)) + 0.3];
	};
	
	[[_reinforcement,_side,getpos _missionCenterTrigger, triggerArea _missionCenterTrigger, _cond,_zoneNumber,_faction,MW_debug,_totalEnemyUnits],"MCC_fnc_MWreinforcement",false,false] call BIS_fnc_MP;
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
	
	private "_monthFactor";
	_monthFactor = [1,1,0.8,0.8,0.6,0.4,0.2,0.2,0.4,0.6,0.8,1] select ((MCC_date select 1)-1);
				//     1 , 2,  3   , 4    , 5     , 6    , 7   , 8    , 9    , 10   , 11   , 12
	
	MCC_Overcast	= (random (_monthFactor/2)) + _monthFactor/2;
	MCC_WindForce 	= (random (_monthFactor/2)) + _monthFactor/2;
	MCC_Waves 		= (random (_monthFactor/2)) + _monthFactor/2;
	
	if (MCC_Overcast > 0.6) then
	{
		MCC_Rain 		= (random (_monthFactor/2)) + _monthFactor/2;
		MCC_Lightnings	= (random (_monthFactor/2)) + _monthFactor/2;
		MCC_Fog 		= ((random (_monthFactor/2)) + _monthFactor/2)/5; 
		
		publicVariable "MCC_Overcast";
		publicVariable "MCC_WindForce";
		publicVariable "MCC_Waves";
		publicVariable "MCC_Rain";
		publicVariable "MCC_Lightnings";
		publicVariable "MCC_Fog";
		
		[[[MCC_Overcast, MCC_WindForce, MCC_Waves, MCC_Rain, MCC_Lightnings, MCC_Fog]],"MCC_fnc_setWeather",true,false] call BIS_fnc_MP;
	}
	else
	{
		[[[MCC_Overcast, MCC_WindForce, MCC_Waves]],"MCC_fnc_setWeather",true,false] call BIS_fnc_MP;
		publicVariable "MCC_Overcast";
		publicVariable "MCC_WindForce";
		publicVariable "MCC_Waves";
	};
};			
			
			
// ------------------  CREATE BRIEFINGS --------------------------------------------------------------------------
//-----------------  CREATE BRIEFINGS --------------------------------------------------------------------------
private ["_night","_factionName","_music","_missionName1","_missionName2","_html","_control","_tempText"];
_missionName1 = ["Desert","Oversized","Roguish","Smouldering","Cold","Flaring","Furious","Silver","Vengeance","Yellow","Red","Blue","White","Gold","Dark","Broken",
                 "Morbid","Flying","Living","Swift","Evil","Fallen","False","Solitary","Broken","Alpha","Bravo","Charlie","Delta","Echo","Foxtrot"] call BIS_fnc_selectRandom; 
_missionName2 = ["Storm","Lightning","Rain","Thunder","Tornado","Hurricane","Flood","Dragonfly","Ocelot","Cobra","Fiend","Father","Horse","Thorn",
                 "Urgency","Snake","Serpent","Famine","Cage","Contempt","Priest","Stranger","Dagger","One","Two","Three","Zero","Arrow"] call BIS_fnc_selectRandom; 
_night = if ((date select 3)>19 || (date select 3)<6) then {true} else {false}; 
_factionName = getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName");
//Location
if ((_center select 1) != "") then
{
        _tempText = ["Attack On","The Battle For","Assault On","The Fight For"] call BIS_fnc_selectRandom; 
        _html = format ["<t size='1.1' color='#a8e748' underline='true' align='center'>Operation: </t><t size='1.1' color='#a8e748' underline='true' align='center'>%1 %2. %3 %4</t>",toupper _missionName1,toupper _missionName2,_tempText,(_center select 1)];
}
else
{
        _html = format ["<t size='1.1' color='#a8e748' underline='true' align='center'>Operation: </t><t size='1.1' color='#a8e748' underline='true' align='center'>%1 %2.</t>",toupper _missionName1,toupper _missionName2];
};
//General
_tempText = ["presence in the area has been increasing","have established a foothold in the area","forces are active in the area"] call BIS_fnc_selectRandom; 
_html = _html + format ["<br/><br/><t size='0.8' color='#E2EEE0'>%1 %2.</t>",_factionName,_tempText];

//_isCQB
if (_isCQB) then
{
    _tempText = ["They have taken up defensive positions inside buildings","They are using civilian buildings to fortify themselves"] call BIS_fnc_selectRandom; 
    _html = _html + format ["<t size='0.8' color='#E2EEE0'> %1.</t>",_tempText];
};
_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>HQ informs us that infantry are present. </t>",_factionName];
//_vehicles
if (_vehicles) then
{
    _html = _html + format ["<t size='0.8' color='#E2EEE0'>You may also encounter %1 technicals or soft vehicles. </t>",_factionName];
};
//_armor
if (_armor) then
{
    _html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>Be aware that there may be %1 armored vehicles or even MBT's operating in the OP.</t>",_factionName];
};

//Artillery
if (_artillery != 0) then
{
	_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>%1 may also have artillery operating in the area.</t>",_factionName];
};

//_isRoadblocks
if (_isRoadblocks) then
{
    _html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>%1 forces have established hasty checkpoints on some of the roads leading in and out of the area.</t>",_factionName];
};
//_isIED
if (_isIED || _isSB) then
{
    _html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>Keep an eye out for anything that might look suspicious, as we believe that %1 may employ IEDs, or even suicide attacks. </t>",_factionName];
};
//_isAS
if (_isAS) then
{
    _html = _html + format ["<t size='0.8' color='#E2EEE0'>The local civilians support %1, so be on the look out for any strange behavior. But keep civilian casualties to a minimum as the top Brass don't want to draw unnecessary attention.</t>",_factionName];
};

//Reinforcment
if (_reinforcement in [1,2,3] || _stealth) then 
{
	private "_text";
	_text = switch (_reinforcement) do
			{
				case 0: 	
				{ 
					""
				};
				
				case 1: 	
				{ 
					" aerial "
				};
				
				case 2: 	
				{ 
					" motorized "
				};
				
				case 3: 	
				{ 
					" aerial and motorized "
				};
			};
			

	_html = _html +"<br/><t size='0.8' color='#E2EEE0'>The enemy have" + _text + "QRF forces nearby. Expect enemy reinforcements should they become aware of your presence.</t>";
};

_html = _html + format ["<br/><t size='0.8' color='#E2EEE0'>Go over your objectives, gear up and get ready.<br/>Mission is a go!</t>",_factionName];

_music = ["LeadTrack01a_F","LeadTrack02_F","LeadTrack03_F","LeadTrack04a_F","LeadTrack05_F","LeadTrack06_F","AmbientTrack03_F","BackgroundTrack03_F","BackgroundTrack01_F",
           "BackgroundTrack01a_F","BackgroundTrack02_F","LeadTrack01_F_EPA","LeadTrack02_F_EPA","EventTrack01_F_EPA","EventTrack01a_F_EPA","EventTrack03_F_EPA"] call BIS_fnc_selectRandom; 
[[2,compile format ["playMusic '%1'",_music]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;

//move that into client side
[[_missionCenter,_objectives,overcast,_night,1,_html], "MCC_fnc_MWopenBriefing", true, false] spawn BIS_fnc_MP;

//Clear up
MCC_MWisGenerating = false; 
deleteVehicle hsim_worldArea;
hsim_worldArea = nil; 
deleteVehicle MWMissionArea;
MWMissionArea = nil; 