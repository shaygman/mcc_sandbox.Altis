//=================================================================MCC_fnc_medicUseItem=========================================================================================
//Handle medic uses item
//=============================================================================================================================================================================
private ["_item","_itemType","_unit","_complex","_self","_fail","_remaineBlood","_maxBleeding","_hitArray","_hitSelections","_damage","_break","_string","_magPlayer","_magUnit"];
_itemType 	= _this select 0;
_unit 		= _this select 1;
_self		= if (_unit == player) then {true} else {false};
_break	= false;

_complex = missionNamespace getVariable ["MCC_medicComplex",false];

_item = switch (_itemType) do {
			case "bandage": {if (_complex) then {"MCC_bandage"} else {"FirstAidKit"}};
			case "epipen": {if (_complex) then {"MCC_epipen"} else {"Medikit"}};
			case "saline": {if (_complex) then {"MCC_salineBag"} else {"Medikit"}};
			case "heal": {if (_complex) then {"MCC_firstAidKit"} else {"Medikit"}};
		};

_magPlayer =  items player;
_magUnit =  items _unit;

//Remove item in complex mode
if (_complex) then {
	if (!((_item in _magPlayer|| (_item in _magUnit)))|| !(alive _unit) || !(alive player)) exitWith {_break};

	if (_itemType != "heal") then {
		//If unit is unconscious use its items first if it had any
		if (_item in _magUnit && (_unit getVariable ["MCC_medicUnconscious",false])) then {
			_unit removeItem _item;
		} else {
			player removeItem _item;
		};
	};
} else {
	if (!((_item in (items player))|| (_item in (items _unit)))|| !(alive _unit) || !(alive player)) exitWith {_break};

	//Remove item in non complex mode
	if (_itemType == "bandage") then {
		//If unit is unconscious use its items first if it had any
		if (_item in (items _unit) && (_unit getVariable ["MCC_medicUnconscious",false])) then {_unit removeItem _item} else {player removeItem _item}
	};
};

//No item - exit
if (_break) exitWith {};


switch (_itemType) do {
	case "bandage":	{
		_fail = ["Bandaging",10,_unit] call MCC_fnc_medicProgressBar;
		if !(_fail) then {
			//Gain XP
			if ((_unit getVariable ["MCC_medicBleeding",0])>0 && !_self && CP_activated) then {
				_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",true]) then {format ["For bandaging %1",name _unit]} else {""};
				[getplayeruid player, 100,_string] spawn MCC_fnc_addRating;
			};

			_unit setVariable ["MCC_medicBleeding",0,true];
		};
	};

	case "heal": {
		_fail = ["Healing",20,_unit] call MCC_fnc_medicProgressBar;
		if !(_fail) then {
			_hitArray = [];
			_hitSelections = ["HitHead","HitBody","hitHands","hitLegs"];
			{_hitArray pushBack (_unit getHitPointDamage _x)} foreach _hitSelections;

			//Gain XP
			if ((getDammage _unit)>0.2 && !_self && CP_activated) then {
				_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",true]) then {format ["For healing %1",name _unit]} else {""};
				[getplayeruid player, 200,_string] spawn MCC_fnc_addRating;
			};

			_unit setDamage 0.2;

			{
				_damage = if (_x >= 0.2) then {0.2} else {0};
				_unit setHitPointDamage [_hitSelections select _foreachIndex, _damage];
			} forEach _hitArray;
		};
	};

	case "epipen":{
		_fail = ["Injecting Epipen",10,_unit] call MCC_fnc_medicProgressBar;
		if !(_fail) then {
			//Gain XP
			if ((_unit getVariable ["MCC_medicUnconscious",false]) && !_self && CP_activated) then {
				_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",true]) then {format ["For healing %1",name _unit]} else {""};
				[getplayeruid player, 300,_string] spawn MCC_fnc_addRating;
			};

			_unit setVariable ["MCC_medicUnconscious",false,true];
		};
	};

	case "saline": {
		_fail = ["Saline Transfusion",30,_unit] call MCC_fnc_medicProgressBar;

		_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];
		_remaineBlood = _unit getvariable ["MCC_medicRemainBlood",_maxBleeding];

		if !(_fail) then {
			_unit setVariable ["MCC_medicRemainBlood",(_remaineBlood + 50) min _maxBleeding,true];
		};
	};
};

