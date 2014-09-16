private ["_name","_type","_cityLocations","_militaryLocations","_natureLocations","_hillsLocations","_marineLocations","_pos","_radius","_type","_locations","_markerColor","_locationsArray"];
_mcc_zone =  _this select 0;
_mcc_gaia_density = 1;


mcc_delayed_spawn		= TRUE;


//Buildup the unit arrays
[mcc_faction,mcc_sidename] call MCC_fnc_MWCreateUnitsArray;

_cityLocations = ["Airport","CityCenter","FlatAreaCity","FlatAreaCitySmall","NameCity","NameCityCapital","NameVillage"]; 
_militaryLocations = ["BorderCrossing","Strategic","StrongpointArea"];
_hillsLocations = ["Hill","Mount","RockArea","ViewPoint"]; 
_marineLocations = ["NameMarine"]; 
_natureLocations = ["Flag","FlatArea","Name","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]; 

//Make vehicles move around the big area
_points = (round(((getmarkersize _mcc_zone select 0) max (getmarkersize _mcc_zone select 1))/100))*_mcc_gaia_density;
//Ship
		_missionCenter = getmarkerpos _mcc_zone;
		_safepos =[_missionCenter ,1,(((getmarkersize _mcc_zone select 0) max (getmarkersize _mcc_zone select 1))*3.5),2,2,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos; //Check if they are water
		if (str _safepos != "[-500,-500,0]") then
		{
			_unitPlaced = [(_points*0.6),parsenumber _mcc_zone,MCC_MWGroupArrayShip,MCC_MWunitsArrayShip,5,15,"WATER"] call MCC_fnc_MWSpawnVehicles;
			
		};

_unitPlaced = [(_points*2),parsenumber _mcc_zone,MCC_MWGroupArrayCar,MCC_MWunitsArrayCar,5,15,"LAND"] call MCC_fnc_MWSpawnVehicles;

//Build city locations
{
//Let'screate the main zone and placing units
_zoneNumber = (count MCC_zones_numbers) + 1;
_oc_size    = (((size _x)select 0) max ((size _x)select 1));

//Occupy citylocations
if ((((size _x)select 0)>50) and (((size _x)select 0)>50)) then
	{
		_script_handler = [_zoneNumber,locationPosition _x,_oc_size] call MCC_fnc_MWUpdateZone; 
		waituntil {_script_handler}; 
		_spawnbehavior	= ["NOFOLLOW","MOVE","FORTIFY","FORTIFY"] call BIS_fnc_selectRandom; 
		_points = (round(((getmarkersize _mcc_zone select 0) + (getmarkersize _mcc_zone select 1))/450))*_mcc_gaia_density;
		//_points = 3;
		_missionCenter = getmarkerpos (str _zoneNumber);
		
		_unitPlaced = [(_points),_zoneNumber,_spawnbehavior] call MCC_fnc_MWSpawnInfantry; 
		
		
	
		[[_zoneNumber],"MCC_fnc_MWspawnAnimals",false,false] spawn BIS_fnc_MP;
	
		if (random(1) >0.5) then
		{_unitPlaced = [(_points*.6),_zoneNumber,MCC_MWGroupArrayCar,MCC_MWunitsArrayCar,5,15,"LAND"] call MCC_fnc_MWSpawnVehicles;};
	
	
	//Armor
		if (random(1) >0.5) then
		{_unitPlaced = [(_points*0.2),_zoneNumber,MCC_MWGroupArrayArmored,MCC_MWunitsArrayArmored,10,30,"LAND"] call MCC_fnc_MWSpawnVehicles;};
	
	
	//Support
		if (random(1) >0.5) then
		{_unitPlaced = [(_points*0.2),_zoneNumber,MCC_MWGroupArraySupport,MCC_MWunitsArraySupport,10,30,"LAND"] call MCC_fnc_MWSpawnVehicles;};
	
		
	
	
		//Ship
		if (random(1) >0.5) then
		{
			_safepos =[_missionCenter ,1,(_oc_size*3.5),2,2,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos; //Check if they are water
			if (str _safepos != "[-500,-500,0]") then
			{
				_unitPlaced = [(_points*0.6),_zoneNumber,MCC_MWGroupArrayShip,MCC_MWunitsArrayShip,5,15,"WATER"] call MCC_fnc_MWSpawnVehicles;
				
			};
		};
	
	
	};
} foreach	nearestLocations [(getmarkerpos _mcc_zone),_cityLocations, ((getmarkersize _mcc_zone select 0) max (getmarkersize _mcc_zone select 1))];

//mcc_delayed_spawn		= _mcc_was_delayed;
