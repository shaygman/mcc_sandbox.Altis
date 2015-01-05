//===============================================================MCC_fnc_handleDamage=========================================================================================
// Handle damage on players and AI
//==============================================================================================================================================================================
private ["_unit","_selectionName","_damage","_source","_bleeding","_unconscious","_string"];
_unit 			= _this select 0;
_selectionName	= tolower (_this select 1);
_damage			= _this select 2;
_source			= _this select 3;
_fatal			= true;

//Get params
_severeInjury 	= _unit getVariable ["MCC_medicSeverInjury",false];
_unconscious 	= _unit getVariable ["MCC_medicUnconscious",false];

if (!local _unit || (damage _unit >=1)) then
{
	0;
}
else
{
	//Effects
	if (_unit == player && _damage > 0.0000001) then
	{
		//Effects
		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [3];
		"dynamicBlur" ppEffectCommit 0;

		"dynamicBlur" ppEffectAdjust [0];
		"dynamicBlur" ppEffectCommit (_damage*10 max 0.5);
	};


	if (_selectionName in ["","head","body"] && _damage >= 1) then
	{
		//AI will not always get unconscious and sometimes just die
		if  (!(isPlayer _unit) && (random 1 > 0.3)) then
		{
			//GetXP
			if (CP_activated) then
			{
				_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",false]) then {format ["For killing %1",name _unit]} else {""};
				[[getplayeruid _source, 500,_string], "MCC_fnc_addRating", _source] spawn BIS_fnc_MP;
			};

			_damage;
		}
		else
		{
			_damage = 0.9;
			[_unit,_source] spawn MCC_fnc_unconscious;
			_damage;
		}
	}
	else
	{
		_bleeding = (getDammage _unit) max (_unit getVariable ["MCC_medicBleeding",0]);
		_unit setVariable ["MCC_medicBleeding",_bleeding min 1,true];

		//Set damage coef
		(_damage * (missionNamespace getVariable ["MCC_medicDamageCoef",1]));
	};
};



/*
if !(_selectionName in ["head","head_hit","body","legs","leg_l","leg_r","hands","hand_r","hand_l",""]) exitWith {0.001};
if (diag_frameno > (_unit getVariable ["MCC_medicFrameNo",diag_frameno])) exitWith {_unit setVariable ["MCC_medicFrameNo",diag_frameno];0.001};
_unit setVariable ["MCC_medicFrameNo",diag_frameno];
if (_damage<0.0000001) exitWith {_damage};

//Can't kill unconscious players but can kill AI
if (_unconscious && (_unit != player)) exitWith {_unit setDamage 1};

if (_unit == player) then
{
	//Effects
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [3];
	"dynamicBlur" ppEffectCommit 0;

	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit (_damage*10 max 0.5);
};

if (_damage<0.00001) exitWith {_damage};

//Where did we got hit
switch (true) do
		{
			case (_selectionName in ["head","head_hit"]) : {_fatal = true; _hitPoint = "HitHead"};
			case (_selectionName in ["body",""]) : {_fatal = true; _hitPoint = "HitBody"};
			case (_selectionName in ["legs","leg_l","leg_r"]) : {_fatal = false; _hitPoint = if (isPlayer _unit) then {"hitLegs"} else {"hitHands"}};
			case (_selectionName in ["hands","hand_r","hand_l"]) : {_fatal = false; _hitPoint = if (isPlayer _unit) then {"hitHands"} else {"hitLegs"}};
		};



_hitLevel 		= _unit getHitPointDamage _hitPoint;
_newDamage		= _damage - (_hitLevel *(missionNamespace getVariable ["MCC_medicDamageCoef",0.8]));
if (!_fatal) then {_newDamage = _newDamage * 0.5};

systemchat str [_selectionName,diag_frameno,_damage];

if (_newDamage >= 0.9) then
{
	//AI will not always get unconscious and sometimes just die
	if  ((_unit != player) && (random 1 > 0.3)) exitWith {_unit setDamage 1;};

	_unit setDamage 0.8;
	_unit setHitPointDamage [_hitPoint, 0.9];
	[_unit,_source] spawn MCC_fnc_unconscious;

	/*
	//If sever damage fall unconscious
	if (_severeInjury && !_unconscious) then
	{
		[_unit,_source] spawn MCC_fnc_unconscious;
	}
	else
	{
		//Else sever injury
		_unit setHitPointDamage [_hitPoint, 0.8];
		[_unit,_source] spawn MCC_fnc_severInjury;
	};

}
else
{
	if !(_severeInjury) then
	{
		_unit setHitPointDamage [_hitPoint, _newDamage];
	};
};

0
*/