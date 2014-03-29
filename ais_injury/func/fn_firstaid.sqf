// by BonInf*
// changed by psycho
private ["_injuredperson","_healer","_behaviour","_timenow","_relpos","_dir","_offset","_time","_damage","_isMedic","_healed","_animChangeEVH"];
_injuredperson = _this select 0;
_healer = _this select 1;
_behaviour = behaviour _healer;

if (!isPlayer _healer && {_healer distance _injuredperson > 4}) then {
	_healer setBehaviour "AWARE";
	_healer doMove (position _injuredperson);
	_timenow = time;
	WaitUntil {
		_healer distance _injuredperson <= 4		 		||
		{!alive _injuredperson}			 					||
		{!(_injuredperson getVariable "tcb_ais_agony")} 	||
		{!alive _healer}				 					||
		{_healer getVariable "tcb_ais_agony"}		 		||
		{_timenow + 120 < time}
	};
};

if (_healer getVariable "tcb_ais_agony") exitWith {};

if (_healer distance _injuredperson > 4) exitWith {
	_healer setBehaviour _behaviour;
	if (isPlayer _healer) then {[format ["%1 is too far away to be healed.", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
};
rtn = call tcb_fnc_isHealable;
if (!rtn) exitWith {};

_injuredperson setVariable ["healer", _healer, true];
tcb_healerStopped = false;

_healer selectWeapon primaryWeapon _healer;
sleep 1;
_healer playAction "medicStart";
tcb_animDelay = time + 2;

if (!isPlayer _healer) then {
	_healer stop true;
	_healer disableAI "MOVE";
	_healer disableAI "TARGET";
	_healer disableAI "AUTOTARGET";
	_healer disableAI "ANIM";
};

if (isPlayer _healer) then {
	_animChangeEVH = _healer addEventhandler ["AnimChanged", {
		private ["_anim","_healer"];
		_healer = _this select 0;
		_anim = _this select 1;
		if (primaryWeapon _healer != "") then {
			if (time >= tcb_animDelay) then {tcb_healerStopped = true};
		} else {
			if (_anim in ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswlnrdnon"]) then {
				_healer playAction "medicStart";
			} else {
				if (!(_anim in ["ainvpknlmstpsnonwnondnon_medic0s","ainvpknlmstpsnonwnondnon_medic"])) then {
					if (time >= tcb_animDelay) then {tcb_healerStopped = true};
				};
			};
		};	
	}];
};

_offset = [0,0,0]; _dir = 0;
_relpos = _healer worldToModel position _injuredperson;
if((_relpos select 0) < 0) then{_offset=[-0.2,0.7,0]; _dir=90} else{_offset=[0.2,0.7,0]; _dir=270};


_injuredperson attachTo [_healer,_offset];
_injuredperson setDir _dir;
_time = time;
_damage = (damage _injuredperson * 50);
sleep 1;
while {
	time - _time < _damage
	&& {alive _healer}
	&& {alive _injuredperson}
	&& {(_healer distance _injuredperson) < 2}
	&& {!(_healer getVariable "tcb_ais_agony")}
	&& {!tcb_healerStopped}
} do {
	sleep 0.5;
	if (isPlayer _healer) then {["Applying First Aid",((time - _time) / (_damage)) min 1] spawn tcb_fnc_progressbar};
};

if (isPlayer _healer) then {_healer removeEventHandler ["AnimChanged", _animChangeEVH]};
detach _healer;
detach _injuredperson;

if (!isPlayer _healer) then {
	_healer stop false;
	_healer enableAI "MOVE";
	_healer enableAI "TARGET";
	_healer enableAI "AUTOTARGET";
	_healer enableAI "ANIM";
	//_healer doMove (position (leader group _healer));
};

if (alive _healer && {!(_healer getVariable "tcb_ais_agony")}) then {
	_healer playAction "medicStop";
	_healer setBehaviour _behaviour;
};
if (!alive _injuredperson) exitWith {["It's already to late for this guy.",0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _healer) exitWith {};
_injuredperson setVariable ["healer",ObjNull,true];

if (!tcb_healerStopped) then {
	_isMedic = _healer call tcb_fnc_isMedic;
	_healed = switch (true) do {
		case (_isMedic && {(items _healer) find "Medikit" > -1}) : {0};
		case (_isMedic && {(items _healer) find "FirstAidKit" >= 0}) : {_healer removeItem "FirstAidKit"; 0.25};
		case (!_isMedic && {(items _healer) find "FirstAidKit" >= 0}) : {_healer removeItem "FirstAidKit"; _injuredperson setHit ["hands", 0.9]; 0.4};
		default {_injuredperson setHit ["legs", 0.4]; _injuredperson setHit ["hands", 0.9]; 0.6};
	};

	if (time - _time > _damage) then {
		_injuredperson setDamage _healed;
		_injuredperson setVariable ["tcb_ais_agony",false,true];
	};
} else {
	["You has stopped the healing process.",0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
};