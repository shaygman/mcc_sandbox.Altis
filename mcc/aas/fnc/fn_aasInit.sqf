/*=================================================================MCC_fnc_aasInit==============================================================================
 Init Advance and Secure mission
  IN <>
    _this select 0: ARRAY array of trigger names that will acts as a capture point in the logical order the first and the last triggers in the array
                    will be the starting poistion for the fighting sides and they will fight to the middle trigger.

    _this select 1: ARRAY of two sides that are contesting each other.

OUT <>
    Nothing

Example:
[[s1,s2,s3,s4,s5,s6],[west,east]] call MCC_fnc_aasInit;

*/

private ["_sectors","_zoneTriggers","_triggersAreas","_trigger","_fnc_drawLine","_sides"];

MCC_fnc_AASHandleSector = {
    private ["_owner","_owners","_index","_sides","_factor","_nextTriggerIndex","_lastTriggerIndex","_triggers","_nextTriggerOwner"];
    params ["_sector"];

    _owner = _sector getvariable ["owner",sideunknown];
    _index = (missionNamespace getVariable ["MCC_fnc_AAS_sectors",[]]) find _sector;

    waitUntil {_owner != (_sector getvariable ["owner",sideunknown]);};
    _owner = _sector getvariable ["owner",sideunknown];

    _owners = missionNamespace getVariable ["MCC_fnc_AAS_owners",[]];
    _owners set [_index,_owner];
    missionNamespace setVariable ["MCC_fnc_AAS_owners",_owners];
    publicVariable "MCC_fnc_AAS_owners";

    _sides = missionNamespace getVariable ["MCC_fnc_AAS_sides",[]];

    //We have a valid conquestor
    if (_owner in _sides) then {

        _triggers = missionNamespace getVariable ["MCC_fnc_AAS_triggers",[]];
        _triggersAreas = missionNamespace getVariable ["MCC_fnc_AAS_triggersAreas",[]];

        //open new sector and close this one
        _nextTriggerIndex = if (_owner == (_sides select 0)) then {_index + 1} else {_index -1};
        _lastTriggerIndex = if (_owner == (_sides select 0)) then {_index - 1} else {_index +1};

        // Marker defend current sector
        deleteMarker (missionNamespace getVariable [format ["sector_%1", _index],""]);
        [_owner, position (_triggers select _index),format ["sector_%1", _index]] remoteExec ["MCC_fnc_AASmarkers", 0,false];

        if (_nextTriggerIndex >= 0 && _nextTriggerIndex < (count _triggers)) then {
            (_triggers select _nextTriggerIndex) setTriggerArea (_triggersAreas select _nextTriggerIndex);

            // Marker
            _nextTriggerOwner = ((missionNamespace getVariable ["MCC_fnc_AAS_sectors",[]]) select _nextTriggerIndex) getVariable ["owner",sideunknown];
            [_nextTriggerOwner, position (_triggers select _nextTriggerIndex),format ["sector_%1", _nextTriggerIndex]] remoteExec ["MCC_fnc_AASmarkers", 0,false];
        };

        if (_lastTriggerIndex >= 0 && _lastTriggerIndex < (count _triggers)) then {
            (_triggers select _lastTriggerIndex) setTriggerArea [0,0,0,false];
            deleteMarker (missionNamespace getVariable [format ["sector_%1", _lastTriggerIndex],""]);
        };
    };

    _sector spawn MCC_fnc_AASHandleSector;
};

//Module or function call
if (typeName (_this select 0) == typeName []) then {
    _sectors =  _this select 0;
    _sides = _this select 1;
} else {
    _sectors = synchronizedObjects (_this select 0);
    _sides = [];
    {
        _sides pushBack ([((_this select 0) getVariable [_x,1])] call BIS_fnc_sideType);
    } forEach ["side1","side2"];
};

//Init
_triggers = [];
_triggersAreas = [];
_owners = [];

{
    while {count (_x getvariable ["areas",[]]) == 0} do {sleep 1};
    _zoneTriggers = _x getvariable ["areas",[]];
    if (count _zoneTriggers == 0) exitWith {diag_log format ["MCC_fnc_AAS Error: no trigger in sector %1", _foreachindex]};
    _trigger = _zoneTriggers select 0;
    _triggers pushBack _trigger;
    _triggersAreas pushBack (triggerArea _trigger);
    _owners pushBack (_x getvariable ["owner",sideunknown]);
    _trigger setTriggerArea [0,0,0,false];
} forEach _sectors;

missionNamespace setVariable ["MCC_fnc_AAS_sides",_sides];
publicVariable "MCC_fnc_AAS_sides";

missionNamespace setVariable ["MCC_fnc_AAS_sectors",_sectors];
publicVariable "MCC_fnc_AAS_sectors";

missionNamespace setVariable ["MCC_fnc_AAS_triggers",_triggers];
publicVariable "MCC_fnc_AAS_triggers";

missionNamespace setVariable ["MCC_fnc_AAS_triggersAreas",_triggersAreas];
publicVariable "MCC_fnc_AAS_triggersAreas";

missionNamespace setVariable ["MCC_fnc_AAS_owners",_owners];
publicVariable "MCC_fnc_AAS_owners";


//Set the first and last areas open for conquest
{
    _trigger = _triggers select _x;
    _trigger setTriggerArea (_triggersAreas select _x);

    //Set Markers
    [_owners select _x, position _trigger,format ["sector_%1", _x]] remoteExec ["MCC_fnc_AASmarkers", 0,false];
} forEach [0,(count _triggers -1)];

//Draw Lines
{
    if (_foreachindex > 0) then {
        [position _x, position (_triggers select (_foreachindex -1)), format ["MCC_AAS_Line_%1", _foreachindex]] remoteExec ["MCC_fnc_AAS_drawLine", 0,true];
    };
} forEach _triggers;

//Main loop
{
    _x spawn MCC_fnc_AASHandleSector;
} forEach _sectors;