//==================================================================MCC_fnc_trackUnits===============================================================================================
//Track units on the given map display
// Example: [] call MCC_fnc_trackUnits; 
//==================================================================================================================================================================================
private ["_map","_leader","_markerColor","_mapsize","_group","_texture","_unit"]; 
_map = _this select 0;

{
	_group = _x; 
	_leader = (leader _group);
	switch (format ["%1", side  _x]) do 
		{
		case "EAST": //East
			{
				_markerColor = [1,0,0,0.8];
			}; 
			
		case "WEST": //West
			{
				_markerColor = [0,0,1,0.8];
			};
			
		case "GUER": //Resistance
			{
				_markerColor = [0,1,0,0.8];
			};
		case "CIVILIAN": //Civilian
			{
				_markerColor = [1,1,1,0.8];
			};	
		}; 
			
	{
		_unit = _x; 
		
		if (vehicle _unit == _unit || ((vehicle _unit != _unit) && (_unit == driver vehicle _unit))) then
		{
			_texture = gettext (configfile >> "CfgVehicles" >> typeof (vehicle _unit) >> "Icon");
			_mapsize = if ((vehicle _unit) == _unit) then {20} else {30}; 
			
			if (isPlayer _unit) then {_markerColor = [_markerColor select 0, _markerColor select 1, _markerColor select 2, 0.3]}; 
			_map drawIcon [
				_texture,
				_markerColor,
				getpos _unit,
				_mapsize,
				_mapsize,
				direction _unit
			];

			if (_x != leader _group) then
			{
				_map drawLine [
					getpos _unit,
					getpos (leader _group),
					[0,0,1,0.8]
				];
			};
		};
	} foreach (units _group); 
	
} foreach allgroups; 
