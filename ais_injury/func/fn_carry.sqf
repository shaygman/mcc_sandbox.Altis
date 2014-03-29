// by psycho
private["_injuredperson","_dragger"];
_dragger = _this select 1;
_injuredperson	= _this select 3;

//if (!isNull(_injuredperson getVariable "healer") || {!isNull(_injuredperson getVariable "dragger")}) exitWith {[format ["%1 is being assisted.", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (_injuredperson distance _dragger > 3) exitWith {[format ["%1 is too far away to be dragged.", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _injuredperson) exitWith {[format ["R.I.P. %1", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (_dragger call tcb_fnc_checklauncher) exitWith {[format ["You cant carry others during you wear a launcher on your back."],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};

if (!isNil "carryaction") then {
	_dragger removeAction carryaction;
	carryaction = nil;
};

detach _dragger;
detach _injuredperson;

_pos = _dragger ModelToWorld [0,1.9,0];
_injuredperson setPos _pos;
_injuredperson playActionNow "grabCarried";
sleep 2;
if (!isPlayer _injuredperson) then {_injuredperson disableAI "ANIM"};
_dragger playAction "grabCarry";

_timenow = time;
waitUntil {!alive _injuredperson || {!alive _dragger} || {(_dragger getVariable "tcb_ais_agony")} || {time > _timenow + 16}};
if (!alive _injuredperson || {!alive _dragger} || {(_dragger getVariable "tcb_ais_agony")}) then {
	if (alive _injuredperson) then {
		_injuredperson playActionNow "agonyStart";
	} else {
		if (!isNil {_dragger getVariable "drop_action"}) then {
			_dragger removeAction (_dragger getVariable "drop_action");
			_dragger setVariable ["drop_action",nil];
		};
	};
	if (alive _dragger && {!(_dragger getVariable "tcb_ais_agony")}) then {
		_dragger playMoveNow "amovpknlmstpsraswrfldnon";
	};
} else {
	_injuredperson attachTo [_dragger, [-0.6, 0.28, -0.05]];
};