private ["_primaryTarget","_missileStart","_missileType","_missileSpeed","_perSecondChecks","_target","_missile","_travelTime",
		"_steps","_relDirHor","_relDirVer","_fireLight","_velocityForCheck","_targetIsHeliEmpty","_light","_tr"];
_primaryTarget = _this select 0; //target for the missile
_missileStart = _this select 1; //position where te missile will be spawned
_missileType = _this select 2; //type of the missile
_missileSpeed = _this select 3; //speed of the missile
_light = _this select 4;		//0 - none, 1 - smoke, 2 - light
_targetIsHeliEmpty = false;

_perSecondChecks = 25; //direction checks per second
if (typeName _primaryTarget == "OBJECT") then {
	_target = _primaryTarget;
	} else
		{
		_target = "O_TargetSoldier" createVehicle _primaryTarget;
		_targetIsHeliEmpty = true;
		};

_missile = _missileType createVehicle [_missileStart select 0, _missileStart select 1,(_missileStart select 2)-5];
_missile setPos [_missileStart select 0, _missileStart select 1,(_missileStart select 2)-5];

//broadcast onwership
[_missile,(owner player)] remoteExec ["setOwner", 2];

//procedure for guiding the missile
_homeMissile = {
				//altering the direction, pitch and trajectory of the missile
				_travelTime = (_target distance _missile) / _missileSpeed;
				_steps = floor (_travelTime * _perSecondChecks);

				_relDirHor = [getpos _missile, getpos _target] call BIS_fnc_DirTo;
				_missile setDir _relDirHor;

				_relDirVer = asin ((((getPosASL _missile) select 2) - ((getPosASL _target) select 2)) / (_target distance _missile));
				_relDirVer = (_relDirVer * -1);
				[_missile, _relDirVer, 0] call BIS_fnc_setPitchBank;

				_velocityX = (((getPosASL _target) select 0) - ((getPosASL _missile) select 0)) / _travelTime;
				_velocityY = (((getPosASL _target) select 1) - ((getPosASL _missile) select 1)) / _travelTime;
				_velocityZ = (((getPosASL _target) select 2) - ((getPosASL _missile) select 2)) / _travelTime;

[_velocityX, _velocityY, _velocityZ]
};

if (_light==1) then
	{
		_fireLight = "#lightpoint" createVehicle position _missile;
		_fireLight setLightBrightness 0.1;
		_fireLight setLightAmbient [0.1, 0.1, 0.1];
		_fireLight setLightColor [1.0, 1.0, 1.0];
		_fireLight lightAttachObject [_missile, [0, -0.5, 0]];

		_missile spawn	{
				private ["_missile"];
				_missile = _this;
				while {alive _missile} do {
					_tr = "#particlesource" createVehicle getpos _missile;
					_tr setParticleCircle [0, [0, 0, 0]];
					_tr setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
					_tr setParticleParams [["A3\data_f\ParticleEffects\Universal\smoke.p3d", 8, 1, 8], "", "Billboard",100,0.2,[0,0,0],[0,0,0],0,90,0.1,0.05,[2],[[0,0,0,1],[0,0,0,1],[0,0,0,1]],[0],0,0,"","", _missile];
					_tr setdropinterval 0.02;
					sleep 1;
					deletevehicle _tr;
				};
			};
	};

if (_light==2) then
	{
	//fuel burning should illuminate the landscape
	_fireLight = "#lightpoint" createVehicle position _missile;
	_fireLight setLightBrightness 0.8;
	_fireLight setLightAmbient [0.5, 0.5, 0.5];
	_fireLight setLightColor [1.0, 1.0, 1.0];
	_fireLight lightAttachObject [_missile, [0, -0.5, 0]];
	};

//missile flying

_velocityForCheck = call _homeMissile;
if ({(typeName _x) == (typeName 0)} count _velocityForCheck == 3) then {_missile setVelocity _velocityForCheck};

waituntil {!alive _missile};
if (_light != 0) then {deleteVehicle _fireLight}; //delete ligh source
if (_targetIsHeliEmpty) then {deleteVehicle _target};
