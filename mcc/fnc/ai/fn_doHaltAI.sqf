//==================================================================MCC_fnc_doHaltAI===========================================================================================
// Trying to halt an AI
// Example:[_target] call MCC_fnc_doHaltAI;
// <IN>
//	_target:					Object- unit.
//
// <OUT>
//		Nothing
//===========================================================================================================================================================================
private["_target","_factor","_targetCorage"];
_target		= _this select 0;

//shout
[[[netid player,player], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
sleep 1;

//Set courage factor
_factor = if (side _target == civilian) then {6} else {11};
if (primaryWeapon player == "") then {_factor = _factor*2};
_rand= random 20;

//Halt the AI
[[2,getpos _target,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _target)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;

//Stop and look at the player
[[[_target, player],
  {
	_target = _this select 0;
	_men = _this select 1;

	(group _target) setFormDir ([_target,_men] call BIS_fnc_dirTo);
	doStop _target;
	_target disableAI "MOVE";
	sleep 2;
	_target enableAI "MOVE";
  }],"BIS_fnc_spawn", _target, false] spawn BIS_fnc_MP;

//Get courage
_targetCorage = _target getVariable "MCC_courage";
if (isnil "_targetCorage") then
{
	_targetCorage = (rankId _target + (random 10 + _factor) + count units group _target);
	_target setVariable ["MCC_courage",_targetCorage,true];
};
_targetCorage = _targetCorage * (1-(getdammage _target));

//If comply
if (random 25 > _targetCorage || (_target getVariable ["MCC_Stunned", false])) then
{
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

		while {alive _target && !(_target getVariable ["MCC_neutralize",false])} do
		{
			if (random 1 < _escapeChance) exitWith {_target setVariable ["MCC_disarmed",false,true]};
			_escapeChance = _escapeChance + 0.01;
		};

		_target setVariable ["MCC_disarmed",false];
		[_target] spawn MCC_fnc_deleteHelper;
	};
}
else
{
	if !(_target getVariable ["MCC_animRunning",false]) then {
		[[[netid _target,_target], format ["alone%1",floor random 10]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		if ((stance _target == "STAND") && (side _target == civilian)) then
		{
			[[_target,"Acts_Kore_Introducing",true,4], "MCC_fnc_setUnitAnim", true, false] spawn BIS_fnc_MP;
		};
	};
};

[[[_target],{(_this select 0) enableAI "MOVE";}],"BIS_fnc_spawn", _target, false] spawn BIS_fnc_MP;