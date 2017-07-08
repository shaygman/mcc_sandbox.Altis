//==================================================================MCC_fnc_dragObject===========================================================================
//Start a dragging animation must be run local on the dragging unit
// Example: [_object] call MCC_fnc_dragObject;
// _object :	 object. unit or object being dragged
//===========================================================================================================================================================================
private ["_object", "_worldPos"];
_object = _this select 0;
_isMan = _object isKindOf "CAManBase";

player setVariable ["mcc_dragAnimEH", player addEventHandler [
		"AnimStateChanged",
		{
			if((animationState player)=="helper_switchtocarryrfl")then
			{
				{detach _x} foreach attachedObjects player;
				sleep 0.5;
				player switchMove "aidlpknlmstpsraswrfldnon_AI";
				player removeEventHandler ["AnimStateChanged", player getVariable ["mcc_dragAnimEH",0]];
			};
		}
	]
];

player playAction "grabDrag";
player forceWalk true;
_worldPos = player worldToModel getpos _object;
_object attachTo [player,[_worldPos select 0, _worldPos select 1, 0.0 +((_object modelToWorld[0,0,0])select 2)-((getpos _object) select 2)]];
[[[_object],{(_this select 0) setDir 180;}],"BIS_fnc_spawn", _object, false] spawn BIS_fnc_MP;
player setVariable ["mcc_draggedObject", _object];

player addAction ["<t color='#FF0000'>Release</t>", {_this call MCC_fnc_releaseObject},[],6,true,true,"","(vehicle _target == vehicle _this)"];