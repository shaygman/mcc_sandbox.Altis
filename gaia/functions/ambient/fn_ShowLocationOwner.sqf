private ["_all","_oc_size","_mrk"];

_refpoint 	= position player;
_all 				= ["Airport","CityCenter","FlatAreaCity","FlatAreaCitySmall","NameCity","NameCityCapital","NameVillage","BorderCrossing","Strategic","StrongpointArea","Hill","Mount","RockArea","ViewPoint","NameMarine","Flag","FlatArea","Name","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
_sideRatios = [];
_mrk        = "";
_MarkerType = "";
_MarkerColor= "";

//Build city locations
{
	_oc_size    = (((size _x)select 0) max ((size _x) select 1));
	if (_oc_size>10) then
	{
		if ( (getMarkerType  (str(_x))) == "") then
		{
			 _mrk = createMarker [(str(_x)), (locationPosition _x ) ];
			 //_mrk setMarkerType "mil_dot";_mrk setMarkerColor "ColorBlue"			 
		}
		else
		{
			_mrk = str(_x);
		};
		_sideRatios = [(locationPosition _x)] call GAIA_fnc_getsideratio;
		_tot = (_sideRatios select 0) + (_sideRatios select 1) + (_sideRatios select 2);
		_set = false;
		if (_tot > 0) then 
		{
		if ((_sideRatios select 0)==_tot) then {_MarkerType = "mil_dot";_MarkerColor = "ColorBlue";_set=true;  };
		if ((_sideRatios select 1)==_tot) then {_MarkerType = "mil_dot";_MarkerColor = "ColorRed";_set=true;   };
		if ((_sideRatios select 2)==_tot) then {_MarkerType = "mil_dot";_MarkerColor = "ColorGreen";_set=true;   };
		};
		if !(_set) 								  	 then {_MarkerType ="mil_warning";_MarkerColor = "ColorWhite";_set=true;   };
		
		if ((getMarkerType  _mrk) != _MarkerType) then {_mrk setMarkerType  _MarkerType;};
		if ((getMarkerColor _mrk) != _MarkerColor) then {_mrk setMarkerColor  _MarkerColor;}
		
	};
	
	
	
} foreach nearestLocations [_refpoint, _all, 300000];

//mcc_delayed_spawn		= _mcc_was_delayed;
