//==================================================================MCC_fnc_initMedic===============================================================================================
// init MCC medic system
//==================================================================================================================================================================================
if (isDedicated) exitWith {}; 
if (!isDedicated && !hasInterface) exitWith {};
MCC_fnc_unconscious =
{
	private ["_unit","_source","_string"];
	_unit 	= _this select 0;
	_source	= _this select 1;
	
	_unit setVariable ["MCC_medicSeverInjury",false,true];
	_unit setVariable ["MCC_medicUnconscious",true,true];
	
	//GetXP
	if (isplayer _source && _source != _unit && CP_activated) then
	{
		_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",false]) then {format ["For killing %1",name _unit]} else {""}; 
		[[getplayeruid _source, 100,_string], "MCC_fnc_addRating", side _source] spawn BIS_fnc_MP;
	};
	
	waitUntil {isTouchingGround _unit};
	_unit switchmove "Unconscious";
	
	sleep 0.1;
	_unit setCaptive true; 
	
	//TODO Create a dialog for respawn call medic
	
	waitUntil {(! alive _unit) || (_unit getVariable ["MCC_medicUnconscious",false])};
	_unit setVariable ["MCC_medicUnconscious",false,true];
	_unit setCaptive false; 
};

MCC_fnc_severInjury =
{
	private ["_unit","_source","_string"];
	_unit 	= _this select 0;
	_source	= _this select 1;
	
	_unit setVariable ["MCC_medicSeverInjury",true,true];
	_unit setVariable ["MCC_medicUnconscious",false,true];
	
	//GetXP
	if (isplayer _source && _source != _unit && CP_activated) then
	{
		_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",false]) then {format ["For severely injuring %1",name _unit]} else {""}; 
		[[getplayeruid _source, 200,_string], "MCC_fnc_addRating", side _source] spawn BIS_fnc_MP;
	};
	
	waitUntil {isTouchingGround _unit};
	_unit playActionNow "agonyStart";
	
	_unit setCaptive true; 
	waitUntil {animationstate _unit == "ainjppnemstpsnonwrfldnon"};
	waitUntil {(! alive _unit) || (animationstate _unit != "ainjppnemstpsnonwrfldnon") || !(_unit getVariable ["MCC_medicSeverInjury",false])};
	_unit setCaptive false; 
};

MCC_fnc_handleDamage =
{
	private ["_unit","_selectionName","_damage","_source","_severeInjury","_unconscious","_hitLevel","_newDamage","_fatal","_hitPoint"];
	_unit 			= _this select 0;
	_selectionName	= tolower (_this select 1);
	_damage			= _this select 2;
	_source			= _this select 3;
	
	if (!local _unit) exitWith {};
	
	if !(_selectionName in ["head","head_hit","body","legs","leg_l","leg_r","hands","hand_r","hand_l"]) exitWith {0};
	
	player sidechat str [_selectionName,_damage];
	
	//Effects
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [3];
	"dynamicBlur" ppEffectCommit 0;

	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit (_damage*10 max 0.5);
	
	//Where did we got hit
	switch (true) do
			{
				case (_selectionName in ["head","head_hit"]) : {_fatal = true; _hitPoint = "HitHead"};
				case (_selectionName == "body") : {_fatal = true; _hitPoint = "HitBody"};
				case (_selectionName in ["legs","leg_l","leg_r"]) : {_fatal = false; _hitPoint = "hitLegs"};
				case (_selectionName in ["hands","hand_r","hand_l"]) : {_fatal = false; _hitPoint = "hitHands"};
			};
	
	//Get params
	_severeInjury 	= _unit getVariable ["MCC_medicSeverInjury",false];
	_unconscious 	= _unit getVariable ["MCC_medicUnconscious",false];
	_hitLevel 		= _unit getHitPointDamage _hitPoint;
	_newDamage 		= if ((_hitLevel + _damage)>1) then {1} else {(_hitLevel + _damage) * (missionNamespace getVariable ["MCC_medicDamageCoef",0.8])};
	
	//Can't kill unconscious players
	if (_unconscious) exitWith {0};
	
	if (_newDamage > 0.9 && _fatal) then 
	{
		//If sever damage fall unconscious
		if (_severeInjury && !_unconscious) then 
		{
			[_unit,_source] call MCC_fnc_unconscious;
		}
		else
		{
			//Else sever injury
			_unit setHitPointDamage [_hitPoint, 0.7];
			[_unit,_source] call MCC_fnc_severInjury;
		};
	}
	else
	{
		if !(_severeInjury) then {_unit setHitPointDamage [_hitPoint, _newDamage]};
	};
	0
};

waitUntil {!isNil {player getVariable "BIS_fnc_feedback_hitArrayHandler"}};
player removeAllEventHandlers "handleDamage";
player addEventHandler ["HandleDamage", {_this spawn MCC_fnc_handleDamage}];