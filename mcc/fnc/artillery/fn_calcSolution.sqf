private ["_targetPos","_unit","_veh","_zpos","_anchorPos","_muzzle","_mag","_initSpeed","_currentWeaponMode","_artilleryCharge","_ammo","_eta",
         "_friction","_vec2Target","_altitude","_dir","_dist","_minElev","_maxElev","_turrets","_turret","_selectedMuzzl","_solution"];

MCC_fnc_calcSolutionInside = 
{
	private ["_dist","_altitude","_initSpeed","_friction","_minElev","_maxElev",
	"_gravity","_low_solution","_eta","_high_solution","_solution","_eta_low_solution"];

	_dist 				= _this select 0;
	_altitude 			= _this select 1;
	_initSpeed 			= _this select 2;
	_friction 			= abs (_this select 3);
	_minElev 			= (_this select 4) select 0;
	_maxElev 			= (_this select 4) select 1;
	_eta				= _this select 5;
	_gravity			= 9.80665;

	_solution = if (_friction == 0) then 
	{
		_low_solution  = atan((_altitude*(_initSpeed^2-_altitude*_gravity+(_initSpeed^4-2*_initSpeed^2*_altitude*_gravity-_gravity^2*_dist^2)^(1/2))/(_altitude^2+_dist^2)+_gravity)/(_initSpeed^2-_altitude*_gravity+(_initSpeed^4-2*_initSpeed^2*_altitude*_gravity-_gravity^2*_dist^2)^(1/2))*(_altitude^2+_dist^2)/_dist);
		_high_solution = -atan(2*(_gravity-1/2*_altitude*(-2*_initSpeed^2+2*_gravity*_altitude+2*(_initSpeed^4-2*_initSpeed^2*_gravity*_altitude-_gravity^2*_dist^2)^(1/2))/(_altitude^2+_dist^2))/(-2*_initSpeed^2+2*_gravity*_altitude+2*(_initSpeed^4-2*_initSpeed^2*_gravity*_altitude-_gravity^2*_dist^2)^(1/2))*(_altitude^2+_dist^2)/_dist);		
		
		//direct soulution?
		if (_low_solution > _minElev) then
		{
			_eta_low_solution = _dist / (_initSpeed * cos (_low_solution));
			_eta = _dist / (_initSpeed * cos (_high_solution));
			[_low_solution,_eta_low_solution,_high_solution,_eta]
		}
		else
		{
			_eta = _dist / (_initSpeed * cos (_high_solution));
			[_high_solution,_eta,nil,nil]
		};
	}
	else
	{
		_high_solution = atan((_gravity*exp(2.*_dist*_friction)*_dist-1.*_gravity*_dist-2.*_dist^2*_friction*_gravity+2.*_dist*_friction^2*_initspeed^2*_altitude+_altitude*(4.*_dist^2*_friction^4*_initspeed^4+8.*_dist*_friction^3*_initspeed^2*_altitude*_gravity+4.*_friction^2*_initspeed^2*_altitude*_gravity-4.*_friction^2*_initspeed^2*_altitude*_gravity*exp(2.*_dist*_friction)-1.*_gravity^2*exp(4.*_dist*_friction)+2.*_gravity^2*exp(2.*_dist*_friction)+4.*_dist*_gravity^2*exp(2.*_dist*_friction)*_friction-1.*_gravity^2-4.*_dist*_friction*_gravity^2-4.*_dist^2*_friction^2*_gravity^2)^(1/2))/(2.*_dist^2*_friction^2*_initspeed^2+2.*_altitude*_friction*_dist*_gravity+_altitude*_gravity-1.*_altitude*_gravity*exp(2.*_dist*_friction)+_dist*(4.*_dist^2*_friction^4*_initspeed^4+8.*_dist*_friction^3*_initspeed^2*_altitude*_gravity+4.*_friction^2*_initspeed^2*_altitude*_gravity-4.*_friction^2*_initspeed^2*_altitude*_gravity*exp(2.*_dist*_friction)-1.*_gravity^2*exp(4.*_dist*_friction)+2.*_gravity^2*exp(2.*_dist*_friction)+4.*_dist*_gravity^2*exp(2.*_dist*_friction)*_friction-1.*_gravity^2-4.*_dist*_friction*_gravity^2-4.*_dist^2*_friction^2*_gravity^2)^(1/2))^(1/2)*(1/(2.*_dist^2*_friction^2*_initspeed^2+2.*_altitude*_friction*_dist*_gravity+_altitude*_gravity-1.*_altitude*_gravity*exp(2.*_dist*_friction)+_dist*(4.*_dist^2*_friction^4*_initspeed^4+8.*_dist*_friction^3*_initspeed^2*_altitude*_gravity+4.*_friction^2*_initspeed^2*_altitude*_gravity-4.*_friction^2*_initspeed^2*_altitude*_gravity*exp(2.*_dist*_friction)-1.*_gravity^2*exp(4.*_dist*_friction)+2.*_gravity^2*exp(2.*_dist*_friction)+4.*_dist*_gravity^2*exp(2.*_dist*_friction)*_friction-1.*_gravity^2-4.*_dist*_friction*_gravity^2-4.*_dist^2*_friction^2*_gravity^2)^(1/2))^(1/2)));
		_eta = _dist / (_initSpeed * cos (_high_solution));
		[_high_solution,_eta,nil,nil]
	};

	_solution;
};

_targetPos	= _this select 0;
_unit		= _this select 1;
_veh 		= vehicle _unit;
_anchorPos = positionCameraToWorld [0,0,0];
_zpos = [(_anchorPos select 0),(_anchorPos select 1),((getPosASL _veh) select 2)-((getPosATL _veh) select 2)+(_anchorPos select 2)];

//Find out which weapon
_muzzle = currentMuzzle _unit;
_mag = if (_unit == gunner _veh) then 
{
	currentMagazine _veh
}
else
{
	getArray(configFile >> "cfgWeapons" >> _muzzle >> "Magazines") select 0
};

//Get weapon configs
_initSpeed = getnumber(configFile >> "cfgMagazines" >> _mag >> "initSpeed");
_currentWeaponMode = currentWeaponMode _unit;
_ammo = getText(configFile >> "cfgMagazines" >> _mag >> "ammo");
_friction = -(getNumber(configFile >> "cfgAmmo" >> _ammo >> "airFriction"));

//Find out which charge is used close-meduim-long
_artilleryCharge = getNumber(configFile >> "cfgWeapons" >> _muzzle >> _currentWeaponMode >> "artilleryCharge");
if (_artilleryCharge > 0) then {_initSpeed = _initSpeed*_artilleryCharge};

//Get distance pitch and dir
_vec2Target 		= [(_targetPos select 0) - (_zpos select 0), (_targetPos select 1) - (_zpos select 1), (_targetPos select 2) - (_zpos select 2)];
_altitude 			= _vec2Target select 2;
_dir 				= (360+( _vec2Target select 0)atan2(_vec2Target select 1))%360;
_dist 				= [_vec2Target select 0,_vec2Target select 1,0] distance [0,0,0];

//Eleveation limit
_turrets = (configFile >> "CfgVehicles" >> (typeOf _veh) >> "Turrets");
for "_i" from 0 to ((count _turrets)-1) do 
{
	_turret = _turrets select _i;
	_selectedMuzzl = _veh weaponsTurret [_i];
	{
		if (_x == _muzzle) exitWith 
		{
			_minElev = getnumber (_turret >> "minelev");
			_maxElev = getnumber (_turret >> "maxelev");
		}
	} forEach _selectedMuzzl;
};

_solution = [];
if (_targetPos inRangeOfArtillery [[_veh], _mag]) then
{
	_solution = [_dist,_altitude,_initSpeed,_friction,[_minElev,_maxElev]] call MCC_fnc_calcSolutionInside;
}
else
{
	_solution = [];
};

if (count _solution > 0) then
{
	_solution set [count _solution,_dir];
};

_solution