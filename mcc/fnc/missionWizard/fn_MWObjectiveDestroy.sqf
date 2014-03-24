//======================================================MCC_fnc_ObjectiveDestroy=========================================================================================================
// Create a Destroy objective
// Example:[_objPos,_isCQB,_side,_faction] call MCC_fnc_ObjectiveDestroy; 
// _objPos = position, objectice position
//_isCQB = Boolean, true - for CQB areay false if it doesn't matters. 
//_side = enemy side
//_faction = enemy Faction
// Return - nothing
//========================================================================================================================================================================================
private ["_objPos","_isCQB","_side","_faction","_preciseMarkers","_type","_objType","_typeSize","_spawnPos",
         "_object","_dummyObject","_spawndir","_unitsArray","_group","_init","_range"];

_objPos = _this select 0;
_isCQB = _this select 1;
_side = _this select 2;
_faction = _this select 3;
_preciseMarkers = _this select 4; 

_objType = ["fuel","radio","tanks","aa","artillery","air","cache","radar"] call BIS_fnc_selectRandom;


//What do we spawn
switch _objType do	
	{
		case "fuel": 
		{
			_type =  MCC_MWFuelDeop call BIS_fnc_selectRandom;
		};
		
		case "radio": 
		{
			_type =  MCC_MWRadio call BIS_fnc_selectRandom;
		};
		
		case "tanks": 
		{
			_type =  MCC_MWTanks call BIS_fnc_selectRandom;
		};
		
		case "aa": 
		{
			_type = switch _side do	
					{
						case west: 
						{
							MCC_MWAAB call BIS_fnc_selectRandom;
						}; 
						
						case east: 
						{
							MCC_MWAAO call BIS_fnc_selectRandom;
						}; 
						
						case resistance: 
						{
							MCC_MWAAI call BIS_fnc_selectRandom;
						}; 
						
						case default 
						{
							MCC_MWAAB call BIS_fnc_selectRandom;
						}; 
					};
		};
		
		case "artillery": 
		{
			_type = switch _side do	
					{
						case west: 
						{
							MCC_MWArtilleryB call BIS_fnc_selectRandom;
						}; 
						
						case east: 
						{
							MCC_MWArtilleryO call BIS_fnc_selectRandom;
						}; 
						
						case resistance: 
						{
							MCC_MWArtilleryI call BIS_fnc_selectRandom;
						}; 
						
						case default 
						{
							MCC_MWArtilleryB call BIS_fnc_selectRandom;
						}; 
					};
		};
		
		case "air": 
		{
			_type =  MCC_MWAir call BIS_fnc_selectRandom;
		};
		
		case "cache": 
		{
			_type =  MCC_MWcache call BIS_fnc_selectRandom;
		};
		
		case "radar": 
		{
			_type =  MCC_MWradar call BIS_fnc_selectRandom;
		};
		
		default 
		{
			_type =  MCC_MWFuelDeop call BIS_fnc_selectRandom;
		};
	};

//How big is it
_typeSize = switch _objType do	
				{
					case "tanks": 
					{
						"Land_dp_bigTank_F"
					};
					
					case "aa": 
					{
						"Land_dp_bigTank_F"
					};
					
					case "artillery": 
					{
						"Land_dp_bigTank_F"
					};
					
					case "air": 
					{
						"Land_TentHangar_V1_F"
					};
					
					case "cache": 
					{
						"Land_dp_smallTank_F"
					};
					
					default 
					{
						_type
					};
				};	
				
//Find an empry spot
_range = 50;
_spawnPos = [_objPos,1,_range,10,0,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;

//If we haven't find it in first time increase by 50; 
while {str _spawnPos == "[-500,-500,0]"} do
{
	_range = _range+ 50; 
	_spawnPos = [_objPos,1,_range,10,0,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	//_spawnPos = _objPos findEmptyPosition [0,200,_typeSize];
};


//Case we are dealing with a vehicle
if (_objType in ["tanks","aa","artillery"]) then
{
	_dummyObject =[_spawnPos, random 360, "c_nestBig"] call MCC_fnc_objectMapper;
	_spawnPos = getpos _dummyObject;
	_spawndir = getdir _dummyObject;
};

//If artillery let's delete the camonet
if (_objType == "artillery") then
{
	deletevehicle (nearestObject [getpos _dummyObject, "CamoNet_BLUFOR_big_F"]);
};

//Case we are dealing with ammo cache
if (_objType == "cache") then
{
	_dummyObject = [_spawnPos, random 360, "c_nestSmall"] call MCC_fnc_objectMapper;
	_spawnPos = getpos _dummyObject;
	_spawndir = getdir _dummyObject;
};

//Case we are dealing with a Air
if (_objType == "air") then
{
	_dummyObject =[_spawnPos, random 360, "c_hanger"] call MCC_fnc_objectMapper;
	_spawnPos = getpos _dummyObject;
	_spawndir = getdir _dummyObject;
};

 
 if (isnil "_spawndir") then {_spawndir = random 360};
 
 //Create the object
_object = _type createvehicle _spawnPos;
_object setpos _spawnPos;
_object setdir _spawndir;

//destroy only with satchel 
if (_objType in ["tanks","aa","artillery","air"]) then
{
	//_init = '_this addEventHandler ["handledamage", {if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo"]) then {(_this select 0) setdamage 1} else {0}}];' + '_this setVehicleLock "LOCKED";'; 
	_init = '_this setVehicleLock "LOCKED";'; 
	if (_objType =="artillery") then {_init = _init + "createVehicleCrew _this;[0,_this] spawn MCC_fnc_amb_Art;"}; 
	[[[netID _object,_object], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
};



//Start Briefings
switch _objType do	
{
	case "tanks": 
	{
		[_object,"destroy_tanks",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "aa": 
	{
		[_object,"destroy_aa",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "artillery": 
	{
		[_object,"destroy_artillery",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "air": 
	{
		[_object,"destroy_tanks",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "cache": 
	{
		[_object,"destroy_cache",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "fuel": 
	{
		[_object,"destroy_fuel",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "radio": 
	{
		[_object,"destroy_radio",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
	
	case "radar": 
	{
		[_object,"destroy_radar",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
		
	default 
	{
		[_object,"destroy_cache",_preciseMarkers] call MCC_fnc_MWCreateTask; 
	};
};


/*//Lets spawn some body guards
_unitsArray = [_faction ,"soldier"] call MCC_fnc_makeUnitsArray;		//Let's build the faction unit's array

_group = creategroup _side; 
_unit = _object;
for [{_i=0},{_i<4},{_i=_i+1}] do 
{
	_type = _unitsArray select round (random 4); 	
	_spawnPos = (getpos _unit) findEmptyPosition [10,200,(_type select 0)]; 
	_unit = _group createUnit [_type select 0,_spawnPos,[],0.5,"NONE"];
	waituntil {alive _unit}; 
};

[_group, _spawnPos] call bis_fnc_taskDefend;