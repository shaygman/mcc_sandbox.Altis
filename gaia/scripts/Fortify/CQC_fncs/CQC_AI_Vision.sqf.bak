private ["_unit"];

_unit = _this select 0;

//FIND NEAR MEN AND CARS
_nearunits = (getposATL _unit) nearentities [["man","car"],100];

{ 
	_sel = _x; 
	_cansee = 0;
	//IF ENEMY
	if (((side _unit) getFriend (side _sel)) <= 0.5) then  
	//DOES UNIT HAVE LINE OF SIGHT
	{ 
		
		_eyedv = eyedirection _unit;  
		_eyed = ((_eyedv select 0) atan2 (_eyedv select 1));   
		_dirto = ([_sel,_unit] call bis_fnc_dirto);
		_eDir = getDir _sel;
		_eDirMinDir = abs(_dirto - _eDir);
		_ang = abs (_dirto - _eyed); 
		_eyepa = eyepos _unit;
		_posASL = getPosASL _sel;
		_eyepb = eyepos _sel; 
		_tint = terrainintersectASL [_eyepa, _eyepb]; 
		_lint = lineintersects [_eyepa, _eyepb];
		_bFlashlight = _sel isFlashlightOn (currentWeapon _sel);
		_bFacing = if (((_eDirMinDir) < 90) or ((_eDirMinDir) > 270)) then {true} else {false};
		
		if ((((_ang > 120) && (_ang < 240)) or (_bFlashlight && _bFacing)) && !(_lint) && !(_tint)) then
		{
		
			//OTHER FACTORS AFFECTING VISIBILITY OF ENEMY
			_vm = (currentvisionmode _unit); 
			if (_vm > 0) then 
			{
				_vm = -1
			} 
			else 
			{
				_vm = 1
			};
			
			
			_dist = (_unit distance _sel); 
			_esp = abs (speed _sel);
			_usp = abs (speed _unit);
			_camo = getnumber (configfile >> "cfgVehicles" >> (typeof _sel) >> "camouflage");
			
			//ANYONE LESS THAN 5m IS FAIR GAME //ignoring this because of CQC_AI_close check;
			if ((_dist < 5) or _bFlashlight) then 
			{
				_cansee = 200;
			}
			else
			{	
				//GET ENEMY'S CURRENT STANCE
				_stance = (((_eyepb select 2) - (_posASL select 2)) / 3) * 2; // to keep in line with the 0.2 to 1 scale of original script;
				
				// check for streetlights;
				_lights = nearestObjects [(getPosATL _sel),["Lamps_base_F","Land_PowerPoleWooden_L_F"],30];
				_light = objNull;
				_litValue = 0;
				
				if ((count _lights) > 0) then
				{
					_toIgnore = ["Land_LampDecor_off_F","Land_LampAirport_off_F","Land_LampHalogen_off_F","Land_LampHarbour_off_F","Land_LampShabby_off_F","Land_LampSolar_off_F","Land_LampStreet_off_F","Land_LampStreet_small_off_F"];
					{
						if (((damage _x) > 0) or ((lightIsON _x) == "OFF") or ((typeof _x) in _toIgnore)) then
						{
							_lights = _lights - [_x];
						}
						else
						{
							_lightPos = getPosASL _x;
							_lightPos set [2,(_lightPos select 2) + 8];
							_bNoLOS = lineIntersects [_eyepb,_lightPos,_sel,_x];
							if (_bNoLOS) then
							{
								_lights = _lights - [_x];
							};
						};
					}foreach _lights;
					
					if ((count _lights) > 0) then
					{
						_light = _lights select 0;
						
						if ((count _lights) > 1) then
						{
							_light = ([_sel,1,_lights] call fnc_Find_Closest) select 0;
						};
					};
				};
				
				if (!(isNull _light)) then
				{
					_lightDist = _sel distance _light;
					_litValue = (30 - _lightDist) * 2;
				};
				
				//MAGIC VISIBILITY FORMULA
				_formula = (_vm * (sunAngle)) + _litValue + ((_stance * _esp) * 6) - (_usp * 2) - _dist + (random 40);
				//hint (str([_formula,((_stance * _esp) * 6),_litValue]));	
				
				//IGNORE CAMO ENEMY	
				if (_camo > 0.6) then 
				{
					_cansee = _formula;
				};
			};
			
			
		};
		
	}; 
	if (_cansee > 0) exitwith  
	//IF VISIBLE ENEMY
	{ 
		[_unit,(getPosATL _sel)] call fnc_cqc_target;
/*		
_posATL = getPosATL _unit;
_target = getPosATL _sel;

_abx = (_target select 0) - (_posATL select 0);
_aby = (_target select 1) - (_posATL select 1);
_abz = (_target select 2) - (_posATL select 2);

_vec = [_abx, _aby, _abz];

// Main body of the function

_unit lookAt objNull;
_unit doTarget objNull;	
sleep 0.2;
_unit setVectorDir _vec;
sleep 0.02;
_unit lookAt _target;
*/
		sleep 0.1; 
		
		_unit doTarget _sel;
		_unit dofire _sel;
	};
} foreach _nearunits;