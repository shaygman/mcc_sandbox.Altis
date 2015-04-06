
	private ["_color","_shape","_Type","_timer","_life","_position","_weight","_vol","_rub","_size","_PS","_unit", "_unitPos"];
	
	//_unit = _this select 0;
	//_PS = _this select 1;

	_shape = "\a3\data_f\cl_water.p3d";
	//_shape = "\A3\data_f\ParticleEffects\Universal\smoke.p3d";
	
	//_timer = 0.01;
	//_life = 2.5;
	//_position = [0, 0, 2.5];
	//_weight = 7.5;
	//_vol = 10;
	//_rub = 0;
	//_size = [0.4];

	//_PS = "#particlesource" createVehicleLocal getpos vehicle _unit;

	while { KEGsTags } do 
	{
		{
			_PS = _x getVariable ["spect_locator", objNull];
			
			_size = 4 min (5* (getPosATL (KEGs_cameras select KEGs_cameraIdx) select 2)/400) max 0.1;
			
			
			if ( alive _x ) then
			{	
				if ( (vehicle _x == _x) || { (((crew vehicle _x) select 0) == _x) } || { _x == leader _x } ) then  
				{
					_unit = _x;
					_unitPos = getPosATL _x;
					
					if ( isNull _PS ) then 
					{
						_PS = "#particlesource" createVehicleLocal (_unit modelToWorld [0,0,1]);
						_PS setParticleCircle [0, [0, 0, 0]];
						_PS setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
						
						_unit setVariable ["spect_locator", _PS];
						
						KEGsTagSources set [count KEGsTagSources, _PS];
					};

					
					//ToDo: check if (behaviour _unit) typeOf boolean instead of Array -> if so some error so do ignore
					_color = switch (side _unit) do 
					{
						case east: {[[1,0,0,1],[1,0,0,1]]};
						case west: {[[0,0.05,1,1],[0,0.15,1,1]]};
						case resistance: {[[0,1,0,1],[0,1,0,1]]};
						default {[[1,1,1,1],[1,1,1,1]]};
					};
					
					if ( _unit == leader _unit ) then { _size = _size * 1.5; _color set [2,[1,1,1,0.5]]; };

					_PS setPosATL _unitPos;
					_PS setParticleParams 
					[
						_shape, 
						"",
						"billboard",
						1, //_timer,
						0.15, //_life,
						[0,0,2], //_position,
						[0,0,0], 
						1,
						1, // _weight,
						1, // _vol,
						0.1, // _rub,
						[_size],
						_color,
						[1],
						10,
						0,
						"",
						"",
						_unitPos
					];
					//_s setParticleParams[_part, "", "billboard", 1, _lifeTime, [0, 0, 2], [0,0,0], 1, 1, 0.784, 0.1, [_size, _size*0.66], [_color, _color, _color, _color, _color], [1], 10.0, 0.0, "", "", vehicle _u];
					_PS setDropInterval 0.05;
				}
				else
				{
					_PS setDropInterval 0;
				};
			}
			else
			{
				_PS setDropInterval 0; 
				deleteVehicle _PS;
				_x setVariable ["spect_locator", nil]; 
				KEGsTagSources = KEGsTagSources - [_x];	
			};
			
		} count allUnits;
		
		sleep 0.1;		
	};

{ 
	_x setDropInterval 0; 
} count KEGsTagSources;
