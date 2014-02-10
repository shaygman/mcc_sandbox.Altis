private ["_unit","_alerter"];
_unit = _this select 0;

if (!(alive _unit)) exitwith {};

_unit setVariable ["lastMadeNoise",time];

_alerter = _unit addeventhandler ["fired",
{
	private ["_unit","_loudness","_nearunits","_dist","_tgtdist","_eyes","_focus","_obstruction","_obstructed","_distace"];
	_unit = _this select 0;
	_lastTriggered = _unit getVariable ["lastMadeNoise",time];
	if ((time - _lastTriggered) > 1) then
	{
		_loudness = ([_unit,_this select 1] call fnc_silenced) * 4;
		
		_farunits = _unit nearentities [["Man"],_loudness * 2];
		_nearunits = [];
		_LOSunits = [];
	
		
		if ((count _farunits) > 0) then
		{
			{
				if (((side _x) getfriend (side _unit) >= 0.6)) then 
				{
					_farunits = _farunits - [_x];
				}
			}foreach _farunits;
			
			{
				if !(isPlayer _x) then 
				{
					_sPos = worldtoscreen (getposATL _x);
					if ((count _sPos) > 0) then
					{
						if ( (((_sPos select 0) > 0) && ((_sPos select 0) < 1)) && (((_sPos select 1) > 0) && ((_sPos select 1) < 1)) ) then
						{
							_bNoLOS = lineIntersects [(eyePos _unit),(eyePos _x),_unit,_x];
							if (!_bNoLOS) then
							{
								_LOSunits set [(count _LOSunits),_x];
							};
						};
					};
					
					_dist = _x distance _unit;
					if (_dist < _loudness) then
					{
						_nearunits set [(count _nearunits),_x];
					};
				};
			}foreach _farunits;
		};
		
		{	
			_alerted = time - (_x getVariable ["alerted",0]);
			if (_alerted < 10) then 
			{
				_dist = _unit distance _x;
				_tgtdist = _x getVariable ["tgtdist",51];
				
				if (_dist > _tgtdist) then
				{
					_nearunits = _nearunits - [_x];
				};
			};
		}foreach _nearunits;
		
		{
			_eyes = eyePos _x;
			_focuseyes = eyePos _unit;
			_obstruction = (lineintersectswith [_eyes,_focuseyes,_x,_unit]) select 0;
			_obstructed = if (isnil("_obstruction")) then {false} else {true};
			
			if (_obstructed) then
			{
				_distance = _x distance _unit;
				if (_distance >= ((_loudness/4)*3)) then
				{
					_nearunits = _nearunits - [_x];
				};
			};
			
		} foreach _nearunits;

		if ((count _nearunits) > 3) then
		{
			_nearunits = [_unit,3,_nearunits] call fnc_Find_Closest;
		};
		
		{
			[_x,_unit] spawn fnc_cqc_react;
		} foreach _nearunits;
		
		if (isPlayer _unit) then
		{		
			{
				if !(_x in _nearunits) then
				{
					[_x,_unit] spawn fnc_cqc_react;
				};
			} foreach _LOSunits;
		
			//hint (str(_LOSunits));
		};
		
		_unit setVariable ["lastMadeNoise",time];
	};
}];

	
	