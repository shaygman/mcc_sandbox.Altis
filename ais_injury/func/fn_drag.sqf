// by Bon_Inf*
private["_injuredperson","_dragger"];
_injuredperson = _this select 0;
_dragger = _this select 1;

if (!isNull(_injuredperson getVariable "healer") || {!isNull(_injuredperson getVariable "dragger")}) exitWith {[format ["%1 is being assisted.", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (_injuredperson distance _dragger > 3) exitWith {[format ["%1 is too far away to be dragged.", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _injuredperson) exitWith {[format ["R.I.P. %1", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};

_injuredperson setVariable ["dragger",_dragger,true];
_injuredperson attachTo [_dragger, [0, 1, 0.08]];
_injuredperson setDir 180;

_injuredperson switchMove "AinjPpneMrunSnonWnonDb";
_dragger playAction "grabDrag";
sleep 1;

dropaction = _dragger addAction [format["<t color='#FC9512'>Drop %1</t>",name _injuredperson], {_this spawn tcb_fnc_drop},_injuredperson, 0, false, true];
carryaction = _dragger addAction [format["<t color='#FC9512'>Carry %1</t>",name _injuredperson], {_this spawn tcb_fnc_carry},_injuredperson, 0, false, true];
_dragger setVariable ["drop_action", dropaction];
_dragger setVariable ["carry_action", carryaction];