private ["_target", "_cas_name", "_spawnkind", "_plane1", "_distA", "_distB", "_fakeTarget", "_planeCrew", "_planeType", "_randomDirX", "_randomDirY", "_tPos", "_newPos"];

_cas_name = _this select 0;
_target =  _this select 1;
_spawnkind = _this select 2;
_plane1 = _this select 3;
_planeType = _this select 4;
_fakeTarget = _this select 5;

diag_log format ["Array = [%1]", _this];

_planeCrew = crew _plane1;

_tPos = getPosATL _target;

_distA = round (_plane1 distance _target);
sleep 0.2;
_distB = round (_plane1 distance _target);

// Approaching, if distB > distA plane passed target
while { ( _distA > _distB ) && ( alive _plane1 ) } do 
{
	_distA = round (_plane1 distance _target);
	sleep 1;
	_distB = round (_plane1 distance _target);

	// change fakeTarget position to force slight gun-run dispersion
	_randomDirX = random 30;
	if ( _randomDirX > 15 ) then {
		_randomDirX = (_randomDirX * 0.5);
	} else {
		_randomDirX = (_randomDirX * -1);
	};
	
	_randomDirY = random 30;
	if ( _randomDirY > 15 ) then {
		_randomDirY = (_randomDirY * 0.5);
	} else {
		_randomDirY = (_randomDirY * -1);
	};
	
	_newPos = [((_tPos select 0) + _randomDirX), ((_tPos select 1) + _randomDirY), 0];
	_fakeTarget setPosATL _newPos;
	
	//diag_log format ["CLEAR time: [%1] - distance [%2 - %3]", time, _distA, _distB];
};

// If Gun-run long, plane will go for a 2nd strafe run
if ( _spawnkind == "Gun-run long" ) then
{	
	sleep 1;
	//drop flares (doesn't work for all planes)
	//while { _distA < 350 } do
	while { ( (_plane1 distance _target) < 350 ) && ( alive _plane1 ) } do
	{
		//_distA = _plane1 distance _target;
		_plane1 fire "CMFlareLauncher";
		sleep 1.5;
	};	
	
	_distA = round (_plane1 distance _target);
	sleep 0.3;
	_distB = round (_plane1 distance _target);
	
	// Plane will return automatically for 2nd approach. 
	// When distB becomes > distA plane is returning
	while { ( _distA < _distB ) && ( alive _plane1 ) } do 
	{
		_distA = round (_plane1 distance _target);
		sleep 1;
		_distB = round (_plane1 distance _target);
		//hint format ["%1 m from target", round (_plane1 distance _target)];
	};
		
	[playerSide,'HQ'] sidechat format ["%1 Final approach - ETA %2 seconds", _cas_name, round ((_plane1 distance _target) / ((speed _plane1) * 0.2778 ))];
	
	sleep 3;
	_distA=round (_plane1 distance _target);
	sleep 0.2;
	_distB=round (_plane1 distance _target);				
	
	// Approaching, if distB > distA plane passed target
	while { ( _distA > _distB ) && ( alive _plane1 ) } do 
	{
		_distA = round (_plane1 distance _target);
		sleep 1;
		_distB = round (_plane1 distance _target);
		
		// change fakeTarget position to force slight gun-run dispersion
		_randomDirX = random 30;
		if ( _randomDirX > 15 ) then {
			_randomDirX = (_randomDirX * 0.5);
		} else {
			_randomDirX = (_randomDirX * -1);
		};
		
		_randomDirY = random 30;
		if ( _randomDirY > 15 ) then {
			_randomDirY = (_randomDirY * 0.5);
		} else {
			_randomDirY = (_randomDirY * -1);
		};
		
		_newPos = [((_tPos select 0) + _randomDirX), ((_tPos select 1) + _randomDirY), 0];
		_fakeTarget setPosATL _newPos;
	};
};

// plane passed target or crashed so now set damage to 1 to continue cas_execute script 
if (!(IsNil "_fakeTarget") ) then { _fakeTarget setdamage 1; };

//diag_log format ["DAMAGE SET - time: [%1] - distance [%2 - %3] - damage [%4]", time, _distA, _distB, damage _fakeTarget];

//drop flares (doesn't work for all planes)
_plane1 fire "CMFlareLauncher";
sleep 1.5;

// clear invisible targets
if (IsNil "_fakeTarget") then {_fakeTarget = objNull}; deleteVehicle _fakeTarget;

//while { ( (_plane1 distance _target) < 500 ) && (alive _plane1) } do
for "_i" from 0 to 5 do
{
	_plane1 fire "CMFlareLauncher";
	sleep 1.5;
};	

// delete crew if plane crashed but crew is still alive
//sleep 40; // usually enough time to leave the area
waitUntil { sleep 1;( !(alive _plane1) || ( damage _plane1 > 0.5 ) ) };
sleep 5;
{deleteVehicle _x} forEach  _planeCrew;

//hint format ["clear cas target script ready %1", _plane1];

if ( true ) exitWith {};
