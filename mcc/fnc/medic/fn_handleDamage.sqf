//===============================================================MCC_fnc_handleDamage=========================================================================================
// Handle damage on players and AI
//==============================================================================================================================================================================
private ["_unit","_selectionName","_damage","_source","_bleeding","_string","_distance","_kill","_xpFactor"];
_unit 			= _this select 0;
_selectionName	= tolower (_this select 1);
_damage			= _this select 2;
_source			= _this select 3;
_fatal			= true;

if (_damage < 0.0001) exitWith {};

if (!local _unit || (damage _unit >=1)) then {
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


	if (_selectionName in ["","head","body","spine1","spine2","spine3","face_hub","pelvis","neck"] && _damage >= 1) then {
		//AI will not always get unconscious and sometimes just die

		if (CP_activated) then {

			//GetXP
			if (missionNamespace getVariable ["MCC_medicXPmesseges",true]) then {
				_distance =floor (_source distance _unit);
				_kill = if (_selectionName in ["face_hub","neck","head"]) then {"Headshout"} else {"Incapacitating"};
				_string = format ["%3 %1 (Distance %2m)",name _unit, _distance, _kill];
				_xpFactor = if (vehicle player != player) then {0.5} else {(ceil(_distance/200) min 3)};

			} else {
				_string = "";
			};

			[[getplayeruid _source, (100*_xpFactor),_string], "MCC_fnc_addRating", _source] spawn BIS_fnc_MP;
		};

		if  (!(isPlayer _unit) && (random 1 > 0.3)) then {
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
		_damage
	};
};