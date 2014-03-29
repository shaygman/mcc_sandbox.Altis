// by BonInf*
// changed by Psycho
#define __includedMates (units group _playerdown - [_playerdown])
private ["_playerdown","_closestsquadmate","_min_distance","_distance"];
_playerdown = _this select 0;
_closestsquadmate = if (count _this > 1) then {_this select 1} else {nil};

sleep (15 + (random 40));
if (count _this > 1) then {
	if (!alive _closestsquadmate || {_closestsquadmate getVariable "tcb_ais_agony"}) then {
		_closestsquadmate = Nil;
	};
};
if (isNil "_closestsquadmate") then {
	{if (_x call tcb_fnc_isMedic) exitWith {_closestsquadmate = _x}} forEach __includedMates;

	if (isNil "_closestsquadmate") then {
		_closestsquadmate = _playerdown;
		_min_distance = 100000;
		{
			_distance = _playerdown distance _x;
			if (_distance < _min_distance && {!isPlayer _x}) then {
				_min_distance = _distance;
				_closestsquadmate = _x;
			};
		} foreach __includedMates;
	};
};

While {alive _playerdown && {_playerdown getVariable "tcb_ais_agony"} && {_closestsquadmate distance _playerdown < 4} && {alive _closestsquadmate} && {!(_closestsquadmate getVariable "tcb_ais_agony")}} do {
	if (currentCommand _closestsquadmate != "MOVE") then {_closestsquadmate Stop false; _closestsquadmate doMove position _playerdown};
	sleep 3;
};

if (!alive _closestsquadmate || {_closestsquadmate getVariable "tcb_ais_agony"} || {isNull _closestsquadmate}) then {
	[_playerdown] spawn tcb_fnc_sendaihealer;
};

if (alive _playerdown && {_playerdown getVariable "tcb_ais_agony"}) then {
	if (_closestsquadmate != _playerdown && {!(_closestsquadmate getVariable "tcb_ais_agony")}) then {
		[_playerdown, _closestsquadmate] spawn tcb_fnc_firstAid;
	};
};