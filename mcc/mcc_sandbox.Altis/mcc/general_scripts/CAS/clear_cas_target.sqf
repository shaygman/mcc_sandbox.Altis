private ["_targeth", "_cas_name", "_spawnkind"];

_cas_name = _this select 0;
_targeth =  _this select 1;
_spawnkind = _this select 2;

//hint format ["Target damage check A: %1", (damage _targeteh)];
//sleep 0.1;

if ( _spawnkind == "Gun-run short(ACE)" ) then	{
	sleep 40;
	}	else	{
		sleep 110;
};

if (!(IsNil "_targeth")) then {_targeth setdamage 1};

//allow time for strafe_cas_target.sqf script to catch up
sleep 5;

if (IsNil "_targeth") then {_targeth = objNull};
deleteVehicle _targeth;