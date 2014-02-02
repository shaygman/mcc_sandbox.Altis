/*********************************
 mando_heliroute_arma.sqf v1.3
 August 2009 Mandoble 
 
 Moves a chopper accurately to the desired destination point following the indicated route and land it if so indicated.

 Execute it there were the chopper is local.

 Sintax:
[chopper, route positions array, flying height, landing true/false] execVM "mando_heliroute_arma.sqf"

Route positions array is an array of at least one position that defines the route the chopper will follow.
Once it reaches the final destination it will land if landing parameter is set to true. Note that for landings on ship's decks the Z of the last route position must match ship's deck altitude.

When the route is completed, the chopper will set its internal mando_heliroute variable to "waiting".
While the chopper is executing the route that variable is set to "busy" and, if the chopper is damaged or the pilot is killed, the variable is set to "damaged".

If you want to check when the route has been completed, you may do it this way:

Sleep 2;
waitUntil {heli1 getVariable "mando_heliroute" != "busy"};
if (heli1 getVariable "mando_heliroute" == "damaged") then
{
   hint "Chopper damaged or pilot dead, not available for more routes.";
}
else
{
   if (heli1 getVariable "mando_heliroute" == "waiting") then
   {
      hint "Chopper waiting for a new route.";
   };
};
**********************************/


private["_heli", "_route", "_endpos", "_height", "_landing ", "_pilot", "_i", "_j", "_pos", "_dist", "_distold", "_angh", "_dir",
		"_accel", "_speed", "_steps", "_inipos", "_offset","_nearSmokes","_wp"];

_route         = _this select 0;
_height        = _this select 1;
_landing       = _this select 2;
_heli          = _this select 3;

if (!local _heli) exitWith {hint "mando_heliroute: vehicle must be local";};
if (_height == 5000) then {								//We got a vehicle
		for [{_j = 0},{_j < count _route},{_j = _j + 1}] do
		{ 
		_pos = _route select _j;
		_wp = (group _heli) addWaypoint [_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "CARELESS";
		};
	} else	{
	// First of all chopper gets its indicated flying height for the route
	_pilot = driver _heli;
	_heli setfuel 1; 
	_heli setVariable ["mando_heliroute", "busy"];
	
	_heli flyinHeight _height;
	_pilot doMove [getPos _heli select 0, getPos _heli select 1, _height];
	Sleep 2;
	while {(!unitReady _pilot)&&(alive _pilot)&&(damage _heli < 0.5)} do
		{
		   Sleep 2;
		};
	if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith 
		{
		_heli setVariable ["mando_heliroute", "damaged"];
		};


	// The chopper moves through the route positions
	for [{_j = 0},{_j < count _route},{_j = _j + 1}] do
	{ 
	   _endpos = _route select _j;
	   _inipos = getPos _heli;
	   _dist = sqrt(((_endpos select 0) - (_inipos select 0))^2 + ((_endpos select 1) - (_inipos select 1))^2);
	   _steps = _dist / 3000;
	   _steps = _steps - (_steps % 1);
	   _ang = ((_endpos select 0) - (_inipos select 0)) atan2 ((_endpos select 1) - (_inipos select 1));

	   // Each route position is reached in steps no larger than 3Km
	   for [{_i = 0},{_i < _steps},{_i = _i + 1}] do
	   { 
		  _pos = [(_inipos select 0) + sin(_ang)*3000*_i,(_inipos select 1) + cos(_ang)*3000*_i];
		  _pilot doMove _pos;
		  Sleep 2;

		  if (_i < (_steps - 1)) then
		  {
			 _offset = 5;
		  }
		  else
		  {
			 _offset = 1;
		  };

		  while {((sqrt(((_pos select 0) - (getPos _heli select 0))^2 + ((_pos select 1) - (getPos _heli select 1))^2))>500)&&(alive _pilot)&&(damage _heli < 0.5)} do
		  {
			 Sleep 2;
		  };
		  if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
	   };
	   if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};

	   _pilot doMove _endpos;
	   Sleep 2;
	   while {((!unitReady _pilot) || (abs(speed _heli) > 1))&&(alive _pilot)&&(damage _heli < 0.5)} do 
	   {
		  Sleep 0.2;
	   };
	   if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
	};

	while {(abs(vectorUp _heli select 2) < 0.996)&&(alive _pilot)&&(damage _heli < 0.5)} do 
		{
		   Sleep 0.2;
		};
	 
	//If it's a free landing
	if (_landing == 3 || _landing == 4) then {
			if (_landing == 3) then {_heli land "GET IN"};
			if (_landing == 4) then {_heli land "LAND"};
			//server globalchat format ["End pos: %1",_endpos];
		} else	{
			//If it's a smoke landing
			if (_landing == 5) then {
				[[_heli, "Waiting for smoke signal to land", false],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;    
				_nearSmokes = []; 
				while {(count _nearSmokes < 1)} do {
					_nearSmokes = (getPos _heli) nearObjects ["SmokeShell", 200];
					sleep 1;
					if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
				};
				_endpos = getpos(_nearSmokes select 0);
			};
			
			if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith 
			{
				_heli setVariable ["mando_heliroute", "damaged"];	
			};
			_pilot doMove [getPos _heli select 0, getPos _heli select 1];
			
			// If chopper is not closer than 2m to final route point, it aligns with it and moves towards it
			_dist = sqrt(((_endpos select 0) - (getPos _heli select 0))^2 + ((_endpos select 1) - (getPos _heli select 1))^2);
			_dir = getDir _heli;

			if (_dist > 2) then
				{
				   _pos = _heli worldToModel _endpos;
				   _angh = (_pos select 0) atan2 (_pos select 1);
				   _dist = sqrt((_pos select 0)^2+(_pos select 1)^2);

				   for [{_i = 0},{_i < abs(_angh)},{_i = _i + 1}] do
				   {
					  if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
					  _heli setDir ((getDir _heli)+abs(_angh)/_angh);
					  _heli setVelocity [0,0,0];
					  Sleep 0.05;
				   };  
				};
			_heli setDir (_dir + _angh);
			_dir = getDir _heli;

			_distold = 99999;
			_dist = 99998;
			_speed = 0;
			while {(_distold >= _dist) && (alive _pilot) && (damage _heli < 0.5)} do
				{
					//hint format ["%1, %2",_dist,_speed];
				   if (_speed < 7) then
				   {
					  _speed = _speed + 0.1;
				   };
				   _distold = _dist;
				   _dist = sqrt(((_endpos select 0) - (getPos _heli select 0))^2 + ((_endpos select 1) - (getPos _heli select 1))^2);
				   _heli setVelocity [sin(_dir)*_speed, cos(_dir)*_speed, 0];
				   _heli setDir _dir;
				   Sleep 0.005;
				};

			if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith 
				{
					_heli setVariable ["mando_heliroute", "damaged"];
				};
			hint "we got this far";
			// Do we need to land?
			if (_landing == 0 || _landing == 5) then	{	//Landing engine on
			 while {(((getpos _heli) select 2)> ((_endpos select 2) + 1))&& (alive _pilot) && (damage _heli < 0.5)} do
			   {
				  if ((getPos _heli select 2) > ((_endpos select 2) + 1)) then
				  {
					 _heli setDir _dir;
					 if ((getPos _heli select 2) > ((_endpos select 2) + 5)) then
					 {
						_heli setVelocity [0,0,-7];
					 } 
					 else
					 {
						_heli setVelocity [0,0,-7*((getPos _heli select 2)-(_endpos select 2))/-5 min -1];
					 };
				  } 
				  else
				  {
					// _pilot action ["ENGINEOFF", _heli];
					 _heli setVelocity [0,0,0];
				  };
				  Sleep 0.01;
			   }; 
				[[[netid _heli,_heli], "Golf 1 touchdown",false], "MCC_fnc_groupchat", true, false] spawn BIS_fnc_MP;
			   for [{_i = 0},{_i < 100},{_i = _i + 1}] do
			   {
				  _heli setVelocity [0,0,-0.1];
				  Sleep 0.05;
			   };

			   if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};

			   _heli setVariable ["mando_heliroute", "waiting"];
				while {(alive _pilot) && (damage _heli < 0.5) && ((_heli getVariable "mando_heliroute") == "waiting")} do	{
				  //_pilot action ["ENGINEOFF", _heli];
				  Sleep 0.01;
				  _heli flyinHeight 0;
				  _heli setVelocity [0,0,-0.1];
				  Sleep 0.05;
			   };
			};
						
			if (_landing == 6) then	{
				_heli setVariable ["mando_heliroute", "waiting"];	 //Fast roping
				_heli setVelocity [0,0,0];
				_heli flyinHeight 5;
				waituntil {((getposatl _heli) select 2) < 6};
				[[[netid _heli,_heli], "Golf 1 in position, clear for helocasting",false], "MCC_fnc_groupchat", true, false] spawn BIS_fnc_MP;
				_pilot action ["autoHover", _heli];	
				//[_heli, driver _heli] spawn ace_sys_fastroping_fnc_deployFastropes;
				};
						
			if (_landing == 1) then	{	//Land engine off
				while {(((getpos _heli) select 2)> ((_endpos select 2) + 1))&& (alive _pilot) && (damage _heli < 0.5)} do
				   {
					  if ((getPos _heli select 2) > ((_endpos select 2) + 1)) then
					  {
						 _heli setDir _dir;
						 if ((getPos _heli select 2) > ((_endpos select 2) + 5)) then
						 {
							_heli setVelocity [0,0,-7];
						 } 
						 else
						 {
							_heli setVelocity [0,0,-7*((getPos _heli select 2)-(_endpos select 2))/-5 min -1];
						 };
					  } 
					  else
					  {
						 _pilot action ["ENGINEOFF", _heli];
						 _heli setVelocity [0,0,0];
					  };
					  Sleep 0.01;
				   }; 
				[[[netid _heli,_heli], "Golf 1 touchdown",false], "MCC_fnc_groupchat", true, false] spawn BIS_fnc_MP;
				_heli setVariable ["mando_heliroute", "waiting"];
				_pilot action ["ENGINEOFF", _heli];
				for [{_i = 0},{_i < 100},{_i = _i + 1}] do
					{
					  _heli setVelocity [0,0,-0.1];
					  Sleep 0.05;
					};
				};
						
						
			if (_landing == 2) then	{	//hover
				_heli setVariable ["mando_heliroute", "waiting"];	
				_heli setVelocity [0,0,0];
				_pilot action ["autoHover", _heli];	
				};
		};

	if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith 
		{
		   _heli setVariable ["mando_heliroute", "damaged"];
		};
	};