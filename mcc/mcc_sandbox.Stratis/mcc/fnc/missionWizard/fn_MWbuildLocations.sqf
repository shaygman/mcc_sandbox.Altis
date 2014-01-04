//======================================================MCC_fnc_MWbuildLocations=========================================================================================================
//If the map have locations system it will build the locations
// Example: [_pos,_Radius,_type] call MCC_fnc_MWbuildLocations; 
// _pos = position, from where to start looking.
//_Radius = integer, radius to search distance from _pos
//_type = string, "city","mil","hill","marine","nature"
// Return - _locationsArray - array [[location,name],[location,name],[location,name].....]
//========================================================================================================================================================================================
private ["_name","_type","_cityLocations","_militaryLocations","_natureLocations","_hillsLocations","_marineLocations","_pos","_radius","_type","_locations","_markerColor","_locationsArray"];
_pos 	= _this select 0;
_radius = _this select 1;
_type 	= _this select 2;

_cityLocations = ["Airport","CityCenter","FlatAreaCity","FlatAreaCitySmall","NameCity","NameCityCapital","NameVillage"]; 
_militaryLocations = ["BorderCrossing","Strategic","StrongpointArea"];
_hillsLocations = ["Hill","Mount","RockArea","ViewPoint"]; 
_marineLocations = ["NameMarine"]; 
_natureLocations = ["Flag","FlatArea","Name","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]; 
_locationsArray = []; 

switch (tolower _type) do
{
	case "city":	
	{ 
		_locations = _cityLocations;
		_markerColor = "ColorGreen";
	};
	
	case "mil":	
	{ 
		_locations = _militaryLocations;
		_markerColor = "ColorRed";
	};
	
	case "hill":	
	{ 
		_locations = _hillsLocations;
		_markerColor = "ColorBlack";
	};
	
	case "marine":	
	{ 
		_locations = _marineLocations;
		_markerColor = "ColorYellow";
	};
	
	case "nature":	
	{ 
		_locations = _natureLocations;
		_markerColor = "ColorBlue";
	};
};

if (isnil "_locations") exitWith (diag_log "MCC MW: fn_MWbuildLocations no type of location was selected"); 
		
{	
	_type = type _x;
	_name = text _x;
	_locationsArray set [count _locationsArray, [_x,_name]];
	if (CP_debug) then
	{
		createmarkerlocal [_name ,getpos _x];
		_name setmarkertypelocal "mil_box";
		_name setMarkerTextLocal format ["%1: %2",_name, _type];
		_name setmarkerColorlocal _markerColor;
		_name setMarkerSizeLocal [0.3, 0.3];
	};

} foreach nearestLocations [_pos,_locations, _radius];

_locationsArray
