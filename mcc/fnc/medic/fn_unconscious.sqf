//=================================================================MCC_fnc_unconscious=========================================================================================
//Handle unconscious behavior
//=============================================================================================================================================================================

private ["_unit","_source","_string","_ypos"];
_unit 	= _this select 0;
_source	= _this select 1;

if (_unit getVariable ["MCC_medicUnconscious",false]) exitWith {};
_unit allowDamage false;
_unit setVariable ["MCC_medicSeverInjury",false,true];
_unit setVariable ["MCC_medicUnconscious",true,true];

if (isplayer _source && _source != _unit) then {
	//Teamkill
	if (side _source == side _unit && (missionNamespace getVariable ["MCC_medicPunishTK",false])) then {
		[_source] spawn {
			private ["_answer","_string","_source"];
			_source = _this select 0;

			_answer = [format ["<t font='TahomaB'>You have been killed by %1 do you want to forgive him?</t>",name _source],"Friendly Fire","No","Yes"] call BIS_fnc_guiMessage;
			waituntil {!isnil "_answer"};
			if (_answer) then
			{
				_string = "<t font='puristaMedium' size='0.5' color='#FFFFFF '>Punished for friendly fire</t>";
				[[_string,0,1,2,1,0,4], "bis_fnc_dynamictext", _source, false] spawn BIS_fnc_MP;
				sleep 1;
				_source setDamage 1;
			};
		};
	} else {
		//GetXP
		if (CP_activated) then {
			_string = if (missionNamespace getVariable ["MCC_medicXPmesseges",false]) then {format ["For killing %1",name _unit]} else {""};
			[[getplayeruid _source, 500,_string], "MCC_fnc_addRating", side _source] spawn BIS_fnc_MP;
		};

	};
};

_ypos = (getpos _unit) select 2;
waitUntil {isTouchingGround _unit};
_unit allowDamage true;

//If we are falling from too high
if (_ypos > 10) exitWith {
	_unit setDamage 1;
};

_unit setCaptive true;
_unit playmoveNow "Unconscious";

//Add helper
[[_unit, "Hold %1 to heal"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;

//Handle player
if (isPlayer _unit) exitWith {
	//Close Map
	if (visibleMap) then {openMap false};

	//Disable ACRE
	_unit setVariable ["acre_sys_core_isDisabled", True, True];

	//Disable TF
	_unit setVariable ["tf_voiceVolume", 0, True];
	_unit setVariable ["tf_unable_to_use_radio", True, True];

	while {dialog} do {closeDialog 0; sleep 0.01};
	createDialog "mcc_uncMain";
};

_unit spawn {
	private "_t";
	_t = time + 360;
	_this disableAI "MOVE";
	_this disableAI "TARGET";
	_this disableAI "AUTOTARGET";
	_this disableAI "ANIM";
	_this disableAI "FSM";
	_this disableConversation true;

	sleep 1;
	_this allowDamage true;

	while {alive _this && time < _t && (_this getVariable ["MCC_medicUnconscious",false])} do {
		if (animationState _this != "unconscious") then {_this playmoveNow "Unconscious"};
		//It wake up
		if (random 100 < 0.05) then	{
			_this setVariable ["MCC_medicUnconscious",false,true];
		};
		sleep 2 + random 5;
	};

	_this playmoveNow "amovppnemstpsraswrfldnon";
	_this setCaptive false;
	_this enableAI "MOVE";
	_this enableAI "TARGET";
	_this enableAI "AUTOTARGET";
	_this enableAI "ANIM";
	_this enableAI "FSM";
	_this disableConversation false;

	if ((_this getVariable ["MCC_medicUnconscious",false]) && alive _this) then {_this setDamage 1};

	//Remove helper
	[_this] spawn MCC_fnc_deleteHelper;
};

