private ["_minRange","_distW","_distE","_distI","_distTot","_sideRatios"];

/*_pos = [_this, 0, [], [],3] call BIS_fnc_param;*/
_pos = _this select 0;
if ((count _pos)<2) exitWith {[0,0,0]};

_distW  		=0;
_distE  		=0;
_distI  		=0;
_distTot		=0;
_sideRatios =[];
_min				=0;
_max				=0;

_distW = [west,_pos,true] call GAIA_fnc_getDistanceToClosestZone;
_distE = [east,_pos,true] call GAIA_fnc_getDistanceToClosestZone;
_distI = [independent,_pos,true] call GAIA_fnc_getDistanceToClosestZone;
		
if (_distw==99999) then {_distw=0};
if (_diste==99999) then {_diste=0};
if (_disti==99999) then {_disti=0};
		
_distTot= 	_distI+_distE+_distW;

if (_distw>0 && _distw!=_distTot) then {_distw  =   _distTot - _distW;};
if (_diste>0 && _diste!=_distTot) then {_diste  =   _distTot - _Diste;};
if (_disti>0 && _disti!=_distTot) then {_disti  =   _disttot - _Disti;};

if (_disttot>0) then
{
	_distTot= 	_distI+_distE+_distW;
	_sideRatios = [(_distw/_disttot),(_diste/_disttot),(_disti/_disttot) ];
	_min 				= [_sideratios,0]call BIS_fnc_findExtreme;
	_max 				= [_sideratios,1]call BIS_fnc_findExtreme;
	
	
	// Do the ownership thingy's, driving me titnuts here.Help my math! :)
	//We have 2 sides (max)
	if (
				((_max > 0.6) and _min==0) 										
		 )
	then
	{
		_i=0;
		{
			if (_x!=_max) then {_sideRatios set [_i,0];};
			_i=_i+1;
		} foreach _sideRatios;
	};
	
	//We have 3 side
	if (
				((_max > 0.36) and _min>0) 
		 )
	then
	{
		
		//Find a winner
		_i=0;
		{
			if (_x==_max) then {_sideRatios set [_i,_max+_min];};
			if (_x==_min) then {_sideRatios set [_i,0];};
			_i=_i+1;
		} foreach _sideRatios;
		
		//Declare ownership
		_min 				= [_sideratios,0]call BIS_fnc_findExtreme;
		_max 				= [_sideratios,1]call BIS_fnc_findExtreme;
			//We have 2 sides (max)
		if (
					((_max > 0.6) and _min==0) 										
			 )
		then
		{
			_i=0;
			{
				if (_x!=_max) then {_sideRatios set [_i,0];};
				_i=_i+1;
			} foreach _sideRatios;
		};
	};

	
}
else
{
	_sideRatios = [0,0,0];
};

_sideRatios