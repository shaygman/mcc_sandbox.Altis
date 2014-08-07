private ["_infront","_willwalk","_upos","_obstruction","_opp","_adj","_hyp","_angle"];
_unit = _this select 0;
_angle = _this select 1;
	
	_upos = getposASL _unit;

	_upos set [2,(_upos select 2) + 0.5];
	
	_hyp = (random 4) + 1; // distance to walk
	_adj = _hyp * (cos _angle);
	_opp = sqrt ((_hyp*_hyp) - (_adj * _adj));


	_infront = if ((_angle) >=  180) then 
	{

		[(_upos select 0) - _opp,(_upos select 1) + _adj,(_upos select 2)]

	} else {

		[(_upos select 0) + _opp,(_upos select 1) + _adj,(_upos select 2)]

	};

	_obstruction = (lineintersectswith [_upos,_infront,_unit]) select 0;

	_willwalk = if (isnil("_obstruction")) then {true} else{false};
	
	_infrontATL = (ASltoATL _infront);

	if (_willwalk) then
	{	
		if ((_infrontATL select 2) > 2) then
		{		
			_below = [(_infront select 0),(_infront select 1),((_infront select 2) - 2)];
			/*
			_ball1 = "Sign_Sphere25cm_F" createVehicle [0,0,0];
			_ball1 setPosASL _below;
			_ball1 setObjectTexture [0,"#(argb,8,8,3)color(0,0,1,1)"];
			
			_ball2 = "Sign_Sphere25cm_F" createVehicle [0,0,0];
			_ball2 setPosASL _infront;
			*/
			_floor = (lineintersectswith [_infront,_below]) select 0;
			
			_inAir = if (isnil("_floor")) then {true} else {false};

			_willwalk = if (_inAir) then {false} else {true};
		};
		
		_nearUnits = [];
		_nearUnits = _infrontATL nearentities [["Man"],0.8];
		_bTooClose = if ((count _nearUnits) > 0) then {true} else {false};
		
		_willwalk = if (_bTooClose or (!_willwalk)) then {false} else {true};

	};

[_willwalk,_infrontATL]

