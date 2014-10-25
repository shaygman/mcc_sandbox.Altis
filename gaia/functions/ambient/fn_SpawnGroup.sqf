private ["_sideNr"
				,"_sideRatios"
				,"_spawnPos"
				,"_factions"
				,"_side"
				,"_faction"
				,"_simu"
				,"_roads"
				,"_unitarray"
				,"_amount"
				,"_dude"
				,"_grp"
				];
/*
_sideRatios = [_this, 0, [0,0,0], [],3] call BIS_fnc_param;
_factions 	= [_this, 0, ["","",""], [],3] call BIS_fnc_param;
_spawnPos	  = [_this, 0, [0,0,0], [],3] call BIS_fnc_param;
*/
_sideratios = _this select 0;
_factions 	= _this select 1;
_spawnpos		= _this select 2;

if ((_spawnpos distance [0,0,0])== 0) exitwith {grpNull};

_roads						 = [];
_simu							 = "";
_unitarray				 = [];
_amount						 = 0;
_GrpUnit					 = [];
_grp							 = grpNull;

_sideNr		= [[0,1,2],_sideRatios] call BIS_fnc_selectRandomweighted;
_side     = ([west,east,independent] select _sideNr);
_faction  = ([ _FactionsWest,_FactionsEast, _FactionsIndep] select _sideNr) call BIS_fnc_selectRandom;
if (_faction == "") exitwith {grpNull};

			
// Can be a water pos

//Did we get the world centerpos? Fuck it....
//"soldier", "car", "motorcycle", "tank", "helicopter", "airplane", "ship"

if (surfaceIsWater _spawnPos) then
{
	
	_simu = [["helicopter", "airplane", "ship"],[0.01,0.01,1]] call BIS_fnc_selectRandomWeighted; 			
}
else
{
	
	_simu = [["soldier", "car", "motorcycle", "tank"],[1,0.4,0.05,0.01]] call BIS_fnc_selectRandomWeighted;
};

if (!(isOnRoad _spawnpos) and (_simu in ["soldier", "car","motorcycle","tank"])) then
		{
			_roads = _spawnpos nearRoads 100;
			if (count(_roads)>0) then
				{_spawnpos = position(_roads call BIS_fnc_selectRandom);};
		};

if (_simu == "soldier") then 
{
	// Love the x simulation
	_unitarray= [_faction ,_simu,"men"] call MCC_fnc_makeUnitsArray;
	_unitarray = _unitarray + ( [_faction ,_simu+"x","men"] call MCC_fnc_makeUnitsArray);
	
	_amount = (floor random 10) max 3;
	_dude   = [];
	_GrpUnit= [];
	for [{_i=0}, {_i <  _amount}, {_i=_i+1}] do
	{
		_dude = _unitarray select (floor random (count _unitarray));
		
		_GrpUnit = _GrpUnit + [ (_dude  select 0)];
		
		
	};
	_grp = [_spawnPos, _side, _GrpUnit] call BIS_fnc_spawnGroup;
	( _grp) setVariable ["GAIA_ZONE_INTEND",[_ActiveZone, (["MOVE","NOFOLLOW","FORTIFY"]call BIS_fnc_selectRandom)], true];
	
}
else
{
		// Love the x simulation
	_unitarray= [_faction ,_simu] call MCC_fnc_makeUnitsArray;
	_unitarray = _unitarray + ( [_faction ,_simu+"x"] call MCC_fnc_makeUnitsArray);
	
	
	
	if (count(_unitarray)>0) then
	{
		_dude = _unitarray select (floor random (count _unitarray));					
		_grp = ([_spawnPos, 200, (_dude  select 0), _side] call bis_fnc_spawnvehicle) select 2;
		( _grp) setVariable ["GAIA_ZONE_INTEND",[_ActiveZone, (["MOVE","NOFOLLOW"]call BIS_fnc_selectRandom)], true];
	};
};	
( _grp) setVariable ["GAIA_AMBIENT",true, false];

_grp