/* 
Advance IED script by Shay_Gman 12.10
*/
private ["_dummy","_trapvolume","_IEDExplosionType","_IEDJammable","_IEDTriggerType","_trapdistance","_iedside","_targets",
		"_loop","_nearObjects","_nearTargets","_nrsd","_count","_target","_dummyMarker","_armed", "_triggered","_pos",
		"_IedExplosion","_wh","_randomChanceCREW","_explode","_targetSpeed","_isJammable","_effect"];

_dummy 				= _this select 0;	//the hiden targer
_trapvolume 		= _this select 1;	//How big the explosion
_IEDExplosionType 	= _this select 2;	//Deadly/disabling
_IEDJammable 		= _this select 3;	//Is it jammable?
_IEDTriggerType 	= _this select 4;	//Proximity or admin
_trapdistance 		= _this select 5;	//Proximity distance
_iedside 			= _this select 6;	//targer faction

// Target classes that will triger the IED                                    
_targets 		= ["Car","Tank","Man"];
_loop			= true;	// continue looping?
_armed 			= _dummy getvariable "armed";		//Did the IED armed?
_triggered 		= _dummy getvariable "iedTrigered";	//Did the IED triggered?
_fakeIed 		= _dummy getvariable "fakeIed"; 	//The name of the fake IED object
_explode 		= false; 							//Did the IED explode?
_targetSpeed	= false; 							//Did the target move fast enough to trigger it

if (_IEDTriggerType==2) then	{		//manual detonation
		while {! _triggered} do {_triggered = _dummy getvariable "iedTrigered";sleep 0.5};	
	} else
		{	//Proximity or radio
			while {alive _fakeIed && !isNull _fakeIed && _loop && _armed && !_triggered} do	{  
				sleep 3;
				_triggered = _dummy getvariable "iedTrigered";
				if (isnil "_triggered") then {_triggered = false}; 
				_nearObjects = (getPos _dummy) nearObjects 150;
				if(_iedside countSide _nearObjects > 0) then	{
					while {(alive _fakeIed) && (_loop) && _armed && !_triggered} do	{
						sleep 1;
						_triggered = _dummy getvariable "iedTrigered";
						if (isnil "_triggered") then {_triggered = false};
						_nearTargets = (getPos _dummy) nearObjects (_trapdistance);
						_nrsd = [];
						{if(side _x == _iedside) then {_nrsd = _nrsd + [_x]}} forEach _nearTargets;
						_count=count _nrsd;
						
						for [{_x=0},{_x<_count},{_x=_x+1}] do	
						{
							_target = _nrsd select _x;
							_isJammable = (_target getvariable "MCC_ECM");
							if (isnil "_isJammable") then {_isJammable = false}; 
							if(_IEDJammable && _isJammable && ((_target distance _dummy) <= 80)) then //check if it's a CREW vehicle
							{
								_randomChanceCREW = random 100;
								while {((_target distance _dummy) < 80) && (_randomChanceCREW>1)} do {_randomChanceCREW = random 100;sleep 2};	//While CREW is near IED got only 1% per 2 second to go off
								if (_randomChanceCREW <=1) exitWith {_loop=false; _dummy setvariable ["iedTrigered",true,true];}
							}; 
				
							if (_loop) then	//If we come this far someone is near the IED
							{		
								{
								_targetSpeed = if (_IEDTriggerType==1) then {true} else {(speed _target) > 7}; //if it is radio IED speed dosen't matter 
								if((_target isKindOf _x) && ((_target distance _dummy) <= _trapdistance) && _targetSpeed)exitWith {_loop=false;_dummy setvariable ["iedTrigered",true,true]};
								} forEach _targets;
							};
						};
						
					_armed = _dummy getvariable "armed";
					if (isnil "_armed") then {_armed = false}; 
					};
				};
			};
		};
_dummyMarker = _dummy getvariable "iedMarkerName"; 
if (!isnil "_dummyMarker") then {[[2,compile format ["deletemarkerlocal '%1';",_dummyMarker]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP};	//delete IED marker 
_fakeIed removeaction 0;
_armed = _dummy getvariable "armed";
if (isnil "_armed") then {_armed = false}; 
_triggered = _dummy getvariable "iedTrigered";
if (isnil "_triggered") then {_triggered = false}; 

_pos=[((getposATL _fakeIed) select 0),(getposATL _fakeIed) select 1,((getPosATL _fakeIed) select 2)];	//position of the IED

switch (_IEDExplosionType) do
		{
		   case 0:	
			{ 
				_IedExplosion = MCC_fnc_IedDeadlyExplosion;
			};
			
			case 1:	
			{ 
			   _IedExplosion = MCC_fnc_IedDisablingExplosion;
			};
			
			case 2:	
			{ 
			   _IedExplosion = MCC_fnc_IedFakeExplosion;
			};
			
			case 3:	
			{ 
			   _IedExplosion = {};
			};
		};

if !((_IEDExplosionType == 0) && (typeof _fakeIed) in MCC_MWIED) then 
{
	if (_armed && _triggered) then	//If triger epxplosion
		{	
			[_pos,_trapvolume] spawn _IedExplosion; 
			_explode = true;
		};

	if (!alive _fakeIed && _armed ) then	//If IED is destroyed
		{
			[_pos,_trapvolume] spawn _IedExplosion;
			_explode = true;
		};

	if (!_armed ) then 	//If IED critical fail while trying to disarm it
		{	
			sleep 5; 
			_triggered = _dummy getvariable "iedTrigered";
			if (isnil "_triggered") then {_triggered = false};
			if (_triggered) then {
							[_pos,_trapvolume] spawn _IedExplosion;
							_explode = true;
							};
		};
}
else
{
	_explode = true;
}; 

sleep 0.5;
if (_explode) then 
{
	//If IED is a car lets make it burn
	if (_fakeIed isKindOf "Car") then	
	{	
		_fakeIed setdamage 1;
		_effect = "test_EmptyObjectForFireBig" createVehicle (getpos _fakeIed); _effect attachto [_fakeIed,[0,0,0]];
	} 
	else 
	{
		if (str _IedExplosion != str {}) then {_fakeIed setdamage 1; sleep 0.2; deletevehicle _fakeIed};
	};
};


sleep 2;	//fail safe give the game enough time to read the variable from it before deleting it.

//if ((typeof _fakeIed) in MCC_MWIED) then {deletevehicle _fakeIed;}; 
deletevehicle _dummy;	//Delete the dummyIED
if (true) exitWith {};