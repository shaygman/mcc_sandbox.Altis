private ["_willsee","_infront","_uposASL","_opp","_adj","_hyp","_eyes","_obstruction","_angle"];
_unit = _this select 0;
_angle = _this select 1;

_uposASL = getposASL _unit;
_eyes = eyepos _unit;

_hyp = 5;
_adj = _hyp * (cos _angle);
_opp = sqrt ((_hyp*_hyp) - (_adj * _adj));


_infront = if ((_angle) >=  180) then 
{
	[(_eyes select 0) - _opp,(_eyes select 1) + _adj,(_eyes select 2)]
} 
else 
{
	[(_eyes select 0) + _opp,(_eyes select 1) + _adj,(_eyes select 2)]
};

_obstruction = (lineintersectswith [_eyes,_infront,_unit]) select 0;


_willsee = if (isnil("_obstruction")) then {true} else {false};
	

[_willsee,_infront]

