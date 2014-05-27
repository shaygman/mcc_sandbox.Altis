
	//==================================================================KEGs_fnc_trackUnits===============================================================================================
	//Track units on the given map display
	// Example: [] call KEGs_fnc_trackUnits; 
	//==================================================================================================================================================================================
	private ["_map","_leader","_markerColor","_mapsize","_group","_texture","_unit"]; 
	
	disableSerialization;
	
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
				
				if (isPlayer _unit) then {_markerColor = [1, 0, 1,0.8]}; 
				
				_map drawIcon [
					_texture,
					_markerColor,
					getposATL _unit,
					_mapsize,
					_mapsize,
					direction vehicle _unit
				];
				
				if (_x != leader _group) then
				{
					_map drawLine [
						getposATL _unit,
						getposATL (leader _group),
						[0,0,1,0.8]
					];
				};				
				
				//if (!isnil "KEGscam_lockon") then
				//{
					private ["_size"];
					_bbr = boundingBoxReal vehicle _unit;
					_p1 = _bbr select 0;
					_p2 = _bbr select 1;
					_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
					
					_size =if ((1.5 - ((KEGscam_lockon distance vehicle _unit)*0.001)) < 0) then {0} else {(1.5 - ((KEGscam_lockon distance vehicle _unit)*0.001))};
					
					if (_size > 0) then
					{
						drawIcon3D [
							_texture,
							_markerColor,
							[(getposATL vehicle _unit) select 0, (getposATL vehicle _unit) select 1, ((getposATL vehicle _unit) select 2) + _maxHeight],
							_size,
							_size,
							getdir (vehicle _unit)
						];

						if (_x != leader _group) then
						{
							drawLine3D [
								[(getposATL vehicle _unit) select 0, (getposATL vehicle _unit) select 1, ((getposATL vehicle _unit) select 2) + _maxHeight],
								[(getposATL vehicle (leader _group)) select 0, (getposATL vehicle(leader _group)) select 1, ((getposATL vehicle (leader _group)) select 2) + _maxHeight],
								[0,0,1,1]
							];
						};
					};
				//};
			};
		} foreach (units _group); 
		
		_wpArray = waypoints (group _leader);
		if (count _wpArray > 0)then
		{
			private ["_wp","_wPos","_wType"];
			KEGs_lastWpPos = nil; 
			_texture = gettext (configfile >> "CfgMarkers" >> "waypoint" >> "icon");
			for [{_i= currentWaypoint (group _leader)},{_i < count _wpArray},{_i=_i+1}] do 	//Draw the current WP
			{			
				_wp = (_wpArray select _i);
				_wPos  = waypointPosition _wp;
				if ((_wPos  distance [0,0,0]) > 50) then
				{
					_wType = waypointType _wp;
					
					
					_map drawIcon [
						_texture,
						[0,0,1,1],
						_wPos,
						24,
						24,
						0,
						_wType,
						0,
						0.04,
						"PuristaBold",
						"center"
					];

					if (isnil "KEGs_lastWpPos") then {KEGs_lastWpPos = [(getposATL _leader) select 0,(getposATL _leader) select 1]}; 
					
					_map drawLine [
						KEGs_lastWpPos,
						_wPos,
						[0,0,1,1]
					];

					//if (!isnil "KEGscam_lockon") then
						//{
							private ["_size"];
							_size =if ((1.5 - ((KEGscam_lockon distance vehicle _leader)*0.001)) < 0) then {0} else {(1.5 - ((KEGscam_lockon distance vehicle _leader)*0.001))};
							
							if (_size>0) then
							{
								drawIcon3D [
										_texture,
										[0,1,1,0.6],
										[_wPos select 0,_wPos select 1,2],
										_size,
										_size,
										0,
										_wType,
										0,
										(_size*0.03),
										"PuristaBold",
										"center"
									];
								
								
									drawLine3D [
										[KEGs_lastWpPos select 0, KEGs_lastWpPos select 1, (KEGs_lastWpPos select 2)+2],
										[_wPos select 0, _wPos select 1, (_wPos select 2)+2],
										[0,1,1,0.8]
									];
							};
						//};
					KEGs_lastWpPos = _wPos; 
				};
			};
		};
		
	} foreach allgroups; 

