private ["_pos", "_units", "_spawn","_away","_plane","_pilot","_pilot1","_pilot2","_group","_count","_dropPos","_UMUnit", "_jumpers", "_i",
		"_light","_isHalo","_flightHight","_unitsArray","_unit","_init"];
_pos 		= _this select 0;
_units 		= _this select 1;
_UMUnit		= _this select 2;
_isHalo		= _this select 3; 
_flightHight = if (_isHalo) then {4000} else {400};

_spawn =[(_this select 4 select 0),_this select 4 select 1,(_this select 4 select 2) + _flightHight];
_away  =[(_this select 5 select 0),_this select 5 select 1,(_this select 5 select 2) + _flightHight];
_dropPos = if (_isHalo) then {[_pos select 0, _pos select 1, _flightHight]} else {[_pos select 0, _pos select 1, (_pos select 2)+ _flightHight]};

_unitsArray	= [];
_group = creategroup civilian;
_plane = createVehicle ["C130J", _spawn, [], 0, "FLY"];
_plane lock true;
_pilot = _group createUnit ["Pilot", _spawn, [], 0, "NONE"];
_pilot assignAsDriver _plane;
_pilot moveindriver _plane;
_pilot1 = _group createUnit ["Pilot", _spawn, [], 0, "NONE"];
_pilot1 assignAsCargo _plane;
_pilot1 MoveInCargo [_plane,0];
_pilot2 = _group createUnit ["Pilot", _spawn, [], 0, "NONE"];
_pilot2 assignAsCargo _plane;
_pilot2 MoveInCargo _plane;
_plane setpos _spawn;
_init =  format ["_this setBehaviour 'CARELESS';_this flyInHeight %1;",_flightHight];
[[[netid _plane,_plane], _init], "MCC_fnc_setVehicleInit", true, false] spawn BIS_fnc_MP;

//Set plane variables
_plane setVariable ["MCCJumperNumber",-1,true];																		//Number of unit to jump		
if (_isHalo) then {_plane setVariable ["MCCisHALO",true,true]} else {_plane setVariable ["MCCisHALO",false,true]}; 	//Is HALO jump?
_plane setVariable ["MCCjumpReady",false,true];																		//Are we ready on the ramp

_planeName	= format ["mccPlane%1",MCC_planeNameCount];
call compile (_planeName + " = _plane"); 																			//Give the plane a uniqe name
publicVariable _planeName;									
MCC_planeNameCount = MCC_planeNameCount + 1;

_count = 0;	
if (_UMUnit==0) then {
		{
			if (_count < 12) then {
				_unitsArray set [_count,_x];
				_count = _count + 1;	
			};
		} foreach _units;
	} else 	{
		{
			{
				if (_count < 12) then {
					_unitsArray set [_count,_x];
					_count = _count + 1;	
				};
			} foreach (units _x);
		} foreach _units;
	};

//server globalchat format ["%1",_unitsArray];	//debug
_count = 0;
for [{_x=0},{_x < count _unitsArray},{_x=_x+1}] do {
		_unit = _unitsArray select _x;
		_init = format[" if (local _this) then {[%1,_this,%2,%3] execVM ""\mcc_sandbox_mod\mcc\general_scripts\unitManage\paraStart.sqf"";}",_planeName,_count,_pos];
		[[[netid _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, false] spawn BIS_fnc_MP;
		_count = _count + 1;
	};
	
//Set waypoint
_plane move _dropPos;
[_plane, _flightHight] spawn
	{
	private ["_plane", "_flightHight"];
	_plane = _this select 0;
	_flightHight = _this select 1;
	while {alive _plane} do {_plane flyInHeight _flightHight;_plane forceSpeed 300;};
	};

while {(_plane distance _dropPos) > 2000} do {sleep 1}; //Make them stand on the deck
	
_plane setVariable ["MCCjumpReady",true,true];				//Ready for the jump

sleep 6; 
_plane animate ["ramp_top",1];
_plane animate ["ramp_bottom",0.7];

//sleep 10 + (random 10);

_light setLightColor [0,1,0];					////start the jump, Turn the light green
_light setLightAmbient [0,0.5,0]; 
sleep 4; 

_plane setVariable ["MCCJumperNumber",0,true];
	

_plane move _away;
_pilot domove _away;
_plane forceSpeed -1;	//Return to normal speed
sleep 40; 

deletevehicle _pilot;
deletevehicle _pilot1;
deletevehicle _pilot2;
deletevehicle _plane;
deletevehicle _light;