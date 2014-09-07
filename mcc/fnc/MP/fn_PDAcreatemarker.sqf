//==================================================================MCC_fnc_PDAcreatemarker===============================================================================================
// Example:[_question, _header , _variable] call MCC_fnc_PDAcreatemarker;
//==================================================================================================================================================================================
private ["_markerName","_mark","_path","_pos","_type","_text","_time","_index","_color"];
_markerName =_this select 0;
_path	 	=_this select 1;
_pos	 	=_this select 2;
_type	 	=_this select 3;
_text	 	=_this select 4;
_time	 	=_this select 5;
_color	 	=_this select 6;


_mark = createmarkerlocal [_markerName,_pos];
_markerName setmarkertypelocal format ["%1%2", _path, _type];
_markerName setmarkerTextlocal _text;
_markerName setmarkercolorlocal _color;

if (isnil "MCC_PDAMarkers") then {MCC_PDAMarkers = []; MCC_PDAMarkersTime = []};
_index = count MCC_PDAMarkers;
MCC_PDAMarkers set [_index, _markerName];
MCC_PDAMarkersTime set [_index, _time];


