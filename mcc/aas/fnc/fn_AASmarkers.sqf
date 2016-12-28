/*=================================================================MCC_fnc_AASmarkers==============================================================================
 Init Advance and Secure mission
  IN <>
    _this select 0: SIDE the side owns the capture point
    _this select 1: ARRAY position of the marker
    _this select 2: STRING unique name of the marker

OUT <>
    Nothing

Example:
[west,_markerPos,"markerName"] call MCC_fnc_AASmarkers;

*/

private ["_logic","_triggers","_attack","_marker","_attackText"];
params ["_owner","_pos","_markerName"];

_pos =  [_pos, 20, 0] call BIS_fnc_relPos;
_attack = playerSide != _owner;
_attackText = if (_attack) then {"Attack"} else {"Defend"};
_marker = missionNamespace getVariable [_markerName,""];

if (str getMarkerPos _marker == "[0,0,0]") then {
    _marker = createMarkerLocal [format ["%1_%2",_markerName,_attackText], _pos];
    _marker setMarkerTextLocal _attackText;
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal  "mil_marker";
    _marker setMarkerColorLocal (if (_attack) then {"ColorRed"} else {"ColorBlue"});
    missionNamespace setVariable [_markerName,_marker];
};

_marker setMarkerPosLocal _pos;