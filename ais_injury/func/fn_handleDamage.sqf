// by BonInf*
// changed by psycho
private ['_agony','_unit','_bodypart','_damage','_return','_revive_factor'];
_unit 		= _this select 0;
_bodypart	= _this select 1;
_damage		= _this select 2;

if (!(_unit getVariable "tcb_ais_agony") && {alive _unit}) then {
	_return = _damage / (tcb_ais_rambofactor max 1);
	//diag_log format ["part: %1 --- damage: %2 --- return: %3",_bodypart,_damage,_return];
	_revive_factor = (tcb_ais_rambofactor max 1) * 1.5;
	_agony = false;

	switch _bodypart do {
		case "body" : {
			_damage = (_unit getVariable "tcb_ais_bodyhit") + _return;
			_unit setVariable ["tcb_ais_bodyhit", _damage];
			if (_damage >= 0.9) then {
				_unit allowDamage false;
				_agony = true;
				if (!tcb_ais_revive_guaranty) then {
					if (_damage > _revive_factor) then {_unit setVariable ["tcb_ais_unit_died", true]};
				};
			} else {
				_unit setHit ["body", _damage];
			};
		};
		
		if (tcb_ais_realistic_mode) then {
			case "head" : {
				_damage = (_unit getVariable "tcb_ais_headhit") + _return;
				_unit setVariable ["tcb_ais_headhit", _damage];
				if (_damage >= 0.9) then {
					_agony = true;
					if (!tcb_ais_revive_guaranty) then {
						if (_damage > _revive_factor) then {_unit setVariable ["tcb_ais_unit_died", true]};
					};
				} else {
					_unit setHit ["head", _damage];
				};
			};
		} else {
			case "head" : {};
		};
		
		case "legs" : {
			_damage = (_unit getVariable "tcb_ais_legshit") + _return;
			_unit setVariable ["tcb_ais_legshit", _damage];
			if (_damage >= 1.8) then {
				_agony = true;
			} else {
				_unit setHit ["legs",_damage];
			};
		};
		case "legs_l" : {
			_damage = (_unit getVariable "tcb_ais_legshit") + _return;
			_unit setVariable ["tcb_ais_legshit", _damage];
			if (_damage >= 1.8) then {
				_agony = true;
			} else {
				_unit setHit ["legs",_damage];
			};
		};
		case "legs_r" : {
			_damage = (_unit getVariable "tcb_ais_legshit") + _return;
			_unit setVariable ["tcb_ais_legshit", _damage];
			if (_damage >= 1.8) then {
				_agony = true;
			} else {
				_unit setHit ["legs",_damage];
			};
		};
		case "hands" : {
			_damage = (_unit getVariable "tcb_ais_handshit") + _return;
			_unit setVariable ["tcb_ais_handshit", _damage];
			if (_damage >= 2.3) then {
				_agony = true;
			} else {
				_unit setHit ["hands",_damage];
			};
		};
		case "hands_l" : {
			_damage = (_unit getVariable "tcb_ais_handshit") + _return;
			_unit setVariable ["tcb_ais_handshit", _damage];
			if (_damage >= 2.3) then {
				_agony = true;
			} else {
				_unit setHit ["hands",_damage];
			};
		};
		case "hands_r" : {
			_damage = (_unit getVariable "tcb_ais_handshit") + _return;
			_unit setVariable ["tcb_ais_handshit", _damage];
			if (_damage >= 2.3) then {
				_agony = true;
			} else {
				_unit setHit ["hands",_damage];
			};
		};
		
		case "" : {
			_damage = damage vehicle _unit + _return; //(_unit getVariable "tcb_ais_overall") + _return;
			_unit setVariable ["tcb_ais_overall", _damage];
			if (_damage >= 0.9) then {
				_unit allowDamage false;
				_agony = true;
				if (!tcb_ais_revive_guaranty) then {
					if (_damage > _revive_factor) then {_unit setVariable ["tcb_ais_unit_died", true]};
				};
			} else {
				_unit setDamage _damage;
			};
		};
		default {};
	};

	if (_agony && {!(_unit getVariable "tcb_ais_agony")}) then {
		_unit setVariable ["tcb_ais_agony", true];
		_delay = time + 5;
		_unit setVariable ["tcb_ais_fall_in_agony_time_delay", _delay];
	};
	_return = 0;

} else {
	if (!alive _unit) exitWith {_unit setVariable ["tcb_ais_unit_died", true]; _damage};
	if (time > (_unit getVariable "tcb_ais_fall_in_agony_time_delay")) then {
		_unit setVariable ["tcb_ais_unit_died", true];
	};
	_return = _unit getVariable "tcb_ais_overall";
};

BIS_hitArray = _this; BIS_wasHit = true; // For BIS stuff to work
_return