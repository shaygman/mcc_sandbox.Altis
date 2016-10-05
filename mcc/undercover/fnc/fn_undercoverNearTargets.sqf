#define LEGAL_WEAPON_TYPES [4096,131072]
private ["_enemySides","_group", "_unit", "_spotted", "_spottedWithWeapon", "_weapons", "_nearTargets", "_count", "_nearCount","_target","_leader","_canSee"];

_target = _this select 0;

_spottedWithWeapon = false;
_count = 0;

while { true } do {
	_enemySides = [_target] call bis_fnc_enemySides;
	_spotted = false;

	{
		_group = _x;
		if (side _group in _enemySides) then {

			_weapons = weapons _target;
			_leader = leader _group;
			_nearTargets = (leader _group) nearTargets 500;
			{
				_unit = _x select 4;
				if (_unit == _target) then {
					_spotted = true;
					if ((count _weapons) > 0) then {
						{
							if !(getNumber(configFile >> "CfgWeapons" >> _x >> "type") in LEGAL_WEAPON_TYPES) exitWith {
								_spottedWithWeapon = true;
								_unit setCaptive false;
							};
						 } forEach _weapons;
					};

					//_canSee = ({!(lineintersects [eyepos _x,getposasl _target,_target])} count units _group)>0;
					_canSee = false;

					{
						if ([_x,_target,500] call GAIA_fnc_haslineofsight) exitWith {_canSee = true};
					} forEach units _group;

					if (_canSee && ((_target distance _unit) < 10 || (vehicle _target == _target && ((speed _target > 10) || (stance _target != "STAND"))))
						&& !_spottedWithWeapon) then {

						if (_target getVariable ["MCC_undercoverNearEnemy",false]) then {
							_spottedWithWeapon = true;
							_unit setCaptive false;
						} else {
							systemChat "You are getting suspicious";
							_target setVariable ["MCC_undercoverNearEnemy",true];
						};
					} else {
						_target setVariable ["MCC_undercoverNearEnemy",false];
					};
				};

				// quit the nearTargets loop if _target was spotted
				if (_spotted) exitWith {};
			} forEach _nearTargets;
		};

		// quit the groups loop if _target was spotted
		if (_spotted) exitWith {};
	} forEach allGroups;

	// Set unit to captive status when he was not spotted anymore, while he was spottedWithWeapon before
	if (_spottedWithWeapon && !_spotted) then {
		_count = _count +1;

		 //if unit is hidden more then 2 minutes it will be captive again.
		if (_count>10) then {
			_count = 0;
			_spottedWithWeapon = false;
			_target setCaptive true;
			hint "Your are no longer suspicious";
		};
	};

	sleep 6;
};