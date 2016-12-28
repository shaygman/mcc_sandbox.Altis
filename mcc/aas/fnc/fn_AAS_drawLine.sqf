/*=================================================================MCC_fnc_AAS_drawLine==============================================================================
 Draw lines withing sectors in an AAS mission in the order they need to be captured
  IN <>
    _this select 0: ARRAY position of start location
    _this select 1: ARRAY position of end location
    _this select 2: STRING unique name of the marker
OUT <>
    Nothing

Example:
[_start,_end,"line1"] call MCC_fnc_AAS_drawLine;

*/

private ["_dist","_dir","_center"];
params ["_start","_end","_lineMarkerName"];

_dist = _start distance _end;
_dir = ((_end select 0) - (_start select 0)) atan2
((_end select 1) - (_start select 1));

_center = [(_start select 0) + ((sin _dir) * _dist / 2),
(_start select 1) + ((cos _dir) * _dist / 2)];

createMarkerLocal [_lineMarkerName, _center];
_lineMarkerName setMarkerShapeLocal "RECTANGLE";
_lineMarkerName setMarkerSizeLocal [10, _dist / 2];
_lineMarkerName setMarkerColorLocal "ColorBlack";
_lineMarkerName setMarkerDirLocal _dir;