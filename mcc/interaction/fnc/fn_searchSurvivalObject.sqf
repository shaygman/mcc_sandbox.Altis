//==================================================================MCC_fnc_searchSurvivalObject=================================================================================
// Search a survival object
// Example:[]  call MCC_fnc_searchSurvivalObject;
// <IN>
//	none
//
// <OUT>
//		Boolean
//===========================================================================================================================================================================
private ["_positionStart","_positionEnd","_pointIntersect","_selected","_resault","_objArray"];
if !(missionNamespace getVariable ["MCC_surviveMod",false]) exitWith {};

//Not MCC object
_positionStart 	= eyePos player;
_positionEnd 	= ATLtoASL screenToWorld [0.5,0.5];
_pointIntersect = lineIntersectsWith [_positionStart, _positionEnd, player, objNull, true];
_resault = false;
if (count _pointIntersect > 0) then {
	_selected = _pointIntersect select ((count _pointIntersect)-1);

	if (player distance _selected < 5) then {
		_objArray = [] call MCC_fnc_getSurvivalPlaceHolders;

		if ((({[_x , str _selected] call BIS_fnc_inString} count _objArray)>0) && (isNull attachedTo _selected)) then {
			[_selected] call MCC_fnc_interactObject;
		};
	};
};

_resault