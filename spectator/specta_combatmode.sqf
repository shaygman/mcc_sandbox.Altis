
	private ["_color","_shape","_Type","_timer","_life","_position","_weight","_vol","_rub","_size","_PS","_unit", "_unitPos"];
	
	//_unit = _this select 0;
	//_PS = _this select 1;

	//_shape = "\a3\data_f\cl_water.p3d";
	_shape = "\A3\data_f\ParticleEffects\Universal\smoke.p3d";
	
	//_timer = 0.01;
	//_life = 2.5;
	//_position = [0, 0, 2.5];
	//_weight = 7.5;
	//_vol = 10;
	//_rub = 0;
	_size = [0.4];

	//_PS = "#particlesource" createVehicleLocal getpos vehicle _unit;

	while { KEGsTagsStat } do 
	{
		{
			_PS = _x getVariable ["spect_combatmode", objNull];
			
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
											
						_unit setVariable ["spect_combatmode", _PS];
						
						KEGsTagStatSources set [count KEGsTagStatSources, _PS];
					};
					
					//ToDo: check if (behaviour _unit) typeOf boolean instead of Array -> if so some error so do ignore
					_color = switch (behaviour _unit) do 
					{
						case 'CARELESS': {[[0,0,1,1]]};
						case 'SAFE': {[[0,1,0,1]]};
						case 'AWARE': {[[1,1,0,1]]};
						case 'COMBAT': {[[1,0,0,1]]};
						case 'STEALTH': {[[0,1,1,1]]};
						default {[[1,1,1,1]]};
					};
					
					//if ( _unit == leader _unit ) then { _size = [0.6]; };

					_PS setPosATL _unitPos;
					_PS setParticleParams 
					[
						[_shape, 8, 2, 0], 
						"",
						"billboard",
						0.01, //_timer,
						2.5, //_life,
						[0,0,2.5], //_position,
						[0, 0, 0], 
						0,
						7.5, // _weight,
						10, // _vol,
						0, // _rub,
						_size,
						_color,
						[1],
						0,
						0,
						"",
						"",
						_unitPos
					];
					_PS setDropInterval 0.01;
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
				_x setVariable ["spect_combatmode", nil]; 
				KEGsTagStatSources = KEGsTagStatSources - [_x];	
			};
			
		} count allUnits;
		
		sleep 0.07;		
	};
	
//exit combat particles
{ 
	_x setDropInterval 0; 	
} count KEGsTagStatSources;
