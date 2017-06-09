//===============================================================MCC_fnc_handleDamage=========================================================================================
// Handle damage on players and AI
//==============================================================================================================================================================================
private ["_unit","_selectionName","_damage","_source","_bleeding","_string","_distance","_kill","_xpFactor"];
_unit 			= _this select 0;
_selectionName	= tolower (_this select 1);
_damage			= _this select 2;
_source			= _this select 3;

if (_damage < 0.0001) exitWith {};

if (!alive vehicle _unit) then {
	unassignVehicle _unit;
  	_unit action ["eject", vehicle _unit];
};

if (!local _unit || (damage _unit >=1) || !alive _unit) then {
	0;
} else {
	//Effects
	if (_unit == player) then {
		//Effects
		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [3];
		"dynamicBlur" ppEffectCommit 0;

		"dynamicBlur" ppEffectAdjust [0];
		"dynamicBlur" ppEffectCommit (_damage*10 max 0.5);
	};

	if ((_selectionName in ["","body","head","spine1","spine2","spine3","face_hub","pelvis","neck"] && (_damage > 0.9)) || !alive (vehicle player)) then {
		//AI will not always get unconscious and sometimes just die

		if  (!(isPlayer _unit) && (random 1 > 0.1)) then {
			_damage;
		} else {
			_damage = 0.9;
			[_unit,_source] spawn MCC_fnc_unconscious;
			_damage;
		}
	} else {
		_bleeding = (getDammage _unit) max (_unit getVariable ["MCC_medicBleeding",0]);
		_unit setVariable ["MCC_medicBleeding",_bleeding min 1,true];

		//Set damage coef
		_damage = if (isPlayer _unit) then {((missionNamespace getVariable ["MCC_medicDamageCoef",0.6])*_damage) min 0.95} else {_damage* 1.3};
		_damage min 0.9
	};
};