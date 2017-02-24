//==================================================================MCC_fnc_doHaltAI===========================================================================================
// Trying to halt an AI
// Example:[_target] call MCC_fnc_doHaltAI;
// <IN>
//	_target:					Object- unit.
//	_unit						OBJECT - unit enforcing the target
//	_shout						BOOLEAN, true the _unit will call the _target to surrender
//
// <OUT>
//		Nothing
//===========================================================================================================================================================================
private["_target","_targetCorage","_shout","_unit"];

_target	= param [0,objNull,[objNull]];
_unit	= param [1,player,[objNull]];
_shout	= param [2,true,[true]];

//shout
if (_shout) then {
	[[[netid _unit,_unit], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	sleep 1;
};

//if no unit or already disarmed
if (!alive _target || !alive _unit || (_unit getVariable ["MCC_disarmed",false])) exitWith {};

/*---------------------------------------------------------------------------------------
/
/						Set courage factor. Courage is in scale 0 - 100-
/
----------------------------------------------------------------------------------------*/

//If is civ base courage is 20 soldier base courage is 40
_targetCorage = _target getVariable ["MCC_courage",if (side _target == civilian) then {20 + (random 20)} else {60 + (random 30)}];

//if the threating unit has weapon +10 courage, Max 50
if (primaryWeapon _unit == "") then {_targetCorage = _targetCorage + 10};

//Unit rank effects courage
_targetCorage = _targetCorage + ((rankId _target)*3);

//number of units in group
_targetCorage = _targetCorage + ({alive _x} count (units _target));

//Damage effect courage
_targetCorage = _targetCorage * (1-(getdammage _target));

_targetCorage = _targetCorage min 98;

//Halt the AI
if (_shout) then {
	[[2,getpos _target,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _target)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;

	//Stop and look at the player
	[[[_target, _unit],
	  {
		_target = _this select 0;
		_men = _this select 1;

		(group _target) setFormDir ([_target,_men] call BIS_fnc_dirTo);
		doStop _target;
		_target disableAI "MOVE";
		sleep 2;
		_target enableAI "MOVE";
	  }],"BIS_fnc_spawn", _target, false] spawn BIS_fnc_MP;
};

//If comply
if (random 100 >= _targetCorage || (_target getVariable ["MCC_Stunned", false])) then {
	[[[netid _target,_target], format ["enough%1",floor random 14]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	[[_target,"amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"], "MCC_fnc_disarmUnit", _target, false] spawn BIS_fnc_MP;

	//if is armed civilian
	if ((_target getVariable ["MCC_IEDtype",""]) == "ac") then
	{
		_target setvariable ["armed",false,true];
		sleep 1;
		{
		  deleteVehicle _x;
		} forEach attachedObjects _target;
	};

	//If left unintended for long will break free
	_target spawn
	{
		private ["_escapeChance","_target"];
		_target		= _this;
		_escapeChance 	= 0.01;

		while {alive _target && !(_target getVariable ["MCC_neutralize",false])} do {
			if (random 1 < _escapeChance) exitWith {_target setVariable ["MCC_disarmed",false,true]};
			_escapeChance = _escapeChance + 0.01;
		};

		_target setVariable ["MCC_disarmed",false,true];
		[_target] spawn MCC_fnc_deleteHelper;
	};
} else {
	if !(_target getVariable ["MCC_animRunning",false]) then {

		//Says he surrender
		if (_shout)  then {
			[[[netid _target,_target], format ["alone%1",floor random 10]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		};

		if ((stance _target == "STAND") && (side _target == civilian)) then	{
			[_target,"Acts_Kore_Introducing",true,4] remoteExec ["MCC_fnc_setUnitAnim",0];
		};
	};
};

[[[_target],{(_this select 0) enableAI "MOVE";}],"BIS_fnc_spawn", _target, false] spawn BIS_fnc_MP;