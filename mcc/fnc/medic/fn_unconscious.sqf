//=================================================================MCC_fnc_unconscious=========================================================================================
//Handle unconscious behavior
/*
player setVariable ["MCC_medicUnconscious",false]
[player,player] spawn MCC_fnc_unconscious;
*/
//=============================================================================================================================================================================
#define ANIM_WOUNDED "acts_injuredlyingrifle02_180"
private ["_unit","_source","_string","_distance","_xpFactor"];
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
		if (missionNamespace getVariable ["CP_activated",true]) then {

			if (missionNamespace getVariable ["MCC_medicXPmesseges",true]) then {
				_distance =floor (_source distance _unit);
				_string = format ["Incapacitating %1 (Distance %2m)",name _unit, _distance];
				_xpFactor = if (vehicle player != player) then {0.5} else {(ceil(_distance/200) min 3)};

			} else {
				_string = "";
			};

			if (side _source getFriend side _unit < 0.6) then {
				[[getplayeruid _source, (100*_xpFactor),_string], "MCC_fnc_addRating", _source] spawn BIS_fnc_MP;
			};
		};

	};
};


//waitUntil {isTouchingGround _unit};


//Make it captive
_unit setCaptive true;
//_unit playmoveNow "Unconscious";

//Lets try ragdolls
if (vehicle _unit != _unit) then {
	unassignVehicle _unit;
  	_unit action ["eject", vehicle _unit];
};

private "_rag";
_rag = "Land_Can_V3_F" createVehicleLocal [0,0,0];
_rag setMass 1e10;
_rag attachTo [_unit, [0,0,0], "Spine3"];
_rag setVelocity [0,0,6];
_unit allowDamage false;
detach _rag;
0 = _rag spawn {
    deleteVehicle _this;
};

waitUntil{sleep 0.05; (velocity _unit) distance [0,0,0] < 0.1};

//play wounded animation
_unit switchMove ANIM_WOUNDED;

//add 'anim changed' event handler to ensure unit stays in the incap animation
private _ehAnimChanged = _unit addEventHandler
[
	"AnimChanged",
	{
		params["_unit","_anim"];

		if (_anim != ANIM_WOUNDED && alive _unit && (_unit getVariable ["MCC_medicUnconscious",false])) then
		{
			_unit switchMove ANIM_WOUNDED;
		};
	}
];

_unit setVariable ["bis_ehAnimChanged", _ehAnimChanged];
_unit allowDamage true;

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
	(["mcc_uncMain"] call BIS_fnc_rscLayer) cutRsc ["mcc_uncMain", "PLAIN"];
	//createDialog "mcc_uncMain";
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

	//remove 'anim changed' event handler
	private _ehAnimChanged = _this getVariable ["bis_ehAnimChanged", -1];
	if (_ehAnimChanged != -1) then {_this removeEventHandler ["AnimChanged", _ehAnimChanged]};

};

